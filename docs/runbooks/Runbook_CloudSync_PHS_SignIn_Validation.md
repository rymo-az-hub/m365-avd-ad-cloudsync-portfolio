# Runbook: Password Hash Sync Sign-in Validation

## 1. Purpose

Validate that a Cloud Sync-synchronized AD DS user can sign in to Microsoft cloud services using a password reset on the AD DS side.

## 2. Preconditions

| Item | Expected state |
|---|---|
| Cloud Sync configuration | Enabled and healthy |
| Password Hash Sync | Enabled |
| Target user | Synchronized to Microsoft Entra ID |
| `onPremisesSyncEnabled` | `true` |
| Sign-in log access | Available through portal or Microsoft Graph |

## 3. Reset AD password

Run on the AD DS management host.

```powershell
Import-Module ActiveDirectory

$UserName = "<SYNCED-USER-SAM>"

Get-ADUser $UserName -Properties Name,SamAccountName,UserPrincipalName,Enabled,PasswordLastSet,DistinguishedName |
  Select-Object Name,SamAccountName,UserPrincipalName,Enabled,PasswordLastSet,DistinguishedName

$NewPassword = Read-Host "Enter new temporary password" -AsSecureString

Set-ADAccountPassword -Identity $UserName -NewPassword $NewPassword -Reset -ErrorAction Stop
Set-ADUser -Identity $UserName -Enabled $true -ChangePasswordAtLogon $false -ErrorAction Stop

Get-ADUser $UserName -Properties Name,SamAccountName,UserPrincipalName,Enabled,PasswordLastSet,DistinguishedName |
  Select-Object Name,SamAccountName,UserPrincipalName,Enabled,PasswordLastSet,DistinguishedName
```

Expected result:

```text
Enabled: True
PasswordLastSet: updated to current validation time
```

Do not store the password in screenshots, logs, Markdown, or scripts.

## 4. Wait for Password Hash Sync

Wait several minutes before testing cloud sign-in. The exact timing can vary by tenant and service state.

## 5. Cloud sign-in validation

Use an InPrivate or private browser session.

```text
https://myaccount.microsoft.com/
```

Sign in with:

```text
User: <SYNCED-USER-UPN>
Password: password set in AD DS during this validation
```

Expected result:

| Outcome | Interpretation |
|---|---|
| My Account page opens | PHS sign-in validation succeeded |
| MFA registration or challenge appears | Password was likely accepted; validate Conditional Access/MFA separately |
| Conditional Access block | Check sign-in logs before treating as PHS failure |
| Invalid password | Check password entry, PHS status, sync delay, and AD reset result |

## 6. Sign-in log validation

Portal path:

```text
Microsoft Entra admin center
  > Microsoft Entra ID
    > Monitoring and health
      > Sign-in logs
```

Expected event properties:

| Item | Expected value |
|---|---|
| User | `<SYNCED-USER>` |
| UPN | `<SYNCED-USER-UPN>` |
| Application | My Account / My Profile or equivalent Microsoft profile app |
| Client app | Browser |
| Status | Success |
| Status error code | 0 |
| Failure reason | Empty, none, or not applicable |

## 7. Notes

- A Keep Me Signed In interruption can create a separate non-success event. Treat the final successful event as the PHS validation result.
- PHS validation and Conditional Access/MFA validation should be separated.
- Public evidence should use summarized Markdown instead of screenshots or raw sign-in log exports.

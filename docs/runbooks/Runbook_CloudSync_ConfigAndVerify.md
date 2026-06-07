# Runbook: Cloud Sync Configuration and Verification

## 1. Purpose

Synchronize a single AD DS lab user to Microsoft Entra ID through Microsoft Entra Cloud Sync, while keeping the initial scope minimal and auditable.

## 2. Preconditions

| Item | Value |
|---|---|
| AD domain | `ad.contoso-lab.local` |
| Agent server | `<CLOUD-SYNC-AGENT-SERVER>` |
| Agent status | Active during validation |
| Scope group | `GG-CloudSync-Users` |
| Target user | `<SYNCED-USER>` |
| Target UPN | `<SYNCED-USER-UPN>` |
| Agent placement | DC co-location for lab cost only |

## 3. AD-side validation

Run on the AD DS management host.

```powershell
Import-Module ActiveDirectory

Get-ADUser <SYNCED-USER-SAM> -Properties UserPrincipalName,DistinguishedName,Enabled,MemberOf |
  Select-Object Name,SamAccountName,UserPrincipalName,Enabled,DistinguishedName,MemberOf

Get-ADGroup GG-CloudSync-Users -Properties DistinguishedName,Members |
  Select-Object Name,DistinguishedName,Members
```

Expected result:

```text
User is enabled.
User is a direct member of GG-CloudSync-Users.
User DistinguishedName matches the value used for on-demand provisioning.
```

## 4. Entra-side duplicate check

Run from a management workstation with Azure CLI and Microsoft Graph access.

```powershell
$Upn = "<SYNCED-USER-UPN>"
$Uri = "https://graph.microsoft.com/v1.0/users?`$filter=userPrincipalName eq '$Upn'&`$select=id,displayName,userPrincipalName,onPremisesSyncEnabled"
az rest --method GET --url $Uri
```

Expected first-run result:

```json
{"value": []}
```

## 5. Cloud Sync configuration

Portal path:

```text
Microsoft Entra admin center
  > Microsoft Entra Connect
    > Cloud sync
      > Configurations
        > New configuration
```

Configuration:

| Item | Value |
|---|---|
| Direction | AD DS to Microsoft Entra ID |
| Domain | `ad.contoso-lab.local` |
| Password Hash Sync | Enabled |
| Scope type | Selected security groups |
| Scope group DN | `CN=GG-CloudSync-Users,OU=Groups,OU=Lab,DC=ad,DC=contoso-lab,DC=local` |
| Attribute mapping | Default for initial validation |

## 6. On-demand provisioning validation

Use the exact AD DistinguishedName of the target user.

```text
<CORRECT-USER-DISTINGUISHED-NAME>
```

Expected result:

| Step | Expected result |
|---|---|
| Import user | Success |
| Determine if user is in scope | Success |
| Match user | Success |
| Perform action | Create or Update Success |

Note: On-demand provisioning is useful for validating a single user. It should not be treated as the only proof of the normal sync scope. Normal provisioning logs and Graph checks should also be captured.

## 7. Normal sync verification

After enabling the configuration and restarting sync, confirm the user through Graph.

```powershell
$Upn = "<SYNCED-USER-UPN>"
$Uri = "https://graph.microsoft.com/v1.0/users?`$filter=userPrincipalName eq '$Upn'&`$select=displayName,userPrincipalName,onPremisesSyncEnabled,onPremisesDistinguishedName,onPremisesDomainName,onPremisesSamAccountName,onPremisesLastSyncDateTime"
az rest --method GET --url $Uri
```

Expected result:

```text
onPremisesSyncEnabled: true
onPremisesDomainName: ad.contoso-lab.local
onPremisesSamAccountName: <SYNCED-USER-SAM>
```

## 8. Scope verification

A clean public evidence summary should state:

| Item | Expected public result |
|---|---|
| Lab domain synced user count | 1 |
| Synced target user | `<SYNCED-USER-UPN>` |
| Provisioning result | Success |

## 9. Operational notes

- Security group scoping is useful for pilot validation. Nested groups are not used in this lab.
- Treat the Cloud Sync Agent server as a high-privilege identity infrastructure component.
- Avoid applying interactive MFA/Conditional Access requirements to sync-related service identities without validating the impact.
- In production, consider multiple agents, hardened hosts, least privilege, monitoring, alerting, and break-glass access.

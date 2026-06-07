# Runbook: AVD Troubleshooting Notes

## Common checks

| Area | Check |
|---|---|
| Assignment | User/group assigned to Desktop Application Group |
| RBAC | VM User Login or equivalent access for Entra joined VM sign-in |
| Session host | Host registration, status, agent health |
| VM state | Running or Start VM on Connect capable |
| Intune | Device enrollment and compliance status |
| Network | Required outbound access for AVD agent and Microsoft services |
| Identity | User sign-in status and Conditional Access results |

## Session host and user sessions

If Azure CLI AVD subcommands are unavailable or inconsistent, use Azure PowerShell or ARM REST API for session host and user session checks.

Recommended Azure PowerShell cmdlets:

```powershell
Get-AzWvdSessionHost
Get-AzWvdUserSession
```

ARM REST pattern is documented in [Runbook_Lab_Cost_Stop.md](Runbook_Lab_Cost_Stop.md).

## Troubleshooting principle

Separate the issue into these layers:

1. User assignment / entitlement
2. Identity and Conditional Access
3. AVD control plane
4. Session host registration
5. VM power state
6. Network access
7. Intune compliance / policy impact

Avoid treating all connection failures as AVD host issues.

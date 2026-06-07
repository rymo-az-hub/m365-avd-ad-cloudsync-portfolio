# Security Design Notes

## Identity and access

| Area | Design note |
|---|---|
| Conditional Access | Treated as part of the identity baseline. PHS validation is separated from CA/MFA validation. |
| MFA | Designed for user/admin access, but sync service impact must be validated before broad enforcement. |
| Admin separation | Production design should separate daily user accounts and administrative accounts. |
| Break-glass access | Production design should include cloud-only emergency access accounts, monitored and excluded from disruptive CA policies. |
| Least privilege | Administrative roles should be scoped and time-bound where possible. |

## Cloud Sync

| Area | Design note |
|---|---|
| Agent placement | Lab uses DC co-location for cost. Production should treat the agent server as Tier 0/control-plane infrastructure. |
| gMSA | Cloud Sync uses a managed service account pattern. Production documentation should include ownership, rotation, and monitoring considerations. |
| High availability | Production should consider multiple active agents. |
| Scope control | Initial lab scope uses selected security group. Production should define explicit synchronization scope and change process. |

## AD DS / DNS

| Area | Design note |
|---|---|
| DC exposure | DC has no public IP in this lab design. |
| DNS | Lab scope avoids broad VNet DNS changes until required. Production should design DNS based on workload name-resolution needs. |
| Backup / recovery | Production requires backup, restore testing, event monitoring, and DC health checks. |
| Stop/deallocate | Lab-only cost control. Production DC deallocate is not a normal operating pattern. |

## Logging and evidence

| Area | Design note |
|---|---|
| Sign-in logs | Used to distinguish PHS success from CA/MFA interruptions. |
| Provisioning logs | Used to validate normal Cloud Sync behavior beyond on-demand testing. |
| Graph checks | Used for repeatable verification and evidence extraction. |
| Public evidence | Raw logs and screenshots are excluded from GitHub. |

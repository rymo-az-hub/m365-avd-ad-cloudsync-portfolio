# P7 Completion Summary: AD DS / Cloud Sync / Password Hash Sync / Cost Stop

## Result

P7 completed the AD DS / DNS lab domain, Microsoft Entra Cloud Sync configuration, scoped synchronization, Password Hash Sync sign-in validation, sign-in log confirmation, and post-validation VM deallocate operation.

## Completed scope

| Area | Result |
|---|---|
| AD DS / DNS | Lab domain configured |
| OU / group / user | Lab objects created |
| Cloud Sync Agent | Registered and active during validation |
| Cloud Sync configuration | Created and enabled |
| Sync scope | Selected security group |
| On-demand provisioning | Successful |
| Normal sync | Successful |
| Provisioning logs | Create action confirmed |
| Graph verification | Synced user confirmed with on-premises sync attributes |
| Password Hash Sync | Enabled |
| Cloud sign-in | Successful after AD password reset |
| Sign-in logs | Successful sign-in event confirmed |
| Cost stop | DC VM and AVD session host deallocated |

## Public configuration values

| Item | Public value |
|---|---|
| AD domain | `ad.contoso-lab.local` |
| NetBIOS | `CONTOSOLAB` |
| Cloud Sync Agent | `<CLOUD-SYNC-AGENT-SERVER>` |
| Sync direction | AD DS to Microsoft Entra ID |
| Scope type | Selected security group |
| Scope group | `GG-CloudSync-Users` |
| Synced user | `<SYNCED-USER>` / `<SYNCED-USER-UPN>` |
| Password Hash Sync | Enabled |

## Issues found and resolved

| Issue | Root cause | Resolution |
|---|---|---|
| Cloud Sync domain dropdown was empty | Portal session or blade refresh delay | Signed out and signed in again. Domain became selectable. |
| On-demand import returned ResourceNotFound | Entered DN used the account name, but the actual CN was different | Retrieved the exact DistinguishedName from AD DS and retried. |
| Initial sign-in log Graph query returned no records | Log delay or overly strict filter | Queried recent sign-ins with a broader filter and confirmed the target event. |
| Azure CLI AVD session-host command was unavailable | CLI subcommand difference | Used ARM REST API to check session hosts and user sessions. |

## Lab vs production considerations

| Area | Lab decision | Production consideration |
|---|---|---|
| Cloud Sync Agent placement | Agent installed on the DC | Use hardened Tier 0 handling. Consider dedicated member servers and multiple active agents. |
| AD DS | Single lab DC | Use multiple DCs, backup, monitoring, patching, and recovery process. |
| Sync scope | Selected security group | Good for pilot. Use clear OU/group scoping and change management for steady operation. |
| VNet DNS | Not broadly changed for this validation | Configure custom DNS when workloads require AD DS name resolution. |
| Monitoring | Manual portal/Graph checks | Use Log Analytics, alerts, and audit retention. |
| Cost stop | Manual deallocate | Do not directly apply to production DCs without impact review and recovery planning. |

## Public evidence summaries

- [Cloud Sync provisioning summary](../../evidence/public/p7-cloudsync-provisioning-summary.md)
- [Password Hash Sync sign-in summary](../../evidence/public/p7-phs-signin-summary.md)
- [Cost stop summary](../../evidence/public/p7-cost-stop-summary.md)

## Completion judgement

P7 is complete for this lab scope. The public version intentionally excludes raw screenshots and raw logs. Evidence is represented by sanitized Markdown summaries.

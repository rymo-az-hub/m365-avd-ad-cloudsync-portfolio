# P7 Cloud Sync Provisioning Evidence Summary

## Result

Cloud Sync successfully synchronized the selected AD DS lab user to Microsoft Entra ID.

## Public validation summary

| Item | Public result |
|---|---|
| Source | AD DS lab domain |
| Target | Microsoft Entra ID |
| Sync direction | AD DS to Microsoft Entra ID |
| Scope type | Selected security group |
| Scope group | `GG-CloudSync-Users` |
| On-demand provisioning | Success |
| Normal sync | Success |
| Provisioning action | Create confirmed |
| Synced lab-domain user count | 1 |
| Synced target | `<SYNCED-USER-UPN>` |
| `onPremisesSyncEnabled` | `true` |

## Troubleshooting evidence summary

| Issue | Resolution |
|---|---|
| Domain dropdown empty in Cloud Sync configuration screen | Portal sign-out/sign-in refreshed the blade and the domain became selectable. |
| On-demand import ResourceNotFound | The entered DN used an incorrect CN. The exact AD DistinguishedName was retrieved and used successfully. |

## Notes

- On-demand provisioning was not treated as the only scope evidence.
- Normal provisioning logs and Graph verification were used to support the final result.
- Raw provisioning logs and screenshots are excluded from the public repository.

# P6 Completion Summary: Azure Virtual Desktop Modern Configuration

## Result

P6 validated a Microsoft Entra joined Azure Virtual Desktop session host with Intune enrollment, compliance confirmation, user access, Start VM on Connect, and deallocate operation.

## Completed scope

| Item | Result |
|---|---|
| Host pool | Created |
| Workspace | Created |
| Desktop Application Group | Created and assigned |
| Session host | Microsoft Entra joined |
| Intune enrollment | Enabled and confirmed |
| Compliance status | Confirmed |
| User connection | Successful |
| Start VM on Connect | Enabled and validated |
| VM deallocate operation | Validated |

## Design intent

The AVD design intentionally uses a modern Microsoft Entra joined session host pattern. The lab emphasizes a cloud-first desktop platform rather than a classic AD domain joined AVD pattern.

## Operational notes

- User assignment, VM User Login role assignment, RDP property validation, and AVD session checks were included in the runbook flow.
- Start VM on Connect was treated as both a user-experience and cost-control feature.
- VM deallocate was validated as a lab cost-stop operation.

## Public evidence summary

See [evidence/public/p6-avd-validation-summary.md](../../evidence/public/p6-avd-validation-summary.md).

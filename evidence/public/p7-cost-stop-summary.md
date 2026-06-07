# P7 Cost Stop Evidence Summary

## Result

After validation, the lab DC VM and AVD session host VM were deallocated successfully.

## Public validation summary

| Item | Public result |
|---|---|
| Execution host | Management workstation, not the AVD session host |
| AVD session host status before stop | Available |
| AVD active sessions | 0 |
| AVD user sessions | 0 |
| DC VM before stop | Running |
| AVD VM before stop | Running |
| DC VM deallocate | Success |
| AVD VM deallocate | Success |
| DC VM after stop | VM deallocated |
| AVD VM after stop | VM deallocated |

## Notes

- Cloud Sync Agent may appear inactive while the DC VM is deallocated. This is expected for the lab cost-stop state.
- Deallocate stops compute cost but does not delete managed disks, NICs, or other persistent resources.

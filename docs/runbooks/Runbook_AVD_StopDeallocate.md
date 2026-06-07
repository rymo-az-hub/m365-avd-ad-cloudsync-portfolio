# Runbook: AVD Stop / Deallocate

## Purpose

Stop lab compute cost by deallocating the AVD session host after confirming no active user sessions remain.

## Steps

1. Confirm current host is not the AVD session host being stopped.
2. Confirm AVD session count is 0.
3. Confirm user sessions list is empty.
4. Deallocate the AVD session host VM.
5. Confirm VM state is `VM deallocated`.
6. Record result in the cost-stop evidence summary.

## Command pattern

```powershell
az vm deallocate --resource-group "<RESOURCE-GROUP>" --name "<AVD-SESSION-HOST-VM>"
```

## Notes

This is a lab cost-control operation. Production stop/start design should include user communication, drain mode, maintenance windows, monitoring, and rollback.

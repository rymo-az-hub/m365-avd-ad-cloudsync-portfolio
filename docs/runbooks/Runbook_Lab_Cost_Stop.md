# Runbook: Lab Cost Stop / VM Deallocate

## 1. Purpose

Safely stop compute cost after lab validation by confirming there are no active AVD sessions and then deallocating the lab DC VM and AVD session host.

This is a lab-only cost-control procedure. Do not apply this directly to production domain controllers.

## 2. Target resources

| VM | Purpose |
|---|---|
| `<DC-VM-NAME>` | AD DS / DNS / Cloud Sync Agent |
| `<AVD-SESSION-HOST-VM>` | AVD Session Host |

## 3. Pre-stop checks

| Check | Expected result |
|---|---|
| Current execution host | Not the AVD session host being stopped |
| AVD session host sessions | 0 |
| AVD user sessions | 0 |
| DC VM state | Running before stop |
| AVD VM state | Running before stop |

## 4. AVD session host check through ARM REST

Azure CLI AVD subcommands can differ by extension/version. ARM REST is used here to make the check explicit.

```powershell
$RgName     = "<RESOURCE-GROUP>"
$HostPool   = "<AVD-HOST-POOL>"
$ApiVersion = "2024-04-03"
$SubId      = az account show --query id -o tsv

$SessionHostsUri = "https://management.azure.com/subscriptions/$SubId/resourceGroups/$RgName/providers/Microsoft.DesktopVirtualization/hostPools/$HostPool/sessionHosts?api-version=$ApiVersion"
$SessionHostsResp = az rest --method GET --url $SessionHostsUri | ConvertFrom-Json

$SessionHostsResp.value |
  Select-Object name,
    @{Name='sessions';Expression={$_.properties.sessions}},
    @{Name='status';Expression={$_.properties.status}},
    @{Name='allowNewSession';Expression={$_.properties.allowNewSession}}
```

Expected result:

```text
sessions: 0
```

## 5. Deallocate lab VMs

```powershell
$RgName = "<RESOURCE-GROUP>"
$TargetVmNames = @("<DC-VM-NAME>", "<AVD-SESSION-HOST-VM>")

foreach ($VmName in $TargetVmNames) {
  az vm deallocate --resource-group $RgName --name $VmName
}
```

## 6. Post-stop check

```powershell
foreach ($VmName in $TargetVmNames) {
  az vm get-instance-view `
    --resource-group $RgName `
    --name $VmName `
    --query "{name:name, powerState:instanceView.statuses[?starts_with(code, 'PowerState/')].displayStatus | [0]}" `
    -o json
}
```

Expected result:

```text
<DC-VM-NAME>: VM deallocated
<AVD-SESSION-HOST-VM>: VM deallocated
```

## 7. Restart / recovery checks

When resuming the lab:

1. Start the DC VM first.
2. Confirm AD DS / DNS services are running.
3. Confirm Cloud Sync Agent service is running.
4. Confirm Cloud Sync configuration returns to healthy state.
5. Start the AVD session host.
6. Confirm AVD session host status becomes available.
7. Validate sign-in and sync only after identity services are healthy.

## 8. Notes

- Cloud Sync Agent may appear inactive while the DC VM is deallocated. This is expected for the lab.
- Deallocate stops compute cost but does not remove managed disks, NICs, or other persistent resources.
- Production DC shutdown/deallocation requires explicit impact review, maintenance window, backup, monitoring, and recovery planning.

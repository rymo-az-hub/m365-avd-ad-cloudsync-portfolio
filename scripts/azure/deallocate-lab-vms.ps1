param(
  [Parameter(Mandatory = $true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory = $true)]
  [string[]]$VmNames
)

foreach ($VmName in $VmNames) {
  Write-Host "Deallocating VM: $VmName"
  az vm deallocate --resource-group $ResourceGroupName --name $VmName
}

foreach ($VmName in $VmNames) {
  az vm get-instance-view `
    --resource-group $ResourceGroupName `
    --name $VmName `
    --query "{name:name, powerState:instanceView.statuses[?starts_with(code, 'PowerState/')].displayStatus | [0]}" `
    -o json
}

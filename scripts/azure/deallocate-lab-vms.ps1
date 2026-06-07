#requires -Version 5.1
[CmdletBinding(SupportsShouldProcess = $true)]
param(
  [Parameter(Mandatory = $true)]
  [ValidateNotNullOrEmpty()]
  [string]$ResourceGroupName,

  [Parameter(Mandatory = $true)]
  [ValidateNotNullOrEmpty()]
  [string[]]$VmNames
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Warning 'LAB ONLY: This script deallocates Azure VMs. Do not use for production domain controllers or AVD hosts without impact review and change approval.'

foreach ($VmName in $VmNames) {
  if ($PSCmdlet.ShouldProcess($VmName, 'az vm deallocate')) {
    az vm deallocate --resource-group $ResourceGroupName --name $VmName
  }
}

foreach ($VmName in $VmNames) {
  az vm get-instance-view `
    --resource-group $ResourceGroupName `
    --name $VmName `
    --query "{name:name, powerState:instanceView.statuses[?starts_with(code, 'PowerState/')].displayStatus | [0]}" `
    -o json
}

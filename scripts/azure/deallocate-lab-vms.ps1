#requires -Version 5.1
<#!
.SYNOPSIS
ラボVMをdeallocateするための公開用サンプルです。

.DESCRIPTION
LAB ONLYの手順です。本番のDomain Controller、AVD Session Host、業務VMへそのまま適用しないでください。
実行結果にはResource Group名、VM名、PowerStateなどの環境固有値が含まれるため、公開リポジトリへ貼り付けないでください。

.PREREQUISITES
- Azure CLIで対象サブスクリプションへログイン済みであること
- 対象VMに対するdeallocate権限を持つこと
- 停止前にAVD user sessionが0であることを確認済みであること
- PowerShell 5.1以上
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param(
  [Parameter(Mandatory = $true)]
  [ValidateNotNullOrEmpty()]
  [string]$ResourceGroupName,

  [Parameter(Mandatory = $true)]
  [ValidateNotNullOrEmpty()]
  [string[]]$VmNames,

  [switch]$IncludeSensitiveOutput
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Warning 'LAB ONLY: This script deallocates Azure VMs. Do not use for production domain controllers or AVD hosts without impact review and change approval.'
Write-Warning 'Do not paste raw command output into a public repository.'

foreach ($VmName in $VmNames) {
  if ($PSCmdlet.ShouldProcess($VmName, 'az vm deallocate')) {
    az vm deallocate --resource-group $ResourceGroupName --name $VmName
  }
}

$States = foreach ($VmName in $VmNames) {
  $State = az vm get-instance-view `
    --resource-group $ResourceGroupName `
    --name $VmName `
    --query "{name:name, powerState:instanceView.statuses[?starts_with(code, 'PowerState/')].displayStatus | [0]}" `
    -o json | ConvertFrom-Json

  [pscustomobject]@{
    vmNameRedacted = '<VM_NAME_REDACTED>'
    powerState     = $State.powerState
  }
}

if ($IncludeSensitiveOutput) {
  Write-Warning 'Sensitive output mode is enabled. Do not paste this output into a public repository.'
  foreach ($VmName in $VmNames) {
    az vm get-instance-view `
      --resource-group $ResourceGroupName `
      --name $VmName `
      --query "{name:name, powerState:instanceView.statuses[?starts_with(code, 'PowerState/')].displayStatus | [0]}" `
      -o json
  }
}
else {
  $States
}

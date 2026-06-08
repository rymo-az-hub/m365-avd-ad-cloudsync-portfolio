#requires -Version 5.1
<#!
.SYNOPSIS
指定したオンプレミスドメイン由来の同期ユーザー件数を確認する公開用サンプルです。

.DESCRIPTION
既定では、同期ユーザー件数と判定のみを出力します。
UPN、DN、sAMAccountName、同期時刻などの詳細は、-IncludeSensitiveOutput を明示した場合のみ出力します。
実行結果をGitHub、Issue、PR、READMEへそのまま貼り付けないでください。

.PREREQUISITES
- Azure CLIで対象テナントへログイン済みであること
- Microsoft Graphのユーザー読み取り権限を持つこと
- PowerShell 5.1以上
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  [ValidateNotNullOrEmpty()]
  [string]$OnPremisesDomainName,

  [switch]$IncludeSensitiveOutput
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Select = 'displayName,userPrincipalName,onPremisesSyncEnabled,onPremisesDistinguishedName,onPremisesDomainName,onPremisesSamAccountName,onPremisesLastSyncDateTime'
$Uri = "https://graph.microsoft.com/v1.0/users?`$select=$Select&`$top=999"

$AllUsers = @()

do {
  $Resp = az rest --method GET --url $Uri | ConvertFrom-Json
  $AllUsers += @($Resp.value)

  if ($Resp.PSObject.Properties.Name -contains '@odata.nextLink') {
    $Uri = $Resp.'@odata.nextLink'
  }
  else {
    $Uri = $null
  }
} while ($Uri)

$LabSyncedUsers = @(
  $AllUsers | Where-Object {
    $_.onPremisesSyncEnabled -eq $true -and
    $_.onPremisesDomainName -eq $OnPremisesDomainName
  }
)

$Summary = [pscustomobject]@{
  onPremisesDomainNameRedacted = '<ON_PREMISES_DOMAIN_REDACTED>'
  totalUsersScanned            = $AllUsers.Count
  labDomainSyncedUsers         = $LabSyncedUsers.Count
  result                       = if ($LabSyncedUsers.Count -ge 1) { 'Synced users found' } else { 'No lab synced users found' }
}

if ($IncludeSensitiveOutput) {
  Write-Warning 'Sensitive output mode is enabled. Do not paste this output into a public repository.'
  $LabSyncedUsers | Select-Object displayName,userPrincipalName,onPremisesDomainName,onPremisesSamAccountName,onPremisesLastSyncDateTime
}
else {
  $Summary
}

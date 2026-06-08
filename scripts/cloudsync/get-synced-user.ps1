#requires -Version 5.1
<#!
.SYNOPSIS
指定したUPNのMicrosoft Entra同期属性を確認する公開用サンプルです。

.DESCRIPTION
既定では、公開貼り付けしやすい最小サマリーのみを出力します。
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
  [string]$UserPrincipalName,

  [switch]$IncludeSensitiveOutput
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Select = 'displayName,userPrincipalName,onPremisesSyncEnabled,onPremisesDistinguishedName,onPremisesDomainName,onPremisesSamAccountName,onPremisesLastSyncDateTime'
$EscapedUpn = $UserPrincipalName.Replace("'", "''")
$Uri = "https://graph.microsoft.com/v1.0/users?`$filter=userPrincipalName eq '$EscapedUpn'&`$select=$Select"

$Resp = az rest --method GET --url $Uri | ConvertFrom-Json
$Users = @($Resp.value)

$Summary = [pscustomobject]@{
  queriedUserRedacted       = '<UPN_REDACTED>'
  matchedUserCount          = $Users.Count
  onPremisesSyncEnabled     = if ($Users.Count -eq 1) { [bool]$Users[0].onPremisesSyncEnabled } else { $null }
  onPremisesDomainAvailable = if ($Users.Count -eq 1) { [bool]$Users[0].onPremisesDomainName } else { $null }
}

if ($IncludeSensitiveOutput) {
  Write-Warning 'Sensitive output mode is enabled. Do not paste this output into a public repository.'
  $Users | Select-Object displayName,userPrincipalName,onPremisesSyncEnabled,onPremisesDistinguishedName,onPremisesDomainName,onPremisesSamAccountName,onPremisesLastSyncDateTime
}
else {
  $Summary
}

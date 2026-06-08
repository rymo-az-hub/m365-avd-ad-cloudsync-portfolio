#requires -Version 5.1
<#!
.SYNOPSIS
ARM REST APIでAVD Session HostとUser Sessionを確認する公開用サンプルです。

.DESCRIPTION
既定では、セッションホスト数、利用可能ホスト数、セッション数のみを出力します。
Session Host名やUser Principal Nameなどの詳細は、-IncludeSensitiveOutput を明示した場合のみ出力します。
実行結果をGitHub、Issue、PR、READMEへそのまま貼り付けないでください。

.PREREQUISITES
- Azure CLIで対象サブスクリプションへログイン済みであること
- Microsoft.DesktopVirtualizationリソースを読み取れるRBAC権限を持つこと
- PowerShell 5.1以上
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  [ValidateNotNullOrEmpty()]
  [string]$ResourceGroupName,

  [Parameter(Mandatory = $true)]
  [ValidateNotNullOrEmpty()]
  [string]$HostPoolName,

  [string]$ApiVersion = '2024-04-03',

  [switch]$IncludeSensitiveOutput
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$SubId = az account show --query id -o tsv
if (-not $SubId) { throw 'Azure subscription ID could not be acquired.' }

$SessionHostsUri = "https://management.azure.com/subscriptions/$SubId/resourceGroups/$ResourceGroupName/providers/Microsoft.DesktopVirtualization/hostPools/$HostPoolName/sessionHosts?api-version=$ApiVersion"
$SessionHostsResp = az rest --method GET --url $SessionHostsUri | ConvertFrom-Json

$SessionHostSummary = @(
  $SessionHostsResp.value | ForEach-Object {
    [pscustomobject]@{
      name            = $_.name
      sessionHostName = ($_.name -split '/')[-1]
      status          = $_.properties.status
      allowNewSession = $_.properties.allowNewSession
      sessions        = [int]$_.properties.sessions
      agentVersion    = $_.properties.agentVersion
    }
  }
)

$AllUserSessions = @()
foreach ($SessionHost in $SessionHostSummary) {
  $EscapedSessionHostName = [System.Uri]::EscapeDataString($SessionHost.sessionHostName)
  $UserSessionsUri = "https://management.azure.com/subscriptions/$SubId/resourceGroups/$ResourceGroupName/providers/Microsoft.DesktopVirtualization/hostPools/$HostPoolName/sessionHosts/$EscapedSessionHostName/userSessions?api-version=$ApiVersion"
  $UserSessionsResp = az rest --method GET --url $UserSessionsUri | ConvertFrom-Json

  $AllUserSessions += @(
    $UserSessionsResp.value | ForEach-Object {
      [pscustomobject]@{
        sessionHostName   = $SessionHost.sessionHostName
        name              = $_.name
        userPrincipalName = $_.properties.userPrincipalName
        sessionState      = $_.properties.sessionState
      }
    }
  )
}

$Summary = [pscustomobject]@{
  resourceGroupNameRedacted     = '<RESOURCE_GROUP_REDACTED>'
  hostPoolNameRedacted          = '<HOST_POOL_REDACTED>'
  sessionHostCount              = $SessionHostSummary.Count
  availableSessionHostCount     = @($SessionHostSummary | Where-Object { $_.status -eq 'Available' }).Count
  reportedSessionCount          = ($SessionHostSummary | Measure-Object -Property sessions -Sum).Sum
  activeUserSessionRecordCount  = $AllUserSessions.Count
}

if ($IncludeSensitiveOutput) {
  Write-Warning 'Sensitive output mode is enabled. Do not paste this output into a public repository.'
  $SessionHostSummary
  $AllUserSessions
}
else {
  $Summary
}

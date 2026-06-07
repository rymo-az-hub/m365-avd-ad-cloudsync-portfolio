#requires -Version 5.1
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  [ValidateNotNullOrEmpty()]
  [string]$ResourceGroupName,

  [Parameter(Mandatory = $true)]
  [ValidateNotNullOrEmpty()]
  [string]$HostPoolName,

  [string]$ApiVersion = '2024-04-03'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Do not commit raw command output to the public repository.
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
      sessions        = $_.properties.sessions
      agentVersion    = $_.properties.agentVersion
    }
  }
)

$SessionHostSummary

foreach ($SessionHost in $SessionHostSummary) {
  $EscapedSessionHostName = [System.Uri]::EscapeDataString($SessionHost.sessionHostName)
  $UserSessionsUri = "https://management.azure.com/subscriptions/$SubId/resourceGroups/$ResourceGroupName/providers/Microsoft.DesktopVirtualization/hostPools/$HostPoolName/sessionHosts/$EscapedSessionHostName/userSessions?api-version=$ApiVersion"
  $UserSessionsResp = az rest --method GET --url $UserSessionsUri | ConvertFrom-Json

  $UserSessionsResp.value |
    Select-Object @{Name='sessionHostName';Expression={$SessionHost.sessionHostName}},
      name,
      @{Name='userPrincipalName';Expression={$_.properties.userPrincipalName}},
      @{Name='sessionState';Expression={$_.properties.sessionState}}
}

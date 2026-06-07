param(
  [Parameter(Mandatory = $true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory = $true)]
  [string]$HostPoolName,

  [string]$ApiVersion = "2024-04-03"
)

$SubId = az account show --query id -o tsv
if (-not $SubId) { throw "Azure subscription ID could not be acquired." }

$SessionHostsUri = "https://management.azure.com/subscriptions/$SubId/resourceGroups/$ResourceGroupName/providers/Microsoft.DesktopVirtualization/hostPools/$HostPoolName/sessionHosts?api-version=$ApiVersion"
$SessionHostsResp = az rest --method GET --url $SessionHostsUri | ConvertFrom-Json

$SessionHostsResp.value |
  Select-Object name,
    @{Name='sessionHostName';Expression={($_.name -split '/')[-1]}},
    @{Name='status';Expression={$_.properties.status}},
    @{Name='allowNewSession';Expression={$_.properties.allowNewSession}},
    @{Name='sessions';Expression={$_.properties.sessions}},
    @{Name='agentVersion';Expression={$_.properties.agentVersion}}

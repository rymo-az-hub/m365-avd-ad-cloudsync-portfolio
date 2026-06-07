#requires -Version 5.1
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  [ValidateNotNullOrEmpty()]
  [string]$OnPremisesDomainName
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# This script uses az rest so that access tokens are not materialized into PowerShell variables.
# Do not commit raw command output to the public repository.
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

$AllUsers |
  Where-Object {
    $_.onPremisesSyncEnabled -eq $true -and
    $_.onPremisesDomainName -eq $OnPremisesDomainName
  } |
  Select-Object displayName,userPrincipalName,onPremisesDomainName,onPremisesSamAccountName,onPremisesLastSyncDateTime

#requires -Version 5.1
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  [ValidateNotNullOrEmpty()]
  [string]$UserPrincipalName
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# This script uses az rest so that access tokens are not materialized into PowerShell variables.
# Do not commit raw command output to the public repository.
$Select = 'displayName,userPrincipalName,onPremisesSyncEnabled,onPremisesDistinguishedName,onPremisesDomainName,onPremisesSamAccountName,onPremisesLastSyncDateTime'
$Uri = "https://graph.microsoft.com/v1.0/users?`$filter=userPrincipalName eq '$UserPrincipalName'&`$select=$Select"

az rest --method GET --url $Uri

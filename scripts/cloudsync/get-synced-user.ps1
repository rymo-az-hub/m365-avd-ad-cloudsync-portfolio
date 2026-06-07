param(
  [Parameter(Mandatory = $true)]
  [string]$UserPrincipalName
)

$Uri = "https://graph.microsoft.com/v1.0/users?`$filter=userPrincipalName eq '$UserPrincipalName'&`$select=displayName,userPrincipalName,onPremisesSyncEnabled,onPremisesDistinguishedName,onPremisesDomainName,onPremisesSamAccountName,onPremisesLastSyncDateTime"

az rest --method GET --url $Uri

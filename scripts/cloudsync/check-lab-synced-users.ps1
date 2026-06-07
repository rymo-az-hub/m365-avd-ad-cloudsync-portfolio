param(
  [Parameter(Mandatory = $true)]
  [string]$OnPremisesDomainName
)

$Token = az account get-access-token --resource "https://graph.microsoft.com/" --query accessToken -o tsv
if (-not $Token) { throw "Microsoft Graph access token could not be acquired." }

$Headers = @{ Authorization = "Bearer $Token" }
$Uri = "https://graph.microsoft.com/v1.0/users?`$select=displayName,userPrincipalName,onPremisesSyncEnabled,onPremisesDistinguishedName,onPremisesDomainName,onPremisesSamAccountName,onPremisesLastSyncDateTime&`$top=999"

$AllUsers = @()
do {
  $Resp = Invoke-RestMethod -Method Get -Uri $Uri -Headers $Headers
  $AllUsers += @($Resp.value)
  $Uri = $Resp.'@odata.nextLink'
} while ($Uri)

$AllUsers |
  Where-Object { $_.onPremisesSyncEnabled -eq $true -and $_.onPremisesDomainName -eq $OnPremisesDomainName } |
  Select-Object displayName,userPrincipalName,onPremisesDomainName,onPremisesSamAccountName,onPremisesLastSyncDateTime

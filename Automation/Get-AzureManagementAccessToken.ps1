$connection = Get-AutomationConnection -Name 'AzureRunAsConnection'
# Write-Output "connection"
# Write-Output -InputObject $connection

$loginresults = Connect-AzAccount -ServicePrincipal -Tenant $connection.TenantId -ApplicationId $connection.ApplicationId -CertificateThumbprint $connection.CertificateThumbprint
# Write-Output "loginresults"
# Write-Output -InputObject $loginresults

$context = Get-AzContext
# Write-Output "context"
# Write-Output -InputObject $context

$SubscriptionId = $context.Subscription

$AccessToken = Get-AzAccessToken -ResourceUrl 'https://management.core.windows.net/'
$token = $AccessToken.Token

Write-Output -InputObject @{AccessToken = $token; SubscriptionId = $SubscriptionId }
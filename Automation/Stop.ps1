$subscriptionId = Get-AutomationVariable -Name subscriptionId
$resourceGroupName = Get-AutomationVariable -Name resourceGroupName
$resourceName = Get-AutomationVariable -Name resourceName

$url = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.ContainerService/managedClusters/$resourceName/stop?api-version=2021-03-01"

$accessDetails = .\Get-AzureManagementAccessToken.ps1
$AccessToken = $accessDetails.AccessToken

$state = .\State.ps1 -SubscriptionId $subscriptionId -ResourceGroupName $resourceGroupName -ResourceName $resourceName -AccessToken $AccessToken
Write-Output $state

if ($state -eq "Running")
{
    Write-Output "Stopping ..."
    $headerParams = @{'Authorization'="Bearer $AccessToken"}

    Invoke-RestMethod -Method 'Post' -Uri $url -Headers $headerParams
}
else
{
    Write-Output "Already Stopped."
}
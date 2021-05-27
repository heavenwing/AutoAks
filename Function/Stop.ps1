using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

$ResourceGroupName = "YourResoureGroupNameOfAksCluster"
$ResourceName = "YourResourceNameOfAksCluster"
$body= "Started"

try
{
    $context = Get-AzContext

    $SubscriptionId = $context.Subscription

    $AccessToken = Get-AzAccessToken -ResourceUrl 'https://management.core.windows.net/'
    $token = $AccessToken.Token

    $urlState = "https://management.azure.com/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroupName/providers/Microsoft.ContainerService/managedClusters/$ResourceName/?api-version=2021-03-01"

    $headerParams = @{'Authorization'="Bearer $token"}

    $cluster = Invoke-RestMethod -Method 'Get' -Uri $urlState -Headers $headerParams

    if ($cluster.properties.powerState.code -eq "Running")
    {
        $urlStart = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.ContainerService/managedClusters/$resourceName/stop?api-version=2021-03-01"
        Invoke-RestMethod -Method 'Post' -Uri $urlStart -Headers $headerParams
    }
    else
    {
        $body = "Already Stopped"
    }
}
catch
{
    $body = $_.ToString()
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})

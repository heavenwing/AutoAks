param (
    $AccessToken,
    $SubscriptionId,
    $ResourceGroupName,
    $ResourceName
)

$url = "https://management.azure.com/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroupName/providers/Microsoft.ContainerService/managedClusters/$ResourceName/?api-version=2021-03-01"

$headerParams = @{'Authorization'="Bearer $AccessToken"}

$cluster = Invoke-RestMethod -Method 'Get' -Uri $url -Headers $headerParams

Write-Output $cluster.properties.powerState.code

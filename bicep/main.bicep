targetScope = 'resourceGroup'

@description('Location to deploy to')
param location string = resourceGroup().location
@description('Environment to deploy to')
param env string = 'dev'
@description('Service ID used in resource naming to group all related resources')
param serviceId string

param clientConfig object = {
  clients: [
    {
      name: 'client1'
      apiUrl: '123'
    }
    {
      name: 'client2'
      apiUrl: '456'
    }
  ]
}

var hostingPlanName = 'fnapp-hosting-plan-${serviceId}-${env}'
var applicationInsightsName = 'fnapp-insights-${serviceId}-${env}'

resource storage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'clistrg${env}${uniqueString(resourceGroup().id)}'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    supportsHttpsTrafficOnly: true
    defaultToOAuthAuthentication: true
  }
}

resource hostingPlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: hostingPlanName
  location: location
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
  properties: {}
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}

module storageMod 'modules/fnapp.bicep' = [for client in clientConfig.clients: {
  name: 'storage-fn-${client.name}-${env}'
  params: {
    location: location
    env: env
    serviceId: serviceId
    clientName: client.name
    apiUrl: client.apiUrl
    hostingPlanId: hostingPlan.id
    storageName: storage.name
    storageKey: storage.listKeys().keys[0].value  
    applicationInsightsKey: applicationInsights.properties.InstrumentationKey
  }
}]

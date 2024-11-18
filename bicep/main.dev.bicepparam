using './main.bicep'

param env = 'dev'
param serviceId = 'mbefnclient'
param clientConfig = {
  clients: [
    {
      name: 'Dev-Client'
      apiUrl: 'https://apim-aisv31-dev.azure-api.net/DEV/'
    }
    {
      name: 'SIT-Client'
      apiUrl: 'https://apim-aisv31-dev.azure-api.net/SIT/'
    }
    {
      name: 'PreProd-Client'
      apiUrl: 'https://apim-aisv31-dev.azure-api.net/CFT2/'
    }
    {
      name: 'Prod-Client'
      apiUrl: 'https://apim-aisv31-dev.azure-api.net/PROD/'
    }
  ]
}


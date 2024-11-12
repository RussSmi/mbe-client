using './main.bicep'

param env = 'dev'
param serviceId = 'mbefnclient'
param clientConfig = {
  clients: [
    {
      name: 'Dev-Client'
      apiUrl: '123'
    }
    {
      name: 'SIT-Client'
      apiUrl: '456'
    }
    {
      name: 'PreProd-Client'
      apiUrl: '456'
    }
    {
      name: 'Prod-Client'
      apiUrl: '456'
    }
  ]
}


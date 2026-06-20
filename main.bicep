@description('ストレージアカウントの名前（3〜24文字の小文字英数字）')
@minLength(3)
@maxLength(24)
param storageAccountName string

@description('リソースをデプロイするAzureリージョン')
param location string = resourceGroup().location

@description('ストレージアカウントのSKU（冗長性タイプ）')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
])
param skuName string = 'Standard_LRS'

@description('ストレージアカウントの種類')
@allowed([
  'StorageV2'
  'Storage'
  'BlobStorage'
])
param kind string = 'StorageV2'

@description('アクセス層（BlobStorageおよびStorageV2の場合に適用）')
@allowed([
  'Hot'
  'Cool'
])
param accessTier string = 'Hot'

@description('Blobコンテナの名前')
@minLength(3)
@maxLength(63)
param containerName string = 'mycontainer'

@description('コンテナのパブリックアクセスレベル')
@allowed([
  'None'
  'Blob'
  'Container'
])
param publicAccess string = 'None'

@description('HTTPSのみのトラフィックを強制するか')
param supportsHttpsTrafficOnly bool = true

@description('最小TLSバージョン')
@allowed([
  'TLS1_0'
  'TLS1_1'
  'TLS1_2'
])
param minimumTlsVersion string = 'TLS1_2'

@description('リソースに付けるタグ')
param tags object = {}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  tags: tags
  sku: {
    name: skuName
  }
  kind: kind
  properties: {
    accessTier: accessTier
    supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
    minimumTlsVersion: minimumTlsVersion
    allowBlobPublicAccess: publicAccess != 'None'
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccount
  name: 'default'
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: containerName
  properties: {
    publicAccess: publicAccess
  }
}

@description('ストレージアカウントのリソースID')
output storageAccountId string = storageAccount.id

@description('ストレージアカウントのプライマリエンドポイント')
output primaryBlobEndpoint string = storageAccount.properties.primaryEndpoints.blob

@description('Blobコンテナのリソースid')
output containerId string = container.id

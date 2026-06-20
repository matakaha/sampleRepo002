using './main.bicep'

// ストレージアカウントの名前（3〜24文字の小文字英数字。グローバルで一意である必要があります）
param storageAccountName = 'mystorageaccount001'

// Azureリージョン（例: japaneast, japanwest, eastus, westeurope）
param location = 'japaneast'

// SKU（冗長性タイプ）
// Standard_LRS  : ローカル冗長ストレージ
// Standard_GRS  : geo冗長ストレージ
// Standard_RAGRS: 読み取りアクセスgeo冗長ストレージ
// Standard_ZRS  : ゾーン冗長ストレージ
// Premium_LRS   : Premiumローカル冗長ストレージ
// Premium_ZRS   : Premiumゾーン冗長ストレージ
param skuName = 'Standard_LRS'

// ストレージアカウントの種類
// StorageV2   : 汎用v2（推奨）
// Storage     : 汎用v1
// BlobStorage : BlobStorage専用アカウント
param kind = 'StorageV2'

// アクセス層（StorageV2 / BlobStorage の場合に適用）
// Hot  : 頻繁にアクセスするデータ向け
// Cool : あまりアクセスしないデータ向け
param accessTier = 'Hot'

// 作成するBlobコンテナの名前
param containerName = 'mycontainer'

// コンテナのパブリックアクセスレベル
// None      : パブリックアクセス無効（推奨）
// Blob      : BlobのみパブリックRead可
// Container : コンテナ一覧・BlobともにパブリックRead可
param publicAccess = 'None'

// HTTPSのみ強制（セキュリティ上 true 推奨）
param supportsHttpsTrafficOnly = true

// 最小TLSバージョン
param minimumTlsVersion = 'TLS1_2'

// タグ（任意のキーと値のペア）
param tags = {
  environment: 'dev'
  project: 'sampleRepo002'
}

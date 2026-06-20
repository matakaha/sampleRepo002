# sampleRepo002

Azure Blob Storage を 1 つ作成する Bicep テンプレートです。

## このテンプレートで作成される環境

`main.bicep` では、次の Azure リソースを作成します。

- ストレージアカウント: `Microsoft.Storage/storageAccounts`
- Blob サービス（default）: `Microsoft.Storage/storageAccounts/blobServices`
- Blob コンテナ: `Microsoft.Storage/storageAccounts/blobServices/containers`

あわせて、以下の出力を返します。

- `storageAccountId`
- `primaryBlobEndpoint`
- `containerId`

## 既定パラメータ（main.bicepparam）

- リージョン: `japaneast`
- SKU: `Standard_LRS`
- 種類: `StorageV2`
- アクセス層: `Hot`
- コンテナ名: `mycontainer`
- パブリックアクセス: `None`
- HTTPS 強制: `true`
- 最小 TLS: `TLS1_2`

## デプロイ例

```bash
az deployment group create \
  --resource-group <your-resource-group> \
  --template-file main.bicep \
  --parameters @main.bicepparam
```

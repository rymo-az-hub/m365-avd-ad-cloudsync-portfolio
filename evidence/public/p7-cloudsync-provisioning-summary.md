# P7 Cloud Sync Provisioning証跡サマリー

## 結果

AD DSラボドメイン上の選定ユーザーを、Microsoft Entra Cloud SyncでMicrosoft Entra IDへ同期できました。

## 公開用検証結果

| 項目 | 結果 |
|---|---|
| Source | AD DS lab domain |
| Target | Microsoft Entra ID |
| Sync direction | AD DS to Microsoft Entra ID |
| Scope type | Selected security group |
| Scope group | `GG-CloudSync-Users` |
| On-demand provisioning | 成功 |
| Normal sync | 成功 |
| Provisioning action | Create確認 |
| Synced lab-domain user count | 1 |
| Synced target | `<SYNCED_USER_UPN>` |
| `onPremisesSyncEnabled` | `true` |

## Scope証跡の考え方

On-demand provisioningは、選択した1ユーザーで同期構成を確認するために利用しました。ただし、On-demand provisioningは通常同期Scopeの唯一の証跡としては扱っていません。

最終判断は、通常同期、Provisioning logs、Microsoft Graphでの同期属性確認を組み合わせて行いました。

## トラブルシュート要約

| 事象 | 対応 |
|---|---|
| Cloud Sync構成画面でドメインが表示されない | Portalサインアウト/サインインで表示が回復。 |
| On-demand import ResourceNotFound | 入力DNのCNが誤っていたため、AD DSから正確なDistinguishedNameを取得して再実行。 |

## 非公開原本

- Provisioning logs原本
- Graph JSON原本
- Portalスクリーンショット
- UPN / Object ID / Request ID / Tenant IDを含むログ

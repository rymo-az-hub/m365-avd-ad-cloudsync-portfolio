# Runbook: Cloud Sync構成・同期確認

## 目的

AD DSラボドメインからMicrosoft Entra IDへ、選定ユーザーのみをMicrosoft Entra Cloud Syncで同期します。

## 前提

| 項目 | 前提 |
|---|---|
| AD DS | ラボドメイン構成済み |
| Cloud Sync Agent | Active |
| gMSA | Agent構成で利用 |
| 同期対象 | Selected security group |
| 初回同期 | 1 userのみ |

## 事前確認

1. AD DS上で同期対象グループが存在することを確認する。
2. 同期対象ユーザーがグループの直接メンバーであることを確認する。
3. Microsoft Entra ID側に同一UPNの既存クラウドユーザーがないことを確認する。
4. Cloud Sync AgentがActiveであることを確認する。

## スコープ設定

| 項目 | 設定 |
|---|---|
| Scope type | Selected security group |
| Scope group | `GG-CloudSync-Users` |
| Selected security groups | direct members onlyを前提とし、同期対象ユーザーは直接メンバーにする。 |

Security Groupスコープは、パイロットや段階展開に向いた方式です。定常運用ではOU設計、グループ運用、変更管理、対象外条件を別途設計します。

## On-demand provisioningの位置づけ

On-demand provisioningは、選択した1ユーザーまたは1グループで同期構成を検証するために利用します。これは単体検証機能であり、通常同期全体の代替証跡ではありません。

重要:

- On-demand provisioningは単体検証として有効です。一方で、実務上の証跡設計では、通常同期のProvisioning logsとGraph確認でsteady-stateを補完します。
- ただし、選択ユーザーに対するscoping filtersの評価は通常同期と同じ証跡にはなりません。
- 最終的なScope確認は、通常同期、Provisioning logs、Graph確認で補完します。

## 通常同期確認

| 確認 | 期待値 |
|---|---|
| Provisioning logs | 対象ユーザーのCreateまたはUpdate成功 |
| Graph user property | `onPremisesSyncEnabled = true` |
| Lab domain synced users | 1 |
| onPremisesDomainName | ラボADドメイン |

## 代表的なトラブルシュート

| 事象 | 原因 | 対応 |
|---|---|---|
| ドメインドロップダウンが空 | Portalセッション/Blade反映遅延 | サインアウト/再ログイン、Agent状態確認 |
| On-demand importでResourceNotFound | 入力DNが実DNと異なる | ADからDistinguishedNameを再取得 |
| 同期対象が増える | Scopeまたはグループメンバー誤り | Group membershipとGraph結果を確認 |
| AgentがInactive | Agent server停止、サービス停止、通信障害 | VM/サービス/ネットワーク/Portal状態を確認 |

## 実務での注意

- Cloud Sync Agent serverはTier 0資産として扱います。
- Directory Synchronization AccountsをConditional Accessで誤ってブロックしないようにします。
- 複数Agent、監査ログ、同期失敗時のアラート、変更管理を設計します。
- 実行結果にはUPNやIDが含まれるため、公開リポジトリには貼り付けません。

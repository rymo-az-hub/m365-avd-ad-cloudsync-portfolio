# 公開用マスキング方針

## 基本方針

このリポジトリはGitHub公開前提のポートフォリオです。公開版では、検証結果を説明できる最小限の情報だけを残し、テナント固有情報や生証跡は含めません。

## 公開しないもの

| 種別 | 扱い |
|---|---|
| スクリーンショット原本 | 公開しない |
| Graph JSON / CSV export | 公開しない |
| Sign-in logs / Provisioning logs原本 | 公開しない |
| Excel / Word / PowerPointバイナリ | 公開しない |
| Tenant ID / Subscription ID | 公開しない |
| Object ID / Request ID / Correlation ID / Session ID | 公開しない |
| SID | 公開しない |
| UPN / 実メールアドレス | 公開しない |
| IPアドレス | 公開しない |
| token / secret / password | 公開しない |

## プレースホルダー規約

| 値 | 公開表記 |
|---|---|
| 同期ユーザーUPN | `<SYNCED_USER_UPN>` |
| クラウドユーザーUPN | `<CLOUD_USER_UPN>` |
| Tenant ID | `<TENANT_ID_REDACTED>` |
| Subscription ID | `<SUBSCRIPTION_ID_REDACTED>` |
| Object ID | `<OBJECT_ID_REDACTED>` |
| Request ID | `<REQUEST_ID_REDACTED>` |
| Correlation ID | `<CORRELATION_ID_REDACTED>` |
| SID | `<SID_REDACTED>` |
| Public IP | `<PUBLIC_IP_REDACTED>` |
| Private IP | `<PRIVATE_IP_REDACTED>` |
| Agent server | `<AGENT_SERVER_REDACTED>` |
| Resource group | `<RESOURCE_GROUP_REDACTED>` |
| Temporary password | 公開しない |

## 証跡の公開方針

公開版の`evidence/public/`には、Markdown形式の要約だけを配置します。

| 公開するもの | 公開しないもの |
|---|---|
| 検証目的 | Portalスクリーンショット |
| 判定結果 | Sign-in logs原本 |
| 抽象化した成功条件 | Provisioning logs原本 |
| トラブルシュート要約 | Graph JSON原本 |
| 実務との差分 | CSV/Excel原本 |

## 運用ルール

- 実行結果をREADME、Issue、Pull Request、commit messageへ貼り付けない。
- スクリプトの出力は非公開証跡フォルダに保存する。
- 公開前に`docs/repository/GitHub_Publication_Checklist.md`のスキャンを実行する。
- 公開後に漏えいが見つかった場合は、単純削除だけでなくGit履歴からの削除も検討する。

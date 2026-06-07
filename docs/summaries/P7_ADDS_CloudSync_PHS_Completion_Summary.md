# P7 AD DS / Cloud Sync / PHS完了サマリー

## 結果

AD DS / DNSラボドメインをAzure上に構築し、Microsoft Entra Cloud Syncで選定ADユーザーをMicrosoft Entra IDへ同期しました。さらにPassword Hash Syncを有効化し、AD側パスワード再設定後にMicrosoftクラウドへサインインできることを確認しました。

## 完了範囲

| 作業 | 結果 |
|---|---|
| AD DS / DNS VM構築 | 完了 |
| ラボドメイン作成 | 完了 |
| OU / Group / User作成 | 完了 |
| Cloud Sync Agent導入 | 完了 |
| Agent Active確認 | 完了 |
| Cloud Sync Configuration作成 | 完了 |
| Selected security group scope設定 | 完了 |
| On-demand provisioning | 成功 |
| 通常同期 | 成功 |
| Provisioning logs確認 | 成功 |
| Microsoft Graphによる同期ユーザー確認 | 成功 |
| Password Hash Sync | 有効化・確認済み |
| ADパスワード再設定 | 成功 |
| Microsoftクラウドサインイン | 成功 |
| Sign-in logs確認 | status/errorCode = 0を確認 |
| 検証後のVM deallocate | 完了 |

## Cloud Sync設計

| 項目 | 内容 |
|---|---|
| Source | AD DS lab domain |
| Target | Microsoft Entra ID |
| Sync direction | AD DS to Microsoft Entra ID |
| Scope | Selected security group |
| 初回同期対象 | 1 synced AD user |
| Attribute mapping | 既定値 |
| Agent配置 | DC同居。個人ラボのコスト優先判断。 |

## 検証上の重要ポイント

| ポイント | 内容 |
|---|---|
| On-demand provisioning | 単体ユーザー同期の動作確認として利用。これだけを通常同期Scopeの唯一の証跡にはしない。 |
| Scope証跡 | 通常同期、Provisioning logs、Graph確認で補完。 |
| PHS検証 | AD側でパスワードを再設定し、クラウド側サインイン成功とSign-in logsで確認。 |
| CA/MFA切り分け | PHS失敗とConditional Access/MFAの影響を混同しないよう、Sign-in logsで確認。 |

## 発生したトラブルと対応

| 事象 | 原因 | 対応 |
|---|---|---|
| Cloud Syncドメイン選択欄が空 | PortalセッションまたはBlade反映遅延 | サインアウト/再ログインで解消。 |
| On-demand importでResourceNotFound | 入力DNのCNが実際のADオブジェクトDNと異なった | AD DSから正確なDistinguishedNameを取得し再実行。 |
| Sign-in logsの初回Graph取得が空 | ログ反映遅延またはフィルター条件が厳しい | 直近ログを広めに取得して成功イベントを確認。 |
| Azure CLIでAVD session-hostコマンドが使えない | CLIサブコマンド差異 | ARM REST APIでSession Host / User Sessionを確認。 |

## 実務との差分

| 領域 | ラボ判断 | 実務での考慮 |
|---|---|---|
| Cloud Sync Agent | DC同居 | Tier 0資産として保護。専用サーバー、複数Agent、gMSA運用、監査を設計する。 |
| AD DS | 単一DC | 複数DC、バックアップ、監視、復旧試験、パッチ設計が必要。 |
| 同期スコープ | Selected security group | パイロットには有効。定常運用ではOU設計、グループ運用、変更管理を明確化する。 |
| VNet DNS | 本検証では広範囲に変更しない | AD DS名前解決やドメイン参加が必要なワークロードではCustom DNSが必要。 |
| VM停止 | ラボのコスト停止 | 本番DCには影響評価・復旧計画なしに適用しない。 |
| 監視 | 手動確認 | Log Analytics、アラート、監査ログ保持、レビュー運用を設計する。 |

## 公開証跡

- [Cloud Sync provisioning summary](../../evidence/public/p7-cloudsync-provisioning-summary.md)
- [Password Hash Sync sign-in summary](../../evidence/public/p7-phs-signin-summary.md)
- [Cost stop summary](../../evidence/public/p7-cost-stop-summary.md)

# 試験計画・結果サマリー

## 試験方針

このラボでは、単にリソースを作成するだけでなく、利用者目線・運用者目線の確認を行いました。
公開版では、スクリーンショットやGraph/CSV/JSON原本ではなく、検証結果をMarkdown要約として残しています。

## 試験結果

| ID | 試験項目 | 結果 | 補足 |
|---|---|---|---|
| T-AVD-01 | AVD Workspace / DAG / Session Host構成確認 | 成功 | Microsoft Entra joined構成 |
| T-AVD-02 | AVDユーザー接続 | 成功 | ユーザーセッションを確認 |
| T-AVD-03 | Session HostのIntune登録・準拠確認 | 成功 | Compliance確認済み |
| T-AVD-04 | Start VM on Connect | 成功 | 検証後にdeallocate運用も確認 |
| T-HYB-01 | AD DS / DNS基本正常性 | 成功 | ADWS、DNS、NTDS、KDC、Netlogonを確認 |
| T-HYB-02 | Cloud Sync Agent Active確認 | 成功 | Agentがクラウド側でActive表示 |
| T-HYB-03 | Cloud Sync scope設定 | 成功 | Selected security groupを利用 |
| T-HYB-04 | On-demand provisioning | 成功 | DN不一致を切り分け、正しいDNで成功 |
| T-HYB-05 | 通常同期 / Provisioning logs確認 | 成功 | Createイベント確認 |
| T-HYB-06 | Graphで同期ユーザー確認 | 成功 | onPremisesSyncEnabled = trueを確認 |
| T-PHS-01 | AD側パスワード再設定 | 成功 | PasswordLastSet更新を確認 |
| T-PHS-02 | PHSサインイン確認 | 成功 | Microsoftクラウドへサインイン成功 |
| T-PHS-03 | Sign-in logs確認 | 成功 | Sign-in logsのstatus/errorCode = 0を確認 |
| T-OPS-01 | AVDセッション確認後のVM停止 | 成功 | ACTIVE_USER_SESSION_COUNT=0を確認後にdeallocate |

## 主なトラブルシュート

| 事象 | 原因 | 対応 |
|---|---|---|
| Cloud Sync構成画面でドメインが表示されない | PortalセッションまたはBlade反映遅延 | サインアウト/再ログインで解消 |
| On-demand importでResourceNotFound | 入力DNのCNが実際のADオブジェクトDNと異なる | ADからDistinguishedNameを再取得して再実行 |
| Sign-in logの初回Graph取得が空 | 反映遅延またはフィルター条件が厳しい | 最近のサインインを広めに取得し、成功イベントを確認 |
| Azure CLIのAVD session-hostサブコマンドが利用不可 | CLIサブコマンド差異 | ARM REST APIでSession Host / User Sessionを確認 |

## 公開版の制約

- 原本スクリーンショット、Graph JSON、CSVログ、Sign-in logs原本は非公開です。
- GitHub公開版では、要約結果と判定ロジックのみを掲載しています。

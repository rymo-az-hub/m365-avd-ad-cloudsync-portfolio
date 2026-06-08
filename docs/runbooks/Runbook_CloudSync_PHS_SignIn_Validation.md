# Runbook: Password Hash Syncサインイン検証

## 目的

AD DS側でパスワードを再設定した同期ユーザーが、Microsoftクラウドへサインインできることを確認します。

## 前提

| 項目 | 前提 |
|---|---|
| Cloud Sync | 構成済み、正常 |
| Password Hash Sync | 有効 |
| 同期ユーザー | Microsoft Entra ID上に存在し、`onPremisesSyncEnabled = true` |
| ADアカウント | Enabled |
| Sign-in logs | 確認可能 |

## 検証手順

1. AD DS側で対象ユーザーの一時パスワードを再設定する。
2. `PasswordLastSet`が更新されたことを確認する。
3. Cloud Sync / PHS状態が正常であることを確認する。
4. 数分待ってからInPrivate / シークレットウィンドウでMicrosoftクラウドへサインインする。
5. Sign-in logsで対象イベントを確認する。
6. Sign-in logsのstatus/errorCode = 0 の成功イベントを確認する。
7. 検証後、一時パスワードを放置せず、必要に応じて再変更・無効化・削除する。

## 同期待ち時間の目安

| 対象 | 目安 |
|---|---|
| Password Hash Sync | 数分程度を想定 |
| User / Group object provisioning | Password Hashとは別に反映待ちが発生し得る |

この検証では、ユーザーオブジェクトがEntra ID側に存在し、同期状態が正常であることを確認したうえで、PHSサインインを検証します。

## 待機時間とcredential hygiene

PHSは一般に数分単位で反映されます。ユーザー/グループオブジェクト同期とは別観点のため、対象ユーザーがEntra ID上で正常に作成・同期済みであることを確認したうえでサインイン試験を行います。

検証用に設定した一時パスワードは、検証完了後に再変更またはアカウント無効化する前提です。公開リポジトリやIssue/PRに一時パスワード、サインインログ原本、IP、Request IDを貼り付けません。

## 判定基準

| 結果 | 判定 |
|---|---|
| Microsoftクラウドへサインイン成功 | PHS検証成功 |
| Sign-in logsのstatus/errorCode = 0 | Sign-in logs上の成功イベント |
| MFA/CAで停止 | PHS失敗とは限らない。Sign-in logsで切り分ける。 |
| パスワード不正 | PHS未反映、入力誤り、AD側設定不備を確認する。 |

## 50140等の割り込みイベント

Keep Me Signed Inなどの割り込みイベントが記録される場合があります。この場合でも、後続でSign-in logsのstatus/errorCode = 0の成功イベントが確認できれば、PHS失敗とは扱いません。

## セキュリティ注意

- 一時パスワードは公開証跡に残さない。
- Sign-in logsのスクリーンショットやCSV原本は公開しない。
- IP、Request ID、Correlation ID、Session ID、UPNは公開しない。
- 検証後に一時パスワードをローテーションする。
- Conditional Accessの設計では、Emergency access accountとDirectory Synchronization Accountsを誤ってブロックしない。

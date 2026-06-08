# P7 Password Hash Syncサインイン証跡サマリー

## 結果

Password Hash Syncのサインイン検証は成功しました。

## 公開用検証結果

| 項目 | 結果 |
|---|---|
| AD password reset | 成功 |
| AD `PasswordLastSet` | 検証時に更新確認 |
| Cloud Sync configuration | 検証時に正常 |
| Password Hash Sync | 有効 |
| Cloud sign-in | 成功 |
| Application | Microsoft profile/account experience |
| Client app | Browser |
| status/errorCode | 0 |
| Failure reason | 成功イベントでは該当なし |
| Conditional Access | 取得した成功イベントでは未適用 |

## 判定

Sign-in logsのstatus/errorCode = 0の成功イベントと、Microsoftクラウドへのサインイン成功をもって、PHS検証成功と判断しました。

Keep Me Signed Inの割り込みイベントは別途記録されましたが、後続の成功イベントが確認できたため、PHS失敗とは扱っていません。

## 非公開原本

- Sign-in logsスクリーンショット
- Sign-in logs CSV/JSON原本
- IP、Request ID、Correlation ID、Session ID、UPNを含むログ
- 検証用一時パスワード

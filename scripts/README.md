# Scripts

このディレクトリには、ポートフォリオ内で利用した確認パターンを、公開用に抽象化したPowerShellスクリプトとして配置しています。

## 注意

- スクリプトにはテナント固有の値、token、password、Object ID、SID、UPNの実値を含めていません。
- 既定出力は公開貼り付けしやすい最小サマリーにしています。
- `-IncludeSensitiveOutput`を指定すると、UPN、同期属性、Resource ID、IPなどの詳細が出る場合があります。
- 詳細出力はprivate evidenceとして扱い、公開リポジトリへコミットしないでください。
- 実行にはAzure CLIログインと、Microsoft Graph / Azure RBACの適切な権限が必要です。

## 配置

| Path | 用途 |
|---|---|
| `scripts/cloudsync/get-synced-user.ps1` | 指定UPNの同期属性確認 |
| `scripts/cloudsync/check-lab-synced-users.ps1` | 指定オンプレミスドメイン由来の同期ユーザー一覧確認 |
| `scripts/avd/check-avd-sessions-rest.ps1` | ARM REST APIによるAVD Session Host / User Session確認 |
| `scripts/azure/deallocate-lab-vms.ps1` | ラボVMのdeallocateサンプル |


## 共通パラメータ

| パラメータ | 用途 | 注意 |
|---|---|---|
| `-IncludeSensitiveOutput` | 詳細な実行結果を表示する | UPN、DN、Resource ID、Session Host名などが含まれる可能性があるため、公開貼り付け禁止 |

原則として、GitHub、Issue、Pull Request、READMEには既定出力または手作業で抽象化したMarkdown要約のみを掲載します。

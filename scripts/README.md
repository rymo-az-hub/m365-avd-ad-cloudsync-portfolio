# Scripts

このディレクトリには、ポートフォリオ内で利用した確認パターンを、公開用に抽象化したPowerShellスクリプトとして配置しています。

## 注意

- スクリプトにはテナント固有の値、token、password、Object ID、SID、UPNの実値を含めていません。
- 実行結果にはUPN、同期属性、Resource ID、IPなどが含まれる可能性があります。
- 実行結果は公開リポジトリへコミットしないでください。
- 実行にはAzure CLIログインと、Microsoft Graph / Azure RBACの適切な権限が必要です。

## 配置

| Path | 用途 |
|---|---|
| `scripts/cloudsync/get-synced-user.ps1` | 指定UPNの同期属性確認 |
| `scripts/cloudsync/check-lab-synced-users.ps1` | 指定オンプレミスドメイン由来の同期ユーザー一覧確認 |
| `scripts/avd/check-avd-sessions-rest.ps1` | ARM REST APIによるAVD Session Host / User Session確認 |
| `scripts/azure/deallocate-lab-vms.ps1` | ラボVMのdeallocateサンプル |

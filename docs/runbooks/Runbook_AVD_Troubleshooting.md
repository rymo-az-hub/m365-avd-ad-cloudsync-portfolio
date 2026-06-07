# Runbook: AVD Troubleshooting

## 目的

AVD接続、Session Host状態、ユーザーセッション、Intune状態の一次切り分けを行います。

## 主な確認観点

| 観点 | 確認内容 |
|---|---|
| Host Pool | Session Hostが登録されているか |
| Session Host | Available / Unavailable / Needs Assistanceなどの状態 |
| User Session | 接続中ユーザー、セッション数 |
| Assignment | ユーザーがDesktop Application Groupに割り当てられているか |
| RBAC | VM User Login等の権限が不足していないか |
| Intune | デバイス登録、準拠状態、ポリシー適用 |
| Sign-in logs | Conditional Access、MFA、認証失敗理由 |

## CLI / RESTの注意

Azure CLIのDesktop Virtualizationサブコマンドは環境によって利用できる範囲が異なる場合があります。このラボでは、AVD Session Host / User Session確認にARM REST APIを利用するパターンも用意しています。

公開用スクリプト:

- `scripts/avd/check-avd-sessions-rest.ps1`

## よくある切り分け

| 事象 | 確認 |
|---|---|
| Workspaceにデスクトップが出ない | DAG割り当て、ユーザーグループ、アプリグループ |
| 接続できない | RBAC、CA/MFA、Session Host状態、RDPプロパティ |
| Session HostがAvailableにならない | AVD Agent、ネットワーク、VM状態、Intune状態 |
| Start VM on Connectが動かない | Host Pool設定、AVD service principalのRBAC、VM power state |

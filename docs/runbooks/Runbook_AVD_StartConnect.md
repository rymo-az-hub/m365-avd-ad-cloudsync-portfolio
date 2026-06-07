# Runbook: AVD Start / Connect確認

## 目的

Azure Virtual DesktopのSession Hostが利用可能であり、ユーザーがWorkspace / Desktop Application Group経由で接続できることを確認します。

## 前提

| 項目 | 前提 |
|---|---|
| Session Host | Microsoft Entra joined |
| 管理 | Microsoft Intune登録済み |
| ユーザー権限 | Desktop Application Group割り当て済み |
| VMログイン | 必要なAzure RBACを付与済み |
| Start VM on Connect | 有効化済み |

## Start VM on Connectの注意

Start VM on Connectを実務で利用する場合、Azure Virtual Desktop service principalに対して、適切なスコープでDesktop Virtualization Power On Contributor相当の権限を付与する必要があります。ラボでは動作確認済みですが、実務ではRBACスコープ、変更管理、監査証跡を設計に含めます。

## 確認手順

1. Host Pool、Workspace、Desktop Application Groupが存在することを確認する。
2. ユーザーがDesktop Application Groupに割り当てられていることを確認する。
3. Session HostのPower stateを確認する。
4. Start VM on Connectを利用する場合、停止状態から接続してVMが起動することを確認する。
5. 接続後、セッション数が増えることを確認する。
6. Intune側でSession Hostの登録・準拠状態を確認する。

## 期待結果

| 項目 | 期待値 |
|---|---|
| AVD接続 | 成功 |
| Session count | 接続ユーザー数に応じて増加 |
| Intune compliance | 準拠 |
| Sign-in / Audit | 異常なし |

## 実務での追加観点

- SSO設定
- FSLogix / Profile Container
- 監視とアラート
- Scale plan
- ユーザー通知
- 接続失敗時の一次切り分け手順

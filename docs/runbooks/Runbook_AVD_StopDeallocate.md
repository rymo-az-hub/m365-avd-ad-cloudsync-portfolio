# Runbook: AVD Stop / Deallocate

## 目的

個人ラボのコスト停止を目的に、Azure Virtual Desktop Session Host VMを安全にdeallocateします。

> **LAB ONLY:** この手順は個人ラボ向けです。本番AVD環境では、ユーザー通知、drain、影響評価、変更承認、復旧手順を設計してください。

## 停止前確認

| 確認項目 | 期待値 |
|---|---|
| 実行端末 | 停止対象AVD Session Hostではない |
| Active sessions | 0 |
| Disconnected sessions | 0、または利用者影響を確認したうえで扱いを記録 |
| User sessions | 0 |
| allowNewSession | 必要に応じてfalseへ変更 |
| 証跡 | 停止前状態を記録 |

## 停止手順

1. Session Hostのsessions数を確認する。
2. Active / Disconnectedを含むUser Sessionが残っていないことを確認する。
3. 必要に応じて新規セッション受け入れを停止する。
4. Disconnectedセッションを切断・ログオフ対象にする場合は、利用者影響と判断理由を作業記録に残す。
5. VMをdeallocateする。
6. Power stateが`VM deallocated`になったことを確認する。

## 再開後確認

| 確認項目 | 内容 |
|---|---|
| VM power state | Running |
| AVD Session Host status | Available |
| User connection | 必要に応じて接続試験 |
| Intune compliance | 必要に応じて準拠状態確認 |

## 実務での注意

- 本番AVDではユーザー通知、メンテナンスウィンドウ、drain設定、ログ保持を行います。
- Disconnectedセッションにも未保存作業が残る可能性があるため、Activeセッションと同様に扱いを明確にします。
- 強制切断やログオフは業務影響が大きいため、セッション状態を必ず確認します。

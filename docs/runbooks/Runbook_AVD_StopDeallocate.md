# Runbook: AVD Stop / Deallocate

## 目的

個人ラボのコスト停止を目的に、Azure Virtual Desktop Session Host VMを安全にdeallocateします。

> **LAB ONLY:** この手順は個人ラボ向けです。本番AVD環境では、ユーザー通知、drain、影響評価、変更承認、復旧手順を設計してください。

## 停止前確認

| 確認項目 | 期待値 |
|---|---|
| 実行端末 | 停止対象AVD Session Hostではない |
| Active sessions | 0 |
| User sessions | 0 |
| allowNewSession | 必要に応じてfalseへ変更 |
| 証跡 | 停止前状態を記録 |

## 停止手順

1. Session Hostのsessions数を確認する。
2. User Sessionが残っていないことを確認する。
3. 必要に応じて新規セッション受け入れを停止する。
4. VMをdeallocateする。
5. Power stateが`VM deallocated`になったことを確認する。

## 再開後確認

| 確認項目 | 内容 |
|---|---|
| VM power state | Running |
| AVD Session Host status | Available |
| User connection | 必要に応じて接続試験 |
| Intune compliance | 必要に応じて準拠状態確認 |

## 実務での注意

- 本番AVDではユーザー通知、メンテナンスウィンドウ、drain設定、ログ保持を行います。
- 強制切断は業務影響が大きいため、セッション状態を必ず確認します。

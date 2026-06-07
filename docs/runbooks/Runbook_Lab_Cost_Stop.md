# Runbook: Lab Cost Stop

## 目的

個人ラボの検証後に、AVD Session Host VMとAD DS / DNS VMをdeallocateし、Computeコストを停止します。

> **LAB ONLY:** この手順は個人ラボのコスト停止用です。本番DC、ID基盤、AVD環境に対して、影響評価・変更承認・復旧計画なしに適用しないでください。

## 停止前確認

| 確認項目 | 期待値 |
|---|---|
| 実行端末 | 停止対象AVD Session Hostではない |
| AVD Session Host sessions | 0 |
| AVD User Sessions | 0 |
| 停止対象VM | DC VM、AVD VMのみ |
| 証跡 | 停止前のPower stateとセッション状態を記録 |

## 停止手順

1. AVD Session Hostのsessions数を確認する。
2. User Sessionが残っていないことを確認する。
3. DC VMとAVD VMのPower stateを確認する。
4. 対象VMをdeallocateする。
5. `VM deallocated`になったことを確認する。

## 停止中の想定状態

Cloud Sync AgentをこのラボではDCに同居させています。そのため、DC VMをdeallocateするとAgentをホストするサーバー自体が停止し、Microsoft Entra管理センター上でAgentがInactiveまたは未接続に見える可能性があります。これはラボ停止中の想定動作です。

## 再開後確認

| 順番 | 確認項目 | 期待値 |
|---:|---|---|
| 1 | DC VM起動 | Running |
| 2 | AD DSサービス | ADWS / DNS / NTDS / KDC / NetlogonがRunning |
| 3 | DNS名前解決 | ラボドメイン名を解決できる |
| 4 | Cloud Sync Agent | Activeに戻る |
| 5 | Cloud Sync configuration | Healthy / Normal |
| 6 | AVD VM起動 | Running |
| 7 | AVD Session Host | Available |
| 8 | サインイン試験 | 必要に応じてクラウドサインインを確認 |

## 実務での注意

- 本番DCのdeallocateは原則として安易に実施しません。
- 全DC停止、復旧順序、SYSVOL/DFSR、時刻同期、DNS、RID、バックアップなどを考慮する必要があります。
- 本番AVD停止では、ユーザー通知、drain、変更承認、復旧確認を行います。

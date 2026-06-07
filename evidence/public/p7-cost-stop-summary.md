# P7 Cost Stop証跡サマリー

## 結果

検証後、ラボ用DC VMとAVD Session Host VMをdeallocateしました。

## 公開用検証結果

| 項目 | 結果 |
|---|---|
| 実行端末 | 管理端末。停止対象AVD Session Hostではない。 |
| AVD Session Host状態 | 停止前にAvailableを確認 |
| AVD active sessions | 0 |
| AVD user sessions | 0 |
| DC VM停止前 | Running |
| AVD VM停止前 | Running |
| DC VM deallocate | 成功 |
| AVD VM deallocate | 成功 |
| DC VM停止後 | VM deallocated |
| AVD VM停止後 | VM deallocated |

## 注意

このラボではCloud Sync AgentをDCに同居させています。そのため、DC VMをdeallocateすると、Agentをホストするサーバー自体が停止し、Microsoft Entra管理センター上でAgentがInactiveまたは未接続に見える可能性があります。これはラボ停止中の想定動作です。

## 非公開原本

- VM power state出力
- AVD Session Host / User Session確認出力
- Portalスクリーンショット
- Resource group名やVM名を含む操作ログ

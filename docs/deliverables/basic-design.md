# 基本設計サマリー

## 設計ブロック

| ブロック | 設計概要 |
|---|---|
| Identity | Microsoft Entra IDをクラウドID制御面として利用する。 |
| Conditional Access | ユーザー/管理者アクセスに対するCA/MFAの基本方針を整理する。 |
| Endpoint Management | Microsoft Intuneによる登録・準拠確認を行う。 |
| Azure Virtual Desktop | Microsoft Entra joined session host、Workspace、Desktop Application Groupで構成する。 |
| Hybrid Identity | AD DSラボドメインをCloud SyncでEntra IDへ同期する。 |
| Authentication | Password Hash Syncを有効化し、ADパスワード再設定後のクラウドサインインを確認する。 |
| Operations | AVD、Cloud Sync、PHS、トラブルシュート、Cost StopのRunbookを整備する。 |

## 主要な設計判断

| 判断 | 理由 |
|---|---|
| AVD Session HostをMicrosoft Entra joinedにする | クラウド中心のAVD構成とIntune管理を示すため。 |
| AD DSはAVD前提ではなくHybrid Identity検証用に追加する | AVD Modern構成とAD DS/Cloud Syncの目的を分離し、設計意図を明確にするため。 |
| Classic full Connect SyncではなくCloud Syncを使う | 小規模・選定ユーザー同期の検証に適した軽量構成を示すため。 |
| 初回同期はSelected security groupで最小化する | 同期対象を1ユーザーに絞り、証跡と切り分けを明確にするため。 |
| 初回のAttribute mappingは既定値を使う | 初期同期時のトラブルシュート要素を減らすため。 |
| On-demand provisioningだけで完了扱いにしない | On-demandは単体検証であり、通常同期ログとGraph結果で補完する必要があるため。 |
| 公開証跡はMarkdown要約にする | GitHub公開時の情報漏えいリスクを下げるため。 |

## AVD設計メモ

| 項目 | 内容 |
|---|---|
| Join方式 | Microsoft Entra joined |
| 管理 | Microsoft Intune enrollment / compliance validation |
| Session type | ラボ検証用の単一Session Host。実務ではsingle-session / multi-session、OS edition、FSLogix要件を別途設計する。 |
| Start VM on Connect | 有効化・検証済み。実務ではAzure Virtual Desktop service principalへのDesktop Virtualization Power On Contributor割り当てなどRBAC前提を明記する。 |

## 実務との差分

| 領域 | ラボ | 実務での検討 |
|---|---|---|
| AD DS | 単一DC | 複数DC、バックアップ、監視、復旧試験、パッチ管理 |
| Cloud Sync Agent | DC同居 | Tier 0資産としての保護、専用メンバーサーバー、複数Agent、gMSA運用 |
| Monitoring | 手動確認 | Log Analytics、アラート、監査ログ保持、レビューサイクル |
| Deallocate | 手動のラボ停止 | 本番DCでは影響評価、変更管理、復旧計画が必須 |
| IaC | 手順・スクリプト中心 | Bicep / Terraform / GitHub Actionsによる再構築性の確保 |

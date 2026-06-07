# P6 AVD完了サマリー

## 結果

Azure Virtual DesktopのModern構成を検証し、Microsoft Entra joined session host、Intune登録、準拠確認、ユーザー接続、Start VM on Connect、deallocate運用まで確認しました。

## 検証範囲

| 項目 | 結果 |
|---|---|
| Host Pool | 作成済み |
| Workspace | 作成済み |
| Desktop Application Group | 作成・割り当て済み |
| Session Host | Microsoft Entra joined |
| Intune enrollment | 確認済み |
| Compliance | 確認済み |
| User connection | 成功 |
| Sessions count | 確認済み |
| Start VM on Connect | 有効化・検証済み |
| VM deallocate | 検証済み |

## 設計意図

| 判断 | 意図 |
|---|---|
| Microsoft Entra joined AVD | オンプレミスAD DS前提に寄せず、クラウド中心のAVD構成を示すため。 |
| Intune管理 | Session Hostを端末管理・準拠評価の対象として扱うため。 |
| Start VM on Connect | ラボのコスト最適化と、ユーザー接続時の起動運用を検証するため。 |
| Runbook化 | 接続、停止、トラブルシュートを作業ログではなく運用手順として残すため。 |

## 実務との差分

| 領域 | ラボ | 実務での考慮 |
|---|---|---|
| Session Host | 単一ホスト中心 | 複数Session Host、スケーリング、可用性、監視を設計する。 |
| Start VM on Connect | 有効化・動作確認 | Azure Virtual Desktop service principalへのDesktop Virtualization Power On Contributor割り当てなどRBAC前提を明記する。 |
| Profile | この公開版では対象外 | FSLogix、ストレージ、バックアップ、容量管理が必要。 |
| Monitoring | 手動確認 | Log Analytics、アラート、診断設定を設計する。 |

## 公開証跡

- [P6 AVD validation evidence summary](../../evidence/public/p6-avd-validation-summary.md)

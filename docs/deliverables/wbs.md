# WBSサマリー

## 完了済み作業パッケージ

| WBS | 作業 | 状態 | 主な成果物 |
|---|---|---|---|
| P0 | ラボ方針・作業フォルダ・証跡方針整理 | 完了 | README、マスキング方針 |
| P1 | Microsoft 365 / Entra ID初期設計 | 完了 | 要件整理、ID設計メモ |
| P2 | ユーザー/グループ設計 | 完了 | Entra ID設計、グループ設計 |
| P3 | Conditional Access / MFA設計 | 完了 | CA/MFA方針、セキュリティメモ |
| P4 | Intune初期設定 | 完了 | 登録・準拠ポリシー検証 |
| P5 | AVD設計準備 | 完了 | Host Pool / Workspace / DAG設計 |
| P6 | AVD構築・接続・運用検証 | 完了 | P6サマリー、AVD Runbook |
| P7-01 | AD DS / DNS用Azure VM構築 | 完了 | AD DS構築サマリー |
| P7-02 | AD DS / DNS構成 | 完了 | ドメイン正常性確認 |
| P7-03 | OU / Group / User作成 | 完了 | 同期対象ユーザー・グループ |
| P7-04 | Cloud Sync Agent導入 | 完了 | Agent Active確認 |
| P7-05 | 同期対象の事前確認 | 完了 | AD/Graph precheck |
| P7-06 | Cloud Sync Configuration作成 | 完了 | Security Group scope設定 |
| P7-07 | On-demand / 通常同期確認 | 完了 | Provisioning logs、Graph確認 |
| P7-08 | Password Hash Sync検証準備 | 完了 | ADパスワード再設定 |
| P7-09 | PHSサインイン確認 | 完了 | Sign-in logs成功確認 |
| P7-10 | コスト停止 | 完了 | AVD/DC VM deallocate Runbook |

## 未実装・今後の拡張候補

| WBS | 作業 | 状態 | 備考 |
|---|---|---|---|
| P8 | WSUS / Azure Update Manager比較検証 | 未実装 | パッチ管理設計の拡張候補 |
| P9 | Log Analytics / Alert / Workbook整備 | 未実装 | CloudOps Lead向けに有効 |
| P10 | Bicep / TerraformによるIaC化 | 未実装 | 再構築性とPlatform Engineering観点の強化 |
| P11 | AD DSバックアップ・復旧試験 | 未実装 | 本番差分の実装候補 |

## 公開版管理方針

- WBSは公開用に抽象化しています。
- 実テナント名、リソースID、UPN、IP、SID、Request IDは含めません。
- 実スクリーンショットと生ログは非公開証跡として扱います。

# 要件整理サマリー

## 想定シナリオ

小規模企業がMicrosoft 365 Business Premiumを中心に、Microsoft Entra ID、Microsoft Intune、Azure Virtual Desktop、AD DS、Microsoft Entra Cloud Syncを利用し、クラウド中心の端末・仮想デスクトップ・Hybrid Identity基盤を段階的に整備する想定です。

## 機能要件

| ID | 要件 | 検証結果 |
|---|---|---|
| REQ-ID-01 | Entra IDユーザー/グループを設計する | 完了 |
| REQ-ID-02 | Conditional Access / MFAの基本方針を整理する | 完了 |
| REQ-END-01 | Windows端末をIntuneで管理し、準拠状態を確認する | AVD Session Hostで確認済み |
| REQ-AVD-01 | AVD Workspace / Desktop accessを提供する | ユーザー接続確認済み |
| REQ-AVD-02 | AVD compute costを抑制する | Start VM on Connectとdeallocate運用を検証済み |
| REQ-AVD-03 | Session HostのOS、session type、Intune登録前提を整理する | 基本設計に記載 |
| REQ-HYB-01 | AD DS / DNSラボドメインを構築する | 完了 |
| REQ-HYB-02 | 選定ADユーザーをEntra IDへ同期する | Cloud Syncで完了 |
| REQ-HYB-03 | Password Hash Syncによるクラウドサインインを確認する | ADパスワード再設定後のサインインで確認済み |
| REQ-OPS-01 | Runbook、WBS、証跡要約を整備する | 完了 |
| REQ-PUB-01 | GitHub公開に耐えるマスキング・証跡抽象化を行う | スクショ・生ログ・ID類を除外済み |

## 非機能要件

| 領域 | 要件 |
|---|---|
| セキュリティ | DCにPublic IPを付与しない。最小権限、CA/MFA、管理者アカウント分離を考慮する。 |
| 運用性 | 手順をRunbook化し、再現性と切り分け観点を残す。 |
| 監査性 | Provisioning logs、Sign-in logs、Graph確認結果を非公開原本として保持し、公開版では要約化する。 |
| コスト | 個人ラボでは検証後にVMをdeallocateする。 |
| 公開安全性 | UPN、Tenant ID、Object ID、SID、IP、トークン、スクリーンショット原本を公開リポジトリに含めない。 |

## スコープ外

| 項目 | 理由 |
|---|---|
| 本番相当のAD DS高可用性 | 個人ラボであり、単一DC構成に限定。実務では複数DC、バックアップ、復旧試験が必要。 |
| FSLogix / Profile Container | AVD基盤検証を優先し、この公開版では対象外。 |
| 完全IaC化 | 今回は設計・構築・検証・Runbook化を主目的とし、IaCによるフル再構築は今後の拡張。 |
| WSUS / Azure Update Manager | 次フェーズ候補。今回の公開版では未実装。 |
| 本番監視設計 | 手動確認中心。実務ではLog Analytics、アラート、監査ログ保持を設計。 |

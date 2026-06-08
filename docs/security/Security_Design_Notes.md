# セキュリティ設計メモ

## 前提

このリポジトリは個人ラボです。実務へそのまま適用するのではなく、設計観点、責任分界、運用上の注意点を説明するための成果物です。

## IDとアクセス管理

| 項目 | ラボでの扱い | 実務での考慮 |
|---|---|---|
| 管理者アカウント | ラボ用管理者で構成 | 通常利用者、管理者、Break-glassを分離する。 |
| Break-glass | 実装対象外。設計差分として明記 | Cloud-onlyのEmergency access accountを最低2つ用意し、ブロック系Conditional Accessから除外し、定期的に検証する。 |
| Hybrid Identity管理者 | ラボ管理者で実施 | Cloud-onlyのHybrid Identity Administratorを用意し、オンプレミス停止時もCloud Sync設定を管理できるようにする。 |
| Conditional Access | MFA/CA設計を実施 | Emergency access accountとDirectory Synchronization Accountsを誤ってブロックしない設計が必要。 |

## Cloud Sync Agentの配置と保護

| 項目 | ラボでの扱い | 実務での考慮 |
|---|---|---|
| Agent配置 | DC同居。コスト優先判断。 | Agent serverはTier 0 / control-plane資産として扱う。専用メンバーサーバー、複数Agent、管理者権限の制御を検討する。 |
| gMSA | Cloud Sync Agent構成で利用 | gMSAの権限、ローテーション、監査を運用設計に含める。 |
| 可用性 | 単一Agent | 実務では複数Agentによる可用性とメンテナンス時の影響低減を検討する。 |
| 停止影響 | DC deallocate中はAgentが停止 | 本番ではDC停止やAgent停止を変更管理・影響評価なしに実施しない。 |

## AD DS / DNSの設計注意点

| 項目 | ラボでの扱い | 実務での考慮 |
|---|---|---|
| DC | 単一DC | 複数DC、バックアップ、監視、復旧試験、時刻同期、パッチ設計が必要。 |
| Public IP | 付与しない | DCはPublic Internetへ直接公開しない。管理経路は踏み台、VPN、Private接続を検討する。 |
| DNS | ラボ検証範囲で必要最小限 | AD DS名前解決やドメイン参加が必要な場合はVNet custom DNS設計が必要。 |

## AVD / Intuneの設計注意点

| 項目 | ラボでの扱い | 実務での考慮 |
|---|---|---|
| Session Host | Microsoft Entra joined | OS edition、single/multi-session、FSLogix、プロファイル、監視を設計する。 |
| Start VM on Connect | 有効化・検証 | Azure Virtual Desktop service principalへ`Desktop Virtualization Power On Contributor`を**subscription scope**で割り当てる前提を明記する。 |
| VM User Login | 接続検証で利用 | ユーザー/グループへのRBAC付与範囲を最小化する。 |
| Intune | 登録・準拠確認 | 準拠ポリシー、デバイス構成、セキュリティベースライン、更新管理を検討する。 |

## 監査・証跡

| 項目 | ラボでの扱い | 実務での考慮 |
|---|---|---|
| Sign-in logs | 成功/失敗判定に利用 | 保持期間、エクスポート、Log Analytics連携、定期レビューを設計する。 |
| Provisioning logs | Cloud Sync検証に利用 | 同期失敗時のアラート、定期確認、変更管理を設計する。 |
| 公開証跡 | Markdown要約のみ | 原本証跡は非公開保管し、公開時はマスキング・抽象化する。 |

## ラボ停止と再開

- VM deallocateは個人ラボのコスト停止手順です。
- 本番DCやID基盤に対して、そのまま適用する手順ではありません。
- 再開後は、DCサービス、DNS名前解決、Cloud Sync Agent状態、Cloud Sync configuration、AVD Session Host状態、サインイン確認を順番に確認します。


## 条件付きアクセスと非常用アカウント

実務設計では、少なくとも2つのcloud-only emergency access accountを用意し、ブロック系Conditional Accessの対象外にします。これらのアカウントは常時有効、強固な認証、定期的なサインイン確認、利用時の監査を前提にします。

Cloud Sync構成・運用では、オンプレミス障害時にもテナント管理を継続できるよう、cloud-onlyのHybrid Identity Administrator相当の管理経路を残します。また、Directory Synchronization Accountsや同期関連サービスアカウントを、誤って対話型MFA必須・ブロック系CAの対象にしないよう除外設計を明記します。

## Cloud Sync Agentの配置と保護 / gMSA / Tier 0

Cloud Sync AgentはgMSAを利用する前提で、agent serverはTier 0 / Control Plane資産として扱います。本ラボではコスト優先でDC同居としましたが、実務では専用メンバーサーバー、複数Agent、変更管理、監査、パッチ適用、バックアップ、復旧手順を設計に含めます。

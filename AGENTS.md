# AGENTS.md

このリポジトリでAIエージェントを利用する際の共通指示です。
本書は Owner-led AI-assisted engineering baseline v1.0 に準拠します。

## 役割前提

- 最終判断、リスク受容、スコープ管理、公開判断、merge判断はProject Ownerが行います。
- AIは文書整理、レビュー、スクリプト草案、表現改善の補助であり、意思決定主体ではありません。
- AIの出力を判断の根拠として本文へ記載しないでください。判断はOwnerの判断として記述します。

## リポジトリの位置づけ

- Microsoft 365 / Entra ID / Intune / AVD / AD DS / Entra Cloud Sync を個人ラボで検証したポートフォリオです。
- 実案件の成果物ではなく、設計観点・検証観点・運用Runbookを説明する公開用成果物です。
- portfolio / sample / reference implementation の位置づけを維持し、顧客環境へそのまま適用可能と誤解される表現を避けてください。

## 安全境界

- Azure、Microsoft Graph、M365テナントへの実接続、実環境へのスクリプト実行は行わないでください。
- 破壊的・状態変更系のPowerShell（Stop / Deallocate / Remove / Set系）を追加・変更する場合は、`SupportsShouldProcess`、WhatIf / Confirm、対象スコープの明示、LAB ONLYの注意書きを必須とします。既存スクリプトの挙動変更は明示指示なしに行わないでください。
- AVD / AD DS / M365の責任分界（このリポジトリで扱う範囲と実務で別途定義する範囲）を曖昧にしないでください。

## Secrets / 非公開情報

- 実Tenant ID、実Subscription ID、Object ID、実UPN、IPアドレス、顧客名、顧客ID、メールアドレス、credential、connectionString、SAS URL、token類を記載しないでください。
- スクリーンショット原本、CSV / JSON原本、実環境ログ、Request ID / Correlation ID / SIDを追加しないでください。
- 公開時のマスキングは `docs/security/Public_Masking_Policy.md` に従ってください。

## 記述ルール

- 実施済みの検証、Runbook化済みの手順、実務拡張時の追加設計領域（構想）を混同しないでください。
- 誇大表現を使わず、落ち着いた自然な日本語の敬体で記述してください。
- 年齢、経験年数などの内部評価基準を本文へ記載しないでください。

## 明示指示なしに行わない操作

- ファイルの削除・移動・リネーム
- README・主要docsの章立ての大幅変更
- GitHub Actions、Secrets、リポジトリ設定の変更
- 実環境へ接続するスクリプト・手順の追加

## GitHub Actions方針

- GitHub Actionsを使う場合は、`uses:` をタグではなくfull commit SHAで固定し、バージョンを示すコメントを併記することを基線とします。
- SHA固定の追随はDependabot（`github-actions` エコシステム）で行う前提を維持します。Dependabotが更新しない場合は、`git ls-remote` で対象タグのcommit SHAを取得して手動更新します。
- SHA固定はサプライチェーン対策として有効ですが、workflow変更であるため、明示指示なしに行わず、Owner承認対象とします。

## 変更の進め方

- 変更は小さなPR単位で行い、目的を明確にしてください。
- 変更後に `git diff --check`、Markdownコードフェンス、リンク実在を確認してください。
- PRのmerge判断はProject Ownerが行います。

# GitHub公開前チェックリスト

## 目的

このチェックリストは、GitHub公開前に以下を確認するためのものです。

- スクリーンショット、生ログ、CSV/JSON/Officeバイナリを公開リポジトリに含めない。
- UPN、Tenant ID、Subscription ID、Object ID、SID、IP、Request ID、Correlation ID、token、password相当の値を残さない。
- 公開用の証跡はMarkdown要約のみとする。
- README、WBS、Runbook、Evidence summaryの完了状態を一致させる。

## 1. Git状態確認

```powershell
git status
git remote -v
git log --oneline -5
```

期待値:

```text
working tree clean
origin が想定GitHubリポジトリを指している
```

## 2. 公開対象外ファイルの検出

```powershell
$BlockedExtensions = @('*.png','*.jpg','*.jpeg','*.webp','*.bmp','*.gif','*.csv','*.json','*.xlsx','*.xlsm','*.docx','*.pptx','*.log','*.har','*.evtx','*.etl')
Get-ChildItem -Recurse -File -Include $BlockedExtensions
```

期待値:

```text
何も表示されない
```

Git管理対象だけを確認する場合:

```powershell
git ls-files | Select-String -Pattern '\.(png|jpg|jpeg|webp|bmp|gif|csv|json|xlsx|xlsm|docx|pptx|log|har|evtx|etl)$'
```

期待値:

```text
何も表示されない
```

## 3. 代表的な実値パターン確認

公開作業で実際に使った値がある場合は、以下に追加して確認します。

```powershell
$Patterns = @(
  '<ADD_REAL_TENANT_DOMAIN_FRAGMENT_HERE>',
  '<ADD_REAL_UPN_PREFIX_HERE>',
  '<ADD_REAL_TENANT_ID_FRAGMENT_HERE>',
  '<ADD_REAL_OBJECT_ID_FRAGMENT_HERE>',
  '<ADD_REAL_SID_FRAGMENT_HERE>',
  '<ADD_REAL_PUBLIC_IP_FRAGMENT_HERE>',
  '<ADD_REAL_PRIVATE_IP_PREFIX_HERE>'
)

foreach ($Pattern in $Patterns) {
  if ($Pattern -like '<ADD_*') { continue }
  Write-Host "`n==== $Pattern ===="
  git grep -n -I -- $Pattern
}
```

期待値:

```text
何も表示されない
```

## 4. 正規表現によるセンシティブ値スキャン

```powershell
$Files = Get-ChildItem -Recurse -File |
  Where-Object {
    $_.FullName -notmatch '\\.git\\' -and
    $_.Extension -in '.md','.ps1','.mmd','.txt','.yml','.yaml','.gitignore'
  }

$RegexPatterns = @(
  @{ Name = 'GUID'; Pattern = '[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}' },
  @{ Name = 'SID'; Pattern = 'S-\d-\d+-(\d+-){1,14}\d+' },
  @{ Name = 'IPv4'; Pattern = '\b(?:\d{1,3}\.){3}\d{1,3}\b' },
  @{ Name = 'EmailOrUPN'; Pattern = '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b' },
  @{ Name = 'BearerToken'; Pattern = 'Bearer\s+[A-Za-z0-9._\-]+=*' },
  @{ Name = 'SecretKeyword'; Pattern = '(?i)(password|secret|client_secret|access_token|refresh_token|bearer)' }
)

foreach ($Entry in $RegexPatterns) {
  Write-Host "`n==== $($Entry.Name) ===="
  Select-String -Path $Files.FullName -Pattern $Entry.Pattern |
    Select-Object Path, LineNumber, Line
}
```

注意:

- このスキャンは、マスキング方針やチェックリスト内の説明文も検出する場合があります。
- 検出結果は機械的に削除せず、値そのものか、方針説明かを人間が判定します。
- 実値らしきものが1件でも出た場合は、push前に修正します。

## 5. README表示確認

GitHub上で以下を確認します。

| 確認項目 | 期待値 |
|---|---|
| README冒頭 | 30秒でラボの目的と完了範囲が分かる |
| Mermaid | 図が崩れていない |
| 成果物リンク | 404にならない |
| 言語 | 日本語ファースト。製品名・コマンド・ファイル名のみ英語中心 |
| Evidence | Markdown要約のみ。スクショや生ログなし |

## 6. 最終判定

| 判定 | 条件 |
|---|---|
| OK | 公開対象外ファイルなし、実値検出なし、README表示確認済み |
| 要修正 | 実値、スクショ、生ログ、空白placeholder、リンク切れがある |
| 公開停止 | token、password、UPN、Tenant ID、Object ID、SID、IP等の実値が残っている |

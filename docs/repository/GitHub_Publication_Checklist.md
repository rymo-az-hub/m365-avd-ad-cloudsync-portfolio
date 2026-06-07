# GitHub Publication Checklist

## Repository role

This repository is the second portfolio repository alongside:

```text
https://github.com/rymo-az-hub/azure-platform-governance-portfolio
```

The governance repository covers Azure platform governance. This repository covers Microsoft 365 / AVD / AD DS / Cloud Sync / CloudOps validation.

## Recommended repository name

```text
m365-avd-ad-cloudsync-portfolio
```

Alternative:

```text
m365-avd-cloudops-hybrid-identity-portfolio
```

## Pre-commit checks

Run from the repository root.

```powershell
# Confirm no screenshots are staged
Get-ChildItem -Recurse -File -Include *.png,*.jpg,*.jpeg,*.webp,*.bmp,*.gif

# Confirm no raw CSV/JSON/log evidence files are present
Get-ChildItem -Recurse -File -Include *.csv,*.json,*.log,*.har

# Confirm no Office binary deliverables are present in this public version
Get-ChildItem -Recurse -File -Include *.xlsx,*.xlsm,*.docx,*.pptx

# Search for common sensitive patterns
$Files = Get-ChildItem -Recurse -File | Where-Object { $_.Extension -in '.md','.ps1','.mmd','.txt' }
$Patterns = @(
  '<YOUR-TENANT-DOMAIN>',
  '<YOUR-USER-UPN>',
  '<YOUR-SUBSCRIPTION-ID>',
  '<YOUR-TENANT-ID>',
  '<YOUR-CLIENT-IP>',
  '<YOUR-ONPREM-SID-PREFIX>'
)
foreach ($Pattern in $Patterns) {
  Select-String -Path $Files.FullName -Pattern $Pattern -SimpleMatch
}
```

Expected result: no tenant-specific raw identifiers. Generic documentation labels such as `Tenant ID` in the masking policy are acceptable.

## Local Git initialization

```powershell
cd C:\work\portfolio-public-staging\m365-avd-ad-cloudsync-portfolio

git init
git add .
git status
git commit -m "feat: publish m365 avd ad cloud sync portfolio"
```

## Connect to GitHub after review

Create an empty GitHub repository first, then connect.

```powershell
git branch -M main
git remote add origin https://github.com/rymo-az-hub/m365-avd-ad-cloudsync-portfolio.git
git push -u origin main
```

## Do not commit

- Private screenshots
- Portal exports
- Graph JSON outputs
- Sign-in logs CSV/JSON
- Provisioning logs CSV/JSON
- Excel drafts with raw identifiers
- DeepResearch prompts
- Next-thread prompts
- Local run logs

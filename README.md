# Microsoft 365 / AVD / AD DS / Cloud Sync Portfolio

小規模企業向けの Microsoft 365 / Microsoft Entra ID / Intune / Azure Virtual Desktop / AD DS / Microsoft Entra Cloud Sync 基盤を想定し、要件整理、設計、構築、試験、運用Runbook整備までを個人ラボで再現したポートフォリオです。

AVD の Microsoft Entra joined 構成、Intune管理、AD DS / DNS、Cloud Sync、Password Hash Sync、サインインログ確認、検証後のコスト停止運用までを一連で確認しています。

> このリポジトリは実案件の成果物ではありません。GitHub公開版では、スクリーンショット原本、CSV/JSON原本、Tenant ID、Subscription ID、Object ID、Request ID、Correlation ID、SID、IPアドレス、UPN、トークン類を含めていません。

## Related portfolio

| Theme | Repository | Focus |
|---|---|---|
| Azure Governance / Policy Baseline | https://github.com/rymo-az-hub/azure-platform-governance-portfolio | Management Group, Azure Policy, RBAC, tagging, monitoring, cost governance |
| M365 / AVD / AD DS / Cloud Sync | This repository | Entra ID, Intune, AVD, AD DS, Cloud Sync, PHS, CloudOps runbooks |

## What this portfolio demonstrates

| Area | Demonstrated outcome |
|---|---|
| Identity | Entra ID user/group design, Conditional Access/MFA design, AD DS to Entra ID Cloud Sync, Password Hash Sync validation |
| Endpoint / Device Management | Intune enrollment and Windows compliance validation for AVD session host |
| Virtual Desktop | Microsoft Entra joined AVD session host, Workspace/DAG assignment, Start VM on Connect, user connection validation |
| Hybrid identity | AD DS/DNS lab domain, Cloud Sync Agent, selected security group scoping, provisioning logs, Graph verification |
| Operations | Runbook, WBS, troubleshooting notes, evidence summaries, VM deallocate cost-stop operation |

## Completion status

| Phase | Scope | Status |
|---|---|---|
| P0-P5 | M365 / Entra ID / Conditional Access / MFA / Intune initial design | Completed |
| P6 | AVD Modern configuration, Entra joined session host, Intune compliance, Start VM on Connect | Completed |
| P7-01 to P7-07 | AD DS / DNS / OU / group / user / Cloud Sync Agent | Completed |
| P7-08 | Cloud Sync configuration, selected security group scope, on-demand provisioning, normal sync | Completed |
| P7-09 | Password Hash Sync, AD password reset, cloud sign-in validation, sign-in logs | Completed |
| P7-10 | AVD/DC VM session check and deallocate | Completed |
| P8+ | WSUS / Azure Update Manager extension work | Not implemented in this public version |

## Architecture

See:

- [Architecture overview](docs/architecture/architecture.md)
- [Mermaid architecture diagram](docs/architecture/architecture.mmd)

## Key deliverables

| Category | File |
|---|---|
| Architecture | [docs/architecture/architecture.md](docs/architecture/architecture.md) |
| P6 summary | [docs/summaries/P6_AVD_Completion_Summary.md](docs/summaries/P6_AVD_Completion_Summary.md) |
| P7 summary | [docs/summaries/P7_ADDS_CloudSync_PHS_Completion_Summary.md](docs/summaries/P7_ADDS_CloudSync_PHS_Completion_Summary.md) |
| Cloud Sync Runbook | [docs/runbooks/Runbook_CloudSync_ConfigAndVerify.md](docs/runbooks/Runbook_CloudSync_ConfigAndVerify.md) |
| PHS Runbook | [docs/runbooks/Runbook_CloudSync_PHS_SignIn_Validation.md](docs/runbooks/Runbook_CloudSync_PHS_SignIn_Validation.md) |
| Cost Stop Runbook | [docs/runbooks/Runbook_Lab_Cost_Stop.md](docs/runbooks/Runbook_Lab_Cost_Stop.md) |
| Requirements summary | [docs/deliverables/requirements.md](docs/deliverables/requirements.md) |
| Basic design summary | [docs/deliverables/basic-design.md](docs/deliverables/basic-design.md) |
| Test plan / results | [docs/deliverables/test-plan-results.md](docs/deliverables/test-plan-results.md) |
| WBS summary | [docs/deliverables/wbs.md](docs/deliverables/wbs.md) |
| Public evidence summaries | [evidence/public/README.md](evidence/public/README.md) |
| Security notes | [docs/security/Security_Design_Notes.md](docs/security/Security_Design_Notes.md) |
| Masking policy | [docs/security/Public_Masking_Policy.md](docs/security/Public_Masking_Policy.md) |

## Public evidence policy

This public repository intentionally uses Markdown evidence summaries instead of screenshots or raw exports.

| Item | Public repository treatment |
|---|---|
| Azure / Entra / Intune portal screenshots | Excluded |
| Raw Graph JSON | Excluded |
| Sign-in log CSV/JSON | Excluded |
| Provisioning log CSV/JSON | Excluded |
| Tenant-specific identifiers | Replaced with placeholders or omitted |
| Evidence summaries | Included as Markdown under `evidence/public/` |

## Lab decisions vs production design

| Area | Lab decision | Production consideration |
|---|---|---|
| Cloud Sync Agent | Installed on the domain controller to reduce lab cost | Treat as Tier 0/control-plane asset. Consider a dedicated hardened member server and multiple agents for availability. |
| AD DS | Single lab DC | Use multiple DCs, backup, monitoring, patching, recovery testing, and documented DNS dependencies. |
| Sync scope | Selected security group | Suitable for lab/pilot. For stable production operation, design clear OU/group scope and change control. |
| VNet DNS | Not broadly changed for this validation scope | Configure custom DNS when Azure VMs require AD DS name resolution or domain join. |
| VM stop | Manual deallocate after validation | Do not apply blindly to production DCs. Evaluate impact, recovery process, and maintenance windows. |
| Monitoring | Manual portal/Graph checks | Use Log Analytics, alerts, audit-log retention, and periodic health checks. |

## Interview discussion points

- Why the AVD session host was Microsoft Entra joined rather than AD joined.
- Why Cloud Sync was scoped with a selected security group for initial validation.
- Why on-demand provisioning was not treated as the only evidence of scope correctness.
- Why normal provisioning logs and Graph verification were also collected.
- How Password Hash Sync was validated using AD password reset and cloud sign-in logs.
- How VM deallocate was handled as a lab cost-control operation.
- What would change in a production design: HA, monitoring, break-glass, least privilege, backup, recovery, and agent placement.

## Repository status

This is the GitHub-public version. Private screenshots and raw evidence are intentionally excluded.

# Basic Design Summary

## Design blocks

| Block | Design |
|---|---|
| Identity | Microsoft Entra ID as cloud identity control plane |
| Conditional Access | Baseline CA/MFA design for user and admin access |
| Endpoint management | Intune enrollment and compliance validation |
| AVD | Microsoft Entra joined AVD session host with Workspace and DAG |
| Hybrid identity | AD DS lab domain synchronized to Entra ID by Cloud Sync |
| Authentication | Password Hash Sync validated with cloud sign-in |
| Operations | Runbooks for AVD, Cloud Sync, PHS, troubleshooting, and cost stop |

## Key design decisions

| Decision | Rationale |
|---|---|
| Microsoft Entra joined AVD session host | Aligns with modern cloud-first AVD pattern and Intune management. |
| Cloud Sync instead of classic full Connect Sync | Lightweight validation for selected AD DS objects in a small lab. |
| Selected security group scoping | Keeps first sync minimal and auditable. |
| Default attribute mapping for initial sync | Reduces troubleshooting variables during initial validation. |
| PHS validation after sync | Confirms practical sign-in outcome, not only object provisioning. |
| Public evidence as Markdown | Reduces GitHub information-leak risk. |

## Production deltas

| Area | Lab | Production consideration |
|---|---|---|
| AD DS | Single DC | Multiple DCs, backup, monitoring, recovery tests |
| Cloud Sync Agent | DC co-located | Dedicated/hardened Tier 0 treatment, multiple agents |
| Monitoring | Manual validation | Log Analytics, alerts, retention, review cadence |
| Deallocate | Manual lab stop | Change-controlled maintenance and DR planning |

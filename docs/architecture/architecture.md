# Architecture Overview

## Scope

This portfolio models a small-business Microsoft cloud and hybrid identity platform.

The validation scope covers:

- Microsoft 365 / Microsoft Entra ID identity foundation
- Conditional Access / MFA design
- Intune device management and compliance
- Azure Virtual Desktop with Microsoft Entra joined session host
- AD DS / DNS lab domain
- Microsoft Entra Cloud Sync
- Password Hash Sync sign-in validation
- Lab VM cost-stop operation

## Logical architecture

```mermaid
flowchart LR
  subgraph UserLayer[Users]
    U1[Cloud user]
    U2[Synced AD user]
  end

  subgraph M365[Microsoft 365 / Microsoft Entra ID]
    Entra[Microsoft Entra ID]
    CA[Conditional Access / MFA]
    Intune[Microsoft Intune]
    Logs[Sign-in logs / Audit logs]
  end

  subgraph AVD[Azure Virtual Desktop]
    HP[Host Pool]
    WS[Workspace]
    DAG[Desktop Application Group]
    SH[Session Host\nMicrosoft Entra joined]
  end

  subgraph Hybrid[Azure IaaS lab AD]
    DC[AD DS / DNS VM\nNo public IP]
    Agent[Cloud Sync Agent]
    OU[OU / Groups / User]
  end

  U1 --> WS
  WS --> DAG
  DAG --> HP
  HP --> SH
  SH --> Intune
  SH --> Entra
  Entra --> CA
  DC --> Agent
  Agent --> Entra
  Entra --> Logs
  U2 --> Entra
```

## Main flows

| Flow | Description |
|---|---|
| AVD user access | User accesses AVD Workspace, DAG, and Microsoft Entra joined session host. |
| Device management | AVD session host is enrolled into Intune and evaluated by compliance policy. |
| Hybrid identity sync | AD DS user in the lab domain is synchronized to Microsoft Entra ID by Cloud Sync. |
| Password authentication | AD password change is synchronized through Password Hash Sync and validated with cloud sign-in. |
| Operations | VM state, AVD sessions, Cloud Sync health, and sign-in logs are checked through runbooks. |

## Design notes

- The session host is Microsoft Entra joined. This reduces dependency on AD DS line-of-sight for the AVD session host scenario validated here.
- AD DS is added for hybrid identity validation, not because the AVD session host requires AD domain join in this lab design.
- Cloud Sync is scoped to a selected security group for pilot-style validation.
- The Cloud Sync Agent is installed on the DC only for lab cost reduction. This is not presented as a production default.
- Public repository evidence is summarized as Markdown. Raw screenshots and raw logs are not included.

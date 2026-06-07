# Requirements Summary

## Assumed customer scenario

A small organization wants to use Microsoft 365, Microsoft Entra ID, Intune, Azure Virtual Desktop, and a lightweight hybrid identity pattern for selected AD DS users.

## Functional requirements

| ID | Requirement | Validation |
|---|---|---|
| REQ-ID-01 | Define Entra ID users and groups | User/group design completed |
| REQ-ID-02 | Configure Conditional Access / MFA baseline | Design and validation notes completed |
| REQ-END-01 | Enroll and manage Windows devices with Intune | AVD session host enrollment and compliance confirmed |
| REQ-AVD-01 | Provide AVD workspace and desktop access | User connection validated |
| REQ-AVD-02 | Reduce AVD compute cost | Start VM on Connect and deallocate operation validated |
| REQ-HYB-01 | Build lab AD DS / DNS domain | Completed |
| REQ-HYB-02 | Synchronize selected AD user to Entra ID | Cloud Sync completed |
| REQ-HYB-03 | Validate Password Hash Sync sign-in | Completed through AD password reset and cloud sign-in |
| REQ-OPS-01 | Prepare runbooks and evidence summaries | Completed |

## Non-functional requirements

| Area | Requirement |
|---|---|
| Security | Avoid public DC exposure, use least privilege, separate CA/PHS validation concerns |
| Operations | Provide repeatable runbooks and cost-stop procedure |
| Auditability | Keep evidence summaries and validation results |
| Publication safety | Exclude tenant-specific identifiers and raw screenshots from GitHub |

# Runbook: AVD Start and Connect Validation

## Purpose

Validate that a user can access the Azure Virtual Desktop workspace and connect to the Microsoft Entra joined session host.

## Preconditions

| Item | Expected state |
|---|---|
| Host pool | Created |
| Workspace | Created |
| Desktop Application Group | Assigned to target user/group |
| Session host | Microsoft Entra joined |
| Intune enrollment | Completed |
| Start VM on Connect | Enabled if VM is deallocated |
| RBAC | User has required AVD access and VM login permissions |

## Validation steps

1. Confirm the session host VM state.
2. Confirm Host Pool, Workspace, and DAG association.
3. Confirm target user/group assignment.
4. Confirm session host status is available.
5. Connect as the test user through the AVD client or web client.
6. Confirm session count increments.
7. Confirm Intune compliance status for the session host.

## Evidence to keep privately

- AVD connection success
- Session count before/after
- Intune compliance status
- VM power state before/after Start VM on Connect

Public repository evidence should be represented by a sanitized Markdown summary only.

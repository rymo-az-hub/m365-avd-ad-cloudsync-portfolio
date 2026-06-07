# Public Masking Policy

## Purpose

This repository is intended for GitHub publication. Tenant-specific and personal-lab identifiers are excluded from the public version.

## Excluded from the public repository

| Item | Public treatment |
|---|---|
| UPN / email address | Replaced with placeholders such as `<SYNCED-USER-UPN>` |
| Tenant ID | Omitted or replaced with `<TENANT-ID>` |
| Subscription ID | Omitted or replaced with `<SUBSCRIPTION-ID>` |
| Object ID / Request ID / Correlation ID / Session ID | Omitted or replaced with `<GUID>` |
| SID | Omitted or replaced with `<ONPREM-SID>` |
| Client/public IP | Omitted or replaced with `<CLIENT-IP>` |
| Private IP | Omitted or replaced with `<PRIVATE-IP>` when not required for explanation |
| Registration token / secret / password | Excluded |
| Portal screenshots | Excluded |
| Raw CSV/JSON/log exports | Excluded |

## Evidence approach

The public repository uses Markdown summaries under `evidence/public/` instead of portal screenshots or raw log files.

## Review rule

Before publishing, run a text scan and manually inspect file names and Markdown content. Do not commit private evidence to Git history.

---
name: 13_DATABASE_WORKFLOW
description: Database migration guidelines, workflow protocols, and safety rules.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 13 — Database Workflow and Safety Rules

## Scope within AgentMemory Kit

The `agentmemory-kit` repository itself does not connect to or manage an active database instance. All state is maintained via the Git tree and local session files.

## Guidelines for Projects Using This Kit

When applied to projects with active databases (SQL, NoSQL, ORM migrations):

1. **Major Task Trigger**:
   - Any modification touching the database schema, models, or migrations automatically classifies as a **Major Task** under Rule 3 (`memory/12_AI_CONTEXT_RULES.md`).
   - The agent must stop, alert the user, and propose a planning step prior to touching schema files.
2. **Credential Safety**:
   - Database credentials (host, port, username, password, connection URI) must **never** be logged, printed, or saved into `memory/` documents.
   - All connection parameters must reference environment variables (e.g., `DATABASE_URL` in `.env`) or secret managers.
3. **Migration Protocol**:
   - Never perform destructive manual schema changes in production without recorded migration scripts.
   - Record applied schema migrations and version numbers in `memory/02_DATABASE.md`.

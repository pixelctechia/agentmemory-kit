---
name: 02_DATABASE
description: Memory schema specification, templates/memory/ structure, and data persistence models.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 02 — Data Schema and Memory Templates (`templates/memory/`)

## Context

`agentmemory-kit` does not use a traditional SQL or NoSQL database engine. Within this project, the canonical "data schema" and persistence blueprints are represented by the template catalog in `templates/memory/`.

These template files serve as the structural data contract (the schemas) that define how an AI agent's memory must be organized across repositories.

## The Memory Schema Blueprint (`templates/memory/`)

The directory `templates/memory/` defines 18 standardized numbered entities and state models:

| Template Entity | Schema Purpose / Data Model |
|---|---|
| `00_PROJECT_OVERVIEW.md` | Core project definition, target audience, and primary capabilities |
| `01_ARCHITECTURE.md` | System layers, data flow, component interactions, and truth hierarchy |
| `02_DATABASE.md` | Data models, schemas, persistence mechanisms, and credential policies |
| `03_FRONTEND.md` | User interface layer, client touchpoints, design systems, and components |
| `04_BACKEND.md` | Business logic, background workers, server services, and automation scripts |
| `05_ADMIN_CONSOLE.md` | Operational management, internal dashboards, and administrative controls |
| `06_API_ROUTES.md` | External and internal contracts, endpoints, schemas, and hook routes |
| `07_DEPLOYMENT.md` | Infrastructure, installation procedures, CI/CD, and hosting environments |
| `08_DECISIONS_LOG.md` | Architectural decision records (ADRs) and structural trade-offs |
| `09_PENDING_TASKS.md` | Roadmap, backlogs, and prioritized technical debt |
| `10_BUGS_AND_FIXES.md` | Known issues, platform quirks, edge cases, and resolved incidents |
| `11_CHANGELOG.md` | Version history, releases, and migration milestones |
| `12_AI_CONTEXT_RULES.md` | The 6 mandatory behavioral rules for AI coding assistants |
| `13_DATABASE_WORKFLOW.md` | Migration guidelines, data safety rules, and change protocols |
| `14_REMOTE_MCP_ACCESS.md` | Model Context Protocol policies, tool access, and security controls |
| `15_TESTING.md` | Test strategy, test suites, simulation harnesses, and quality gates |
| `16_ENVIRONMENTS.md` | Prerequisites, runtime configurations, and OS platform matrices |
| `17_GRAPHIFY_INDEX.md` | Knowledge graph index, output file locations, and live tested queries |
| `CURRENT_STATE.md` | Active session snapshot (read first every session; max ~150 lines) |

## Auxiliary Data Templates

Located in `templates/`:
- `templates/DAILY_LOG_TEMPLATE.md`: Schema for recording single-day session progress, decisions made, pending tasks, and client-visible work.
- `templates/DECISION_TEMPLATE.md`: Schema for documenting individual ADRs (`DECISION-XXX`).

## State Persistence and Credential Policy

- **Session State Files**: Temporary tracking files (`START_TIME`, `LAST_WARN`) stored in `$HOME/.claude/memory-orchestrator/sessions/<session_id>.state`.
- **Zero Plaintext Secrets**: Connection strings, API tokens, and credentials must never be written into memory files or templates. All connections in consumer projects must point to environment variables or secret managers.

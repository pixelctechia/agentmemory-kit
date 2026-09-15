---
name: 03_FRONTEND
description: The prompts/ catalog as the primary user interface and interaction layer of AgentMemory Kit.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 03 — Frontend and Interaction Layer (`prompts/`)

## Context

`agentmemory-kit` does not bundle a traditional graphical or web frontend (such as HTML/CSS/JS). Instead, the user interface through which developers and operators drive the system is the **`prompts/` catalog**.

These standalone prompt files form the human-to-agent interface: clean, standardized instructions designed to be copied directly into AI coding assistants (Claude Code, Antigravity, Cursor, Windsurf, etc.) to trigger specific memory operations.

## The `prompts/` Catalog Architecture

The interface catalog is organized into three primary operational categories:

### 1. Bootstrap and Onboarding Routes (`prompts/`)

These prompts serve as the project setup wizards:

- **`prompts/caminho-a-new-project.md` (Path A)**:
  - **Purpose**: Bootstrap memory from absolute scratch for brand new projects without an existing `memory/` folder.
  - **Workflow**: Generates all 18 numbered files, runs graph extraction, sets up `CURRENT_STATE.md`, templates, and root `AGENTS.md`.
- **`prompts/caminho-b-existing-memory.md` (Path B)**:
  - **Purpose**: Repair and complete an existing but incomplete `memory/` directory.
  - **Workflow**: Audits existing files, fills missing numbers (00 to 17), enforces metadata headers, and sets up missing rules.
- **`prompts/caminho-c-migrate-old-memory.md` (Path C)**:
  - **Purpose**: Migrate monolithic, single-file memory dumps into the modular 00-17 structure without losing historical context.

### 2. Daily Operational Interface (`prompts/daily/`)

The daily workflow interface guiding day-to-day pairing:

- **`prompts/daily/prompt-7-open-session.md` (Session Start)**:
  - Opens a working session, reads `CURRENT_STATE.md`, checks recent logs, and aligns on immediate priorities.
- **`prompts/daily/prompt-8-plan-major-task.md` (Major Task Planning)**:
  - Pre-flight planning protocol triggered whenever a task touches the database, auth, affects >3 files, or changes contracts.
- **`prompts/daily/prompt-9-lite-checkpoint.md` (Quick Checkpoint)**:
  - Lightweight mid-session synchronization. Default action recommended when the 2-hour session warning fires.
- **`prompts/daily/prompt-9-close-session.md` (Session Close)**:
  - End-of-day wrap-up: records daily session log, updates `CURRENT_STATE.md`, updates task status, and rotates stale logs.
- **`prompts/daily/prompt-15-refresh-graph.md` (Graph Refresh)**:
  - Triggers knowledge graph re-extraction after structural codebase modifications.

### 3. Governance and Audit Interface (`prompts/audit/`)

The administrative and quality assurance interface:

- **`prompts/audit/full-audit.md`**:
  - Read-only diagnostic running a comprehensive health check: verifies structure completeness (00-17), audits metadata headers, checks `CURRENT_STATE.md` line count (< 150), checks graph freshness, and scans for secret leaks.

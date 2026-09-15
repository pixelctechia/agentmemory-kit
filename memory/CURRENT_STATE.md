---
name: CURRENT_STATE
description: Snapshot of the project's current state. Read first, every session. Max ~150 lines.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# Current State — AgentMemory Kit

## What this project does

AgentMemory Kit is an open-source standard and operational framework providing persistent, versioned memory and self-checking behavior for AI coding agents. It pairs a standardized markdown memory directory (`memory/00_` to `17_`) with zero-token shell lifecycle hooks and custom agent definitions for Claude Code, Google Antigravity, and AGENTS.md-compatible tools.

## Recently worked on

- **2026-09-15**: Bootstrapped complete canonical memory via **Path A** (Caminho A).
- Populated all numbered memory files (`00_PROJECT_OVERVIEW.md` through `16_ENVIRONMENTS.md`) with real codebase content.
- Created `memory/12_AI_CONTEXT_RULES.md` containing all 6 mandatory behavior sections.
- Created `memory/templates/` with `DAILY_LOG_TEMPLATE.md` and `DECISION_TEMPLATE.md`.
- Generated initial codebase knowledge graph with Graphify into `graphify-out/` and documented real query examples in `17_GRAPHIFY_INDEX.md`.
- Created root `AGENTS.md` and pointer `GEMINI.md`.

## In progress

- Verification and full audit of the bootstrapped memory structure.
- Continuous maintenance of documentation and hook integration.

## Known issues / blockers

- Claude Code requires CLI session restart to reload hook scripts or agent definitions.
- Antigravity IDE interactive chat runs custom agents via in-thread persona adoption (context is shared with the main thread).
- Host machines must have `jq` installed for hook shell scripts to parse JSON inputs.

## Memory & graph status

- **`memory/12_AI_CONTEXT_RULES.md`**: Current — contains all 6 mandatory sections (Source of Truth Hierarchy, Graphify Usage Rule, Major Task Criteria & Self-Check, Session Length Self-Check, Memory Hygiene, Scope Discipline).
- **Knowledge Graph (`graphify-out/graph.json`)**: Current — extracted on 2026-09-15 using Graphify AST engine (`graphify-out/graph.json`, 4 nodes, 2 edges).

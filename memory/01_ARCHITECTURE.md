---
name: 01_ARCHITECTURE
description: System architecture, layers, and operational flow of AgentMemory Kit.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 01 — Architecture

## 3-Layer System Design

AgentMemory Kit bridges the gap caused by an AI coding agent's stateless context window across sessions using three cooperative layers:

```
[Layer 1: Codebase] ─── What exists (AST, source files, shell scripts, configs)
       │
       ▼
[Layer 2: Knowledge Graph] ─── How it connects (Graphify nodes, edges, dependencies)
       │
       ▼
[Layer 3: Project Memory] ─── Why it exists (memory/ files, decisions, rules, state)
```

- **Source of Truth Hierarchy**: Code > Graph (when fresh) > Memory.
- Divergences require updating memory or re-extracting the graph, never modifying valid code to match outdated documentation.

## Global Orchestrator vs Local Repository

- **Global Layer (Once per machine)**:
  - Resides outside project repositories (e.g. `~/.claude/` for Claude Code or `~/.gemini/config/` for Antigravity).
  - Implements lifecycle hooks (`SessionStart`, `UserPromptSubmit`).
  - Read-only observer: checks memory existence, presence of `CURRENT_STATE.md`, graph file age, and calculates session elapsed time. Emits concise plain-text context on standard output without modifying files without explicit user command.
- **Local Layer (Per project repository)**:
  - `memory/`: Numbered markdown files (00 to 17), logs, reports, and templates.
  - `AGENTS.md` (and `GEMINI.md` pointer): Entry point recognized by coding assistants.
  - `graphify-out/`: Artifact directory holding `graph.json`, reports, and graph indexes.

## Zero-Token Philosophy

Automated guardrails and session time tracking are implemented as lightweight Bash scripts using standard utilities (`date`, `find`, `stat`, `jq`). This guarantees zero LLM context window consumption and zero API cost for pre-flight health checks.

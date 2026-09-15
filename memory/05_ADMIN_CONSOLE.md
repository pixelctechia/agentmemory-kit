---
name: 05_ADMIN_CONSOLE
description: Administrative management, audit controls, and maintenance operations.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 05 — Administrative Operations and Management

## Operational Controls

While `agentmemory-kit` provides no web-based admin console, system administration is conducted through CLI operations and prompt-driven audit suites:

1. **State Directory Inspection**:
   - Inspect active session clocks:
     ```bash
     ls -la ~/.claude/memory-orchestrator/sessions/
     cat ~/.claude/memory-orchestrator/sessions/<session_id>.state
     ```
   - Manual cleanup of stale session states:
     ```bash
     rm -rf ~/.claude/memory-orchestrator/sessions/*
     ```
2. **Audit Execution**:
   - Automated structural audit using prompt: `prompts/audit/full-audit.md`.
   - Checks metadata headers across all files in `memory/`.
   - Validates that `memory/CURRENT_STATE.md` stays below 150 lines.
   - Performs regex-based scanning for secret leaks (e.g. `sk-`, `ghp_`, `password=`, `token=`).
3. **Graph Diagnostics**:
   - Check graph status and multi-graph integrity:
     ```bash
     graphify diagnose multigraph --graph graphify-out/graph.json
     ```
   - Inspect key architectural hubs:
     ```bash
     graphify god-nodes --graph graphify-out/graph.json
     ```

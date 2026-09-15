---
name: 09_PENDING_TASKS
description: Pending tasks, backlog items, and future roadmap for AgentMemory Kit.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 09 — Pending Tasks and Roadmap

## Immediate Backlog

- [ ] Add unified automated installer script (`scripts/install.sh`) detecting installed agent tools and placing hooks automatically.
- [ ] Implement automated test suite (`tests/test_hooks.sh`) simulating hook inputs and asserting stdout expectations.
- [ ] Add pre-commit hook to verify `CURRENT_STATE.md` stays below the 150-line limit.

## Future Explorations

- [ ] Add Windows PowerShell (`.ps1`) variants of `memory-session-start.sh` and `memory-session-length.sh`.
- [ ] Investigate bidirectional synchronization between Graphify node attributes and `memory/` references.
- [ ] Support automated archiving of daily logs older than 30 days via a maintenance script.

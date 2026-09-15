---
name: 04_BACKEND
description: Backend logic, shell hooks, lifecycle execution, and agent definitions.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 04 — Backend and Automation Scripts

## Script Specifications

The active backend components of `agentmemory-kit` consist of POSIX/Bash scripts and agent definition specifications:

1. **`claude-code/hooks/memory-session-start.sh`**:
   - **Invocation**: Triggered on `SessionStart` event with JSON payload over `stdin`.
   - **Functions**:
     - Extracts `session_id` and `cwd` using `jq`.
     - Initializes or maintains `$HOME/.claude/memory-orchestrator/sessions/<session_id>.state`.
     - Prunes state files older than 7 days.
     - Inspects presence of `memory/`, `AGENTS.md`, `CURRENT_STATE.md`, and `graphify-out/`.
     - Calculates age in days of `CURRENT_STATE.md` and `graphify-out/graph.json`.
     - Emits memory health summary to `stdout` (injected directly into agent context).
2. **`claude-code/hooks/memory-session-length.sh`**:
   - **Invocation**: Triggered on `UserPromptSubmit` before each prompt.
   - **Functions**:
     - Compares current epoch timestamp against `LAST_WARN` in session state.
     - If `>= 7200` seconds (2 hours), emits a warning advising Prompt 9-LITE (mid-session checkpoint).
     - Updates `LAST_WARN` upon firing to avoid spamming the user.
3. **`antigravity/agents/memory-orchestrator/agent.md`**:
   - Agent definition specifying persona, Path A/B/C protocols, and domain isolation rules.
   - Operates in interactive IDE chat via main-thread persona adoption.
4. **`antigravity/hooks.json`**:
   - Configuration registering lifecycle hooks within Antigravity environment.

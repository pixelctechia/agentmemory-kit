---
name: 15_TESTING
description: Testing strategies, script validation, and hook simulation.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 15 — Testing Strategy

## Testing Pillars

Because `agentmemory-kit` consists of shell automation, Markdown templates, and agent definitions, testing centers on script correctness, hook execution, and documentation linting:

## 1. Shell Script Validation

- **Bash Static Analysis**:
  ```bash
  shellcheck claude-code/hooks/*.sh
  ```
- **Execution Flags**:
  Ensure all scripts retain `set -euo pipefail` to halt on unhandled errors, unbound variables, or failed pipeline segments.

## 2. Hook Simulation Testing

Simulate hook triggers by passing synthetic JSON payloads through `stdin`:
```bash
# Test SessionStart hook
echo '{"session_id":"test-session-001","cwd":"."}' | bash claude-code/hooks/memory-session-start.sh

# Verify generated state file
cat ~/.claude/memory-orchestrator/sessions/test-session-001.state

# Test UserPromptSubmit hook
echo '{"session_id":"test-session-001","cwd":"."}' | bash claude-code/hooks/memory-session-length.sh
```

## 3. Knowledge Graph Health Checks

Verify the Graphify CLI can parse the codebase and answer queries without syntax or schema errors:
```bash
graphify god-nodes
graphify explain "memory-session-start.sh"
```

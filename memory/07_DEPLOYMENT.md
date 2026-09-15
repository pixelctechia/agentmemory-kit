---
name: 07_DEPLOYMENT
description: Installation procedures, global setup, and distribution.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 07 — Deployment and Installation

## Deployment Scope

AgentMemory Kit uses a split deployment model:
1. **Global Orchestrator**: Installed once per machine on developer workstations or CI environments.
2. **Project Memory**: Checked into Git per repository.

## Global Installation Instructions

### Claude Code (`~/.claude/`)
1. Create agents directory and copy subagent:
   ```bash
   mkdir -p ~/.claude/agents
   cp claude-code/agents/memory-orchestrator.md ~/.claude/agents/memory-orchestrator.md
   ```
2. Copy executable hooks:
   ```bash
   mkdir -p ~/.claude/hooks
   cp claude-code/hooks/memory-session-start.sh ~/.claude/hooks/
   cp claude-code/hooks/memory-session-length.sh ~/.claude/hooks/
   chmod +x ~/.claude/hooks/*.sh
   ```
3. Register hooks in `~/.claude/settings.json` under `hooks.SessionStart` and `hooks.UserPromptSubmit`.

### Google Antigravity (`~/.gemini/config/`)
1. Create agent directory:
   ```bash
   mkdir -p ~/.gemini/config/agents/memory-orchestrator
   cp antigravity/agents/memory-orchestrator/agent.md ~/.gemini/config/agents/memory-orchestrator/agent.md
   ```
2. Register hooks:
   ```bash
   cp antigravity/hooks.json ~/.gemini/config/hooks.json
   ```

## Post-Install Verification
Restart the AI assistant session so global configuration reloads cleanly.

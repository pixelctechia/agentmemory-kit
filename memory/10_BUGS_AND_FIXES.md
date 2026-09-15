---
name: 10_BUGS_AND_FIXES
description: Known issues, platform quirks, and verified workarounds.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 10 — Known Bugs, Quirks, and Workarounds

## Platform Quirks

### 1. Claude Code Hook & Subagent Hot-Reload Limitation
- **Symptom**: Editing `~/.claude/hooks/*.sh` or `~/.claude/agents/*.md` mid-session does not change active behavior.
- **Cause**: Claude Code loads agent definitions and hook bindings once during CLI process initialization.
- **Workaround**: Restart the Claude Code CLI session (`exit` then restart) after modifying hook scripts.

### 2. Antigravity Main-Thread Persona Execution
- **Symptom**: Invoking `@memory-orchestrator` in interactive IDE chat shares context window with main conversation rather than running in an isolated subagent.
- **Cause**: Interactive chat persona adoption in Antigravity occurs in-thread; context isolation exists only outside interactive chat via SDK/built-in subagents.
- **Workaround**: Keep orchestrator audit outputs concise to minimize token accumulation.

### 3. Missing `jq` Dependency on Host Machine
- **Symptom**: Hooks terminate with exit code 127 if `jq` is not installed.
- **Resolution**: Ensure `jq` is installed via system package manager (`sudo apt install jq` or `brew install jq`).

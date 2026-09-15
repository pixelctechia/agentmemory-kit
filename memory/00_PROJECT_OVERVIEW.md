---
name: 00_PROJECT_OVERVIEW
description: Purpose, scope, and ecosystem of AgentMemory Kit.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 00 — Project Overview

## What this project is

**AgentMemory Kit** is an open-source framework and operational standard for persistent, structured memory and self-checking behavior for AI coding agents. It provides a version-controlled, human-readable documentation structure inside a repository (`memory/`) coupled with a global, once-per-machine orchestrator (hooks + custom agents) that runs automated health, freshness, and session-length checks at zero LLM token cost.

## Target Agents and Tools

- **Claude Code**: Native support via custom subagent (`~/.claude/agents/memory-orchestrator.md`) and lifecycle hooks (`SessionStart`, `UserPromptSubmit`).
- **Google Antigravity (Gemini)**: Custom agent persona (`antigravity/agents/memory-orchestrator/agent.md`) and hooks configuration.
- **AGENTS.md-compatible tools**: Cursor, Codex, Windsurf, Zed, JetBrains, VS Code Copilot, Factory Droid, Aider, and any tool conforming to the universal `AGENTS.md` convention.

## Core Capabilities

1. **Structured Memory Hierarchy (`memory/`)**: Standardized numbered files (00 to 17) covering architecture, environments, decisions, bugs, and graph indexing.
2. **Universal Root Entry Point (`AGENTS.md` & `GEMINI.md`)**: Bootstrap file instructing agents to read `CURRENT_STATE.md` first and adhere to governance rules.
3. **6 Mandatory Agent Behavior Rules (`12_AI_CONTEXT_RULES.md`)**: Enforcing truth hierarchy, graph-first investigation, major task self-checks, 2-hour session checkpoint warnings, memory hygiene, and strict domain isolation.
4. **Knowledge Graph Integration (Graphify)**: Integration with code AST/knowledge graphs to answer architectural queries before raw grep, minimizing context bloating.
5. **Zero-Token Lifecycle Automation**: Pre-flight checks implemented in pure shell scripts (`bash` + `jq`) running before LLM execution starts.

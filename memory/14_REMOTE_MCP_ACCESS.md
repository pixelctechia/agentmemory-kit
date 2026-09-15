---
name: 14_REMOTE_MCP_ACCESS
description: MCP server connection policies, remote tool execution, and security controls.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 14 — Remote MCP Access and Policies

## Remote Protocol Architecture

Model Context Protocol (MCP) servers extend agent capabilities by exposing database connections, cloud integrations, and execution tools.

In `agentmemory-kit`:
- The kit operates standalone without requiring mandatory MCP servers.
- When MCP servers are configured in Claude Code or Antigravity, they interact with the orchestrator via standard MCP JSON-RPC protocols.

## Credential and Secret Rules

1. **Zero Secret Ingestion**:
   - Never write MCP authentication tokens, API keys, or basic auth credentials into memory files, agent prompts, or git-tracked configuration files.
2. **Environment Variable Redirection**:
   - Reference secret values via local environment configuration (e.g. `~/.claude/settings.json` referencing `${API_KEY}` or secret manager commands).
3. **Audit Verification**:
   - During full audits (Prompt `prompts/audit/full-audit.md`), scan all files in `memory/` to guarantee no MCP endpoint headers or sensitive credentials have leaked into version control.

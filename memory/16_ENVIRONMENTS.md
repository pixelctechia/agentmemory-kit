---
name: 16_ENVIRONMENTS
description: Supported operating systems, prerequisites, and runtime environments.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 16 — Environments and Prerequisites

## Supported Environments

- **Operating Systems**: Linux (Ubuntu, Debian, Fedora, Arch), macOS (Darwin), and Windows via WSL2.
- **Shell**: POSIX-compliant Bash (`/usr/bin/env bash`, Bash 4.0+ recommended).

## System Dependencies

1. **`bash`**: Core execution environment for hooks.
2. **`jq`**: JSON parsing utility required for hook stdin parsing.
3. **`graphify`**: Code knowledge-graph generator and AST extractor (`/home/marcos/.local/bin/graphify` or installed via pip/uv).
4. **`git`**: Version control for project tree and state diffing.

## Key File Paths by Environment

- **Global Claude State**:
  `$HOME/.claude/memory-orchestrator/sessions/`
- **Global Antigravity Config**:
  `$HOME/.gemini/config/agents/memory-orchestrator/`
- **Local Project Memory Root**:
  `./memory/`
- **Local Graphify Output**:
  `./graphify-out/`

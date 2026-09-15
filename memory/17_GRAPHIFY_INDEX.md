---
name: 17_GRAPHIFY_INDEX
description: Code knowledge graph coverage, output locations, and real tested query examples.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 17 — Graphify Knowledge Graph Index

## What the Graph Covers

The codebase graph maps the automation and hook scripts of `agentmemory-kit`:
- **Main AST Nodes**:
  - `claude-code/hooks/memory-session-start.sh` (AST extraction node & script execution entry)
  - `claude-code/hooks/memory-session-length.sh` (AST extraction node & script execution entry)
- **Extracted Relations**: Script containment, invocation endpoints, and dependency mappings.

## Where the Graph Files Live

- **Graph Data (JSON)**: `graphify-out/graph.json`
- **Output Directory**: `graphify-out/`

## How to Query It (Real, Tested Commands)

These commands have been executed and verified against this codebase:

### 1. Identify Key Architectural Hubs (God Nodes)
```bash
graphify god-nodes
```
**Observed Output:**
```text
God nodes (most connected):
  1. memory-session-length.sh script - 1 edges
  2. memory-session-start.sh script - 1 edges
```

### 2. Inspect Node Details and Connections
```bash
graphify explain "memory-session-start.sh"
```
**Observed Output:**
```text
Node: memory-session-start.sh
  ID:        claude_code_hooks_memory_session_start
  Source:    claude-code/hooks/memory-session-start.sh L1
  Type:      code
  Degree:    1

Connections (1):
  --> memory-session-start.sh script [contains] [EXTRACTED] claude-code/hooks/memory-session-start.sh:L1
```

## When to Regenerate

After any structural code change (new scripts added to `claude-code/hooks/`, refactored hook logic, or newly added automation tools):
```bash
graphify extract . --code-only --no-cluster
```

## Relationship to Narrative Memory Files

The graph is the source of truth for **HOW** code connects — generated, disposable, regenerate freely. The other `memory/` files are the source of truth for **WHY** things exist — hand-curated, never regenerated automatically.

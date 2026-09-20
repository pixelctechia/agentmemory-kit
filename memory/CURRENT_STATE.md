---
name: CURRENT_STATE
description: Snapshot of the project's current state. Read first, every session. Max ~150 lines.
Last updated: 2026-09-20
Updated by: session 2026-09-20
Status: current
---

# Current State — AgentMemory Kit

## What this project does

AgentMemory Kit is an open-source standard and operational framework providing persistent, versioned memory and self-checking behavior for AI coding agents. It pairs a standardized markdown memory directory (`memory/00_` to `17_`) with zero-token shell lifecycle hooks and custom agent definitions for Claude Code, OpenAI Codex CLI, Google Antigravity, and AGENTS.md-compatible tools.

## Recently worked on

- **2026-09-20**:
  - Added OpenAI Codex CLI support: new `codex/` folder with `hooks/memory-session-start.sh`, `hooks/memory-session-length.sh`, `agents/memory-orchestrator.toml` (official Codex subagent TOML schema), `config-snippet.toml`, and `INSTALL.md`.
  - Confirmed via official docs + native-binary string inspection that Codex's `SessionStart`/`UserPromptSubmit` hook JSON contract is field-for-field identical to Claude Code's — flagged as unconfirmed whether that's intentional compatibility or coincidence.
  - Confirmed Codex's native 3-level `AGENTS.md` merge (`~/.codex/AGENTS.md` → repo-root → cwd) via official docs.
  - Bumped version to **v2.5** in `CHANGELOG.md`; updated `README.md`, `docs/README.pt-BR.md`, and `docs/MANUAL.md` to reference Codex CLI alongside Claude Code and Antigravity.
- **2026-09-15**:
  - Bootstrapped canonical memory via **Path A** (Caminho A) with all 18 numbered memory files (`00_` to `17_`).
  - Adapted `02_DATABASE.md` (templates as data schemas) and `03_FRONTEND.md` (prompts as UI catalog).
  - Enforced all 6 mandatory governance rules in `12_AI_CONTEXT_RULES.md` and created `AGENTS.md` / `GEMINI.md`.
  - Generated codebase knowledge graph with Graphify into `graphify-out/` and verified queries in `17_GRAPHIFY_INDEX.md`.
  - Added GitHub community health files: `CODE_OF_CONDUCT.md` and issue templates (`.github/ISSUE_TEMPLATE/`).
  - Published official GitHub Release `v2.4 — Scope Discipline (Domain Isolation)`.
  - Enhanced `README.md` and `docs/README.pt-BR.md` with plain-language intro and visual Mermaid workflow diagram.
  - Executed full memory audit (clean secret scan, metadata headers verified, line count limits respected).

## In progress

- None. Session complete; all code and documentation changes pushed to remote `main`.

## Known issues / blockers

- None blocking. Standard platform traits documented in `10_BUGS_AND_FIXES.md` (e.g. Claude Code CLI restart for hook reload, Antigravity in-thread persona adoption).

## Memory & graph status

- **`memory/12_AI_CONTEXT_RULES.md`**: Current — all 6 mandatory sections active.
- **Knowledge Graph (`graphify-out/graph.json`)**: Current — extracted and verified on 2026-09-15.
- **Memory Structure**: Complete — 18 numbered files, daily log recorded, zero secrets.

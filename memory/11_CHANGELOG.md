---
name: 11_CHANGELOG
description: Chronological record of major releases, updates, and memory bootstraps.
Last updated: 2026-09-20
Updated by: session 2026-09-20
Status: current
---

# 11 — Changelog

## 2026-09-20 — Codex CLI support (v2.5)
- Added `codex/` folder: `hooks/memory-session-start.sh`, `hooks/memory-session-length.sh`, `agents/memory-orchestrator.toml` (official Codex subagent TOML schema — `name`, `description`, `developer_instructions` required), `config-snippet.toml`, `INSTALL.md`.
- Confirmed native 3-level `AGENTS.md` merge in Codex CLI (`~/.codex/AGENTS.md` global → repo-root → cwd) via official docs.
- Confirmed Codex's `SessionStart`/`UserPromptSubmit` hook JSON I/O contract via official docs and native-binary string inspection — field-for-field identical to Claude Code's contract (`session_id`, `cwd`, `hookSpecificOutput`, `additionalContext`); origin of the convergence (intentional compatibility vs. coincidence) not confirmed.
- Updated `README.md`, `docs/README.pt-BR.md`, `docs/MANUAL.md` to mention Codex CLI alongside Claude Code and Antigravity.

## 2026-09-15 — Path A Bootstrap
- Bootstrapped full `memory/` structure (files 00 to 17, `CURRENT_STATE.md`, templates, logs).
- Created root `AGENTS.md` and pointer `GEMINI.md`.
- Generated initial codebase knowledge graph with Graphify.

## v2.4
- Added Rule 6: **Scope Discipline (Domain Isolation)** — request classification by domain (design/UI, backend, database, infrastructure, content) and mandatory permission before crossing domains.

## v2.3
- Added Rule 4: **Session Length Self-Check** — 2-hour elapsed session warning with lightweight checkpoint (Prompt 9-LITE) by default.
- Documented global orchestrator architecture (per-machine installation vs per-project memory).

## v2.2
- Added Knowledge Graph integration via Graphify (`17_GRAPHIFY_INDEX.md`) and graph-first lookup rule.
- Added Rule 3: **Major Task Criteria and Self-Check**.

## v2.1
- Introduced root `AGENTS.md` universal bootstrap convention.

## v2.0
- First structured, numbered `memory/` folder standard (00-16).

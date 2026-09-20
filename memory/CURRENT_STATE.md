---
name: CURRENT_STATE
description: Snapshot of the project's current state. Read first, every session. Max ~150 lines.
Last updated: 2026-09-20
Updated by: session 2026-09-20 (pt-BR tutorials)
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
  - **Real end-to-end test result: the Codex hooks do NOT fire.** Fresh session, project marked `trust_level = "trusted"`, both hooks permanently registered in `~/.codex/config.toml` — `~/.codex/memory-orchestrator/sessions/` stayed empty after the session. `AGENTS.md`/memory reading worked correctly (confirmed independently of the hooks). Suspected cause: a separate `HookTrustStatus`/`HookExecutionMode` wire type found in the binary, distinct from project trust — its approval flow (if any) lives in TUI onboarding code (`trust_directory.rs`) but did not surface during manual interactive testing either. Documented as a known, unresolved limitation in `codex/INSTALL.md` — hooks section retitled "built but not confirmed working," with manual-workaround guidance (run Prompt 7 manually, self-monitor session length) and an open call for outside investigation.
  - Bumped version to **v2.5** in `CHANGELOG.md`; updated `README.md`, `docs/README.pt-BR.md`, and `docs/MANUAL.md` to reference Codex CLI alongside Claude Code and Antigravity.
  - Added Brazilian Portuguese translations of all three tool installation tutorials: `claude-code/INSTALL.pt-BR.md`, `antigravity/INSTALL.pt-BR.md`, `codex/INSTALL.pt-BR.md`. Each original English `INSTALL.md` now links to its Portuguese counterpart and vice versa. Commands, paths, and code blocks kept untranslated; the Codex limitation section (hooks confirmed not firing, suspected `HookTrustStatus`/`HookExecutionMode` cause, open call for investigation) was translated preserving the exact same confident/honest framing as the English original.
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

- **Codex CLI `SessionStart`/`UserPromptSubmit` hooks do not fire automatically**, confirmed via a real end-to-end test (trusted project, hooks registered, fresh session — no state file created). Root cause unconfirmed; suspected separate hook-trust gate (`HookTrustStatus` in the binary) with no known non-dangerous way to satisfy it yet. Not blocking for AGENTS.md/memory support, which works independently. See `codex/INSTALL.md` section 3 for full detail and the manual-workaround guidance until resolved.
- Other standard platform traits documented in `10_BUGS_AND_FIXES.md` (e.g. Claude Code CLI restart for hook reload, Antigravity in-thread persona adoption) — none blocking.

## Memory & graph status

- **`memory/12_AI_CONTEXT_RULES.md`**: Current — all 6 mandatory sections active.
- **Knowledge Graph (`graphify-out/graph.json`)**: Current — extracted and verified on 2026-09-15.
- **Memory Structure**: Complete — 18 numbered files, daily log recorded, zero secrets.

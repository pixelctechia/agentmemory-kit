---
name: 08_DECISIONS_LOG
description: Log of foundational architectural and design decisions for AgentMemory Kit.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 08 — Decisions Log

## DECISION-001 — Zero-Token Shell Hooks for Pre-flight Checks
**Date:** 2026-09-15  
**Context:** Pre-flight session checks and duration monitoring could be done by asking an LLM to evaluate health, but this wastes model tokens, slows down startup, and increases API cost on every prompt.  
**Decision:** Implement hooks as native POSIX Bash scripts parsing JSON via `jq`.  
**Rationale:** Execution completes in milliseconds with 0 token overhead.  
**Consequences:** Requires bash and jq on host system.

## DECISION-002 — Adoption of Root AGENTS.md Standard
**Date:** 2026-09-15  
**Context:** Dozens of coding agents support different filenames (`CLAUDE.md`, `.cursorrules`, `GEMINI.md`, etc.).  
**Decision:** Standardize on `AGENTS.md` at repository root, with short pointer files (like `GEMINI.md`) where needed.  
**Rationale:** Widely adopted industry standard natively read by 30+ tools.  
**Consequences:** Keeps instructions synchronized in a single file.

## DECISION-003 — 3-Layer Truth Hierarchy
**Date:** 2026-09-15  
**Context:** Risk of hallucination or stale documentation causing models to overwrite newer code.  
**Decision:** Code defines WHAT exists → Graph defines HOW components connect → Memory defines WHY it was built.  
**Rationale:** In case of conflict, code always wins. Documentation must be adapted to reality.  
**Consequences:** Memory files are never automatically overwritten by code without user review.

## DECISION-004 — Domain Isolation (Scope Discipline)
**Date:** 2026-09-15  
**Context:** Agents frequently cause regressions by touching unrelated styles, backend logic, or database configs during small changes.  
**Decision:** Enforce domain classification (UI, backend, db, infra, content) and require explicit approval before crossing boundaries.  
**Rationale:** Prevents unintended side effects and protects completed code.  
**Consequences:** Agents must stop and request confirmation if cross-domain changes are required.

## DECISION-005 — 2-Hour Warning Defaulting to Prompt 9-LITE
**Date:** 2026-09-15  
**Context:** Long-running sessions suffer from context degradation and token exhaustion.  
**Decision:** When 2+ hours elapse, suggest a quick checkpoint (Prompt 9-LITE) rather than forcing a full session close.  
**Rationale:** Preserves mid-session momentum while safely recording current state.  
**Consequences:** Users retain control over whether to continue or sync state.

---
name: 12_AI_CONTEXT_RULES
description: The 6 mandatory behavior rules every AI working on this project must follow.
sources: [template]
---

## 1. Source of Truth Hierarchy

The codebase is the source of truth about WHAT exists. The knowledge graph
(when up to date) is the source of truth about HOW components connect.
The memory system is the source of truth about WHY things exist. On
conflict between them, trust the code, flag the divergence, and propose
fixing the memory or regenerating the graph — never modify the code to
match a stale memory or graph.

## 2. Graphify / Knowledge Graph Usage Rule

Before grep or raw file reading to understand structure, use the
knowledge-graph tool's query/path/explain commands first. After any
structural code change, regenerate the graph.

## 3. Major Task Criteria and Self-Check

A task is a **major task** if it meets any one of these criteria:
- touches the database or authentication
- affects more than 3 files
- changes an API contract or the architecture
- changes a shared/reusable component
- affects deployment

Before starting ANY task, silently check it against this criteria as a
mandatory pre-flight step. If the task matches, do NOT proceed directly
into implementation — tell the user which criteria the task matches and
ask for permission to run a planning step first, then wait for explicit
confirmation before doing anything else. If the task does not match any
criteria, proceed normally without mentioning this check.

## 4. Session Length Self-Check

Record the session start time at startup. Before starting work on any
task, compare the current time against the recorded session start time —
or against the time of the last session-length warning already given in
this conversation, whichever is more recent. If 2 hours or more have
elapsed, do NOT proceed directly — warn the user that the session has
been running for 2+ hours and ask for permission to run a lightweight
checkpoint (not a full session close) before continuing, then wait for
explicit confirmation. If the user declines, proceed with the task but
reset the reference point to the current time, so the next warning only
fires after another 2 hours. This check is independent from the Major
Task Self-Check — if both trigger in the same turn, mention both concerns
in a single message rather than asking twice.

## 5. Memory Hygiene

- `CURRENT_STATE.md` stays under approximately 150 lines.
- Daily logs older than 30 days move to `daily_logs/archive/`.
- Metadata headers are kept updated.
- The knowledge graph is regenerated when flagged as outdated.

## 6. Scope Discipline (Domain Isolation)

Before implementing any request, classify which domain(s) it explicitly
targets: design/UI/frontend visual layer, backend/business logic,
database/schema, infrastructure/deployment, or content/copy. Only touch
files within that domain.

Never change finished, already-built visual design or layout unless the
request explicitly asks for a design/visual change. Never touch the
database schema, backend logic, or infrastructure unless the request
explicitly targets that domain or the change genuinely cannot be
completed without it.

If a request genuinely requires touching a domain not mentioned (e.g. a
new UI field that needs a new database column), stop before making that
cross-domain change: explain exactly what's needed and why, and ask for
explicit permission — then wait for confirmation before proceeding with
that specific cross-domain part, while still completing the rest of the
request within the originally requested domain in the meantime.

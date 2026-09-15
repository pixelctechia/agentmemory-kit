# AgentMemory Kit — Technical Manual

This is the canonical technical reference. It describes every rule, file,
and workflow in full detail. `README.md` is the quick overview;
`docs/README.pt-BR.md` is the Portuguese version of that overview.

## 1. Philosophy

An AI coding agent's context window resets between sessions. Without a
deliberate memory system, every session starts blind: it doesn't know what
was decided last week, whether a migration was already applied, or what
parts of the codebase it's safe to touch. AgentMemory Kit solves this with
three layers:

1. **A structured, versioned, human-readable memory** living inside the
   project's own repository (`memory/`).
2. **A knowledge graph of the codebase** (via [Graphify](https://github.com/)
   or an equivalent tool), so the agent can answer "how does this connect"
   without re-reading the whole codebase every time.
3. **A global orchestrator** (installed once per machine, not per project)
   that automatically checks project memory health and session length,
   using plain shell scripts — zero LLM token cost — before the model
   even starts reasoning.

The source-of-truth hierarchy that ties these together:

> **Code** defines what exists → **the graph** (when current) defines how
> it connects → **the memory** defines why it exists. On conflict, trust
> the code, flag the divergence, and propose fixing the memory or
> regenerating the graph — never the other way around.

## 2. The `memory/` structure

```
memory/
├── 00_PROJECT_OVERVIEW.md
├── 01_ARCHITECTURE.md
├── 02_DATABASE.md
├── 03_FRONTEND.md
├── 04_BACKEND.md
├── 05_ADMIN_CONSOLE.md
├── 06_API_ROUTES.md
├── 07_DEPLOYMENT.md
├── 08_DECISIONS_LOG.md
├── 09_PENDING_TASKS.md
├── 10_BUGS_AND_FIXES.md
├── 11_CHANGELOG.md
├── 12_AI_CONTEXT_RULES.md      ← the 6 mandatory rules (see section 4)
├── 13_DATABASE_WORKFLOW.md
├── 14_REMOTE_MCP_ACCESS.md
├── 15_TESTING.md
├── 16_ENVIRONMENTS.md
├── 17_GRAPHIFY_INDEX.md        ← what the knowledge graph covers, with real examples
├── CURRENT_STATE.md            ← max ~150 lines, read first every session
├── daily_logs/
│   └── archive/                ← logs older than 30 days move here
├── client_reports/weekly/
└── templates/
```

Every file carries a standard metadata header:

```
---
Last updated: YYYY-MM-DD
Updated by: session YYYY-MM-DD
Status: current
---
```

## 3. `AGENTS.md`

A single bootstrap file at the project root, read natively by Claude Code,
Cursor, Codex, Antigravity, Windsurf, Zed, VS Code, and JetBrains — over
30 tools recognize this filename by convention. It should contain:

1. A mandatory startup procedure: read `CURRENT_STATE.md` first, then pull
   in specific numbered files only as needed for the task at hand.
2. The permanent rules, referencing `memory/12_AI_CONTEXT_RULES.md` by name
   rather than duplicating its full text.

Tools that don't read `AGENTS.md` natively (e.g. Gemini CLI) need a short
pointer file (`GEMINI.md`) that just says "read AGENTS.md."

## 4. The six mandatory rules (`memory/12_AI_CONTEXT_RULES.md`)

### 4.1 Source of Truth Hierarchy
See section 1. This is the tie-breaker whenever memory and code disagree.

### 4.2 Graphify Usage Rule
Before grep or raw file reading to understand structure, try a knowledge-
graph query first (`graphify query`, `graphify path`, `graphify explain`,
or the equivalent for whatever graph tool is in use). After any structural
code change, regenerate the graph.

### 4.3 Major Task Criteria and Self-Check
A task is **major** if it meets any of:
- touches the database or authentication
- affects more than 3 files
- changes an API contract or the architecture
- changes a shared/reusable component
- affects deployment

Before starting **any** task, the agent silently checks it against this
list. If it matches, the agent does **not** proceed directly — it tells the
user which criterion matched and asks permission to run a planning step
first, then waits for confirmation. If nothing matches, it proceeds
normally without mentioning the check.

### 4.4 Session Length Self-Check
The agent records the session start time at startup. Before starting work
on any task, it compares the current time against session start (or
against the last warning already given). If 2+ hours have elapsed, it
warns the user and asks permission to run a lightweight checkpoint —
**not** a full session close — before continuing. If the user declines,
the agent proceeds but resets the reference time, so the next warning only
fires after another 2 hours.

### 4.5 Memory Hygiene
- `CURRENT_STATE.md` stays under ~150 lines.
- Daily logs older than 30 days move to `daily_logs/archive/`.
- Metadata headers stay current.
- The knowledge graph gets regenerated when flagged as stale.

### 4.6 Scope Discipline (Domain Isolation)
Before implementing any request, the agent classifies which domain(s) it
explicitly targets — design/UI/frontend visual layer, backend/business
logic, database/schema, infrastructure/deployment, or content/copy — and
only touches files within that domain. It never changes finished, already-
built visual design or layout unless the request explicitly asks for a
design change, and never touches the database schema, backend logic, or
infrastructure unless the request explicitly targets that domain or the
change genuinely cannot be completed without it.

If a request genuinely requires crossing into a domain not mentioned (a
new UI field that needs a new database column, for instance), the agent
stops, explains exactly what's needed and why, and asks for explicit
permission before making that specific cross-domain change — completing
the rest of the request within the originally requested domain in the
meantime.

## 5. The three bootstrap paths

| Path | When to use it |
|---|---|
| **A — New project** | No `memory/` folder exists yet. |
| **B — Existing but incomplete memory** | `memory/` exists but is missing files, sections, or the graph. |
| **C — Old single-file memory** | A pre-existing large, unstructured memory file needs migrating into the numbered structure. |

Path A always ends with: analyze the real codebase and fill every file with
real content (no placeholders), document the database/MCP access flow
without ever writing credential values, create all 6 mandatory rule
sections, create `CURRENT_STATE.md`, create templates, run a full audit
(structure, metadata headers, secret scan), create `AGENTS.md`, and install
the knowledge graph tool with a documented index file containing real,
tested query examples.

## 6. The global orchestrator

Installed **once per machine**, not per project or per account — it lives
outside any single project's repository:

- **Claude Code**: `~/.claude/agents/memory-orchestrator.md` (a custom
  subagent) plus two hooks in `~/.claude/settings.json`:
  - `SessionStart` — records the session start time and inspects the
    current project's `memory/` folder for completeness and freshness,
    injecting a short summary as context. Zero LLM cost — plain shell.
  - `UserPromptSubmit` — checks elapsed session time before every prompt;
    injects the 2-hour warning described in section 4.4 when due.
- **Antigravity**: the equivalent custom agent at
  `~/.gemini/config/agents/memory-orchestrator/agent.md`, plus lifecycle
  hooks in Antigravity's own hook configuration format.

Both installations only ever **report** what they find — they never
install, delete, or overwrite memory files on their own initiative. Any
actual setup or fix requires the user's explicit instruction.

### Known platform differences
- Claude Code hooks and the custom subagent list are only (re)loaded at
  process start — editing these files mid-session has no effect until the
  session is restarted.
- In Antigravity's interactive chat, a custom agent invoked via `@agent`
  always runs as persona-adoption in the main thread — it does not spawn
  an isolated child process the way Claude Code's subagent delegation
  does. True isolated execution in Antigravity exists only through
  built-in tools or the Antigravity SDK outside the interactive chat.

## 7. Graph tool integration

Any code knowledge-graph tool that can answer "what does this call," "what
depends on this," and "explain this symbol's connections" fits here. The
project used to design this kit used a tool with three commands
(`query`, `path`, `explain`) and a generated report file — adapt the
`17_GRAPHIFY_INDEX.md` template to whichever tool you use, but keep the
same contract: real, tested examples specific to the actual codebase, not
generic placeholders, and a clear regeneration trigger after structural
changes.

## 8. Full prompt catalog

See the `prompts/` directory. Each file is a complete, standalone prompt
meant to be pasted as-is into whichever AI coding tool you're using.

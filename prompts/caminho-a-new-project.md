# Path A — Bootstrap a brand new project (no memory yet)

Use this when the project has no `memory/` folder at all yet.

```text
Create the full memory/ folder structure for this project from scratch, following this standard:

memory/
├── 00_PROJECT_OVERVIEW.md through 16_ENVIRONMENTS.md (standard numbered files, reserve 17_ for the knowledge-graph index)
├── CURRENT_STATE.md
├── daily_logs/ + daily_logs/archive/
├── client_reports/weekly/
└── templates/

Create each file with a standard metadata header (Last updated / Updated by / Status) and a title. Then analyze this project's entire codebase and fill in every file with real content — what this project does, its tech stack, folder structure, key architectural decisions visible in the code, and any conventions you observe. Base everything on what's actually in the code, never guess or assume placeholders.

Document the database/MCP access flow in the appropriate numbered file without ever writing credential values — reference where they're stored (e.g. .env, secret manager) instead.

Create memory/12_AI_CONTEXT_RULES.md with all 6 mandatory sections: SOURCE OF TRUTH HIERARCHY, GRAPHIFY (KNOWLEDGE GRAPH) USAGE RULE, MAJOR TASK CRITERIA AND SELF-CHECK, SESSION LENGTH SELF-CHECK, MEMORY HYGIENE, and SCOPE DISCIPLINE (DOMAIN ISOLATION) — see docs/MANUAL.md section 4 for the exact wording of each.

Create CURRENT_STATE.md (max ~150 lines), templates/ (DAILY_LOG_TEMPLATE.md, DECISION_TEMPLATE.md at minimum), and run a full audit: check every file has a metadata header, and scan the entire memory/ folder for any accidentally exposed credential, API key, or secret.

Create AGENTS.md at the project root: a mandatory startup procedure (read CURRENT_STATE.md first, then pull in specific files as needed) and permanent rules referencing memory/12_AI_CONTEXT_RULES.md by name.

Finally, install a code knowledge-graph tool for this codebase, generate the initial graph, and create memory/17_GRAPHIFY_INDEX.md documenting what it covers with real, tested query examples run against this actual codebase — not generic examples.

Do not modify application code. Report everything you did, step by step.
```

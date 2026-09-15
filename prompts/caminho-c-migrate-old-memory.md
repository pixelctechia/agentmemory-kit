# Path C — Migrate an old, single-file memory dump

Use this when the project has AI memory stored as one large unstructured
file (or scattered notes) instead of the numbered `memory/` structure.

```text
This project currently has AI memory stored in a single file (or scattered notes), not the structured memory/ folder standard. Migrate it to the standard structure (00_PROJECT_OVERVIEW.md through 16_ENVIRONMENTS.md, 17_GRAPHIFY_INDEX.md, CURRENT_STATE.md, daily_logs/, client_reports/weekly/, templates/).

Extract and redistribute all useful information from the old file into the appropriate numbered files. Do not lose any information — if something doesn't fit a standard file, note it in 08_DECISIONS_LOG.md for review. Add the standard metadata header to every file created.

After migration, do not delete the old memory file yet — ask me for explicit confirmation before deleting it.

Once the structure exists, follow the same completion steps as Path A: document database/MCP access without credential values, create all 6 mandatory rule sections in memory/12_AI_CONTEXT_RULES.md (see docs/MANUAL.md section 4), create CURRENT_STATE.md, templates/, run a full audit including a secret scan, create AGENTS.md, and install/verify the knowledge-graph tool with a real, tested index file.

Report everything you did, step by step, before I confirm deletion of the old file.
```

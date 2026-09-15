# Full memory audit

Use this periodically (roughly every 30 days) or whenever you're unsure
the memory setup is complete and correct. This is read-only — it changes
nothing by itself.

```text
Audit this project's AI memory setup completely. Do not create, modify, or delete anything — this is read-only diagnostic only.

1. STRUCTURE: Does memory/ exist? List every file and folder inside it. Note any numbered file missing between 00 and 17, and any duplicate or colliding file numbers.

2. BOOTSTRAP FILES: Does AGENTS.md exist at the project root, with a startup procedure and permanent rules? Does it duplicate content instead of pointing to itself consistently?

3. CURRENT_STATE.md: Does it exist? How many lines? Metadata header present? Is the content accurate compared to the actual codebase, or outdated?

4. KNOWLEDGE GRAPH: Does the graph output exist? Check its generation date against the current git HEAD — aligned or stale? Test one live query/explain command right now and show the raw result.

5. RULES FILE: Open memory/12_AI_CONTEXT_RULES.md and confirm all 6 sections are present, quoting a short snippet of each: SOURCE OF TRUTH HIERARCHY, GRAPHIFY/KNOWLEDGE GRAPH USAGE RULE, MAJOR TASK CRITERIA AND SELF-CHECK, SESSION LENGTH SELF-CHECK, MEMORY HYGIENE, SCOPE DISCIPLINE (DOMAIN ISOLATION).

6. DATABASE/MCP DOCUMENTATION: Does it exist? Any real credential value found (flag without printing it)?

7. TEMPLATES: List exactly which template files exist in memory/templates/.

8. HYGIENE: Any daily logs older than 30 days still outside daily_logs/archive/? Any files missing metadata headers? Scan the entire memory/ folder for accidentally exposed credentials, API keys, tokens, or secrets, and flag which file and line without printing the value.

Present the findings as a checklist: ✅ CONFIRMED, ⚠️ PARTIALLY COMPLETE (explain the gap), or ❌ MISSING, based on real evidence only — no assumptions.
```

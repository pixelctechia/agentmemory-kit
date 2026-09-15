# Path B — Complete an existing but incomplete memory setup

Use this when `memory/` already exists but is missing files, rule sections,
or the knowledge graph.

```text
Audit this project's existing memory/ setup and report exactly what's missing before changing anything: which numbered files (00-17) are absent, whether AGENTS.md exists and contains a startup procedure and permanent rules, whether CURRENT_STATE.md exists and is under ~150 lines, whether a knowledge-graph tool is installed and whether the graph is stale relative to the current code, and which of the 6 mandatory sections are present in memory/12_AI_CONTEXT_RULES.md (SOURCE OF TRUTH HIERARCHY, GRAPHIFY/KNOWLEDGE GRAPH USAGE RULE, MAJOR TASK CRITERIA AND SELF-CHECK, SESSION LENGTH SELF-CHECK, MEMORY HYGIENE, SCOPE DISCIPLINE / DOMAIN ISOLATION).

Report the gaps first. Then, once I confirm, fill in only what's missing — do not recreate or overwrite files that already exist and are correct. For any numbered file that's missing, analyze the real codebase and fill it with real content, not placeholders. For any missing rule section, add it with the exact wording described in docs/MANUAL.md section 4. If the knowledge graph is missing or stale, install/regenerate it and create or update the index file with real, tested examples specific to this codebase.

Do not modify application code. Report everything you did, step by step.
```

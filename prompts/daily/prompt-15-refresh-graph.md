# Prompt 15 — Refresh the knowledge graph

Use this after any structural code change: new files, modules, functions,
or refactors that altered calls or dependencies.

```text
Regenerate the knowledge graph, since structural changes were made in this session.

After regenerating, verify the update resolved correctly by testing a query/explain command on one or two of the new or changed components.

Update memory/17_GRAPHIFY_INDEX.md and memory/CURRENT_STATE.md with the new commit hash and confirm the graph is current — remove any staleness note if one exists. Do not modify application code.

Report confirming the graph was regenerated and which new components now resolve.
```

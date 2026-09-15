# Prompt 8 — Plan before a major task

Use this before any task that touches the database, authentication, more
than 3 files, an API contract, the architecture, shared components, or
deployment — or let the Major Task Self-Check (rule 4.3) trigger it for
you.

```text
Before starting this task, use the knowledge-graph tool (query/path/explain) to map out which files, modules, and dependencies this change will actually touch — do not rely on grep or guesswork.

Then produce a short plan: what will be changed, which files are affected, any risks or side effects the graph reveals (e.g. shared dependencies, other modules that import the affected code), and your recommended approach. Wait for my confirmation before writing any code.

Task: [DESCRIBE THE TASK HERE]
```

# Changelog

## v2.4
- Added rule 6: **Scope Discipline (Domain Isolation)** — the agent
  classifies every request by domain (design/UI, backend, database,
  infrastructure, content) and asks permission before crossing into a
  domain the request didn't mention.

## v2.3
- Added rule 4: **Session Length Self-Check** — after 2+ hours in a
  session, the agent warns and offers a lightweight checkpoint by
  default, not a full session close.
- Documented the global orchestrator pattern: a one-time, per-machine
  installation (custom subagent + lifecycle hooks) instead of
  per-project manual reminders.

## v2.2
- Added knowledge-graph integration (Graphify or equivalent): a
  `17_GRAPHIFY_INDEX.md` file and the rule to prefer graph queries over
  blind grep/file reading.
- Added rule 3: **Major Task Criteria and Self-Check**.

## v2.1
- Introduced the universal `AGENTS.md` bootstrap file, read natively by
  multiple AI coding tools without a tool-specific config file each.

## v2.0
- First structured, numbered `memory/` folder standard, replacing
  single-file memory dumps.

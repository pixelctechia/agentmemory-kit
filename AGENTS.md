# AGENTS.md — Agent Instructions for AgentMemory Kit

Welcome, agent. This repository is governed by **AgentMemory Kit**. You must follow the startup procedure and permanent behavioral rules outlined below.

---

## Mandatory Startup Procedure

Every time you begin a session or task in this repository, you must:

1. **Read [memory/CURRENT_STATE.md](file:///home/marcos/App/agentmemory-kit/memory/CURRENT_STATE.md) first** before performing any actions or answering questions about project state.
2. **Consult [memory/17_GRAPHIFY_INDEX.md](file:///home/marcos/App/agentmemory-kit/memory/17_GRAPHIFY_INDEX.md)**: Before grepping or scanning files blindly to understand structure, check the code knowledge graph (`graphify god-nodes`, `graphify explain "<symbol>"`).
3. **Pull in numbered memory files on-demand**: Do NOT load all memory files at once. Only inspect the specific numbered file relevant to your immediate task (e.g., `04_BACKEND.md` for hook script work, `07_DEPLOYMENT.md` for installation steps).

---

## Permanent Behavioral Rules

All interactions and modifications in this codebase are strictly governed by the **six mandatory rules** defined in [memory/12_AI_CONTEXT_RULES.md](file:///home/marcos/App/agentmemory-kit/memory/12_AI_CONTEXT_RULES.md):

1. **Source of Truth Hierarchy**: Code > Knowledge Graph (when fresh) > Memory. Trust the code in conflicts; update memory or regenerate the graph — never modify valid code to match stale documentation.
2. **Graphify / Knowledge Graph Usage Rule**: Try a knowledge-graph query first before raw grep/reads. Regenerate the graph after structural changes.
3. **Major Task Criteria & Self-Check**: Stop and ask for permission to run a planning step before starting any task that touches the database/auth, affects >3 files, changes API contracts/architecture, alters shared components, or affects deployment.
4. **Session Length Self-Check**: After 2+ hours elapsed in a single session, warn the user and suggest a lightweight checkpoint (Prompt 9-LITE) rather than a full session close.
5. **Memory Hygiene**: Keep `CURRENT_STATE.md` under ~150 lines, rotate daily logs older than 30 days to `daily_logs/archive/`, keep headers updated, and regenerate stale graphs.
6. **Scope Discipline (Domain Isolation)**: Classify each request by domain (design/UI, backend, database, infrastructure, content). Never touch out-of-scope domains without explicit permission.

---

## Non-Negotiable Boundaries

- **Never modify application/script code when only updating memory.**
- **Never store plaintext secrets or credentials in any file.**

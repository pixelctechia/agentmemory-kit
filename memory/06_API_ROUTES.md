---
name: 06_API_ROUTES
description: Hook interface schemas, prompt contracts, and CLI command endpoints.
Last updated: 2026-09-15
Updated by: session 2026-09-15 (Path A bootstrap)
Status: current
---

# 06 — API Contracts and Invocation Routes

## Hook I/O Schema

The shell hooks interface with agent runtimes via standard POSIX streams (JSON input over `stdin`, plain text output over `stdout`):

### 1. `SessionStart` Hook Input (`stdin`)
```json
{
  "session_id": "string (e.g. 550e8400-e29b-41d4-a716-446655440000)",
  "cwd": "string (absolute path to repository root)"
}
```

### 2. `SessionStart` Hook Output (`stdout`)
Plain-text lines emitted to stdout and automatically surfaced as system context to the model:
- `[memoria] memory/ encontrada. Presentes: <LIST_OF_FOUND_FILES>.`
- `[memoria] AUSENTES: <LIST_OF_MISSING_FILES> — pode ser Caminho B.`
- `[memoria] CURRENT_STATE.md atualizado ha <N> dia(s).`
- `[memoria] Grafo gerado ha <N> dia(s).`

### 3. `UserPromptSubmit` Hook Output (`stdout`)
- `[memoria-aviso] Sessao rodando ha mais de 2 horas. Sugira Prompt 9-LITE (checkpoint rapido).`

## Prompt Catalog Endpoints

The prompt catalog routes common workflows to standard interaction templates:
- **`prompts/caminho-a-new-project.md`**: Initial memory bootstrap for blank repos.
- **`prompts/caminho-b-existing-memory.md`**: Repair/completion of partial memory setups.
- **`prompts/caminho-c-migrate-old-memory.md`**: Migration from monolithic memory dumps.
- **`prompts/daily/prompt-7-open-session.md`**: Morning/session opening routine.
- **`prompts/daily/prompt-8-plan-major-task.md`**: Pre-flight planning protocol.
- **`prompts/daily/prompt-9-lite-checkpoint.md`**: Fast mid-session state sync.
- **`prompts/daily/prompt-9-close-session.md`**: End-of-day wrapup and logging.
- **`prompts/daily/prompt-15-refresh-graph.md`**: Knowledge graph regeneration.

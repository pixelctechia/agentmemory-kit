#!/usr/bin/env bash
# AgentMemory Kit — Codex CLI UserPromptSubmit hook
# Checks elapsed time since session start (or since the last warning) and
# injects a warning if 2+ hours have passed, using the same session_id
# keying and state file written by memory-session-start.sh. Silent (no
# output) otherwise. Output uses the confirmed structured contract
# (hookSpecificOutput/additionalContext, struct
# UserPromptSubmitHookSpecificOutputWire, 2 fields) instead of plain
# stdout text. Pure shell — zero LLM token cost.

set -euo pipefail

WARN_SECONDS="${MEMORY_SESSION_WARN_SECONDS:-7200}"  # 2 hours, overridable for testing

INPUT="$(cat)"
SESSION_ID="$(echo "$INPUT" | jq -r '.session_id // "unknown"')"

STATE_FILE="$HOME/.codex/memory-orchestrator/sessions/$SESSION_ID.state"

[ -f "$STATE_FILE" ] || exit 0

# shellcheck disable=SC1090
source "$STATE_FILE"

NOW="$(date +%s)"
REFERENCE="${LAST_WARN:-$START_TIME}"
ELAPSED=$(( NOW - REFERENCE ))

if [ "$ELAPSED" -ge "$WARN_SECONDS" ]; then
  MSG="[memoria] Mais de 2 horas se passaram nesta sessao. Antes de continuar com a tarefa do usuario, avise-o e pergunte se pode rodar o Prompt 9-LITE (checkpoint rapido, sem interromper o trabalho) para salvar o progresso. So sugira o Prompt 9 completo (fechamento de sessao) se o usuario sinalizar que esta encerrando o trabalho por hoje. Aguarde a confirmacao do usuario antes de prosseguir com a tarefa."

  jq -n --arg ctx "$MSG" \
    '{hookSpecificOutput: {hookEventName: "UserPromptSubmit", additionalContext: $ctx}}'

  # Reset the reference point so the next warning only fires after another
  # full window, regardless of whether the user accepts or declines.
  sed -i.bak "/^LAST_WARN=/d" "$STATE_FILE" 2>/dev/null || sed -i "" "/^LAST_WARN=/d" "$STATE_FILE"
  echo "LAST_WARN=$NOW" >> "$STATE_FILE"
  rm -f "$STATE_FILE.bak" 2>/dev/null || true
fi

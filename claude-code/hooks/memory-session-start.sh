#!/usr/bin/env bash
# AgentMemory Kit — SessionStart hook
# Reads session_id and cwd from the JSON passed on stdin, records the
# session start time (only once per session_id), and inspects the
# current project's memory/ folder, emitting a short plain-text summary
# on stdout. This becomes visible context for the model at the start of
# the session. Pure shell — zero LLM token cost.

set -euo pipefail

INPUT="$(cat)"
SESSION_ID="$(echo "$INPUT" | jq -r '.session_id // "unknown"')"
CWD="$(echo "$INPUT" | jq -r '.cwd // "."')"

STATE_DIR="$HOME/.claude/memory-orchestrator/sessions"
mkdir -p "$STATE_DIR"
STATE_FILE="$STATE_DIR/$SESSION_ID.state"

# Record start time only on first run for this session_id — resume/clear/
# compact should not reset the 2-hour clock.
if [ ! -f "$STATE_FILE" ]; then
  NOW="$(date +%s)"
  echo "START_TIME=$NOW" > "$STATE_FILE"
  echo "LAST_WARN=$NOW" >> "$STATE_FILE"
fi

# Prune state files older than 7 days.
find "$STATE_DIR" -type f -mtime +7 -delete 2>/dev/null || true

MEMORY_DIR="$CWD/memory"

if [ ! -d "$MEMORY_DIR" ]; then
  echo "[memoria] Este projeto nao tem pasta memory/ — pode precisar do Caminho A (instalacao do zero)."
  exit 0
fi

PRESENT=""
MISSING=""
[ -f "$CWD/AGENTS.md" ] && PRESENT="$PRESENT AGENTS.md" || MISSING="$MISSING AGENTS.md"
[ -f "$MEMORY_DIR/CURRENT_STATE.md" ] && PRESENT="$PRESENT CURRENT_STATE.md" || MISSING="$MISSING CURRENT_STATE.md"
[ -d "$CWD/graphify-out" ] && PRESENT="$PRESENT graphify-out/" || MISSING="$MISSING graphify-out/"

STATE_AGE_MSG=""
if [ -f "$MEMORY_DIR/CURRENT_STATE.md" ]; then
  LAST_UPDATED="$(grep -m1 '^Last updated:' "$MEMORY_DIR/CURRENT_STATE.md" 2>/dev/null | sed 's/Last updated: *//')"
  if [ -n "$LAST_UPDATED" ]; then
    LAST_EPOCH="$(date -d "$LAST_UPDATED" +%s 2>/dev/null || echo "")"
    if [ -n "$LAST_EPOCH" ]; then
      DAYS_OLD=$(( ( $(date +%s) - LAST_EPOCH ) / 86400 ))
      STATE_AGE_MSG="CURRENT_STATE.md atualizado ha $DAYS_OLD dia(s) ($LAST_UPDATED)."
    fi
  fi
fi

GRAPH_AGE_MSG=""
if [ -f "$CWD/graphify-out/graph.json" ]; then
  GRAPH_MTIME=$(stat -c %Y "$CWD/graphify-out/graph.json" 2>/dev/null || stat -f %m "$CWD/graphify-out/graph.json" 2>/dev/null || echo "")
  if [ -n "$GRAPH_MTIME" ]; then
    GRAPH_DAYS=$(( ( $(date +%s) - GRAPH_MTIME ) / 86400 ))
    GRAPH_AGE_MSG="Grafo gerado ha $GRAPH_DAYS dia(s)."
  fi
fi

echo "[memoria] memory/ encontrada. Presentes:$PRESENT."
[ -n "$MISSING" ] && echo "[memoria] AUSENTES:$MISSING — pode ser Caminho B."
[ -n "$STATE_AGE_MSG" ] && echo "[memoria] $STATE_AGE_MSG"
[ -n "$GRAPH_AGE_MSG" ] && echo "[memoria] $GRAPH_AGE_MSG"

if [ -z "$MISSING" ]; then
  echo "[memoria] Tudo em ordem — memoria completa. Nao precisa levantar isso com o usuario a menos que algo esteja desatualizado."
fi

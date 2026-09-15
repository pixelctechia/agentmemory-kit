# Installing the AgentMemory Kit orchestrator for Claude Code

This is a **one-time, per-machine** installation — not per project, not
per account.

## 1. Copy the files

```bash
mkdir -p ~/.claude/agents ~/.claude/hooks
cp claude-code/agents/memory-orchestrator.md ~/.claude/agents/
cp claude-code/hooks/memory-session-start.sh ~/.claude/hooks/
cp claude-code/hooks/memory-session-length.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/memory-session-start.sh ~/.claude/hooks/memory-session-length.sh
```

## 2. Register the hooks

Back up your existing `~/.claude/settings.json` first:

```bash
cp ~/.claude/settings.json ~/.claude/settings.json.bak-$(date +%Y%m%d-%H%M%S) 2>/dev/null || true
```

Add these two entries under the `"hooks"` key (merge with any existing
hooks you already have — do not replace the whole file):

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/memory-session-start.sh"
          }
        ]
      }
    ],
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/memory-session-length.sh"
          }
        ]
      }
    ]
  }
}
```

Validate the JSON before restarting:

```bash
jq -e . ~/.claude/settings.json > /dev/null && echo "OK"
```

## 3. Restart the session

Hooks and the custom subagent list are only loaded at process start.
Close Claude Code completely and reopen it (or `/exit` then `claude`
again) — editing these files mid-session has no effect until restart.

## 4. Verify

Open any project and confirm the first response mentions the project's
memory status (or stays silent if everything's already fine). To test
without waiting:

```bash
echo '{"session_id":"probe","cwd":"/path/to/some/project"}' | ~/.claude/hooks/memory-session-start.sh
```

To test the 2-hour warning without waiting 2 hours, prefix the second
script with a shorter window:

```bash
MEMORY_SESSION_WARN_SECONDS=5 echo '{"session_id":"probe"}' | ~/.claude/hooks/memory-session-length.sh
```

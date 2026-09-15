# Prompt 9 — Close a session (full)

Use this when you're actually done for the day — not for a mid-session
pause (see Prompt 9-LITE for that).

```text
Session is ending. Update the project memory:

1. Create today's daily log in memory/daily_logs/ following the DAILY_LOG_TEMPLATE.md, including a "Client-visible work" section if any client-facing changes were made.
2. Update memory/CURRENT_STATE.md (max ~150 lines) with what changed today and what's next.
3. If any architectural or workflow decision was made today, log it in memory/08_DECISIONS_LOG.md.
4. If any structural code change was made and the knowledge graph wasn't already regenerated this session, flag that it should be run before the next session.
5. Check that no credentials or secrets were accidentally written into any memory file.

Update metadata headers on all files touched. Then suggest a Git commit message covering both the code changes and the memory updates from this session.
```

# Installing the AgentMemory Kit orchestrator for OpenAI Codex CLI

> **Confidence note before you install:** this hook contract was found to
> be functionally identical to Claude Code's hook contract (same field
> names: `session_id`, `cwd`, `hookSpecificOutput`, `additionalContext`,
> `permission_mode`, etc.), confirmed via official OpenAI docs
> (`learn.chatgpt.com/docs/hooks`, `/docs/agent-configuration/agents-md`,
> `/docs/agent-configuration/subagents`) and via string inspection of the
> installed native binary itself (`SessionStartHookSpecificOutputWire`,
> `UserPromptSubmitHookSpecificOutputWire`, etc. — real struct names found
> in the compiled Codex executable on this machine, v0.130.0). Whether
> this convergence is intentional Claude Code compatibility or independent
> design was **not** confirmed — no explicit "imported from Claude Code"
> label was found anywhere in the binary. Treat it as a strong but
> circumstantial finding, not a documented fact.
>
> The `source` field (`startup`/`resume`/`clear`/`compact`) on
> `SessionStart` is confirmed via docs and binary strings but **not** via
> a successful end-to-end live run on this machine — an interactive trust
> prompt for the untrusted test project blocked automated testing of
> `codex debug prompt-input`. The scripts below were tested standalone
> with synthetic stdin JSON (confirmed working, valid JSON output), not
> through a live Codex session.

This is a **one-time, per-machine** installation — not per project, not
per account.

## 1. Copy the files

```bash
mkdir -p ~/.codex/agents ~/.codex/hooks
cp codex/agents/memory-orchestrator.toml ~/.codex/agents/
cp codex/hooks/memory-session-start.sh ~/.codex/hooks/
cp codex/hooks/memory-session-length.sh ~/.codex/hooks/
chmod +x ~/.codex/hooks/memory-session-start.sh ~/.codex/hooks/memory-session-length.sh
```

Both scripts require `jq` (used both to read the incoming JSON and to
build the structured `hookSpecificOutput` JSON response).

## 2. Register the hooks

Back up your existing `~/.codex/config.toml` first:

```bash
cp ~/.codex/config.toml ~/.codex/config.toml.bak-$(date +%Y%m%d-%H%M%S) 2>/dev/null || true
```

Merge the `[hooks.session_start]` / `[hooks.user_prompt_submit]` tables
from `codex/config-snippet.toml` into your `~/.codex/config.toml` —
replace `/home/YOUR_USER/` with your actual home directory path in both
`command` arrays. Do not replace your whole config file; add these two
tables alongside whatever else is already there (model, projects, plugins,
etc).

The `hooks` feature is `stable = true` by default in this Codex version —
confirmed with `codex features list` on this machine. You do not need
`--enable hooks` or any `features.hooks = true` line.

Validate the TOML before restarting:

```bash
python3 -c "import tomllib; tomllib.load(open('$HOME/.codex/config.toml','rb'))" && echo "OK"
```
(or `python3 -c "import tomli as tomllib; ..."` on Python < 3.11)

## 3. Restart the session

Hooks and custom agent definitions are only loaded at process start.
Close Codex CLI completely and reopen it — editing these files mid-session
has no effect until restart.

## 4. Verify

Open any project and confirm the first response reflects the project's
memory status via injected context (or stays silent if everything's
already fine). To test the scripts directly without waiting on a live
Codex session (no `--dangerously-bypass-approvals-and-sandbox` needed —
this only pipes JSON into a local shell script, no Codex process
involved):

```bash
echo '{"session_id":"probe","cwd":"/path/to/some/project"}' | ~/.codex/hooks/memory-session-start.sh
```

Expected: a `{"hookSpecificOutput": {"hookEventName": "SessionStart", ...}}`
JSON block on stdout, not plain text (plain text also works per the
Codex hook contract, but this kit uses the structured form).

To test the 2-hour warning without waiting 2 hours:

```bash
MEMORY_SESSION_WARN_SECONDS=5 bash -c 'echo "{\"session_id\":\"probe\"}" | ~/.codex/hooks/memory-session-length.sh'
```

Run the SessionStart probe once first so `~/.codex/memory-orchestrator/sessions/probe.state`
exists, then wait 5+ seconds and run the second command — it should print
the `UserPromptSubmit` JSON block with the Prompt 9-LITE warning.

## 5. Using the memory-orchestrator agent

Unlike the hooks, Codex does **not** auto-spawn `memory-orchestrator.toml`.
Delegate to it explicitly in a prompt, e.g.:

```
Use the memory-orchestrator agent to run a full audit of this project's memory/ folder.
```

## Known gaps / things to watch after installing

- If a future Codex release removes or renames `permission_mode`,
  `hookSpecificOutput`, or `additionalContext` from the wire format
  (fields that don't otherwise match Codex's own native vocabulary —
  see the confidence note above), these scripts will need updating. This
  is a real risk given the fields were not found to be part of a
  documented, versioned compatibility guarantee.
- `child_agents_md` is an `under development` feature flag observed on
  this machine (`codex features list`), disabled by default — it may
  affect how AGENTS.md is discovered in subdirectories below the cwd in
  a future release. Not relevant to the hooks in this kit today, but
  worth re-checking after a Codex upgrade.

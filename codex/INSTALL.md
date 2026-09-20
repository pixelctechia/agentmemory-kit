# Installing the AgentMemory Kit orchestrator for OpenAI Codex CLI

> **Status summary:** `AGENTS.md` / memory / the 6 mandatory rules — **confirmed
> working**, no caveats. Automatic session hooks (`SessionStart`,
> `UserPromptSubmit`) — **built, install without error, but confirmed NOT to
> fire automatically** in this Codex version. See the dedicated section
> below before you rely on them.

This is a **one-time, per-machine** installation — not per project, not
per account.

## 1. What's confirmed working: AGENTS.md and memory

Codex CLI reads `AGENTS.md` natively — global (`~/.codex/AGENTS.md`) →
repo root → cwd, concatenated with files closer to cwd taking precedence
(`project_doc_max_bytes` cap, default 32 KiB). Nothing to install for
this part: drop the kit's `AGENTS.md` and `memory/` folder in a project
as usual and Codex picks them up on its own.

A real end-to-end test (fresh Codex session, project marked trusted)
confirmed this works: the model correctly acknowledged the project's
memory state from `AGENTS.md`/`memory/CURRENT_STATE.md` without any
hook involved.

## 2. Install `memory-orchestrator.toml` (the subagent — also confirmed working)

```bash
mkdir -p ~/.codex/agents
cp codex/agents/memory-orchestrator.toml ~/.codex/agents/
```

Codex does **not** auto-spawn this agent — it must be delegated to
explicitly in a prompt, e.g.:

```
Use the memory-orchestrator agent to run a full audit of this project's memory/ folder.
```

This is standard Codex subagent behavior (confirmed via official docs),
not a limitation specific to this kit.

## 3. Hooks: built but not confirmed working (known limitation)

The scripts in `codex/hooks/` (`memory-session-start.sh`,
`memory-session-length.sh`) were built following Codex's **documented
and binary-confirmed** `SessionStart`/`UserPromptSubmit` I/O contract:
same field names as Claude Code's hook contract (`session_id`, `cwd`,
`hookSpecificOutput`, `additionalContext`, etc. — verified via official
docs at `learn.chatgpt.com/docs/hooks` and via string inspection of the
installed native binary, real struct names `SessionStartHookSpecificOutputWire`,
`UserPromptSubmitHookSpecificOutputWire`). They install without error,
register cleanly in `config.toml`, and pass standalone tests (piping
synthetic JSON into them by hand produces correct, valid
`hookSpecificOutput` JSON).

**A real end-to-end test does not confirm they work.** Test performed:
fresh Codex CLI session, project directory explicitly marked
`trust_level = "trusted"` in `~/.codex/config.toml`, both hooks
permanently registered under `[hooks.session_start]` /
`[hooks.user_prompt_submit]`. Result: `ls ~/.codex/memory-orchestrator/sessions/`
showed **no state file** after the session — the `SessionStart` hook did
not execute automatically. This was reproduced twice (once via `codex
exec`, once via a real interactive session), with identical results.

**Suspected cause (not confirmed):** the installed binary contains a
distinct wire type, `codex_app_server_protocol::protocol::v2::hook::HookTrustStatus`
/ `HookExecutionMode`, separate from the project's `trust_level`. This
suggests hooks may need their own trust grant on top of project trust.
The only approval flow found for it lives in the interactive TUI's
onboarding code (`tui/src/onboarding/trust_directory.rs`) — but manually
running the interactive TUI, dismissing its startup screens, and
watching for a hook-trust prompt did **not** surface one during testing.
Whether such a prompt exists under some other condition, whether it's
gated by an undocumented config key, or whether hooks are simply
non-functional in this Codex release, is **unknown**.

**Do not install the hooks expecting them to work.** If you want to
register them anyway (e.g. to test on a newer Codex version), the config
is in `codex/config-snippet.toml` — but verify with the check below
before relying on them:

```bash
ls ~/.codex/memory-orchestrator/sessions/   # after a real session — empty means the hook did not fire
```

**If you figure out the actual hook-trust mechanism** (a config key, a
CLI flag, a specific onboarding path that triggers it, or confirmation
that hooks are simply not implemented yet in this Codex version) —
please open an issue or a pull request on this repository. This is the
one open question blocking full Codex CLI parity with the Claude Code
and Antigravity orchestrators.

## 4. Recommended usage until this is resolved

Since automatic session-health and session-length checks don't fire on
Codex CLI yet, do these manually:

- **At the start of a session**: run [`prompts/daily/prompt-7-open-session.md`](../prompts/daily/prompt-7-open-session.md)
  yourself, or ask Codex to "act as the memory-orchestrator agent and
  check this project's memory health" (see section 2 above).
- **During a long session**: self-monitor elapsed time. Past ~2 hours,
  manually run [`prompts/daily/prompt-9-lite-checkpoint.md`](../prompts/daily/prompt-9-lite-checkpoint.md)
  instead of waiting for an automatic warning that won't come.
- **To check freshness on demand**: delegate to the `memory-orchestrator`
  agent at any point instead of relying on the `SessionStart` summary.

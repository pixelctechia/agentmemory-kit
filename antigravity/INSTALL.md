🇧🇷 [Leia em Português](INSTALL.pt-BR.md)

# Installing the AgentMemory Kit orchestrator for Antigravity

This is a **one-time, per-machine** installation.

> Antigravity's hook and custom-agent configuration format is newer and
> less publicly documented than Claude Code's, and can change between
> versions. Before installing, ask your Antigravity agent to verify the
> exact current schema and paths against its own documentation rather
> than assuming the files below are byte-for-byte correct for your
> installed version.

## 1. Copy the custom agent

```bash
mkdir -p ~/.gemini/config/agents/memory-orchestrator
cp antigravity/agents/memory-orchestrator/agent.md ~/.gemini/config/agents/memory-orchestrator/agent.md
```

## 2. Configure the hooks

Copy `antigravity/hooks.json` to wherever your Antigravity version expects
global hook configuration (commonly under `~/.gemini/config/`) — ask your
Antigravity agent to confirm the exact path and event names for your
version, and adjust `hooks.json` accordingly before relying on it.

The two hooks should implement the same logic as the Claude Code shell
scripts in `claude-code/hooks/` — session-start memory/graph check, and a
2-hour session-length warning defaulting to a lightweight checkpoint
suggestion. Ask your Antigravity agent to port that shell logic into
whatever script language and lifecycle event Antigravity's hooks actually
support.

## 3. Restart

Close and reopen Antigravity (or open a new conversation with a fresh
`conversationId`) before testing — configuration is typically only
(re)loaded at session start.

## 4. Verify

Open a project and ask:

```text
Did the memory-session-start hook fire automatically for this session, without me simulating anything? Show me the exact raw message it injected. Do not create, modify, or run anything — this is a question about your own configuration.
```

## 5. Trigger the agent in a new project

Unlike Claude Code (fully automatic), Antigravity's custom agent needs an
explicit first invocation per new project:

```
@memory-orchestrator apply Path A
```

After that first call, it runs all 9 canonical steps on its own.

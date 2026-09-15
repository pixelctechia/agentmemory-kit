# Contributing

Issues and pull requests are welcome.

## Reporting an issue

Open a GitHub issue describing: which tool you're using (Claude Code,
Antigravity, or other), what you expected, and what actually happened.
Include the relevant hook output or agent report if you have it.

## Proposing a change

- Changes to the 6 mandatory rules (`templates/memory/12_AI_CONTEXT_RULES.md`)
  should keep the existing structure and only add or clarify — avoid
  breaking changes to rules already in wide use.
- Changes to the Claude Code hooks (`claude-code/hooks/*.sh`) must remain
  pure shell with zero LLM token cost. Don't introduce a dependency on
  calling the model from inside a hook.
- Changes to the Antigravity files should note clearly if they depend on
  a specific Antigravity version's hook schema, since that format is
  still evolving.
- Update `CHANGELOG.md` with any behavioral change, bumping the version
  number.

## Code of conduct

Be direct, be kind, assume good faith.

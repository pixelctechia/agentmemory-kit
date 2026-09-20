🇺🇸 [Read in English](INSTALL.md)

# Instalando o orquestrador do AgentMemory Kit para o OpenAI Codex CLI

> **Resumo de status:** `AGENTS.md` / memória / as 6 regras obrigatórias —
> **confirmado funcionando**, sem ressalvas. Hooks automáticos de sessão
> (`SessionStart`, `UserPromptSubmit`) — **construídos, instalam sem erro,
> mas confirmado que NÃO disparam automaticamente** nesta versão do
> Codex. Veja a seção dedicada abaixo antes de depender deles.

Esta é uma instalação **única, por máquina** — não por projeto, não
por conta.

## 1. O que está confirmado funcionando: AGENTS.md e memória

O Codex CLI lê `AGENTS.md` nativamente — global (`~/.codex/AGENTS.md`) →
raiz do repositório → cwd, concatenados com os arquivos mais próximos do
cwd tendo precedência (limite `project_doc_max_bytes`, padrão 32 KiB).
Não há nada para instalar nessa parte: coloque o `AGENTS.md` e a pasta
`memory/` do kit num projeto como de costume, e o Codex os capta
sozinho.

Um teste real de ponta a ponta (sessão nova do Codex, projeto marcado
como confiável) confirmou que isso funciona: o modelo reconheceu
corretamente o estado de memória do projeto a partir de
`AGENTS.md`/`memory/CURRENT_STATE.md` sem nenhum hook envolvido.

## 2. Instalar `memory-orchestrator.toml` (o subagente — também confirmado funcionando)

```bash
mkdir -p ~/.codex/agents
cp codex/agents/memory-orchestrator.toml ~/.codex/agents/
```

O Codex **não** invoca esse agente automaticamente — ele precisa ser
delegado explicitamente num prompt, por exemplo:

```
Use the memory-orchestrator agent to run a full audit of this project's memory/ folder.
```

Este é o comportamento padrão de subagentes do Codex (confirmado via
documentação oficial), não uma limitação específica deste kit.

## 3. Hooks: construídos mas não confirmados funcionando (limitação conhecida)

Os scripts em `codex/hooks/` (`memory-session-start.sh`,
`memory-session-length.sh`) foram construídos seguindo o contrato de
I/O `SessionStart`/`UserPromptSubmit` do Codex, **documentado e
confirmado no binário**: os mesmos nomes de campo do contrato de hooks
do Claude Code (`session_id`, `cwd`, `hookSpecificOutput`,
`additionalContext`, etc. — verificado via documentação oficial em
`learn.chatgpt.com/docs/hooks` e via inspeção de strings do binário
nativo instalado, nomes reais das structs
`SessionStartHookSpecificOutputWire`,
`UserPromptSubmitHookSpecificOutputWire`). Eles instalam sem erro,
registram corretamente no `config.toml`, e passam em testes isolados
(injetar JSON sintético neles manualmente produz JSON
`hookSpecificOutput` correto e válido).

**Um teste real de ponta a ponta não confirma que eles funcionam.**
Teste realizado: sessão nova do Codex CLI, diretório do projeto marcado
explicitamente como `trust_level = "trusted"` em `~/.codex/config.toml`,
ambos os hooks registrados permanentemente sob `[hooks.session_start]` /
`[hooks.user_prompt_submit]`. Resultado: `ls
~/.codex/memory-orchestrator/sessions/` mostrou **nenhum arquivo de
estado** depois da sessão — o hook `SessionStart` não executou
automaticamente. Isso foi reproduzido duas vezes (uma via `codex exec`,
outra via uma sessão interativa real), com resultados idênticos.

**Causa suspeita (não confirmada):** o binário instalado contém um tipo
de wire distinto,
`codex_app_server_protocol::protocol::v2::hook::HookTrustStatus` /
`HookExecutionMode`, separado do `trust_level` do projeto. Isso sugere
que os hooks podem precisar de uma concessão de confiança própria, além
da confiança do projeto. O único fluxo de aprovação encontrado para
isso mora no código de onboarding da TUI interativa
(`tui/src/onboarding/trust_directory.rs`) — mas rodar manualmente a TUI
interativa, dispensar suas telas iniciais, e observar um prompt de
confiança de hook **não** fez esse prompt aparecer durante os testes.
Se tal prompt existe sob alguma outra condição, se é controlado por uma
chave de configuração não documentada, ou se os hooks simplesmente não
são funcionais nesta versão do Codex, é **desconhecido**.

**Não instale os hooks esperando que funcionem.** Se você quiser
registrá-los mesmo assim (por exemplo, para testar numa versão mais
nova do Codex), a configuração está em `codex/config-snippet.toml` —
mas verifique com o comando abaixo antes de depender deles:

```bash
ls ~/.codex/memory-orchestrator/sessions/   # after a real session — empty means the hook did not fire
```

**Se você descobrir o mecanismo real de confiança de hooks** (uma
chave de configuração, uma flag de CLI, um caminho específico de
onboarding que o aciona, ou a confirmação de que os hooks simplesmente
ainda não estão implementados nesta versão do Codex) — por favor abra
uma issue ou um pull request neste repositório. Esta é a única questão
em aberto que bloqueia a paridade completa do Codex CLI com os
orquestradores do Claude Code e do Antigravity.

## 4. Uso recomendado até isso ser resolvido

Como as checagens automáticas de saúde e duração de sessão não disparam
no Codex CLI ainda, faça isso manualmente:

- **No início de uma sessão**: rode
  [`prompts/daily/prompt-7-open-session.md`](../prompts/daily/prompt-7-open-session.md)
  você mesmo, ou peça ao Codex para "agir como o agente
  memory-orchestrator e checar a saúde de memória deste projeto" (veja
  a seção 2 acima).
- **Durante uma sessão longa**: monitore o tempo decorrido você mesmo.
  Depois de ~2 horas, rode manualmente
  [`prompts/daily/prompt-9-lite-checkpoint.md`](../prompts/daily/prompt-9-lite-checkpoint.md)
  em vez de esperar um aviso automático que não vai chegar.
- **Para checar a atualidade sob demanda**: delegue ao agente
  `memory-orchestrator` a qualquer momento, em vez de depender do
  resumo do `SessionStart`.

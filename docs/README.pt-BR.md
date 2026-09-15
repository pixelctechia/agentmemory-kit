# AgentMemory Kit — Manual em Português (Brasil)

**Memória persistente e estruturada, mais autochecagem de comportamento, para agentes de IA que programam — funciona com Claude Code, Antigravity (Gemini), e qualquer ferramenta compatível com `AGENTS.md`.**

🇺🇸 [Read in English](../README.md)

> Este manual é a referência em português. A documentação técnica completa e os prompts oficiais estão em inglês no restante do repositório, para máxima compatibilidade internacional — mas cada conceito é explicado aqui em detalhe.

---

## Por que isso existe

Agentes de IA esquecem tudo entre sessões. O AgentMemory Kit dá a qualquer projeto uma memória persistente, versionada e legível por humanos — mais um orquestrador global (hooks + subagente) que checa automaticamente a saúde da sessão, o tempo de trabalho e o escopo da tarefa, para que o agente nunca comece "no escuro" e nunca ultrapasse o que foi pedido sem avisar.

## O que está incluído

### 1. Estrutura de memória numerada
Arquivos de `memory/00_PROJECT_OVERVIEW.md` até `memory/16_ENVIRONMENTS.md`, mais `17_GRAPHIFY_INDEX.md` — um arquivo por assunto, para que qualquer agente (ou humano) saiba exatamente onde procurar.

### 2. `AGENTS.md`
Arquivo de bootstrap universal, lido nativamente por Claude Code, Cursor, Codex, Antigravity, Windsurf, Zed e outras ferramentas — sem precisar colar prompt manual toda sessão.

### 3. Seis regras obrigatórias de comportamento
Documentadas em `memory/12_AI_CONTEXT_RULES.md`:

1. **Hierarquia de fonte da verdade** — o código define o que existe; o grafo de conhecimento (quando atualizado) define como as partes se conectam; a memória define o porquê.
2. **Regra de uso do grafo (Graphify)** — preferir consultar o grafo de conhecimento do código a fazer grep/leitura bruta às cegas.
3. **Critério e autochecagem de tarefa grande** — antes de tocar em banco de dados, autenticação, mais de 3 arquivos, contrato de API, arquitetura, componente compartilhado ou deploy, o agente para e pede permissão para planejar antes.
4. **Autochecagem de duração de sessão** — depois de 2+ horas numa mesma sessão, o agente avisa e sugere um checkpoint rápido (não o fechamento completo) antes de continuar.
5. **Higiene de memória** — limite de tamanho, arquivamento de logs antigos, cabeçalho de metadados obrigatório.
6. **Disciplina de escopo (isolamento de domínio)** — o agente classifica cada pedido por domínio (design/UI, backend, banco de dados, infraestrutura, conteúdo) e nunca toca num domínio que você não pediu sem parar e perguntar primeiro.

### 4. Orquestrador global
Instalado uma vez por máquina (não por projeto):

- **Claude Code**: um subagente customizado (`~/.claude/agents/memory-orchestrator.md`) + dois hooks leves, com custo zero de token (`SessionStart`, `UserPromptSubmit`), que checam a saúde da memória do projeto e o tempo de sessão automaticamente.
- **Antigravity**: o agente customizado equivalente + hooks de ciclo de vida, no formato de configuração próprio do Antigravity.

### 5. Catálogo completo de prompts
Para cada fase da vida de um projeto: começar do zero, migrar uma memória antiga em arquivo único, auditar uma instalação existente, planejar uma tarefa arriscada com segurança, fechar uma sessão, e manutenção periódica.

### 6. Integração opcional com Graphify
Um grafo de conhecimento do código que o agente consulta antes de recorrer a grep — mantém o consumo de token baixo em bases de código grandes.

## Início rápido

### 1. Iniciar a memória de um projeto

Escolha o caminho certo:

| Situação | Prompt |
|---|---|
| Projeto novo, sem memória ainda | `prompts/caminho-a-new-project.md` |
| Memória já existe, mas incompleta | `prompts/caminho-b-existing-memory.md` |
| Memória antiga, em arquivo único | `prompts/caminho-c-migrate-old-memory.md` |

### 2. Instalar o orquestrador global (uma vez por máquina)

- Claude Code: `claude-code/INSTALL.md`
- Antigravity: `antigravity/INSTALL.md`

### 3. Rotina diária

| Quando | Prompt |
|---|---|
| Abrir uma sessão | `prompts/daily/prompt-7-open-session.md` |
| Antes de uma tarefa grande/arriscada | `prompts/daily/prompt-8-plan-major-task.md` |
| Checkpoint no meio da sessão | `prompts/daily/prompt-9-lite-checkpoint.md` |
| Fechar a sessão | `prompts/daily/prompt-9-close-session.md` |
| Depois de mudança estrutural no código | `prompts/daily/prompt-15-refresh-graph.md` |
| Auditoria completa da memória | `prompts/audit/full-audit.md` |

Manual técnico completo (em inglês): `docs/MANUAL.md`

## Princípios de design

- **O agente nunca instala, apaga ou sobrescreve sem ser pedido.** Detectar e reportar vêm primeiro; qualquer ação exige sua confirmação.
- **Automação com custo zero de token sempre que possível.** As checagens de saúde de memória e de duração de sessão rodam como scripts simples — sem raciocínio de IA, sem custo, todas as vezes.
- **Portátil por design.** Tudo vive no próprio repositório do projeto (`memory/`, `AGENTS.md`), exceto o orquestrador global, que é instalado uma vez por máquina, não por conta.
- **Agnóstico de ferramenta.** Os mesmos arquivos de memória são lidos corretamente pelo Claude Code e pelo Antigravity — e por qualquer outra ferramenta que leia `AGENTS.md`.

## Licença

Apache License 2.0 — veja o arquivo `LICENSE`. Use, modifique, distribua, até comercialmente — só mantenha os créditos.

## Como contribuir

Issues e pull requests são bem-vindos — veja `CONTRIBUTING.md` (em inglês).

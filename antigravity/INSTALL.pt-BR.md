🇺🇸 [Read in English](INSTALL.md)

# Instalando o orquestrador do AgentMemory Kit para o Antigravity

Esta é uma instalação **única, por máquina**.

> O formato de configuração de hooks e agentes customizados do Antigravity
> é mais novo e menos documentado publicamente do que o do Claude Code, e
> pode mudar entre versões. Antes de instalar, peça ao seu agente
> Antigravity para verificar o schema e os caminhos exatos atuais contra
> a própria documentação, em vez de assumir que os arquivos abaixo são
> idênticos byte a byte à sua versão instalada.

## 1. Copiar o agente customizado

```bash
mkdir -p ~/.gemini/config/agents/memory-orchestrator
cp antigravity/agents/memory-orchestrator/agent.md ~/.gemini/config/agents/memory-orchestrator/agent.md
```

## 2. Configurar os hooks

Copie `antigravity/hooks.json` para onde a sua versão do Antigravity
espera a configuração global de hooks (comumente em `~/.gemini/config/`)
— peça ao seu agente Antigravity para confirmar o caminho exato e os
nomes de eventos da sua versão, e ajuste `hooks.json` de acordo antes de
depender dele.

Os dois hooks devem implementar a mesma lógica dos scripts shell do
Claude Code em `claude-code/hooks/` — checagem de memória/grafo no
início da sessão, e um aviso de duração de sessão de 2 horas com
sugestão padrão de checkpoint leve. Peça ao seu agente Antigravity para
portar essa lógica shell para a linguagem de script e o evento de ciclo
de vida que o Antigravity realmente suporta.

## 3. Reiniciar

Feche e reabra o Antigravity (ou abra uma nova conversa com um
`conversationId` novo) antes de testar — a configuração normalmente só
é (re)carregada no início da sessão.

## 4. Verificar

Abra um projeto e pergunte:

```text
Did the memory-session-start hook fire automatically for this session, without me simulating anything? Show me the exact raw message it injected. Do not create, modify, or run anything — this is a question about your own configuration.
```

## 5. Acionar o agente num projeto novo

Diferente do Claude Code (totalmente automático), o agente customizado
do Antigravity precisa de uma primeira invocação explícita por projeto
novo:

```
@memory-orchestrator apply Path A
```

Depois dessa primeira chamada, ele roda os 9 passos canônicos sozinho.

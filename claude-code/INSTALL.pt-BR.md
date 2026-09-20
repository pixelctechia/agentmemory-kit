🇺🇸 [Read in English](INSTALL.md)

# Instalando o orquestrador do AgentMemory Kit para o Claude Code

Esta é uma instalação **única, por máquina** — não por projeto, não
por conta.

## 1. Copiar os arquivos

```bash
mkdir -p ~/.claude/agents ~/.claude/hooks
cp claude-code/agents/memory-orchestrator.md ~/.claude/agents/
cp claude-code/hooks/memory-session-start.sh ~/.claude/hooks/
cp claude-code/hooks/memory-session-length.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/memory-session-start.sh ~/.claude/hooks/memory-session-length.sh
```

## 2. Registrar os hooks

Faça backup do seu `~/.claude/settings.json` existente primeiro:

```bash
cp ~/.claude/settings.json ~/.claude/settings.json.bak-$(date +%Y%m%d-%H%M%S) 2>/dev/null || true
```

Adicione estas duas entradas sob a chave `"hooks"` (faça o merge com
quaisquer hooks que você já tenha — não substitua o arquivo inteiro):

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

Valide o JSON antes de reiniciar:

```bash
jq -e . ~/.claude/settings.json > /dev/null && echo "OK"
```

## 3. Reiniciar a sessão

Hooks e a lista de subagentes customizados só são carregados na
inicialização do processo. Feche o Claude Code completamente e reabra
(ou `/exit` e depois `claude` de novo) — editar esses arquivos no meio
da sessão não tem efeito até o reinício.

## 4. Verificar

Abra qualquer projeto e confirme que a primeira resposta menciona o
status de memória do projeto (ou fica em silêncio se já estiver tudo
certo). Para testar sem esperar:

```bash
echo '{"session_id":"probe","cwd":"/path/to/some/project"}' | ~/.claude/hooks/memory-session-start.sh
```

Para testar o aviso de 2 horas sem esperar 2 horas, prefixe o segundo
script com uma janela mais curta:

```bash
MEMORY_SESSION_WARN_SECONDS=5 echo '{"session_id":"probe"}' | ~/.claude/hooks/memory-session-length.sh
```

# TEMPLATE

Bootstrap-шаблон для новых проектов с Claude Code и GitHub Actions CI/CD.

---

## Быстрый старт

```bash
git clone https://github.com/Arsid0305/TEMPLATE /tmp/arsid-template
bash /tmp/arsid-template/init.sh /path/to/new-project claude
```

Затем заполнить плейсхолдеры в `docs/rules/scoped/project.md`.

**Аргументы `init.sh`:**
| Аргумент | Значение |
|---|---|
| `claude` (default) | `adapters/AGENTS.md` → `AGENTS.md` и `adapters/CLAUDE.md` → `CLAUDE.md` (подключает `AGENTS.md` строкой `@AGENTS.md`) |
| `openai` | Только `adapters/AGENTS.md` → `AGENTS.md` (его читает OpenAI Codex) |

---

## Что копируется в новый проект

```
.github/workflows/     ← CI/CD шаблоны из workflows/
tasks/
  todo.md
  lessons.md
docs/
  AUDIT_PROMPT.md
  rules/scoped/project.md  ← заполнить плейсхолдеры
scripts/
  check_consistency.py
.gitignore
AGENTS.md              ← из adapters/, всегда (вход для любого ИИ)
CLAUDE.md              ← из adapters/, только для `claude`
```

---

## Структура TEMPLATE

```
TEMPLATE/
├── adapters/          ← адаптеры для init.sh (AGENTS.md, CLAUDE.md, OPENAI.md)
├── ADAPTERS/          ← веб-адаптеры (ChatGPT, Claude Web), поддерживаются вручную
├── workflows/         ← шаблоны CI/CD (копируются в новые проекты)
├── docs/              ← AUDIT_PROMPT.md
├── scripts/           ← check_consistency.py
├── .claude/           ← агенты и хуки Claude Code (переносятся из AI_OS вручную)
├── init.sh            ← скрипт инициализации
├── SYSTEM.md          ← контекст TEMPLATE-репо для AI
├── AGENTS.md          ← вход для любого ИИ при работе в TEMPLATE (Codex читает сам)
├── CLAUDE.md          ← адаптер Claude Code: `@AGENTS.md` + Claude-специфика
└── SECURITY.md        ← чеклист безопасности перед деплоем
```

### `adapters/` vs `ADAPTERS/`

| Директория | Что содержит | Для чего |
|---|---|---|
| `adapters/` | AGENTS.md, CLAUDE.md, OPENAI.md | Адаптеры AI-инструментов для **новых проектов** (используются `init.sh`) |
| `ADAPTERS/` | chatgpt/, claude-web/ | Адаптеры для **веб-интерфейсов** (вставить в чат ChatGPT, Claude) |

---

## Воркфлоу CI/CD

| Файл | Назначение |
|---|---|
| `workflows/deploy.yml` | Supabase Edge Functions deploy (опционально) |

Скопируй нужные в `.github/workflows/` нового проекта, удали ненужные. Автомержа нет: PR мержит владелица кнопкой.

---

## Синхронизация с AI_OS

Правила экосистемы живут только в [arsid0305/ai_os](https://github.com/arsid0305/ai_os/tree/main/docs/rules/core) — в TEMPLATE и новых проектах копий нет, `CLAUDE.md` ссылается на AI_OS. Автосинка нет (`sync-to-template.yml` снят 2026-09-30); `.claude/` переносится из AI_OS вручную.

**Не** синхронизируются (тонкие TEMPLATE-специфичные): `SYSTEM.md`, `CLAUDE.md`, `scoped-template/`, `SECURITY.md`, `init.sh`, `adapters/`, `workflows/`, `docs/`, `scripts/`.

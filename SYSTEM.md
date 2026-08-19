# SYSTEM.md — TEMPLATE

> Читай этот файл в начале каждого нового чата в этом репозитории.
> Правила экосистемы — в `docs/rules/core/*.md` (синхронизируется из AI_OS).

---

## 1. Что такое TEMPLATE

Bootstrap-шаблон для новых проектов. Содержит CI/CD воркфлоу, адаптеры для AI-инструментов, документацию и скрипты инициализации.

Для нового проекта:
```bash
git clone https://github.com/Arsid0305/TEMPLATE /tmp/arsid-template
bash /tmp/arsid-template/init.sh /path/to/new-project claude
```

`init.sh` копирует в новый проект в том числе `docs/rules/core/` — новый проект сразу получает актуальные правила экосистемы.

---

## 2. Структура репозитория

```
TEMPLATE/
├── SYSTEM.md              ← ты здесь (тонкий адаптер)
├── CLAUDE.md              ← адаптер для Claude Code (TEMPLATE-специфичный)
├── SECURITY.md            ← чеклист безопасности перед деплоем
├── NEW_PROJECT.md         ← шаблон контекста нового проекта (плейсхолдеры)
├── QUICKSTART.md          ← быстрый старт
├── init.sh                ← скрипт инициализации нового проекта
├── docs/rules/            ← ⭐ ПРАВИЛА ЭКОСИСТЕМЫ (синхронизируется из AI_OS)
│   ├── README.md          ← архитектура rules
│   ├── core/              ← always-on rules (8 файлов)
│   └── scoped/            ← path-scoped (специфика проекта, добавляется локально)
├── adapters/              ← адаптеры для init.sh (CLAUDE.md, CURSOR.md, OPENAI.md)
├── ADAPTERS/              ← веб-адаптеры (ChatGPT, Gemini, Codex, Claude Web)
│   └── [синхронизируется из AI_OS автоматически]
├── workflows/             ← шаблоны CI/CD для новых проектов
│   ├── automerge.yml      ← PR-based auto-merge template (claude/ and cursor/ branches)
│   ├── promote.yml        ← promotion to main (manual trigger via workflow_dispatch)
│   └── deploy.yml         ← Supabase Edge Functions deploy
├── .github/workflows/
│   └── automerge.yml      ← CI для самого TEMPLATE-репо
├── .claude/               ← агенты + хуки Claude Code (синхронизируется из AI_OS)
├── .cursor/               ← правила Cursor (синхронизируется из AI_OS)
├── docs/
│   ├── AUDIT_PROMPT.md    ← reference-промпт для аудитов репо
│   ├── ARCHITECTURE.md    ← архитектурный скелет с AUTO-маркерами
│   └── rules/             ← (см. выше — вынесено отдельным блоком)
└── scripts/
    └── gen_docs.py        ← генерация документации
```

### Два типа адаптеров

| Директория | Назначение | Источник |
|---|---|---|
| `adapters/` | Копируется в новый проект как `CLAUDE.md` / `.cursor/rules` через `init.sh` | Поддерживается вручную |
| `ADAPTERS/` | Веб-адаптеры для вставки в чат (ChatGPT, Gemini, Claude Web, Codex) | Синхронизируется из AI_OS |

---

## 3. Rules — правила экосистемы

Универсальные правила экосистемы — в `docs/rules/core/*.md`. **TEMPLATE не редактирует их вручную** — они синхронизируются из AI_OS через `.github/workflows/sync-to-template.yml` в AI_OS.

Ссылки на правила:
- Классификация задач (SMALL / BIG) → [`docs/rules/core/task-classification.md`](docs/rules/core/task-classification.md)
- Стиль общения → [`docs/rules/core/communication-style.md`](docs/rules/core/communication-style.md)
- Принципы работы с кодом → [`docs/rules/core/code-principles.md`](docs/rules/core/code-principles.md)
- Git flow → [`docs/rules/core/git-flow.md`](docs/rules/core/git-flow.md)
- GitHub anti-abuse → [`docs/rules/core/github-anti-abuse.md`](docs/rules/core/github-anti-abuse.md)
- Session lifecycle → [`docs/rules/core/session-lifecycle.md`](docs/rules/core/session-lifecycle.md)
- Subagents → [`docs/rules/core/subagents.md`](docs/rules/core/subagents.md)
- Audit trigger → [`docs/rules/core/audit-trigger.md`](docs/rules/core/audit-trigger.md)

Архитектура и правила синка — [`docs/rules/README.md`](docs/rules/README.md).

---

## 4. TEMPLATE-специфика — CI/CD

### Auto-merge (`workflows/automerge.yml` — для новых проектов, `.github/workflows/automerge.yml` — для самого TEMPLATE)
- Ветки `claude/...` и `cursor/...` мержатся автоматически через GitHub API
- Триггер: открытие/обновление PR в `main`
- Мерж через `github-script` (squash) — без shell-команд, без injection-рисков
- Требует: Settings → General → «Allow auto-merge» включён в репо

### Promote (`workflows/promote.yml`)
- Ручной запуск через `workflow_dispatch` (не автоматический)
- Продвигает `dev` → `main` после сборки и аудита

---

## 5. Синхронизация с AI_OS

TEMPLATE автоматически получает обновления из AI_OS при каждом пуше в `main` AI_OS (workflow `sync-to-template.yml` в AI_OS):

- `.claude/` — агенты и хуки Claude Code
- `.cursor/` — правила Cursor
- `ADAPTERS/` — веб-адаптеры (ChatGPT, Gemini, Codex, Claude Web)
- `.github/workflows/automerge.yml` — CI
- **`docs/rules/core/`** + **`docs/rules/README.md`** — SSOT правил экосистемы

**Не синхронизируется** (тонкие TEMPLATE-специфичные адаптеры / не пригодные для шаблона): `CLAUDE.md`, `SYSTEM.md`, `NEW_PROJECT.md`, `SECURITY.md`, `init.sh`, `adapters/`, `workflows/`, `docs/AUDIT_PROMPT.md`, `docs/ARCHITECTURE.md`, `skills_sistem/`, `scripts/gen_docs.py`, `docs/rules/scoped/`.

---

## 6. Начало и окончание сессии

См. [`docs/rules/core/session-lifecycle.md`](docs/rules/core/session-lifecycle.md) — универсальное правило для всех ИИ и репо. Триггеры конца сессии распознавать **семантически**.

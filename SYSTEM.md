# SYSTEM.md — TEMPLATE

> Читай этот файл в начале каждого нового чата в этом репозитории.
> Правила экосистемы — в `AI_OS/docs/rules/core/*.md` (только там, копий нет).

---

## 1. Что такое TEMPLATE

Bootstrap-шаблон для новых проектов. Содержит CI/CD воркфлоу, адаптеры для AI-инструментов, документацию и скрипты инициализации.

Для нового проекта:
```bash
git clone https://github.com/Arsid0305/TEMPLATE /tmp/arsid-template
bash /tmp/arsid-template/init.sh /path/to/new-project claude
```

`init.sh` не копирует `docs/rules/core/`: `CLAUDE.md` нового проекта ссылается на правила в AI_OS. В проекте создаётся пустой `docs/rules/scoped/`.

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
├── docs/rules/            ← указатель: правила экосистемы живут в AI_OS
│   └── README.md
├── adapters/              ← адаптеры для init.sh (CLAUDE.md, CURSOR.md, OPENAI.md)
├── ADAPTERS/              ← веб-адаптеры (ChatGPT, Gemini, Codex, Claude Web)
│   └── [синхронизируется из AI_OS автоматически]
├── workflows/             ← шаблоны CI/CD для новых проектов
│   └── deploy.yml         ← Supabase Edge Functions deploy
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

Универсальные правила экосистемы — только в `AI_OS/docs/rules/core/*.md`. Копий в TEMPLATE и проектах нет (решение 2026-09-30: копии расходились с оригиналом). Если AI_OS не подключён к сессии — попросить подключить, по памяти не работать.

Ссылки на правила:
- Классификация задач (SMALL / BIG) → [`AI_OS/docs/rules/core/task-classification.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/task-classification.md)
- Стиль общения → [`AI_OS/docs/rules/core/communication-style.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/communication-style.md)
- Принципы работы с кодом → [`AI_OS/docs/rules/core/code-principles.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/code-principles.md)
- Git flow → [`AI_OS/docs/rules/core/git-flow.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/git-flow.md)
- GitHub anti-abuse → [`AI_OS/docs/rules/core/github-anti-abuse.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/github-anti-abuse.md)
- Session lifecycle → [`AI_OS/docs/rules/core/session-lifecycle.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/session-lifecycle.md)
- Subagents → [`AI_OS/docs/rules/core/subagents.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/subagents.md)
- Audit trigger → [`AI_OS/docs/rules/core/audit-trigger.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/audit-trigger.md)
- Web permissions → [`AI_OS/docs/rules/core/web-permissions.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/web-permissions.md)

Архитектура rules — `AI_OS/docs/rules/README.md`.

---

## 4. TEMPLATE-специфика — CI/CD

### Мерж — только вручную
- Автомержа нет (удалён 2026-09-25). PR из `claude/...` и `cursor/...` мержит владелица кнопкой.
- Канон — `AI_OS/docs/rules/core/github-anti-abuse.md`, `AI_OS/docs/rules/core/git-flow.md`.

---

## 5. Синхронизация с AI_OS

Автосинка нет (`sync-to-template.yml` снят 2026-09-30). Правила не переносятся — на них ссылаются. Из AI_OS вручную переносятся только:

- `.claude/` — агенты и хуки Claude Code
- `.cursor/` — правила Cursor
- `ADAPTERS/` — веб-адаптеры (ChatGPT, Gemini, Codex, Claude Web)

**Не синхронизируется** (тонкие TEMPLATE-специфичные адаптеры / не пригодные для шаблона): `CLAUDE.md`, `SYSTEM.md`, `NEW_PROJECT.md`, `SECURITY.md`, `init.sh`, `adapters/`, `workflows/`, `docs/AUDIT_PROMPT.md`, `docs/ARCHITECTURE.md`, `skills_sistem/`, `scripts/gen_docs.py`, `docs/rules/scoped/`.

---

## 6. Начало и окончание сессии

См. [`AI_OS/docs/rules/core/session-lifecycle.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/session-lifecycle.md) — универсальное правило для всех ИИ и репо. Триггеры конца сессии распознавать **семантически**.

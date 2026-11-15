# AGENTS.md — TEMPLATE

> Общий вход для любого ИИ (OpenAI Codex, Claude Code и других). Codex читает этот файл сам, Claude Code — через `CLAUDE.md` (строка `@AGENTS.md`).
> Универсальные правила — в `SYSTEM.md` и `AI_OS/docs/rules/core/*.md`. Независимость от поставщика ИИ — `AI_OS/docs/rules/core/vendor-independence.md`.
> Читай `SYSTEM.md`, `tasks/lessons.md` и `tasks/todo.md` в начале каждого чата.

---

## LLM_Wiki — контекст экосистемы

В начале каждой сессии прочитать из `arsid0305/llm_wiki` (main):
- `wiki/lessons.md`, `wiki/decisions.md` — кросс-проектные уроки и решения
- `wiki/workflow.md` — единый git/CI workflow + выбор модели
- `wiki/context-mode.md` — защита контекстного окна
- `wiki/audit-universal.md` — audit canon

---

## Каноны (rules как атомы)

Все универсальные правила — в `AI_OS/docs/rules/core/*.md` (SSOT, копий в этом репо нет). Если AI_OS не подключён к сессии — попросить подключить, по памяти не работать. Читать нужное по имени:

- Начало / конец сессии — [`AI_OS/docs/rules/core/session-lifecycle.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/session-lifecycle.md)
- Стиль общения — [`AI_OS/docs/rules/core/communication-style.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/communication-style.md)
- Git flow, запрет флагов, правила редактирования — [`AI_OS/docs/rules/core/git-flow.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/git-flow.md)
- GitHub anti-abuse — [`AI_OS/docs/rules/core/github-anti-abuse.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/github-anti-abuse.md)
- SMALL / BIG критерии — [`AI_OS/docs/rules/core/task-classification.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/task-classification.md)
- Принципы работы с кодом — [`AI_OS/docs/rules/core/code-principles.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/code-principles.md)
- Subagents (worktree, JSON-schema контракты) — [`AI_OS/docs/rules/core/subagents.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/subagents.md)
- Audit-триггер — [`AI_OS/docs/rules/core/audit-trigger.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/audit-trigger.md)
- Разрешения веб-сессий — [`AI_OS/docs/rules/core/web-permissions.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/web-permissions.md)
- Выбор модели `haiku`/`sonnet`/`opus` — `llm_wiki/wiki/workflow.md`
- Context Mode — `llm_wiki/wiki/context-mode.md`

Архитектура rules — `AI_OS/docs/rules/README.md`.

---

## Новый проект

```bash
git clone https://github.com/Arsid0305/TEMPLATE /tmp/arsid-template
bash /tmp/arsid-template/init.sh /path/to/new-project claude   # AGENTS.md + CLAUDE.md; openai — только AGENTS.md
```
Заполнить плейсхолдеры в `docs/rules/scoped/project.md`.

Опционально скопировать доп. workflows:
```bash
WORKFLOWS='deploy.yml' bash init.sh /path/to/new-project claude
```

---

## Рабочий процесс

1. Разработка на ветке `claude/...` (Claude) или `codex/...` (Codex) → PR в `main` (не draft)
2. Один PR на сессию. **Автомержа нет** (удалён 2026-09-25) — мержит владелица кнопкой.
3. Мерж через API запрещён — `AI_OS/docs/rules/core/github-anti-abuse.md`.

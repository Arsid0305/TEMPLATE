# Claude Adapter — TEMPLATE

> Тонкий адаптер для Claude. Универсальные правила — в `SYSTEM.md`.
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

Все универсальные правила — в `docs/rules/core/*.md` (синхронизируется из AI_OS, SSOT). Читать нужное по имени:

- Начало / конец сессии — [`docs/rules/core/session-lifecycle.md`](docs/rules/core/session-lifecycle.md)
- Стиль общения — [`docs/rules/core/communication-style.md`](docs/rules/core/communication-style.md)
- Git flow, запрет флагов, правила редактирования — [`docs/rules/core/git-flow.md`](docs/rules/core/git-flow.md)
- GitHub anti-abuse — [`docs/rules/core/github-anti-abuse.md`](docs/rules/core/github-anti-abuse.md)
- SMALL / BIG критерии — [`docs/rules/core/task-classification.md`](docs/rules/core/task-classification.md)
- Принципы работы с кодом — [`docs/rules/core/code-principles.md`](docs/rules/core/code-principles.md)
- Subagents (worktree, JSON-schema контракты) — [`docs/rules/core/subagents.md`](docs/rules/core/subagents.md)
- Audit-триггер — [`docs/rules/core/audit-trigger.md`](docs/rules/core/audit-trigger.md)
- Выбор модели `haiku`/`sonnet`/`opus` — `llm_wiki/wiki/workflow.md`
- Context Mode — `llm_wiki/wiki/context-mode.md`

Архитектура rules и правила синка — [`docs/rules/README.md`](docs/rules/README.md).

---

## Новый проект

```bash
git clone https://github.com/Arsid0305/TEMPLATE /tmp/arsid-template
bash /tmp/arsid-template/init.sh /path/to/new-project claude
```
Заполнить плейсхолдеры в `NEW_PROJECT.md`.

Опционально скопировать доп. workflows:
```bash
WORKFLOWS='automerge.yml deploy.yml' bash init.sh /path/to/new-project claude
```

---

## Инструменты Claude Code

Агенты `.claude/agents/` (синкаются из AI_OS):

| Агент | Задача |
|---|---|
| `@reviewer` | Аудит кода: чистота, корректность, security, тесты |
| `@repo-auditor` | Аудит структуры репо по `docs/AUDIT_PROMPT.md` |

Триггер: «аудит», «ревью», «проверь», «готово?» — параллельно оба.

---

## Среда Claude

| Инструмент | Статус |
|---|---|
| Python 3, Node.js, context-mode | ✅ |
| Supabase CLI, Deno, .env реальный | ❌ |

---

## Рабочий процесс

1. Разработка на ветке `claude/...` → PR в `main` (не draft)
2. `automerge.yml` (`pull_request_target`) мержит PR через GitHub API (squash) + удаляет head-ref
3. Требует: Settings → General → "Allow auto-merge" включён

Никогда не мержить в `main` вручную без явного подтверждения.

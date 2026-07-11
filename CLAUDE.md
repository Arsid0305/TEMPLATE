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

## Каноны (не дублировать)

- Начало / конец сессии — `SYSTEM.md §8`
- Правила краткости — `AI_OS/SYSTEM.md §4`
- Git flow, запрет флагов, редактирование — `AI_OS/SYSTEM.md §10` + `SYSTEM.md §6`
- Выбор модели `haiku`/`sonnet`/`opus` — `llm_wiki/wiki/workflow.md`
- SMALL/BIG критерии — `SYSTEM.md §3`
- Context Mode — `llm_wiki/wiki/context-mode.md`
- Subagents — `AI_OS/CLAUDE.md`

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

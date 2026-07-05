# Claude Adapter

> Это тонкий адаптер для Claude. Универсальные правила — в `SYSTEM.md`.
> Читай `SYSTEM.md`, `MEMORY/lessons/lessons.md` и `MEMORY/tasks/todo.md` в начале каждого чата.

---

## LLM_Wiki — Общий контекст экосистемы

В начале каждой сессии прочитать из репо `arsid0305/llm_wiki` (ветка `main`):
- `wiki/lessons.md` — кросс-проектные уроки
- `wiki/decisions.md` — ключевые архитектурные решения

Даёт контекст по всем проектам без объяснений от пользователя.

---

## Начало и окончание сессии

Правила в `SYSTEM.md` раздел 8 — универсально для всех ИИ. Триггеры конца сессии распознавать **семантически**.

---

## Правила краткости

Канон — `AI_OS/SYSTEM.md §4` + `AI_OS/CLAUDE.md`.

---

## Новый проект

Для старта нового проекта:
```bash
git clone https://github.com/Arsid0305/TEMPLATE /tmp/arsid-template
bash /tmp/arsid-template/init.sh /path/to/new-project claude
```
Затем заполнить плейсхолдеры в `NEW_PROJECT.md`.

---

## Subagents

**Приоритет:** когда задача подходит для субагента — использовать субагента, не делать в основном контексте. Пользователь не программист, размышления в основном чате ему не информативны. Субагент возвращает только итог — экономия токенов и шума.

Использовать для:
- Исследования и анализа кода (не засорять основной контекст)
- Параллельных независимых задач
- Аудитов, ревью, поиска по репо

Один subagent — одна фокусная задача.

---

## Выбор модели

Автоматически по сложности задачи. Явно указывать только если нужно переопределить.

| Задача | Классификация | Модель |
|---|---|---|
| Поиск, чтение, grep, простые вопросы | SMALL | `haiku` |
| Код, отладка, стандартные задачи | SMALL/BIG | `sonnet` (default) |
| Архитектура, аудит, сложный анализ | BIG | `opus` |

Критерии SMALL/BIG — в `SYSTEM.md` раздел 3.

---

## Инструменты Claude Code

### Агенты `@` — субагенты (`.claude/agents/`)

| Агент | Что делает |
|---|---|
| `@reviewer` | Аудит **кода**: чистота + корректность + security + тесты. Один проход, диагноз без verdict и приоритетов. Решение принимает пользователь |
| `@repo-auditor` | Аудит **структуры репо** (дерево AI_OS) по `docs/AUDIT_PROMPT.md`, 5 проходов, 19 секций |

**Правило вызова:** при словах «аудит», «ревью», «проверь», «готово?» — параллельно прогонять `@reviewer` и `@repo-auditor`. Точечный вызов одного — только по явному запросу.

### Slash-команды и Skills

Локальные удалены — были дублями или обёртками. Используются глобальные навыки Claude Code (`code-review`, `verify`, `run`, `init` и др.) и встроенные slash-команды CLI.

### `skills_sistem/` — Python runtime

`skills_sistem/` относится к Python-runtime AI_OS (`python main.py`), не к Claude Code. В сессии Claude Code не обращаться напрямую.

---

## context-mode — защита контекстного окна

> context-mode MCP установлен. Хуки активны: PreToolUse, PostToolUse, PreCompact, SessionStart.
> В новой web-сессии восстанавливать: `bash /home/user/AI_OS/scripts/setup_context_mode.sh`

### Routing rules (MANDATORY)

**Think in Code:** анализ/поиск/фильтрация данных → писать скрипт через `ctx_execute(language, code)`, только stdout попадает в контекст. Не читать сырые данные.

**Заблокировано:** `curl`, `wget`, inline HTTP (`fetch(`, `requests.get(`), `WebFetch` — использовать `ctx_fetch_and_index(url, source)` или `ctx_execute`.

**Перенаправить в sandbox:**
- `Bash` (>20 строк вывода) → `ctx_batch_execute` или `ctx_execute(language: "shell", ...)`
- `Read` для анализа/исследования → `ctx_execute_file(path, language, code)`
- `Grep` → `ctx_execute(language: "shell", code: "grep ...")`

**Иерархия выбора инструментов:**
1. `ctx_search(sort: "timeline")` — после resume, проверить историю до вопроса пользователю
2. `ctx_batch_execute(commands, queries)` — сбор данных, один вызов вместо 30+
3. `ctx_search(queries: [...])` — все вопросы массивом, один вызов
4. `ctx_execute` / `ctx_execute_file` — обработка в sandbox
5. `ctx_fetch_and_index` → `ctx_search` — веб без HTML в контексте

**После компрессии:** НЕ спрашивать «что мы делали?» — сначала `ctx_search(queries: ["summary"], source: "compaction", sort: "timeline")`.

### Команды

| Команда | Действие |
|---|---|
| `ctx stats` | Вызвать `ctx_stats`, показать вывод |
| `ctx doctor` | Вызвать `ctx_doctor`, запустить команду, показать чеклист |
| `ctx upgrade` | Вызвать `ctx_upgrade`, запустить команду |
| `ctx purge` | Вызвать `ctx_purge` с `confirm: true` — очищает базу знаний |

---

## Среда Claude

| Инструмент | Статус |
|---------------|----------|
| Python 3      | ✅ |
| Node.js       | ✅ |
| context-mode  | ✅ |
| Supabase CLI  | ❌ |
| Deno          | ❌ |
| .env реальный | ❌ |

---

## Рабочий процесс

1. Claude пишет код → пушит в ветку `claude/...` → создаёт PR в `main`
2. `automerge.yml` прогоняет `pytest` → мержит PR через GitHub API (без shell-команд)
3. Требует: Settings → General → "Allow auto-merge" включён в репо
4. При конфликте с `main` — ребейзить локально и пушать заново
5. Никогда не мержить в `main` вручную без явного подтверждения пользователя

---

## Правила Git

- Разрабатывать на ветке `claude/...`, никогда не пушить напрямую в `main`
- Никогда не использовать `--no-verify`, `--force`, `--no-gpg-sign`
- **В начале каждой сессии** — первая команда всегда:
  ```bash
  git pull origin main
  ```
  Main уходит вперёд пока ветка живёт. Без pull — работаешь на устаревшем коде.

---

## Правила редактирования файлов

- Всегда: `Read` → `Edit` → `git commit` → `git push`
- `Edit` меняет только нужные строки — файл не трогается целиком
- **Запрещено** использовать `push_files` (GitHub API) для кода — требует весь файл целиком, риск обрезки и опечаток
- Если `git commit` не работает (ошибка подписи) — сообщить пользователю и остановиться, не обходить через `push_files`

# Quickstart

## Старт чата

| | **Claude Code** | **Cursor** | **ChatGPT** |
|---|---|---|---|
| **Старый проект** | Открыть чат в репо → Клод читает все файлы сам | Открыть папку в Cursor → читает `CLAUDE.md` сам | Вставить `SYSTEM.md` + `NEW_PROJECT.md` в первое сообщение |
| **Новый проект** | 1. Создать репо на GitHub<br>2. Сказать: `Новый проект: [название], репо: github.com/Arsid0305/[название]`<br>3. Клод спросит про стек и сделает всё сам | 1. Создать репо<br>2. Запустить команду ниже в терминале Cursor<br>3. Открыть папку в Cursor | 1. Создать репо<br>2. Запустить команду ниже в терминале<br>3. Вставить `SYSTEM.md` + `NEW_PROJECT.md` в чат |
| **Git flow** | Автоматически: `claude/...` → `main` | Коммит + пуш через терминал, ветка `cursor/...` | ИИ даёт код → применяешь руками |
| **Supabase Secrets** | Добавить руками в GitHub Settings | Добавить руками в GitHub Settings | Добавить руками в GitHub Settings |

---

## Команда для Cursor

> Перед выполнением можно просмотреть скрипт: `curl -s https://raw.githubusercontent.com/Arsid0305/TEMPLATE/main/init.sh | less`

```bash
bash <(curl -s https://raw.githubusercontent.com/Arsid0305/TEMPLATE/main/init.sh) . cursor
```

## Команда для ChatGPT

> Перед выполнением можно просмотреть скрипт: `curl -s https://raw.githubusercontent.com/Arsid0305/TEMPLATE/main/init.sh | less`

```bash
bash <(curl -s https://raw.githubusercontent.com/Arsid0305/TEMPLATE/main/init.sh) . openai
```

---

## Структура после init.sh

```
.github/workflows/     — automerge + promote CI/CD
tasks/
  todo.md             — активные задачи
  lessons.md          — паттерны ошибок
NEW_PROJECT.md        — заполнить плейсхолдеры
CLAUDE.md             — адаптер для выбранного AI
```

---

## Файлы системы

| Файл | Зачем |
|------|-------|
| `SYSTEM.md` | Универсальные правила — читает любой AI |
| `SECURITY.md` | Security checklist перед деплоем |
| `NEW_PROJECT.md` | Шаблон контекста проекта |
| `adapters/CLAUDE.md` | Claude Code специфика |
| `adapters/CURSOR.md` | Cursor специфика |
| `adapters/OPENAI.md` | ChatGPT / OpenAI API специфика |
| `workflows/` | Reference GitHub Actions (копировать в проект) |
| `init.sh` | Инициализатор нового проекта |

# SYSTEM.md — TEMPLATE

> Читай этот файл в начале каждого нового чата в этом репозитории.

---

## 1. Что такое TEMPLATE

Bootstrap-шаблон для новых проектов. Содержит CI/CD воркфлоу, адаптеры для AI-инструментов, документацию и скрипты инициализации.

Для нового проекта:
```bash
git clone https://github.com/Arsid0305/TEMPLATE /tmp/arsid-template
bash /tmp/arsid-template/init.sh /path/to/new-project claude
```

---

## 2. Структура репозитория

```
TEMPLATE/
├── SYSTEM.md              ← ты здесь (читать первым)
├── CLAUDE.md              ← адаптер для Claude Code (синхронизируется из AI_OS)
├── SECURITY.md            ← чеклист безопасности перед деплоем
├── NEW_PROJECT.md         ← шаблон контекста нового проекта (плейсхолдеры)
├── QUICKSTART.md          ← быстрый старт
├── init.sh                ← скрипт инициализации нового проекта
├── adapters/              ← адаптеры для init.sh (CLAUDE.md, CURSOR.md, OPENAI.md)
├── ADAPTERS/              ← веб-адаптеры (ChatGPT, Gemini, Codex, Claude Web)
│   └── [синхронизируется из AI_OS автоматически]
├── workflows/             ← шаблоны CI/CD для новых проектов
│   ├── automerge.yml      ← feature branch auto-merge template
│   ├── promote.yml        ← promotion to main после сборки
│   └── deploy.yml         ← Supabase Edge Functions deploy
├── .github/workflows/
│   └── automerge.yml      ← CI для самого TEMPLATE-репо
├── .claude/agents/        ← субагенты Claude Code (синхронизируется из AI_OS)
├── .cursor/               ← правила Cursor (синхронизируется из AI_OS)
├── skills_sistem/         ← когнитивные скиллы (синхронизируется из AI_OS)
├── docs/
│   ├── AUDIT_PROMPT.md    ← reference-промпт для аудитов репо
│   └── ARCHITECTURE.md    ← архитектурный скелет с AUTO-маркерами
└── scripts/
    └── gen_docs.py        ← генерация документации
```

### Два типа адаптеров

| Директория | Назначение | Источник |
|---|---|---|
| `adapters/` | Копируется в новый проект как `CLAUDE.md` / `.cursor/rules` через `init.sh` | Поддерживается вручную |
| `ADAPTERS/` | Веб-адаптеры для вставки в чат (ChatGPT, Gemini, Claude Web, Codex) | Синхронизируется из AI_OS |

---

## 3. Классификация задач

### SMALL — делать сразу
- Правка 1–3 файлов
- Баг-фикс с очевидной причиной
- Документация, переименование
- Рефакторинг без изменения контракта

### BIG — спросить перед реализацией
- Новый модуль или архитектурное изменение
- Изменение публичного интерфейса
- Удаление файлов/функций
- Задача занимает больше 10 минут или затрагивает несколько слоёв

Для BIG — сначала план (scope / затрагиваемые файлы / риски), реализация после подтверждения.

---

## 4. Стиль общения

- Русский язык в чате, английский в коде
- Отвечать конкретно, без воды
- Задавать уточняющие вопросы перед BIG-задачами
- Не придумывать scope сверх запроса
- Комментарии в коде — только когда WHY неочевиден

---

## 5. Принципы работы с кодом

- Не добавлять фичи без запроса
- Не рефакторить «заодно»
- Не создавать абстракции под гипотетическое будущее
- Простой код лучше «правильного»
- DRY: дублирующийся код выносить явно — три похожих строки уже сигнал
- Verification: перед «готово» прогнать тесты/CLI на golden path + edge case
- Безопасность: никакого command injection, path traversal, hardcoded secrets

---

## 6. Синхронизация с AI_OS

TEMPLATE автоматически получает обновления из AI_OS при каждом пуше в `main` AI_OS:

- `.claude/` — субагенты и конфиги Claude Code
- `.cursor/` — правила Cursor
- `ADAPTERS/` — веб-адаптеры
- `skills_sistem/` — когнитивные скиллы
- `CLAUDE.md` — адаптер Claude Code
- `scripts/gen_docs.py`, `docs/ARCHITECTURE.md`

**Не синхронизируется:** `SYSTEM.md`, `NEW_PROJECT.md`, `SECURITY.md`, `init.sh`, `adapters/`, `workflows/` — поддерживаются вручную в TEMPLATE.

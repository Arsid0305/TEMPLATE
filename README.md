# TEMPLATE

Bootstrap-шаблон для новых проектов с Claude Code, Cursor и GitHub Actions CI/CD.

---

## Быстрый старт

```bash
git clone https://github.com/Arsid0305/TEMPLATE /tmp/arsid-template
bash /tmp/arsid-template/init.sh /path/to/new-project claude
```

Затем заполнить плейсхолдеры в `NEW_PROJECT.md`.

**Аргументы `init.sh`:**
| Аргумент | Значение |
|---|---|
| `claude` (default) | Копирует `adapters/CLAUDE.md` → `CLAUDE.md` |
| `cursor` | Копирует `adapters/CURSOR.md` → `.cursor/rules/project.mdc` |
| `openai` | Копирует `adapters/OPENAI.md` → инструкции для Codex/GPT |

---

## Что копируется в новый проект

```
.github/workflows/     ← CI/CD шаблоны из workflows/
tasks/
  todo.md
  lessons.md
docs/
  AUDIT_PROMPT.md
scripts/
  check_consistency.py
NEW_PROJECT.md         ← заполнить плейсхолдеры
.gitignore
CLAUDE.md              ← из adapters/ (зависит от аргумента)
```

---

## Структура TEMPLATE

```
TEMPLATE/
├── adapters/          ← адаптеры для init.sh (CLAUDE.md, CURSOR.md, OPENAI.md)
├── ADAPTERS/          ← веб-адаптеры (ChatGPT, Gemini, Claude Web, Codex) — синкается из AI_OS
├── workflows/         ← шаблоны CI/CD (копируются в новые проекты)
├── docs/              ← AUDIT_PROMPT.md
├── scripts/           ← check_consistency.py
├── .claude/           ← агенты и хуки Claude Code (синкается из AI_OS)
├── .cursor/           ← правила Cursor (синкается из AI_OS)
├── init.sh            ← скрипт инициализации
├── SYSTEM.md          ← контекст TEMPLATE-репо для AI
├── CLAUDE.md          ← адаптер Claude Code для работы в TEMPLATE (тонкий, не синкается)
└── SECURITY.md        ← чеклист безопасности перед деплоем
```

### `adapters/` vs `ADAPTERS/`

| Директория | Что содержит | Для чего |
|---|---|---|
| `adapters/` | CLAUDE.md, CURSOR.md, OPENAI.md | Адаптеры AI-инструментов для **новых проектов** (используются `init.sh`) |
| `ADAPTERS/` | chatgpt/, claude-web/, codex/, gemini/ | Адаптеры для **веб-интерфейсов** (вставить в чат ChatGPT, Gemini и т.д.) |

---

## Воркфлоу CI/CD

| Файл | Назначение |
|---|---|
| `workflows/deploy.yml` | Supabase Edge Functions deploy (опционально) |

Скопируй нужные в `.github/workflows/` нового проекта, удали ненужные. Автомержа нет: PR мержит владелица кнопкой.

---

## Синхронизация с AI_OS

Правила экосистемы живут только в [arsid0305/ai_os](https://github.com/arsid0305/ai_os/tree/main/docs/rules/core) — в TEMPLATE и новых проектах копий нет, `CLAUDE.md` ссылается на AI_OS. Автосинка нет (`sync-to-template.yml` снят 2026-09-30); `.claude/`, `ADAPTERS/` переносятся из AI_OS вручную.

**Не** синхронизируются (тонкие TEMPLATE-специфичные): `SYSTEM.md`, `CLAUDE.md`, `NEW_PROJECT.md`, `SECURITY.md`, `init.sh`, `adapters/`, `workflows/`, `docs/`, `scripts/`.

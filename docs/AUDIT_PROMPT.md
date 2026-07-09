# Repository Audit — TEMPLATE

Универсальные проверки — см. **`llm_wiki/wiki/audit-universal.md`** (canon для всех репо).

Этот файл — тонкий overlay с проектной спецификой TEMPLATE.

---

## Контекст проекта

```
Тип: мета-шаблон для новых проектов (init.sh + адаптеры для ИИ)
Стек: Bash (init.sh), Python (scripts/), YAML (workflows), Markdown
Внешние API: нет
CI/CD: automerge.yml (claude/** и cursor/** → main)
```

## Проектные проверки (в дополнение к universal)

- [ ] `init.sh` не ломается на путях с пробелами / кириллицей
- [ ] Плейсхолдеры в `NEW_PROJECT.md` реально заменяются `init.sh` — не остаются `{{PROJECT_NAME}}` в новых проектах
- [ ] `adapters/` (для init.sh) не смешан с `ADAPTERS/` (веб-адаптеры) — разные назначения
- [ ] Синк из AI_OS (`sync-to-template.yml` в AI_OS) НЕ копирует `CLAUDE.md`, `SYSTEM.md`, `ARCHITECTURE.md`, `skills_sistem/`, `gen_docs.py` — они AI_OS-specific
- [ ] `SYSTEM.md §7` описание синка совпадает с реальным списком в `sync-to-template.yml`

## Формат отчёта

Как в `llm_wiki/wiki/audit-universal.md` (severity + confidence + файл:строка).

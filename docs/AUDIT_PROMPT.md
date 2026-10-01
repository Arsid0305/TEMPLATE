# Repository Audit — TEMPLATE

Универсальные проверки — см. **`llm_wiki/wiki/audit-universal.md`** (canon для всех репо).

Этот файл — тонкий overlay с проектной спецификой TEMPLATE.

---

## Контекст проекта

```
Тип: мета-шаблон для новых проектов (init.sh + адаптеры для ИИ)
Стек: Bash (init.sh), Python (scripts/), YAML (workflows), Markdown
Внешние API: нет
CI/CD: нет автомержа; workflows/ — опциональные шаблоны (deploy, promote)
```

## Проектные проверки (в дополнение к universal)

- [ ] `init.sh` не ломается на путях с пробелами / кириллицей
- [ ] `init.sh` кладёт `docs/rules/scoped/project.md`; в новом проекте факты о проекте только там, `CLAUDE.md` ссылается
- [ ] `adapters/` (для init.sh) не смешан с `ADAPTERS/` (веб-адаптеры) — разные назначения
- [ ] Нет папки `docs/rules/core/`; `init.sh` её не копирует; ссылки на правила ведут в `AI_OS/docs/rules/core/`

## Формат отчёта

Как в `llm_wiki/wiki/audit-universal.md` (severity + confidence + файл:строка).

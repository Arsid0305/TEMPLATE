# Claude Adapter — TEMPLATE

@AGENTS.md

> Всё общее для любого ИИ — в `AGENTS.md` (подключён строкой выше). Здесь только то, что есть лишь у Claude Code.

---

## Инструменты Claude Code

Агенты `.claude/agents/` (переносятся из AI_OS вручную):

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

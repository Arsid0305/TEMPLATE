# AI_OS — Архитектура

> Файл автоматически обновляется через `scripts/gen_docs.py`.
> Не редактировать секции между `AUTO:` маркерами вручную — они будут перезаписаны.

---

## Дерево репозитория

```
AI_OS/
│
├── ── CORE ────────────────────────────────────────────
│   └── SYSTEM.md                  ← универсальные правила (любой AI)
│
├── ── AI TOOLS ────────────────────────────────────────
│   CLI инструменты (дот-папки) + Web-интерфейсы (ADAPTERS/)
│
│   Адаптеры для Claude Code: CLAUDE.md
│   Адаптеры для Cursor: .cursor/rules/ai-os.mdc
│
├── ── CLAUDE CODE INFRA ───────────────────────────
│   .claude/
│   ├── agents/          ← субагенты Claude Code
│   ├── skills/          ← скиллы (process-driven)
│   └── commands/        ← slash-команды
│
├── ── MEMORY ──────────────────────────────────────────
│   ├── tasks/
│   │   ├── bugs.md
│   │   ├── todo.md
│   │   └── decisions.md
│   ├── lessons/
│   │   └── lessons.md
│   └── archive/
│
├── ── RUNTIME ──────────────────────────────────────────
│   ├── main.py
│   ├── system_identity.json
│   ├── requirements.txt
│   ├── logs/
│   ├── core/
│   │   ├── config.py
│   │   ├── schemas.py
│   │   ├── startup.py
│   │   ├── diagnostics.py
│   │   ├── logger.py
│   │   ├── identity.py
│   │   ├── orchestrator.py
│   │   ├── agent_registry.py
│   │   ├── conflict_protocol.py
│   │   ├── drift.py
│   │   ├── eval.py
│   │   ├── state.py
│   │   ├── memory_writer.py
│   │   ├── memory_hygiene.py
│   │   ├── project_manager.py
│   │   ├── unit_calc.py
│   │   └── engine/
│   │       ├── base_engine.py
│   │       ├── router.py
│   │       ├── openai_engine.py
│   │       ├── anthropic_engine.py
│   │       ├── gemini_engine.py
│   │       └── deepseek_engine.py
│   ├── prompts/
│   ├── preprocessors/
│   └── tests/
│
├── ── SKILLS ───────────────────────────────────────────
│   └── skills_sistem/agents/       ← когнитивные режимы (любой AI)
│
├── ── DOCS ─────────────────────────────────────────────
│   └── docs/
│       ├── ARCHITECTURE.md
│       ├── AUDIT_PROMPT.md
│       ├── AI_TESTING.md
│       ├── ai_benchmark.md
│       ├── памятка.md
│       └── archive/
│
└── ── CI/CD ──────────────────────────────────────────
    ├── .github/workflows/automerge.yml
    └── scripts/gen_docs.py          ← единая точка входа (автообновление документации)
```

---

## AI инструменты

<!-- AUTO:AI_TOOLS_START -->
| Инструмент | Папка | Тип |
|---|---|---|
| `claude` | `.claude/` | CLI |
| `cursor` | `.cursor/` | CLI |
| `chatgpt` | `ADAPTERS/chatgpt/` | Web |
| `claude-web` | `ADAPTERS/claude-web/` | Web |
| `codex` | `ADAPTERS/codex/` | Web |
| `gemini` | `ADAPTERS/gemini/` | Web |
<!-- AUTO:AI_TOOLS_END -->

---

## Claude Code инфраструктура

### Агенты

<!-- AUTO:CLAUDE_AGENTS_START -->
| Агент | Назначение |
|---|---|
| `code-reviewer` | Senior code reviewer that evaluates changes across five dimensions — correctness, readability, architecture, security, and performance. Use for thorough code review before merge. |
| `repo-auditor` | Full repository audit agent. Use when asked to audit the repo, check the full codebase, run a deep analysis, or find all problems across the project. Loads and follows docs/AUDIT_PROMPT.md. |
| `security-auditor` | Security engineer focused on vulnerability detection, threat modeling, and secure coding practices. Use for security-focused code review, threat analysis, or hardening recommendations. |
| `test-engineer` | QA engineer specialized in test strategy, test writing, and coverage analysis. Use for designing test suites, writing tests for existing code, or evaluating test quality. |
<!-- AUTO:CLAUDE_AGENTS_END -->

### Скиллы

<!-- AUTO:CLAUDE_SKILLS_START -->
| Скилл | Назначение |
|---|---|
| `code-review-and-quality` | Conducts multi-axis code review. Use before merging any change. Use when reviewing code written by yourself, another agent, or a human. Use when you need to assess code quality across multiple dimensions before it enters the main branch. |
| `shipping-and-launch` | Prepares production launches. Use when preparing to deploy to production. Use when you need a pre-launch checklist, when setting up monitoring, when planning a staged rollout, or when you need a rollback strategy. |
| `spec-driven-development` | Writes a specification before implementation. Use for new features, ambiguous requirements, changes affecting multiple files, or any task that takes more than 30 minutes. |
| `test-driven-development` | Drives development with tests. Use when implementing any logic, fixing any bug, or changing any behavior. Use when you need to prove that code works, when a bug report arrives, or when you're about to modify existing functionality. |
<!-- AUTO:CLAUDE_SKILLS_END -->

### Slash-команды

<!-- AUTO:CLAUDE_COMMANDS_START -->
| Команда | Назначение |
|---|---|
| `/audit-repo` | Full repository audit. Runs repo-auditor agent with docs/AUDIT_PROMPT.md — 5 passes, 19 sections. |
| `/review` | Run a multi-axis code review on the current changes before merging. |
| `/ship` | Pre-launch gate — run code-reviewer, security-auditor, and test-engineer in parallel, then produce a go/no-go decision. |
<!-- AUTO:CLAUDE_COMMANDS_END -->

---

## Движки (engine/)

<!-- AUTO:PROVIDERS_TABLE_START -->
| Провайдер | Алиас `--model` | Ключ |
|---|---|---|
| OpenAI | `openai` | `OPENAI_API_KEY` |
| Anthropic | `anthropic`, `claude` | `ANTHROPIC_API_KEY` |
| Gemini | `gemini` | `GOOGLE_API_KEY` |
| DeepSeek | `deepseek` | `DEEPSEEK_API_KEY` |
<!-- AUTO:PROVIDERS_TABLE_END -->

Формат вывода (обязателен для всех движков):
```python
{
    "content": str,
    "model": str,
    "latency": float,
    "tokens_prompt": int,
    "tokens_completion": int
}
```

---

## Режимы

<!-- AUTO:MODES_INLINE_START -->
**Режимы (13):** `research` `code` `review` `decision`
`legal` `medical` `marketplace_wb` `marketplace_ozon` `tables`
`writing` `visual` `meta_agent` `meta_prompt`
<!-- AUTO:MODES_INLINE_END -->

> Добавление новой площадки: создать `prompts/marketplace_<X>/{v1.json,marketplace_<X>.md}`, зарегистрировать в `agent_registry.py`.

---

## Запуск

```bash
cd runtime
python main.py --diagnose
python main.py --mode code --model openai --goal "..."
pytest tests/

# Обновить документацию
python scripts/gen_docs.py

# Проверить синхронность (используется в CI)
python scripts/gen_docs.py --check
```

---

## Как расширять

**Новый режим:** добавить в `agent_registry.py` → `gen_docs.py` автообновит документацию.

**Новый движок:** добавить в `engine/` → строка в `router.py` и `startup.py` → обновить `_PROVIDERS` в `gen_docs.py`.

**Новый AI инструмент (CLI):** создать дот-папку в корне → `gen_docs.py` автоподхватит при следующем запуске.

**Новый AI инструмент (Web):** создать папку в `ADAPTERS/` → `gen_docs.py` автоподхватит.

**Новый агент Claude Code:** добавить `.claude/agents/*.md` → `gen_docs.py` автообновит таблицу.

**Новый скилл / команда:** добавить в `.claude/skills/` или `.claude/commands/` → автообновление без дополнительных действий.

> Все пути — через `Paths` из `core/config.py`. После изменений — `pytest tests/`.

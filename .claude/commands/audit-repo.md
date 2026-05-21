---
description: Full repository audit. Runs repo-auditor agent with docs/AUDIT_PROMPT.md — 5 passes, 19 sections.
---

Запусти агент `repo-auditor` для полного аудита репозитория.

Агент читает `docs/AUDIT_PROMPT.md` и выполняет все 5 проходов:
- Pass 1: Runtime correctness
- Pass 2: Security + filesystem
- Pass 3: Drift audit
- Pass 4: Test coverage
- Pass 5: Architecture + ergonomics

Вернуть итоговый отчёт: **Блокеры / Что сделано хорошо / Следующие 3 приоритета**.

# Claude Adapter

> Read after `SYSTEM.md`. Contains Claude Code-specific capabilities and rules.

---

## LLM_Wiki — Shared ecosystem context

At the start of every session, read from `arsid0305/llm_wiki` (branch `main`):
- `wiki/lessons.md` — cross-project lessons
- `wiki/decisions.md` — key architectural decisions

This gives context across all projects without user explanation.

---

## Capabilities

```
SUPPORTED:
- filesystem_rw
- terminal_access
- git_read
- git_push
- web_fetch
- multi_agent (subagents)

LIMITATIONS:
- no Supabase CLI locally
- no Deno locally
- no real .env in context
- no background persistent processes
```

## Subagents

| Model | When |
|-------|------|
| `haiku` | File search, grep, simple reads — fast and cheap |
| `sonnet` | Code writing, debugging — default |
| `opus` | Architecture, complex BIG-task analysis |

## Git Workflow

- Branch: `claude/<description>` — auto-merges to main via CI after tests pass
- PRs are optional, automerge triggers on push regardless

---

## Ecosystem Rules

Universal rules are in `docs/rules/core/*.md` (synced from AI_OS SSOT via `init.sh`). Read on demand:

- Task classification (SMALL / BIG) — [`docs/rules/core/task-classification.md`](docs/rules/core/task-classification.md)
- Communication style — [`docs/rules/core/communication-style.md`](docs/rules/core/communication-style.md)
- Code principles (DRY, verification, no over-engineering) — [`docs/rules/core/code-principles.md`](docs/rules/core/code-principles.md)
- Git flow (branches, PR, forbidden flags) — [`docs/rules/core/git-flow.md`](docs/rules/core/git-flow.md)
- GitHub anti-abuse (rate limits) — [`docs/rules/core/github-anti-abuse.md`](docs/rules/core/github-anti-abuse.md)
- Session lifecycle (start/end, todo/lessons format) — [`docs/rules/core/session-lifecycle.md`](docs/rules/core/session-lifecycle.md)
- Subagents (worktree isolation, JSON-schema contracts) — [`docs/rules/core/subagents.md`](docs/rules/core/subagents.md)
- Audit trigger — [`docs/rules/core/audit-trigger.md`](docs/rules/core/audit-trigger.md)

Architecture and sync rules — [`docs/rules/README.md`](docs/rules/README.md).

Project-specific rules live in `docs/rules/scoped/*.md` (edited locally, not synced).

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

Model choice (`haiku` / `sonnet` / `opus`) — `llm_wiki/wiki/workflow.md`.

## Git Workflow

- Branch: `claude/<description>` → PR to `main` (not draft), one PR per session
- No auto-merge: the owner merges manually with the button. Never merge via API

---

## Ecosystem Rules

Universal rules live **only in AI_OS** (`AI_OS/docs/rules/core/*.md`) — no copies in this repo. Read on demand:

- Task classification (SMALL / BIG) — [`AI_OS/docs/rules/core/task-classification.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/task-classification.md)
- Communication style — [`AI_OS/docs/rules/core/communication-style.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/communication-style.md)
- Code principles (DRY, verification, no over-engineering) — [`AI_OS/docs/rules/core/code-principles.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/code-principles.md)
- Git flow (branches, PR, forbidden flags) — [`AI_OS/docs/rules/core/git-flow.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/git-flow.md)
- GitHub anti-abuse (rate limits) — [`AI_OS/docs/rules/core/github-anti-abuse.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/github-anti-abuse.md)
- Session lifecycle (start/end, todo/lessons format) — [`AI_OS/docs/rules/core/session-lifecycle.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/session-lifecycle.md)
- Subagents (worktree isolation, JSON-schema contracts) — [`AI_OS/docs/rules/core/subagents.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/subagents.md)
- Audit trigger — [`AI_OS/docs/rules/core/audit-trigger.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/audit-trigger.md)
- Web session permissions — [`AI_OS/docs/rules/core/web-permissions.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/core/web-permissions.md)

If AI_OS is not attached to the session — ask to attach it; do not reconstruct rules from memory.

Architecture — [`AI_OS/docs/rules/README.md`](https://github.com/Arsid0305/AI_OS/blob/main/docs/rules/README.md).

Project-specific rules live in `docs/rules/scoped/*.md` (edited locally, not synced).

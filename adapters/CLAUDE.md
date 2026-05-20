# Claude Adapter

> Read after `SYSTEM.md`. Contains Claude Code-specific capabilities and rules.

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

---

## Subagents

Use subagents to isolate context (file search, log reading, parallel tasks).
One subagent = one focused task.

| Model | When |
|-------|------|
| `haiku` | File search, grep, simple reads — fast and cheap |
| `sonnet` | Code writing, debugging — default |
| `opus` | Architecture, complex BIG-task analysis |

---

## Context Mode (if installed)

| Instead of | Use |
|------------|-----|
| Read → whole large file | `ctx_execute` — only stdout in context |
| WebFetch → raw HTML | `ctx_fetch_and_index` → `ctx_search` |
| Multiple grep/find calls | `ctx_batch_execute` |

---

## Git Workflow

- Branch: `claude/<description>` — auto-merges to main via CI after tests pass
- PRs are optional, automerge triggers on push regardless

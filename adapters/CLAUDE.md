# Claude Adapter

@AGENTS.md

> Everything common for any AI is in `AGENTS.md` (imported above). This file holds only Claude Code-specific capabilities.

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

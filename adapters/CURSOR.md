# Cursor Adapter

> Read after `SYSTEM.md`. Contains Cursor IDE-specific capabilities and rules.

---

## Capabilities

```
SUPPORTED:
- filesystem_rw
- terminal_access
- git_read
- git_push (via IDE or terminal)
- web_search (if enabled)
- codebase_indexing

LIMITATIONS:
- no multi_agent
- no persistent_memory across sessions
```

---

## Git Workflow

- Branch: `cursor/<description>` — auto-merges to main via CI after tests pass
- Use terminal or IDE git panel for staging and commits

---

## Notes

- Add `.cursorrules` in project root for project-specific rules
- Cursor reads `SYSTEM.md` + this adapter at session start
- Codebase indexing is available — use it before broad searches

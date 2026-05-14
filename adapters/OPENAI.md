# OpenAI Adapter

> Read after `SYSTEM.md`. Covers ChatGPT, Responses API, Agents SDK environments.

---

## Capabilities

```
SUPPORTED:
- web_search (if tool enabled)
- code_interpreter (if tool enabled)
- long_context

LIMITATIONS:
- no filesystem_rw (ChatGPT web)
- no git_push (ChatGPT web)
- no persistent_memory across sessions (unless memory tool enabled)
- no multi_agent natively
```

---

## Git Workflow

- No direct git access in most environments
- Provide code as diffs or full files for user to apply manually
- Reference branch naming: `ai/openai-...`

---

## Notes

- Context window varies by model (gpt-4o: 128k, o1: 200k)
- Tool availability depends on environment (API vs ChatGPT vs Codex)
- Adapt workflow to available capabilities declared above

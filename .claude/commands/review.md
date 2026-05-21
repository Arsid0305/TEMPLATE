---
description: Run a multi-axis code review on the current changes before merging.
---

Conduct a thorough code review using the `code-reviewer` agent.

## Steps

1. Identify the scope: staged changes, recent commits, or files specified by the user
2. Use the Agent tool to invoke `code-reviewer` with the relevant diff or file list
3. Return the full review report with severity-labeled findings

## Output

A structured report with:
- **Verdict:** APPROVE or REQUEST CHANGES
- **Critical issues** (blocks merge)
- **Important issues** (should fix)
- **Suggestions** (optional)
- **What's done well**

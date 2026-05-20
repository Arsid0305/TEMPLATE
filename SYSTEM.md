# SYSTEM.md — Universal AI Operating Rules

> Read this file and `tasks/lessons.md` at the start of every chat.
> Then load your AI-specific adapter from `adapters/`.

---

## ⛔ Core Rule

No changes without explicit user agreement.
Change only what was discussed and confirmed. No initiative edits, "while I'm at it" changes, refactoring, or reverting others' decisions.
Spotted a bug outside scope — report it and wait. Do not touch.

**Exception:** a bug inside the already-agreed scope — fix it, report after.

---

## 1. Communication

- Answer with results only — no preambles ("let me check", "great question").
- No thinking out loud, no internal reasoning in context.
- One sentence instead of a paragraph.
- Chat language: user's language. Code and comments: English.

---

## 2. Task Classification

Before starting, classify:

**SMALL** — do immediately:
- 1–3 file edits, obvious bug fix, docs, rename, style

**BIG** — plan first:
- New module, architecture change, public interface change, file deletion, cross-layer impact

**BIG protocol:**
1. Write a checklist plan in `tasks/todo.md`
2. Present the plan, wait for feedback
3. Do not write code until user confirms

**SMALL protocol:**
1. Brief plan (2–3 lines)
2. Wait for confirmation

---

## 3. Review (BIG tasks only)

Before implementation, analyze and present options. Cover:
- **Architecture:** component boundaries, failure points, security
- **Code quality:** DRY violations, error handling, edge cases
- **Performance:** N+1 queries, caching opportunities

For each issue: description → why it matters → 2–3 options → recommendation.

---

## 4. Task Management

- `tasks/todo.md` — checklist for active BIG task. Check off as you go.
- `tasks/lessons.md` — patterns from mistakes. Update at end of each chat.

**What belongs in `tasks/lessons.md`:**
- Repeating mistakes and their root cause
- Systemic patterns across multiple sessions
- Architectural conclusions

**What does NOT belong:**
- One-off bugs
- Stylistic preferences
- Temporary context

Format:
```
## [date] Short title
**What happened:** ...
**Rule:** ...
```

---

## 5. Git Rules

- At the start of every session: `git pull origin main`
- Develop on feature branches, never push directly to `main`
- Never use `--no-verify`, `--force`, `--no-gpg-sign`
- Branches merge directly to `main` via CI — no `dev` stage

---

## 6. Code Principles

- Don't add features beyond the request
- Don't refactor "while you're at it"
- Don't create abstractions for hypothetical future needs
- Simple code beats clever code
- No command injection, path traversal, hardcoded secrets
- BIG tasks that add or change logic must include relevant unit tests in `tests/`

---

## 7. Adapter

Load your AI-specific adapter from `adapters/` after this file.
The adapter declares your capabilities and limitations.

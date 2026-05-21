---
name: code-review-and-quality
description: Conducts multi-axis code review. Use before merging any change. Use when reviewing code written by yourself, another agent, or a human. Use when you need to assess code quality across multiple dimensions before it enters the main branch.
---

## Overview

Multi-dimensional code review with quality gates. Every change gets reviewed before merge — no exceptions. Review covers five axes: correctness, readability, architecture, security, and performance.

**The approval standard:** Approve a change when it definitely improves overall code health, even if it isn't perfect.

## When to Use

- Before merging any PR or change
- After completing a feature implementation
- When another agent or model produced code you need to evaluate
- After any bug fix (review both the fix and the regression test)

## The Five-Axis Review

### 1. Correctness
- Does it match the spec or task requirements?
- Are edge cases handled (null, empty, boundary values)?
- Are error paths handled?
- Are there off-by-one errors, race conditions, or state inconsistencies?

### 2. Readability & Simplicity
- Can another engineer understand this code without the author explaining it?
- Are names descriptive and consistent with project conventions?
- Is the control flow straightforward?
- Could this be done in fewer lines?
- Are abstractions earning their complexity?

### 3. Architecture
- Does the change follow existing patterns?
- Are module boundaries maintained?
- Is there code duplication that should be shared?
- Is the abstraction level appropriate?

### 4. Security
- Is user input validated and sanitized?
- Are secrets kept out of code, logs, and version control?
- Is authentication/authorization checked where needed?
- Are SQL queries parameterized?
- Is data from external sources treated as untrusted?

### 5. Performance
- Any N+1 query patterns?
- Any unbounded loops or unconstrained data fetching?
- Any synchronous operations that should be async?
- Any missing pagination on list endpoints?

## Change Sizing

```
~100 lines changed   → Good. Reviewable in one sitting.
~300 lines changed   → Acceptable if it's a single logical change.
~1000 lines changed  → Too large. Split it.
```

## Severity Labels

| Prefix | Meaning | Author Action |
|--------|---------|---------------|
| *(no prefix)* | Required change | Must address before merge |
| **Critical:** | Blocks merge | Security vulnerability, data loss, broken functionality |
| **Nit:** | Minor, optional | Author may ignore |
| **Optional:** | Suggestion | Worth considering but not required |
| **FYI** | Informational only | No action needed |

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "It works, that's good enough" | Working code that's unreadable or insecure creates compounding debt. |
| "AI-generated code is probably fine" | AI code needs more scrutiny, not less. |
| "The tests pass, so it's good" | Tests are necessary but not sufficient. |
| "We'll clean it up later" | Later never comes. The review is the quality gate. |

## Verification

- [ ] All Critical issues are resolved
- [ ] All Important issues are resolved or explicitly deferred
- [ ] Tests pass
- [ ] Build succeeds

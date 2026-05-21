---
name: spec-driven-development
description: Writes a specification before implementation. Use for new features, ambiguous requirements, changes affecting multiple files, or any task that takes more than 30 minutes.
---

## Overview

The spec is the shared source of truth — it defines what we're building, why, and how we'll know it's done. A 15-minute spec prevents hours of debugging later.

## When to Use

- New projects or features
- Ambiguous or incomplete requirements
- Changes affecting multiple files
- Architectural decisions
- Tasks requiring over 30 minutes

**Skip for:** single-line fixes, typos, or self-contained unambiguous changes.

## Four-Phase Workflow

Each phase requires human validation before advancing.

### Phase 1: SPECIFY

Surface assumptions immediately. Document six areas:

1. **Objective** — What are we building? What does success look like?
2. **Commands** — Full executable commands with flags
3. **Project Structure** — Directory organization and purpose
4. **Code Style** — Real examples over abstract descriptions
5. **Testing Strategy** — Framework, coverage requirements, test levels
6. **Boundaries** — What's always done / what requires approval / what's prohibited

### Phase 2: PLAN

Develop technical implementation strategy:
- Components to create or modify
- Dependencies and sequencing
- Risks and unknowns
- Verification checkpoints

### Phase 3: TASKS

Break the plan into discrete work items, each:
- Completable in a single focused session
- Has explicit acceptance criteria
- Has verification steps

### Phase 4: IMPLEMENT

Execute tasks incrementally using TDD principles. Update the spec when decisions or scope change.

## Rules

- Surface assumptions explicitly — never make silent decisions
- Reframe vague requirements into testable success criteria
- Commit the spec to version control alongside code
- Keep the spec alive — update it as the project evolves

## Verification

- [ ] All six spec areas documented
- [ ] Assumptions listed and validated with user
- [ ] Tasks have acceptance criteria
- [ ] Spec committed to version control

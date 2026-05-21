---
description: Pre-launch gate — run code-reviewer, security-auditor, and test-engineer in parallel, then produce a go/no-go decision.
---

Run the full pre-launch review before deploying to production.

## Steps

1. Run three specialist agents **in parallel** using the Agent tool:
   - `code-reviewer` — five-axis quality review
   - `security-auditor` — OWASP-based vulnerability scan
   - `test-engineer` — coverage gap analysis

2. Collect all three reports

3. Apply the `shipping-and-launch` skill to run the pre-launch checklist

4. Produce a final **GO / NO-GO** decision:
   - **NO-GO** if any Critical issue exists from any agent
   - **GO** if all Critical issues are clear (Important issues noted but don't block)

## Output

```markdown
## Ship Report

### GO / NO-GO: [decision]

### Code Review
[summary from code-reviewer]

### Security Audit
[summary from security-auditor]

### Test Coverage
[summary from test-engineer]

### Pre-Launch Checklist
[checklist status]

### Blockers
[list of Critical issues if NO-GO]
```

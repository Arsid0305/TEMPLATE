---
name: shipping-and-launch
description: Prepares production launches. Use when preparing to deploy to production. Use when you need a pre-launch checklist, when setting up monitoring, when planning a staged rollout, or when you need a rollback strategy.
---

## Overview

Ship with confidence. The goal is not just to deploy — it's to deploy safely, with monitoring in place, a rollback plan ready, and a clear understanding of what success looks like. Every launch should be reversible, observable, and incremental.

## Pre-Launch Checklist

### Code Quality
- [ ] All tests pass (unit, integration, e2e)
- [ ] Build succeeds with no warnings
- [ ] Lint and type checking pass
- [ ] Code reviewed and approved
- [ ] No `console.log` debugging statements in production code
- [ ] Error handling covers expected failure modes

### Security
- [ ] No secrets in code or version control
- [ ] Input validation on all user-facing endpoints
- [ ] Authentication and authorization checks in place
- [ ] Security headers configured (CSP, HSTS, etc.)
- [ ] Rate limiting on authentication endpoints
- [ ] CORS configured to specific origins (not wildcard)

### Infrastructure
- [ ] Environment variables set in production
- [ ] Database migrations applied
- [ ] Logging and error reporting configured
- [ ] Health check endpoint exists and responds

### Documentation
- [ ] README updated with any new setup requirements
- [ ] Changelog updated

## Rollout Strategy

```
1. DEPLOY to staging → full test suite + smoke test
2. DEPLOY to production (feature flag OFF) → verify health check
3. ENABLE for team → 24h monitoring
4. CANARY 5% → monitor error rates, latency
5. GRADUAL 25% → 50% → 100%
6. FULL rollout → clean up feature flag
```

## Rollback Decision Thresholds

| Metric | Advance | Hold | Roll back |
|--------|---------|------|-----------|
| Error rate | Within 10% of baseline | 10-100% above | >2x baseline |
| P95 latency | Within 20% of baseline | 20-50% above | >50% above |

## Rollback Plan Template

```markdown
## Rollback Plan

### Trigger Conditions
- Error rate > 2x baseline
- P95 latency > [X]ms

### Rollback Steps
1. Disable feature flag (if applicable)
2. Deploy previous version: `git revert <commit> && git push`
3. Verify rollback: health check, error monitoring

### Time to Rollback
- Feature flag: < 1 minute
- Redeploy previous version: < 5 minutes
```

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "It works in staging" | Production has different data, traffic patterns, and edge cases. |
| "We don't need feature flags" | Every feature benefits from a kill switch. |
| "Monitoring is overhead" | You discover problems from user complaints instead of dashboards. |
| "Rolling back is admitting failure" | Rolling back is responsible engineering. |

## Verification

Before deploying:
- [ ] Pre-launch checklist completed
- [ ] Rollback plan documented
- [ ] Team notified

After deploying:
- [ ] Health check returns 200
- [ ] Error rate is normal
- [ ] Critical user flow works manually verified

# SECURITY.md — Security Checklist

> Run this checklist before the first deploy to `main`.

## Secrets & Keys
- [ ] No `service_role` key in `VITE_` env vars — only in Edge Functions or GitHub Secrets
- [ ] `.env` in `.gitignore`, not in git history (`git log --all -- .env`)
- [ ] No `build.sourcemap: true` in `vite.config.ts`

## Supabase RLS
- [ ] RLS enabled on every table in `public` schema
- [ ] Policies use `auth.uid() = user_id`, not open to anonymous

## Edge Functions
- [ ] Every function verifies JWT: `supabase.auth.getUser(token)` → 401 if invalid
- [ ] No `user_id` from request body — only from verified token
- [ ] Inputs validated via `zod` before any DB call
- [ ] CORS restricted: `Access-Control-Allow-Origin: https://DOMAIN.com` (not `*`)

## CI/CD
- [ ] Workflows use minimal permissions — `contents: write` only where needed, `contents: read` elsewhere
- [ ] Actions pinned to commit SHA, not tag
- [ ] `npm audit --audit-level=high` runs before build step
- [ ] Secrets not echoed in `run:` steps
- [ ] Branch name / user input never interpolated directly into `run:` shell commands — use `env:` block instead

## OWASP Quick Check
- [ ] A01 Broken Access Control — RLS on all tables, JWT in every Edge Function
- [ ] A02 Cryptographic Failures — no service_role in frontend, no secrets in git
- [ ] A03 Injection — zod validation on all Edge Function inputs
- [ ] A05 Misconfiguration — CSP, CORS, headers configured
- [ ] A06 Vulnerable Components — `npm audit` in CI
- [ ] A07 Auth Failures — rate limiting on OTP, token verified on backend

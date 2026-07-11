# Project Context

> Fill in placeholders when starting a new project.
> Keep this file updated throughout the project lifecycle.

---

## 1. Tech Stack
- Frontend: [React + Vite + TS + Tailwind + shadcn/ui / Next.js / none]
- Animations: [Framer Motion / none]
- Backend: [Supabase Edge Functions / Node.js / Python / none]
- DB & Auth: [Supabase / PostgreSQL / none]
- Design System: [git submodule / shadcn/ui / none]

---

## 2. Infrastructure & CI/CD
- Frontend deploy: [Vercel / GitHub Pages / none]
- Repo: github.com/[OWNER]/[REPO]

Reference workflows (copy from `workflows/` — optional, remove unused):
- `automerge.yml` — `claude/**` | `cursor/**` → main via GitHub API (squash + deleteRef) [✅ / ❌]
- `deploy.yml` — Supabase Edge Functions deploy [✅ / ❌]

---

## 3. AI Environment

| Tool | Status | Note |
|------|--------|------|
| Node.js / npm | [✅ / ❌] | Use `npm ci` |
| Python | [✅ / ❌] | Version: [x.x] |
| Supabase CLI | [✅ / ❌] | Often unavailable locally |
| .env (real keys) | [✅ / ❌] | |

---

## 4. Design System

Repo: github.com/[OWNER]/[DESIGN-SYSTEM-REPO] — [git submodule / npm package / none]

Before any UI change — open the relevant preview file:

| What | File |
|------|------|
| Cards | `[preview path]` |
| Buttons | `[preview path]` |
| Navigation | `[preview path]` |

Do not invent UI — use design system components.

---

## 5. Project Structure

```
.github/workflows/     — CI/CD (optional, see workflows/)
src/                   — source code
tasks/
  todo.md              — active task checklist
  lessons.md           — patterns from mistakes
.env.example           — env var template
```

---

## 6. Standard Packages

- `lucide-react` — icons
- `sonner` — toast notifications
- `next-themes` — light/dark theme
- `zod` — validation
- `date-fns` — date formatting
- `xlsx` — Excel parsing

> Add new packages here when introduced to any project.

---

## 7. Auth (Supabase OTP)

- Step 1: `supabase.auth.signInWithOtp({ email })` — sends code
- Step 2: `supabase.auth.verifyOtp({ email, token, type: 'email' })` — verifies
- Code is **8 digits** (not 6)

---

## 8. Open Bugs

_(empty)_

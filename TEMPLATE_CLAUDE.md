# Контекст проекта для Claude

## ⛔ ГЛАВНОЕ ПРАВИЛО

Никаких изменений без явного согласования с пользователем.
Заметил баг или улучшение — сообщи и жди разрешения. Не трогай.

> Правило для Claude: Читай этот файл в начале чата. В конце чата — обновляй раздел «Открытые баги».

---

## Инфраструктура

- Фронтенд: Vercel — автодеплой при пуше в `main`
- Бэкенд: Supabase Edge Functions — GitHub Actions
- Репо: github.com/Arsid0305/REPO_NAME

---

## Стек

- React + Vite + TypeScript + Tailwind + shadcn/ui
- Framer Motion
- Supabase Auth (email OTP), Edge Functions (Deno)

---

## Design System

Репо: `github.com/Arsid0305/design-system` — отдельный репо, наполняется через дизайн-процесс.
Внутри — папка для каждого проекта (`/kino-app/`, `/wb-bot/` и т.д.).
Подключён как git submodule — локальное имя смотреть в `.gitmodules`.
Инициализировать: `git submodule update --init`
Обновить: `git submodule update --remote`

Перед любым изменением UI — открыть нужный файл из `[submodule]/[PROJECT]/preview/`:

| Что меняешь | Файл |
|-------------|------|
| Карточки | `component-cards.html` |
| Кнопки | `component-buttons.html` |
| Чипы, теги | `component-chips.html` |
| Шапка, табы | `component-nav.html` |
| Чат AI | `component-chat.html` |
| Авторизация | `component-auth.html` |
| Цвета | `colors-base.html` |
| Шрифты | `type-display.html` |
| Тени | `shadows-glow.html` |
| Отступы | `spacing-tokens.html` |

Не выдумывать UI с нуля — брать из design system.

---

## Среда Claude

- node_modules: нет (npm ci)
- Supabase CLI: не работает
- Deno: не установлен

---

## Рабочий процесс

Схема: `ветки` → `dev` (авто) → `main` (после билда) → Vercel

1. Claude пишет код → пушит в ветку `claude/...`
2. `automerge.yml` мержит ветку в `dev` автоматически
3. `promote.yml` мержит `dev` → `main` после успешного билда
4. Vercel деплоит фронтенд (1-2 мин)
5. GitHub Actions деплоит Edge Functions (1-2 мин)
6. Тестируем на проде

---

## Правила Git

- Разрабатывать на ветке `claude/...`, никогда не пушить напрямую в `main`
- Никогда не использовать `--no-verify`, `--force`, `--no-gpg-sign`
- Синхронизация с основной: `git pull origin main`

---

## Открытые баги

_(пусто)_

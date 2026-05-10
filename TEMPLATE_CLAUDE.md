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

## Стандартные пакеты

> Правило: при использовании нового пакета в любом проекте — добавлять его сюда.

- `lucide-react` — иконки
- `sonner` — toast-уведомления
- `next-themes` — смена темы (светлая/тёмная)
- `zod` — валидация данных
- `date-fns` — форматирование дат
- `xlsx` — парсинг Excel-файлов
- `@resvg/resvg-js` — SVG → PNG (devDependency, для иконок PWA)

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

## Context Mode (экономия токенов)

Установлен глобально через плагин Claude Code. При старте сессии активируется автоматически.

### Когда использовать

| Ситуация | Вместо | Использовать |
|----------|--------|--------------|
| Большой файл (>5 KB) | Read → весь файл в контекст | `ctx_execute` — скрипт выводит только нужное |
| Fetch URL / документация | WebFetch → сырой HTML | `ctx_fetch_and_index` → `ctx_search` |
| Несколько grep/find подряд | Bash × N вызовов | `ctx_batch_execute` — один вызов |
| Большой markdown (README, docs) | Read → всё в контекст | `ctx_index` → `ctx_search` |
| CSV / JSON / лог-файл | Read → гигабайты | `ctx_execute` — анализирует, возвращает итог |

### Ключевые инструменты

- `ctx_execute` — запустить код в изолированной sandbox (JS/TS/Python/Shell/+8 языков). Данные не входят в контекст, в контекст идёт только вывод stdout. Экономия: 56 KB → 299 B
- `ctx_execute_file` — обработать файл в sandbox (grep, парсинг, анализ)
- `ctx_batch_execute` — несколько команд/запросов в одном вызове
- `ctx_fetch_and_index` — загрузить URL, сжать, проиндексировать (кэш 24 ч)
- `ctx_search` — поиск по проиндексированному контенту (BM25 + FTS5)
- `ctx_index` — проиндексировать markdown-текст
- `ctx_stats` — статистика сессии и экономия токенов

### Сессионная память

При компрессии контекста context-mode автоматически сохраняет состояние сессии в SQLite и восстанавливает его при старте. Claude не теряет нить — знает какие файлы редактировал, какие задачи были в процессе.

### Диагностика

```bash
context-mode doctor   # проверить установку, хуки, рантаймы
ctx_stats             # статистика экономии токенов за сессию
```

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

# Контекст проекта для Claude

## ⛔ ГЛАВНОЕ ПРАВИЛО

Никаких изменений без явного согласования с пользователем.
Заметил баг или улучшение — сообщи и жди разрешения. Не трогай.

> Правило для Claude: Читай этот файл в начале чата. В конце чата — обновляй раздел «Открытые баги».

## Инфраструктура

- Фронтенд: Vercel — автодеплой при пуше в main
- Бэкенд: Supabase Edge Functions — GitHub Actions
- Репо: github.com/Arsid0305/REPO_NAME

## Стек

- React + Vite + TypeScript + Tailwind + shadcn/ui
- Framer Motion
- Supabase Auth (email OTP), Edge Functions (Deno)

## Среда Claude

- node_modules: нет (npm ci)
- Supabase CLI: не работает
- Deno: не установлен

## Рабочий процесс

1. Claude пишет код → пушит в main
2. Vercel деплоит фронтенд (1-2 мин)
3. GitHub Actions деплоит Edge Functions (1-2 мин)
4. Тестируем на проде

## Открытые баги

_(пусто)_

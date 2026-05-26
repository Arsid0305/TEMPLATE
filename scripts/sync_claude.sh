#!/usr/bin/env bash
# sync_claude.sh — синхронизирует универсальную часть CLAUDE.md из TEMPLATE во все указанные репо.
#
# Использование:
#   bash scripts/sync_claude.sh /path/to/repo1 /path/to/repo2 ...
#
# Как работает:
#   1. Берёт TEMPLATE/CLAUDE.md — всё ДО маркера <!--LOCAL_START-->
#   2. Для каждого целевого репо берёт его CLAUDE.md — всё НАЧИНАЯ С <!--LOCAL_START-->
#   3. Соединяет: универсальная часть + локальная часть → записывает в целевой CLAUDE.md
#
# Если в целевом репо нет маркера <!--LOCAL_START--> — добавляет его с пустым placeholder.

set -euo pipefail

TEMPLATE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE_CLAUDE="$TEMPLATE_DIR/CLAUDE.md"
MARKER="<!--LOCAL_START-->"

if [[ ! -f "$TEMPLATE_CLAUDE" ]]; then
  echo "ERROR: $TEMPLATE_CLAUDE не найден" >&2
  exit 1
fi

if [[ $# -eq 0 ]]; then
  echo "Использование: $0 /path/to/repo1 [/path/to/repo2 ...]"
  echo ""
  echo "Пример:"
  echo "  $0 ~/projects/ai_os ~/projects/wb-bot"
  exit 1
fi

# Извлечь универсальную часть из TEMPLATE (всё до маркера, включая пустую строку перед ним)
UNIVERSAL=$(awk "/$MARKER/{exit} {print}" "$TEMPLATE_CLAUDE")

UPDATED=0
SKIPPED=0

for REPO in "$@"; do
  TARGET="$REPO/CLAUDE.md"

  if [[ ! -d "$REPO" ]]; then
    echo "SKIP: $REPO — директория не найдена"
    ((SKIPPED++)) || true
    continue
  fi

  if [[ ! -f "$TARGET" ]]; then
    echo "SKIP: $TARGET — файл не найден"
    ((SKIPPED++)) || true
    continue
  fi

  # Проверить есть ли маркер в целевом файле
  if grep -q "$MARKER" "$TARGET"; then
    # Извлечь локальную часть (от маркера до конца)
    LOCAL=$(awk "/$MARKER/,0" "$TARGET")
  else
    # Маркера нет — добавить пустой placeholder
    LOCAL="$MARKER
\`\`\`
╔══════════════════════════════════════════════════════════════╗
║         ЛОКАЛЬНЫЕ ПРАВИЛА — только для этого репо            ║
╠══════════════════════════════════════════════════════════════╣
║  Всё ВЫШЕ  —  универсально, редактировать в TEMPLATE         ║
║  Всё НИЖЕ  —  специфично для репо, sync не трогает           ║
╚══════════════════════════════════════════════════════════════╝
\`\`\`
<!--LOCAL_END-->

---

_Локальные правила для этого репо не заданы. Добавить ниже после инициализации._"
    echo "INFO: маркер не найден в $TARGET — добавлен placeholder"
  fi

  # Записать объединённый файл
  printf '%s\n%s\n' "$UNIVERSAL" "$LOCAL" > "$TARGET"
  echo "OK: $TARGET обновлён"
  ((UPDATED++)) || true
done

echo ""
echo "Готово: обновлено $UPDATED, пропущено $SKIPPED"

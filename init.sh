#!/bin/bash
# Universal AI Template initializer
#
# Local usage:  bash init.sh /path/to/new-project [adapter]
# Remote usage: bash <(curl -s https://raw.githubusercontent.com/Arsid0305/TEMPLATE/main/init.sh) . [adapter]
# Adapters: claude (default) | openai | cursor

TARGET=${1:-.}
ADAPTER=${2:-claude}
TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"

# If running remotely (via curl), clone TEMPLATE first
if [ ! -f "$TEMPLATE_DIR/SYSTEM.md" ]; then
  echo "Cloning TEMPLATE..."
  rm -rf /tmp/arsid-template
  git clone https://github.com/Arsid0305/TEMPLATE /tmp/arsid-template --quiet
  TEMPLATE_DIR=/tmp/arsid-template
fi

mkdir -p "$TARGET/.github/workflows" "$TARGET/tasks"

cp "$TEMPLATE_DIR"/workflows/*.yml "$TARGET/.github/workflows/" 2>/dev/null && echo "Copied workflows"

touch "$TARGET/tasks/todo.md" "$TARGET/tasks/lessons.md"

cp "$TEMPLATE_DIR/NEW_PROJECT.md" "$TARGET/NEW_PROJECT.md"

ADAPTER_SRC="$TEMPLATE_DIR/adapters/$(echo "$ADAPTER" | tr '[:lower:]' '[:upper:]').md"
if [ -f "$ADAPTER_SRC" ]; then
  cp "$ADAPTER_SRC" "$TARGET/CLAUDE.md"
  echo "Copied adapter: $ADAPTER"
else
  echo "Adapter not found: $ADAPTER (skipped)"
fi

echo ""
echo "Done. Next steps:"
echo "  1. Fill in NEW_PROJECT.md placeholders"
echo "  2. Remove unused workflows from .github/workflows/"
echo "  3. Add GitHub Secrets if using Supabase: SBP_ACCESS_TOKEN, SUPABASE_PROJECT_REF"

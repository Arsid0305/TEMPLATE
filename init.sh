#!/bin/bash
# Universal AI Template initializer
# Usage: bash init.sh /path/to/new-project [adapter]
# Adapters: claude (default) | openai | cursor

TARGET=${1:-.}
ADAPTER=${2:-claude}

mkdir -p "$TARGET/.github/workflows" "$TARGET/tasks"

# Copy reference workflows (remove unused ones after)
cp workflows/*.yml "$TARGET/.github/workflows/" 2>/dev/null && echo "Copied workflows"

# Initialize task files
touch "$TARGET/tasks/todo.md" "$TARGET/tasks/lessons.md"

# Copy project template
cp NEW_PROJECT.md "$TARGET/NEW_PROJECT.md"

# Copy adapter
ADAPTER_SRC="adapters/$(echo "$ADAPTER" | tr '[:lower:]' '[:upper:]').md"
if [ -f "$ADAPTER_SRC" ]; then
  cp "$ADAPTER_SRC" "$TARGET/CLAUDE.md"
  echo "Copied adapter: $ADAPTER_SRC → CLAUDE.md"
else
  echo "Adapter not found: $ADAPTER_SRC (skipped)"
fi

echo ""
echo "Done. Next steps:"
echo "  1. Fill in NEW_PROJECT.md placeholders"
echo "  2. Remove unused workflows from .github/workflows/"
echo "  3. Add GitHub Secrets if using Supabase: SBP_ACCESS_TOKEN, SUPABASE_PROJECT_REF"

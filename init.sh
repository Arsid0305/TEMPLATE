#!/bin/bash
# Universal AI Template initializer
#
# Local usage:  bash init.sh /path/to/new-project [adapter]
# Remote usage: bash <(curl -s https://raw.githubusercontent.com/Arsid0305/TEMPLATE/main/init.sh) . [adapter]
# Adapters: claude (default) | openai | cursor

set -euo pipefail

TARGET=${1:-.}
ADAPTER=${2:-claude}

# Validate TARGET — reject obviously dangerous paths
case "$TARGET" in
  / | /etc | /usr | /bin | /sbin | /lib | /boot | /sys | /proc)
    echo "ERROR: Refusing to initialize into system path: $TARGET" >&2
    exit 1
    ;;
esac

TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"

# If running remotely (via curl), clone TEMPLATE first
if [ ! -f "$TEMPLATE_DIR/SYSTEM.md" ]; then
  echo "Cloning TEMPLATE..."
  TMP_DIR="$(mktemp -d)"
  trap 'rm -rf "$TMP_DIR"' EXIT
  git clone https://github.com/Arsid0305/TEMPLATE "$TMP_DIR" --depth 1 --quiet
  TEMPLATE_DIR="$TMP_DIR"
fi

mkdir -p "$TARGET/.github/workflows" "$TARGET/tasks" "$TARGET/docs" "$TARGET/scripts"

if cp "$TEMPLATE_DIR"/workflows/*.yml "$TARGET/.github/workflows/" 2>/dev/null; then
  echo "Copied workflows"
else
  echo "WARNING: No workflow files found to copy" >&2
fi

touch "$TARGET/tasks/todo.md" "$TARGET/tasks/lessons.md"

cp "$TEMPLATE_DIR/NEW_PROJECT.md" "$TARGET/NEW_PROJECT.md"

if [ -f "$TEMPLATE_DIR/docs/AUDIT_PROMPT.md" ]; then
  cp "$TEMPLATE_DIR/docs/AUDIT_PROMPT.md" "$TARGET/docs/AUDIT_PROMPT.md"
  echo "Copied docs/AUDIT_PROMPT.md"
fi

if [ -f "$TEMPLATE_DIR/scripts/check_consistency.py" ]; then
  cp "$TEMPLATE_DIR/scripts/check_consistency.py" "$TARGET/scripts/check_consistency.py"
  echo "Copied scripts/check_consistency.py"
fi

# Create .gitignore if not present
if [ ! -f "$TARGET/.gitignore" ]; then
  cat > "$TARGET/.gitignore" << 'GITIGNORE'
.env
.env.local
.env.*.local
node_modules/
dist/
build/
.DS_Store
*.log
npm-debug.log*
.supabase/
GITIGNORE
  echo "Created .gitignore"
fi

ADAPTER_UPPER="$(echo "$ADAPTER" | tr '[:lower:]' '[:upper:]')"
ADAPTER_SRC="$TEMPLATE_DIR/adapters/${ADAPTER_UPPER}.md"
if [ -f "$ADAPTER_SRC" ]; then
  cp "$ADAPTER_SRC" "$TARGET/CLAUDE.md"
  echo "Copied adapter: $ADAPTER"
else
  echo "WARNING: Adapter not found: $ADAPTER (skipped)" >&2
fi

echo ""
echo "Done. Next steps:"
echo "  1. Fill in NEW_PROJECT.md placeholders"
echo "  2. Remove unused workflows from .github/workflows/"
echo "  3. Add GitHub Secrets if using Supabase: SBP_ACCESS_TOKEN, SUPABASE_PROJECT_REF"

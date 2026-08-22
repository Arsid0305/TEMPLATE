#!/bin/bash
# Universal AI Template initializer
#
# Local usage:  bash init.sh /path/to/new-project [adapter]
# Remote usage: bash <(curl -s https://raw.githubusercontent.com/Arsid0305/TEMPLATE/main/init.sh) . [adapter]
# Adapters: claude (default) | openai | cursor

set -euo pipefail

TARGET=${1:-.}
ADAPTER=${2:-claude}

# Validate TARGET — reject obviously dangerous paths (including subpaths)
case "$TARGET" in
  / | /etc | /etc/* | /usr | /usr/* | /bin | /bin/* | /sbin | /sbin/* | \
  /lib | /lib/* | /boot | /boot/* | /sys | /sys/* | /proc | /proc/* | /dev | /dev/*)
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

# Copy only automerge.yml by default (canonical CI).
# Other workflows (deploy.yml для Supabase) — по запросу через WORKFLOWS env var.
WORKFLOWS="${WORKFLOWS:-automerge.yml}"
for wf in $WORKFLOWS; do
  if [ -f "$TEMPLATE_DIR/workflows/$wf" ]; then
    cp "$TEMPLATE_DIR/workflows/$wf" "$TARGET/.github/workflows/$wf"
    echo "Copied workflow: $wf"
  else
    echo "WARNING: workflow $wf not found in template" >&2
  fi
done

touch "$TARGET/tasks/todo.md" "$TARGET/tasks/lessons.md"

cp "$TEMPLATE_DIR/NEW_PROJECT.md" "$TARGET/NEW_PROJECT.md"

if [ -f "$TEMPLATE_DIR/docs/AUDIT_PROMPT.md" ]; then
  cp "$TEMPLATE_DIR/docs/AUDIT_PROMPT.md" "$TARGET/docs/AUDIT_PROMPT.md"
  echo "Copied docs/AUDIT_PROMPT.md"
fi

# docs/rules/ — SSOT правил экосистемы (см. docs/rules/README.md)
# core/ синкается из AI_OS; scoped/ — специфика этого проекта, создаётся пустой
if [ -d "$TEMPLATE_DIR/docs/rules/core" ]; then
  mkdir -p "$TARGET/docs/rules/scoped"
  rm -rf "$TARGET/docs/rules/core"
  cp -r "$TEMPLATE_DIR/docs/rules/core" "$TARGET/docs/rules/core"
  cp "$TEMPLATE_DIR/docs/rules/README.md" "$TARGET/docs/rules/README.md"
  echo "Copied docs/rules/ (core + README from AI_OS SSOT)"
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
case "$ADAPTER" in
  claude) DEST="$TARGET/CLAUDE.md" ;;
  cursor) mkdir -p "$TARGET/.cursor/rules"; DEST="$TARGET/.cursor/rules/project.mdc" ;;
  openai) DEST="$TARGET/AGENTS.md" ;;
  *)      DEST="$TARGET/CLAUDE.md" ;;
esac
if [ -f "$ADAPTER_SRC" ]; then
  cp "$ADAPTER_SRC" "$DEST"
  echo "Copied adapter: $ADAPTER → $(basename "$DEST")"
else
  echo "WARNING: Adapter not found: $ADAPTER (skipped)" >&2
fi

echo ""
echo "Done. Next steps:"
echo "  1. Fill in NEW_PROJECT.md placeholders"
echo "  2. Optional: install additional workflows via WORKFLOWS='automerge.yml deploy.yml' bash init.sh ..."
echo "  3. Add GitHub Secrets if using Supabase: SBP_ACCESS_TOKEN, SUPABASE_PROJECT_REF"

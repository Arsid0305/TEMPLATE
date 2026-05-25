#!/bin/bash
set -euo pipefail

# Only run in remote web sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Install Python dependencies
pip install -r "$CLAUDE_PROJECT_DIR/requirements.txt" --quiet

# Install context-mode if missing
if ! command -v context-mode &> /dev/null; then
  npm install -g context-mode --silent
fi

# Register MCP server (idempotent)
claude mcp add context-mode -- npx -y context-mode 2>/dev/null || true

echo "Session ready: Python deps + context-mode installed"

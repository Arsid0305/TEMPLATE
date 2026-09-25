#!/usr/bin/env bash
# WorktreeRemove hook — чистит git worktree после завершения subagent'а.
# Non-blocking: ошибки логируются Claude Code только в debug-mode.
set -euo pipefail

INPUT=$(cat)
REPO_PATH=$(printf '%s' "$INPUT" | jq -r '.repo_path')
WORKTREE_PATH=$(printf '%s' "$INPUT" | jq -r '.worktree_path')

if [[ -z "$REPO_PATH" || -z "$WORKTREE_PATH" ]]; then
  exit 0
fi

git -C "$REPO_PATH" worktree remove --force "$WORKTREE_PATH" 2>/dev/null || true

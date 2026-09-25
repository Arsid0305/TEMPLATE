#!/usr/bin/env bash
# WorktreeCreate hook — создаёт git worktree для subagent'а под .claude/worktrees/<name>.
# Стейтлесс: вызывается Claude Code когда subagent просит isolation: "worktree".
set -euo pipefail

INPUT=$(cat)
REPO_PATH=$(printf '%s' "$INPUT" | jq -r '.repo_path')
WORKTREE_NAME=$(printf '%s' "$INPUT" | jq -r '.worktree_name')
BASE_REF=$(printf '%s' "$INPUT" | jq -r '.base_ref // "HEAD"')

if [[ -z "$REPO_PATH" || -z "$WORKTREE_NAME" ]]; then
  echo "worktree-create: repo_path or worktree_name empty" >&2
  exit 1
fi

WORKTREE_DIR="$REPO_PATH/.claude/worktrees/$WORKTREE_NAME"
BRANCH="agent/$WORKTREE_NAME"

mkdir -p "$REPO_PATH/.claude/worktrees"

if [[ -d "$WORKTREE_DIR" ]]; then
  git -C "$REPO_PATH" worktree remove --force "$WORKTREE_DIR" 2>/dev/null || true
fi

git -C "$REPO_PATH" worktree add -B "$BRANCH" "$WORKTREE_DIR" "$BASE_REF" >&2

printf '%s\n' "$WORKTREE_DIR"

#!/usr/bin/env python3
"""Consistency checker for TEMPLATE repo — runs as CI gate in automerge.yml."""

import argparse
import sys
from pathlib import Path

errors = []


def fail(msg):
    errors.append(msg)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--root",
        default=".",
        help="Repository root to validate (default: current directory)",
    )
    args = parser.parse_args()
    root = Path(args.root).resolve()

    # 1. QUICKSTART.md: no 'dev' stage in git flow
    try:
        quickstart = (root / "QUICKSTART.md").read_text()
        if "→ dev →" in quickstart or "→ `dev` →" in quickstart:
            fail("QUICKSTART.md: git flow references 'dev' stage — should be 'claude/... → main'")
    except OSError as exc:
        fail(f"Cannot read QUICKSTART.md: {exc}")

    # 2. automerge.yml: uses explicit branches allowlist, not branches-ignore
    try:
        automerge = (root / ".github" / "workflows" / "automerge.yml").read_text()
        if "branches-ignore" in automerge:
            fail("automerge.yml: uses 'branches-ignore' — should use explicit branches: [claude/**, cursor/**]")
        if "claude/**" not in automerge:
            fail("automerge.yml: missing 'claude/**' in branches filter")
        if "cursor/**" not in automerge:
            fail("automerge.yml: missing 'cursor/**' in branches filter")
    except OSError as exc:
        fail(f"Cannot read .github/workflows/automerge.yml: {exc}")

    # 3. Adapter files exist
    for adapter in ["adapters/CLAUDE.md", "adapters/CURSOR.md", "adapters/OPENAI.md"]:
        if not (root / adapter).exists():
            fail(f"Missing adapter file: {adapter}")

    # 4. No adapter or SYSTEM.md mentions 'dev' branch in git workflow
    adapters_dir = root / "adapters"
    system_md = root / "SYSTEM.md"
    candidates = list(adapters_dir.glob("*.md")) if adapters_dir.exists() else []
    if system_md.exists():
        candidates.append(system_md)
    for md_path in candidates:
        try:
            content = md_path.read_text()
            if any(pat in content for pat in ["→ dev", "targets `dev`", "targets dev", "into dev"]):
                fail(f"{md_path.relative_to(root)}: references 'dev' branch in git workflow rules")
        except OSError as exc:
            fail(f"Cannot read {md_path.name}: {exc}")

    if errors:
        print("CONSISTENCY ERRORS:")
        for e in errors:
            print(f"  - {e}")
        sys.exit(1)

    print("Consistency check passed.")


if __name__ == "__main__":
    main()

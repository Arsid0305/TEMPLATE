"""
Generate documentation sections from code and filesystem (SSOT).

Sources:
  - runtime/core/agent_registry.py  → mode lists/tables
  - runtime/core/config.py          → providers, model aliases
  - .claude/agents/*.md             → Claude Code agents
  - dot-folders at root + ADAPTERS/ → AI tool adapters

Targets (sections between AUTO markers):
  - README.md
  - docs/ARCHITECTURE.md
  - SYSTEM.md

Usage:
  python scripts/gen_docs.py
  python scripts/gen_docs.py --check   # exit 1 if docs are out of date
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "runtime"))

from core.agent_registry import build_default_registry  # noqa: E402
from core.config import Models  # noqa: E402

_MODE_ORDER = [
    "research", "code", "review", "decision", "legal", "medical",
    "marketplace_wb", "marketplace_ozon", "tables", "writing",
    "visual", "meta_agent", "meta_prompt",
]

_PROVIDERS: list[dict] = [
    {"provider": "OpenAI",    "alias": "`openai`",             "key": "`OPENAI_API_KEY`"},
    {"provider": "Anthropic", "alias": "`anthropic`, `claude`", "key": "`ANTHROPIC_API_KEY`"},
    {"provider": "Gemini",    "alias": "`gemini`",             "key": "`GOOGLE_API_KEY`"},
    {"provider": "DeepSeek",  "alias": "`deepseek`",           "key": "`DEEPSEEK_API_KEY`"},
]

_MODEL_PARAM = "openai | anthropic | gemini | deepseek (default: openai)"

# Dot-folders to ignore when scanning AI tool folders
_IGNORE_DOTS = {".git", ".github", ".pytest_cache", ".venv", ".env"}


# ── Frontmatter parser ───────────────────────────────────────────────────────────

def _parse_frontmatter(path: Path) -> tuple[str, str]:
    """Return (name, description) from YAML frontmatter of a markdown file."""
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---"):
        return "", ""
    end = text.find("---", 3)
    if end == -1:
        return "", ""
    fm = text[3:end]
    name = re.search(r"^name:\s*(.+)$", fm, re.MULTILINE)
    desc = re.search(r"^description:\s*(.+)$", fm, re.MULTILINE)
    return (
        name.group(1).strip() if name else "",
        desc.group(1).strip() if desc else "",
    )


# ── Generators: runtime ──────────────────────────────────────────────────────────

def _modes_table() -> str:
    reg = build_default_registry()
    modes = reg.list_agents()
    ordered = [m for m in _MODE_ORDER if m in modes]
    ordered += sorted(set(modes) - set(ordered))
    lines = ["| Режим | Назначение |", "|---|---|"]    
    for m in ordered:
        desc = reg.get_description(m)
        lines.append(f"| `{m}` | {desc} |")
    return "\n".join(lines)


def _modes_inline() -> str:
    reg = build_default_registry()
    modes = reg.list_agents()
    ordered = [m for m in _MODE_ORDER if m in modes]
    ordered += sorted(set(modes) - set(ordered))
    count = len(ordered)
    chunks = [
        " ".join(f"`{m}`" for m in ordered[:4]),
        " ".join(f"`{m}`" for m in ordered[4:9]),
        " ".join(f"`{m}`" for m in ordered[9:]),
    ]
    body = "\n".join(c for c in chunks if c)
    return f"**Режимы ({count}):** {ordered[0] and body}"


def _modes_inline_system() -> str:
    reg = build_default_registry()
    modes = reg.list_agents()
    ordered = [m for m in _MODE_ORDER if m in modes]
    ordered += sorted(set(modes) - set(ordered))
    count = len(ordered)
    tags = " ".join(f"`{m}`" for m in ordered)
    return f"**Режимы ({count}):** {tags}"


def _providers_table() -> str:
    lines = ["| Провайдер | Алиас `--model` | Ключ |", "|---|---|---|"]    
    for p in _PROVIDERS:
        lines.append(f"| {p['provider']} | {p['alias']} | {p['key']} |")
    return "\n".join(lines)


def _model_param_line() -> str:
    return f"--model     {_MODEL_PARAM}"


# ── Generators: AI tools ────────────────────────────────────────────────────────

def _ai_tools_table() -> str:
    """Scan all AI tool folders: dot-dirs at root (CLI) + ADAPTERS/ subdirs (web)."""
    lines = ["| Инструмент | Папка | Тип |", "|---|---|---|"]    

    # CLI tools: hidden dot-folders at root
    for d in sorted(ROOT.glob(".*")):
        if d.is_dir() and d.name not in _IGNORE_DOTS:
            tool_name = d.name.lstrip(".")
            lines.append(f"| `{tool_name}` | `{d.name}/` | CLI |")    

    # Web tools: ADAPTERS/ subdirectories
    adapters_dir = ROOT / "ADAPTERS"
    if adapters_dir.exists():
        for d in sorted(adapters_dir.iterdir()):
            if d.is_dir():
                lines.append(f"| `{d.name}` | `ADAPTERS/{d.name}/` | Web |")

    return "\n".join(lines)


# ── Generators: Claude Code infra ──────────────────────────────────────────────

def _claude_agents() -> str:
    agents_dir = ROOT / ".claude" / "agents"
    if not agents_dir.exists():
        return "_Нет агентов._"
    lines = ["| Агент | Назначение |", "|---|---|"]    
    for f in sorted(agents_dir.glob("*.md")):
        name, desc = _parse_frontmatter(f)
        label = name or f.stem
        lines.append(f"| `{label}` | {desc or '—'} |")
    return "\n".join(lines)


# ── File patching ──────────────────────────────────────────────────────────────

def _replace_section(text: str, marker: str, new_content: str) -> tuple[str, bool]:
    start = f"<!-- AUTO:{marker}_START -->"
    end   = f"<!-- AUTO:{marker}_END -->"
    pattern = re.compile(
        re.escape(start) + r".*?" + re.escape(end),
        re.DOTALL,
    )
    replacement = f"{start}\n{new_content}\n{end}"
    new_text, count = pattern.subn(replacement, text)
    return new_text, count > 0


def _patch_file(path: Path, replacements: list[tuple[str, str]], check: bool) -> bool:
    original = path.read_text(encoding="utf-8")
    current = original
    for marker, content in replacements:
        current, found = _replace_section(current, marker, content)
        if not found:
            print(f"  WARNING: marker AUTO:{marker} not found in {path.name}")
    if current == original:
        return False
    if check:
        print(f"  OUT OF DATE: {path.relative_to(ROOT)}")
        return True
    path.write_text(current, encoding="utf-8")
    print(f"  updated: {path.relative_to(ROOT)}")
    return True


# ── Entry point ────────────────────────────────────────────────────────────────

def main(check: bool = False) -> int:
    changed = False

    changed |= _patch_file(
        ROOT / "README.md",
        [
            ("MODES_TABLE",  _modes_table()),
            ("MODEL_PARAM",  _model_param_line()),
        ],
        check,
    )

    changed |= _patch_file(
        ROOT / "docs" / "ARCHITECTURE.md",
        [
            ("MODES_INLINE",     _modes_inline()),
            ("PROVIDERS_TABLE",  _providers_table()),
            ("AI_TOOLS",         _ai_tools_table()),
            ("CLAUDE_AGENTS",    _claude_agents()),
        ],
        check,
    )

    changed |= _patch_file(
        ROOT / "SYSTEM.md",
        [
            ("MODES_INLINE", _modes_inline_system()),
        ],
        check,
    )

    if check and changed:
        print("\nRun `python scripts/gen_docs.py` to update.")
        return 1
    if not changed:
        print("All docs up to date.")
    return 0


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true",
                        help="Exit 1 if docs are out of date (used in CI)")
    args = parser.parse_args()
    sys.exit(main(check=args.check))

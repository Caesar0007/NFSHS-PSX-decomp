#!/usr/bin/env python3
"""CI guard for the source-only reconstruction policy.

Post-compiler instruction moves and branch retargets are forbidden.  Older
build.py revisions kept empty sentinel tables with these names, while newer
revisions remove the tables entirely; both forms are valid as long as no
function is configured in either table.
"""

import ast
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
BUILD_PY = ROOT / "tools" / "build.py"
FORBIDDEN_TABLES = {"PER_FN_TEXT_MOVES", "PER_FN_BRANCH_RETARGET"}


def configured_entries(tree: ast.AST) -> dict[str, object]:
    found: dict[str, object] = {}
    for node in ast.walk(tree):
        if not isinstance(node, (ast.Assign, ast.AnnAssign)):
            continue
        targets = node.targets if isinstance(node, ast.Assign) else [node.target]
        value = node.value
        for target in targets:
            if not isinstance(target, ast.Name) or target.id not in FORBIDDEN_TABLES:
                continue
            try:
                found[target.id] = ast.literal_eval(value)
            except (TypeError, ValueError, SyntaxError):
                found[target.id] = "<non-literal configuration>"
    return found


def main() -> None:
    tree = ast.parse(BUILD_PY.read_text(encoding="utf-8", errors="replace"),
                     filename=str(BUILD_PY))
    configured = configured_entries(tree)
    violations = {name: value for name, value in configured.items() if value}
    if violations:
        for name, value in sorted(violations.items()):
            print(f"FAIL: {name} contains forbidden post-compiler configuration: {value!r}")
        sys.exit(1)
    print("PASS: source-only policy; no post-compiler text moves or branch retargets configured")


if __name__ == "__main__":
    main()

"""Inventory SYM functions whose SLD source owner is a header.

The main declaration audit intentionally selects C/C++ translation-unit names.
PsyQ also attributes compiler-emitted inline methods and destructors to headers;
this companion pass makes those records explicit and locates any remaining raw
GCC-v2 linkage identifiers in reconstructed source.
"""

from __future__ import annotations

import collections
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import audit_sym_source as audit


ROOT = Path(__file__).resolve().parents[2]
SYM = Path(r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt")


def main() -> None:
    functions = [
        fn
        for fn in audit.parse_sym(SYM)
        if audit.source_basename(fn.source_file).endswith(".h")
    ]
    paths = sorted(
        p
        for suffix in ("*.c", "*.cpp", "*.h")
        for p in (ROOT / "recon").rglob(suffix)
    )
    wanted = {fn.name for fn in functions}
    occurrences: dict[str, list[tuple[Path, int]]] = collections.defaultdict(list)
    token_re = re.compile(r"[A-Za-z_.$][A-Za-z0-9_.$]*")
    for path in paths:
        for line_no, line in enumerate(
            path.read_text(encoding="utf-8", errors="replace").splitlines(), 1
        ):
            for token in token_re.findall(line):
                if token in wanted:
                    occurrences[token].append((path.relative_to(ROOT), line_no))

    by_header: dict[str, list] = collections.defaultdict(list)
    for fn in functions:
        by_header[audit.source_basename(fn.source_file)].append(fn)

    print("# Header-attributed SYM function inventory")
    print()
    print(f"- Header-attributed function records: {len(functions)}")
    print(f"- Header owners: {len(by_header)}")
    print(
        "- Records whose raw GCC-v2 identifier still occurs in recon source: "
        f"{sum(bool(occurrences[fn.name]) for fn in functions)}"
    )
    print()
    for header, rows in sorted(by_header.items()):
        print(f"## {header} ({len(rows)})")
        print()
        for fn in rows:
            hits = occurrences[fn.name]
            where = ", ".join(f"{p}:{line}" for p, line in hits) or "none"
            print(f"- `{fn.name}` @ {fn.va}: {where}")
        print()


if __name__ == "__main__":
    main()

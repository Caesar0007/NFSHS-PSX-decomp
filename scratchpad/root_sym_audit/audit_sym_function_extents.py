"""Prove every SYM function start/end extent against extracted retail oracles."""

from __future__ import annotations

from collections import defaultdict
from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[2]
SYM = Path(r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt")

START = re.compile(r"^[0-9a-f]+: \$(?P<va>[0-9a-f]{8}) 8c Function start", re.I)
END = re.compile(
    r"^[0-9a-f]+: \$(?P<va>[0-9a-f]{8}) 8e Function end\s+line (?P<line>\d+)",
    re.I,
)
CONFIG = re.compile(
    r"^(?P<name>[A-Za-z_.$][\w.$]*)\s*=\s*0x(?P<va>[0-9a-f]+)", re.I
)
ORACLE_SIZE = re.compile(r"^nonmatching\s+[^,]+,\s*0x(?P<size>[0-9a-f]+)", re.I | re.M)


def main() -> None:
    lines = SYM.read_text(encoding="utf-8", errors="replace").splitlines()
    functions = []
    current = None
    nested_starts = 0
    orphan_ends = 0
    for index, line in enumerate(lines):
        match = START.match(line)
        if match:
            if current is not None:
                nested_starts += 1
            name = next(
                (
                    row.strip()[7:]
                    for row in lines[index + 1 : index + 10]
                    if row.strip().startswith("name = ")
                ),
                "<missing>",
            )
            owner = next(
                (
                    row.strip()[7:]
                    for row in lines[index + 1 : index + 10]
                    if row.strip().startswith("file = ")
                ),
                "<missing>",
            )
            current = (int(match.group("va"), 16), name, owner)
            continue
        match = END.match(line)
        if match:
            if current is None:
                orphan_ends += 1
                continue
            functions.append(
                (*current, int(match.group("va"), 16), int(match.group("line")))
            )
            current = None

    config_by_va: dict[int, list[str]] = defaultdict(list)
    for line in (ROOT / "configs/symbol_addrs.txt").read_text(
        encoding="utf-8", errors="replace"
    ).splitlines():
        match = CONFIG.match(line.strip())
        if match:
            config_by_va[int(match.group("va"), 16)].append(match.group("name"))

    oracles: dict[str, tuple[int, Path]] = {}
    for directory in (
        ROOT / "asm/nonmatchings/front",
        ROOT / "asm/nonmatchings/main",
    ):
        for path in directory.glob("*.s"):
            text = path.read_text(encoding="utf-8", errors="replace")
            match = ORACLE_SIZE.search(text)
            if match:
                oracles[path.stem] = (int(match.group("size"), 16), path)

    rows = []
    missing_config = []
    missing_oracle = []
    size_conflicts = []
    for start, raw_name, owner, end, end_line in functions:
        names = config_by_va.get(start, [])
        if not names:
            missing_config.append((start, raw_name))
        candidates = [oracles[name] for name in names if name in oracles]
        if not candidates:
            missing_oracle.append((start, raw_name, names))
            oracle_size = None
            oracle_path = None
        else:
            extent = end - start
            exact = [candidate for candidate in candidates if candidate[0] == extent]
            oracle_size, oracle_path = exact[0] if exact else candidates[0]
            if oracle_size != extent:
                size_conflicts.append(
                    (start, raw_name, extent, oracle_size, oracle_path)
                )
        rows.append(
            (start, end, raw_name, owner, end_line, names, oracle_size, oracle_path)
        )

    print("# SYM function start/end extent audit")
    print()
    print(f"- Function-start records: {len(functions)}")
    print(f"- Function-end records paired: {len(functions)}")
    print(f"- Nested starts: {nested_starts}")
    print(f"- Orphan ends: {orphan_ends}")
    print(f"- Unterminated start: {1 if current is not None else 0}")
    print(f"- Exact start-VA config carriers: {len(functions) - len(missing_config)}/{len(functions)}")
    print(f"- Extracted retail oracle found: {len(functions) - len(missing_oracle)}/{len(functions)}")
    print(f"- Oracle byte size equals SYM end-start: {len(functions) - len(size_conflicts)}/{len(functions)}")
    print(f"- Non-positive or unaligned extents: {sum(end <= start or (end - start) % 4 for start, end, *_ in rows)}")
    print(f"- Smallest/largest extent: 0x{min(end-start for start,end,*_ in rows):x}/0x{max(end-start for start,end,*_ in rows):x}")
    print()
    print("## Per-record ledger")
    print()
    for start, end, raw_name, owner, end_line, names, oracle_size, oracle_path in rows:
        oracle_desc = (
            f"{oracle_path.relative_to(ROOT)} size 0x{oracle_size:x}"
            if oracle_path is not None and oracle_size is not None
            else "missing"
        )
        print(
            f"- `0x{start:08x}-0x{end:08x}` `{raw_name}`: size "
            f"0x{end-start:x}; end-line {end_line}; owner `{owner}`; config "
            f"{','.join(names) or 'missing'}; oracle {oracle_desc}"
        )
    if missing_config or missing_oracle or size_conflicts:
        print()
        print("## Findings")
        print()
        for start, name in missing_config:
            print(f"- Missing config at 0x{start:08x}: `{name}`")
        for start, name, names in missing_oracle:
            print(f"- Missing oracle at 0x{start:08x}: `{name}` via {names}")
        for start, name, extent, oracle_size, path in size_conflicts:
            print(
                f"- Size conflict 0x{start:08x} `{name}`: SYM 0x{extent:x}, "
                f"oracle 0x{oracle_size:x} ({path})"
            )


if __name__ == "__main__":
    main()

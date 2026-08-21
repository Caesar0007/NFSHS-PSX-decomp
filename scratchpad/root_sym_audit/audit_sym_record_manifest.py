"""Emit a stable census of every decoded record in the trusted NFS4 SYM.

This does not claim that every debug-definition row is semantically restored.
It provides the denominator and the record-class breakdown used by
SYM_RECORD_BACKLOG.md, so unresolved classes cannot silently disappear from the
audit merely because they are duplicated across translation units.
"""

from __future__ import annotations

from collections import Counter
from pathlib import Path
import re


SYM = Path(r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt")
RECORD = re.compile(
    r"^(?P<pos>[0-9a-f]+): \$(?P<value>[0-9a-f]{8}) "
    r"(?P<tag>[0-9a-f]+)(?: (?P<body>.*))?$",
    re.IGNORECASE,
)
DEF = re.compile(r"^Def2? class (?P<class>\S+) type (?P<type>.+?) size \d+(?: |$)")


def main() -> None:
    lines = SYM.read_text(encoding="utf-8", errors="replace").splitlines()
    tags: Counter[str] = Counter()
    def_classes: Counter[str] = Counter()
    def_types: Counter[str] = Counter()
    generic_names: dict[str, list[str]] = {"1": [], "2": [], "6": [], "8": []}
    function_owners: Counter[str] = Counter()
    function_names: list[str] = []

    i = 0
    while i < len(lines):
        match = RECORD.match(lines[i])
        if not match:
            i += 1
            continue
        tag = match.group("tag").lower()
        body = match.group("body") or ""
        tags[tag] += 1

        if tag in generic_names:
            generic_names[tag].append(body)
        if tag in {"94", "96"}:
            dm = DEF.match(body)
            if dm:
                def_classes[dm.group("class")] += 1
                def_types[dm.group("type")] += 1
        if tag == "8c":
            owner = "<missing>"
            name = "<missing>"
            for look in lines[i + 1 : i + 10]:
                stripped = look.strip()
                if stripped.startswith("file = "):
                    owner = stripped[7:]
                elif stripped.startswith("name = "):
                    name = stripped[7:]
            function_owners[owner] += 1
            function_names.append(name)
        i += 1

    total = sum(tags.values())
    print("# Trusted NFS4 SYM record manifest")
    print()
    print(f"- Source: `{SYM}`")
    print(f"- Decoded records: {total}")
    print(f"- Distinct opcodes: {len(tags)}")
    print()
    print("## Opcode census")
    print()
    for tag in sorted(tags, key=lambda value: int(value, 16)):
        print(f"- `0x{tag}`: {tags[tag]}")

    print()
    print("## Balanced structural pairs")
    print()
    for begin, end, label in (
        ("88", "8a", "SLD file spans"),
        ("8c", "8e", "functions"),
        ("90", "92", "lexical blocks"),
    ):
        print(f"- {label}: {tags[begin]} start / {tags[end]} end")

    print()
    print("## Definition classes (`0x94` + `0x96`)")
    print()
    for name, count in def_classes.most_common():
        print(f"- `{name}`: {count}")

    print()
    print("## Definition type encodings (`0x94` + `0x96`)")
    print()
    for name, count in def_types.most_common():
        print(f"- `{name}`: {count}")

    print()
    print("## Function attribution")
    print()
    print(f"- Function-start records: {len(function_names)}")
    print(f"- Distinct owner paths: {len(function_owners)}")
    header_count = sum(
        count for owner, count in function_owners.items()
        if owner.lower().endswith((".h", ".hpp"))
    )
    print(f"- Header-attributed function records: {header_count}")
    print(f"- Non-header-attributed function records: {len(function_names) - header_count}")

    print()
    print("## Generic low-opcode symbols")
    print()
    for tag in ("1", "2", "6", "8"):
        print(f"- `0x{tag}`: {len(generic_names[tag])}")
    vtables = [name for name in generic_names["2"] if name.startswith("_vt.")]
    print(f"- `0x2` `_vt.*` records: {len(vtables)}")


if __name__ == "__main__":
    main()

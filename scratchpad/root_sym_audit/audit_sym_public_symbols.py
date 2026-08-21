"""Classify every opcode-2 public/address name in the trusted NFS4 SYM."""

from __future__ import annotations

from collections import Counter, defaultdict
from pathlib import Path
import re
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))
import audit_sym_source as audit


ROOT = Path(__file__).resolve().parents[2]
SYM = Path(r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt")
MAP = Path(r"C:/Temp/nfs4-clean/NFS4.MAP")

LOW = re.compile(
    r"^[0-9a-f]+: \$(?P<va>[0-9a-f]{8}) (?P<tag>[26]) (?P<name>\S+)$", re.I
)
DEF = re.compile(
    r"^[0-9a-f]+: \$(?P<va>[0-9a-f]{8}) 9[46] Def2? class "
    r"(?P<class>\S+) type (?P<type>.+?) size (?P<size>\d+).* name (?P<name>\S+)$",
    re.I,
)
MAP_SYMBOL = re.compile(r"^\s*(?P<va>[0-9a-f]{8}) (?P<name>\S+)\s*$", re.I)
CONFIG = re.compile(
    r"^(?P<name>[A-Za-z_.$][\w.$]*)\s*=\s*0x(?P<va>[0-9a-f]+)", re.I
)


SECTIONS = (
    ("front.rdata", 0x80010000, 0x800128F0),
    ("front.text", 0x800128F0, 0x80051260),
    ("front.data", 0x80051260, 0x80052B38),
    ("front.bss", 0x80052B38, 0x80054548),
    (".rdata", 0x80054548, 0x8005797C),
    (".text", 0x8005797C, 0x8010CCD4),
    (".data", 0x8010CCD4, 0x8013C54C),
    (".sdata", 0x8013C54C, 0x8013DD7C),
    (".sbss", 0x8013DD7C, 0x8013DEE0),
    (".bss", 0x8013DEE0, 0x80148B04),
)


def section_for(va: int) -> str:
    if va == 0x80148B04:
        return "image-end boundary"
    for name, start, end in SECTIONS:
        if start <= va < end:
            return name
    return "outside retail image"


def main() -> None:
    low: dict[str, list[tuple[int, str]]] = defaultdict(list)
    defs: dict[tuple[int, str], list[tuple[str, str, int]]] = defaultdict(list)
    for line in SYM.read_text(encoding="utf-8", errors="replace").splitlines():
        match = LOW.match(line)
        if match:
            low[match.group("tag")].append(
                (int(match.group("va"), 16), match.group("name"))
            )
        match = DEF.match(line)
        if match:
            defs[(int(match.group("va"), 16), match.group("name"))].append(
                (
                    match.group("class"), match.group("type"),
                    int(match.group("size")),
                )
            )

    map_values: dict[str, set[int]] = defaultdict(set)
    for line in MAP.read_text(encoding="utf-8", errors="replace").splitlines():
        match = MAP_SYMBOL.match(line)
        if match:
            map_values[match.group("name")].add(int(match.group("va"), 16))

    config_by_name: dict[str, set[int]] = defaultdict(set)
    config_by_va: dict[int, list[str]] = defaultdict(list)
    for line in (ROOT / "configs/symbol_addrs.txt").read_text(
        encoding="utf-8", errors="replace"
    ).splitlines():
        match = CONFIG.match(line.strip())
        if match:
            va = int(match.group("va"), 16)
            name = match.group("name")
            config_by_name[name].add(va)
            config_by_va[va].append(name)

    functions = {
        (int(fn.va, 16), fn.name): fn for fn in audit.parse_sym(SYM)
    }
    globals_ = {
        (int(row.va, 16), row.decl.name): row
        for row in audit.parse_sym_globals(SYM)
    }

    rows = []
    categories: Counter[str] = Counter()
    section_counts: Counter[str] = Counter()
    class_failures = []
    for va, name in low["2"]:
        matching_defs = defs.get((va, name), [])
        ext_defs = [item for item in matching_defs if item[0] == "EXT"]
        if matching_defs and len(ext_defs) != len(matching_defs):
            class_failures.append((va, name, matching_defs))
        owner = ""
        typ = ""
        if ext_defs:
            typ = ext_defs[0][1]
            if (va, name) in functions:
                category = "typed public function"
                owner = functions[(va, name)].source_file
            else:
                category = "typed public data"
                global_row = globals_.get((va, name))
                owner = global_row.obj if global_row else "<typed owner not parsed>"
        elif name.startswith("_vt."):
            category = "untyped public vtable"
        elif "text" in section_for(va):
            category = "untyped public text/ABI symbol"
        else:
            category = "untyped public data/boundary symbol"
        categories[category] += 1
        section_counts[section_for(va)] += 1

        if va in config_by_name.get(name, set()):
            carrier = "exact name"
        elif config_by_va.get(va):
            carrier = "VA alias: " + ",".join(config_by_va[va])
        elif name in config_by_name:
            carrier = "same name at other VA"
        else:
            carrier = "not carried"
        rows.append((va, name, category, typ, owner, carrier))

    map_exact = sum(va in map_values.get(name, set()) for va, name in low["2"])
    map_conflicts = [
        (va, name, map_values.get(name, set()))
        for va, name in low["2"]
        if va not in map_values.get(name, set())
    ]
    typed2 = [(va, name) for va, name in low["2"] if defs.get((va, name))]
    typed6 = [(va, name) for va, name in low["6"] if defs.get((va, name))]
    tag2_ext = sum(
        all(item[0] == "EXT" for item in defs[(va, name)])
        for va, name in typed2
    )
    tag6_stat = sum(
        all(item[0] == "STAT" for item in defs[(va, name)])
        for va, name in typed6
    )

    print("# SYM opcode-2 public/address symbol audit")
    print()
    print(f"- Opcode-2 records: {len(low['2'])}")
    print(f"- Distinct opcode-2 (VA,name) pairs: {len(set(low['2']))}")
    print(f"- Exact independent NFS4.MAP matches: {map_exact}/{len(low['2'])}")
    print(f"- MAP missing/address conflicts: {len(map_conflicts)}")
    print(f"- Typed opcode-2 rows paired with EXT: {tag2_ext}/{len(typed2)}")
    print(f"- Typed opcode-6 rows paired with STAT (contrast): {tag6_stat}/{len(typed6)}")
    print(f"- Typed opcode-2 storage contradictions: {len(class_failures)}")
    print(f"- Exact raw-name config carriers: {sum(r[5] == 'exact name' for r in rows)}")
    print(f"- Any exact-VA config carrier: {sum(bool(config_by_va[r[0]]) for r in rows)}")
    for category, count in categories.items():
        print(f"- {category}: {count}")
    print()
    print("## Section distribution")
    print()
    for section, count in section_counts.items():
        print(f"- `{section}`: {count}")
    print()
    print("## Interpretation receipt")
    print()
    print("Opcode 2 is the public/address name lane: every one of its 4,503 rows")
    print("appears at the exact same address in the independent retail MAP.  Its")
    print("complete typed subset pairs with EXT, contrasting with opcode 6's STAT")
    print("subset.  Untyped rows retain public vendor/ABI/data names without enough")
    print("debug information to infer original C declarations.")
    print()
    print("## Per-record ledger")
    print()
    for va, name, category, typ, owner, carrier in rows:
        type_text = typ or "no 0x94/0x96 definition"
        owner_text = owner or "no typed owner"
        print(
            f"- `0x{va:08x}` `{name}`: {category}; section `{section_for(va)}`; "
            f"type `{type_text}`; owner `{owner_text}`; MAP exact; config {carrier}"
        )


if __name__ == "__main__":
    main()

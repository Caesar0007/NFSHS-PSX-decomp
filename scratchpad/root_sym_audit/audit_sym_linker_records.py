"""Audit every trusted SYM opcode-1 linker/section symbol.

Opcode 1 is emitted by SN's linker for group/section boundary symbols.  The
retail MAP is the primary independent name/address witness.  The CPE and
PS-X EXE supply image-span checks; the SYM's obj/org/size families supply
internal arithmetic checks.  No reconstructed link is required for these
retail facts, which is important while the full-reconstruction link still has
unrelated unresolved symbols.
"""

from __future__ import annotations

from collections import defaultdict
from pathlib import Path
import re
import struct


ROOT = Path(__file__).resolve().parents[2]
SYM = Path(r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt")
MAP = Path(r"C:/Temp/nfs4-clean/NFS4.MAP")
CPE = Path(r"C:/Temp/nfs4-clean/NFS4.CPE")
EXE = ROOT / "rom/nfs4-f.exe"

SYM_ROW = re.compile(
    r"^[0-9a-f]+: \$(?P<value>[0-9a-f]{8}) 1 (?P<name>\S+)$", re.I
)
MAP_SYMBOL = re.compile(r"^\s*(?P<value>[0-9a-f]{8}) (?P<name>\S+)\s*$", re.I)
MAP_SECTION = re.compile(
    r"^\s*(?P<start>[0-9a-f]{8}) (?P<stop>[0-9a-f]{8}) "
    r"(?P<size>[0-9a-f]{8}) (?P<object>[0-9a-f]{8}) "
    r"(?P<group>\S+)\s+(?P<section>\S+)\s*$",
    re.I,
)
CONFIG_SYMBOL = re.compile(
    r"^(?P<name>[A-Za-z_.$][\w.$]*)\s*=\s*0x(?P<value>[0-9a-f]+)", re.I
)


def parse_cpe_loads() -> list[tuple[int, int]]:
    data = CPE.read_bytes()
    pos = 4
    loads: list[tuple[int, int]] = []
    sizes = {3: 4, 4: 2, 5: 1, 6: 3}
    while pos < len(data):
        opcode = data[pos]
        if opcode == 0:
            break
        if opcode == 1:
            address, size = struct.unpack_from("<II", data, pos + 1)
            loads.append((address, size))
            pos += 9 + size
        elif opcode == 2:
            pos += 5
        elif opcode in sizes:
            pos += 3 + sizes[opcode]
        elif opcode == 7:
            pos += 5
        elif opcode == 8:
            pos += 2
        else:
            raise ValueError(f"unknown CPE opcode {opcode:#x} at {pos:#x}")
    return loads


def main() -> None:
    sym_rows = []
    for line in SYM.read_text(encoding="utf-8", errors="replace").splitlines():
        match = SYM_ROW.match(line)
        if match:
            sym_rows.append((match.group("name"), int(match.group("value"), 16)))

    map_values: dict[str, set[int]] = defaultdict(set)
    map_sections = []
    for line in MAP.read_text(encoding="utf-8", errors="replace").splitlines():
        match = MAP_SYMBOL.match(line)
        if match:
            map_values[match.group("name")].add(int(match.group("value"), 16))
        match = MAP_SECTION.match(line)
        if match:
            map_sections.append(
                (
                    match.group("section"),
                    int(match.group("start"), 16),
                    int(match.group("stop"), 16) + 1,
                    int(match.group("size"), 16),
                )
            )

    config_values: dict[str, int] = {}
    for line in (ROOT / "configs/symbol_addrs.txt").read_text(
        encoding="utf-8", errors="replace"
    ).splitlines():
        match = CONFIG_SYMBOL.match(line.strip())
        if match:
            config_values[match.group("name")] = int(match.group("value"), 16)

    sym = dict(sym_rows)
    arithmetic: dict[str, str] = {}
    families = []
    for name, value in sym_rows:
        if not name.endswith("_size"):
            continue
        stem = name[:-5]
        needed = [stem + suffix for suffix in ("_obj", "_objend", "_org", "_orgend")]
        if not all(item in sym for item in needed):
            arithmetic[name] = "missing family member"
            continue
        obj, objend, org, orgend = (sym[item] for item in needed)
        issues = []
        if obj != org:
            issues.append("obj != org")
        if objend != orgend:
            issues.append("objend != orgend")
        if value != objend - obj:
            issues.append("size != objend - obj")
        arithmetic[name] = ", ".join(issues) or "exact"
        families.append((stem, obj, objend, value, arithmetic[name]))

    map_exact = sum(map_values.get(name) == {value} for name, value in sym_rows)
    map_missing = [(name, value) for name, value in sym_rows if name not in map_values]
    map_wrong = [
        (name, value, sorted(map_values[name]))
        for name, value in sym_rows
        if name in map_values and value not in map_values[name]
    ]
    config_exact = sum(config_values.get(name) == value for name, value in sym_rows)
    config_wrong = [
        (name, value, config_values[name])
        for name, value in sym_rows
        if name in config_values and config_values[name] != value
    ]

    cpe_loads = parse_cpe_loads()
    cpe_start = min(address for address, size in cpe_loads if size)
    cpe_end = max(address + size for address, size in cpe_loads if size)
    exe_header = EXE.read_bytes()[:0x800]
    exe_pc, exe_gp, exe_base, exe_size = struct.unpack_from("<IIII", exe_header, 0x10)

    print("# SYM opcode-1 linker/section audit")
    print()
    print(f"- Records: {len(sym_rows)}")
    print(f"- Exact independent NFS4.MAP name/address matches: {map_exact}/{len(sym_rows)}")
    print(f"- Missing from NFS4.MAP: {len(map_missing)}")
    print(f"- Address conflicts with NFS4.MAP: {len(map_wrong)}")
    print(f"- Complete obj/org/size families: {len(families)}")
    print(f"- Family arithmetic failures: {sum(status != 'exact' for status in arithmetic.values())}")
    print(f"- Exact optional configs/symbol_addrs.txt carriers: {config_exact}/{len(sym_rows)}")
    print(f"- Conflicting config carriers: {len(config_wrong)}")
    print(f"- Retail MAP sections: {len(map_sections)}")
    print(f"- CPE load commands: {len(cpe_loads)}")
    print(f"- CPE load span: 0x{cpe_start:08x}-0x{cpe_end:08x}")
    print(
        f"- PS-X EXE header: pc=0x{exe_pc:08x}, gp=0x{exe_gp:08x}, "
        f"load=0x{exe_base:08x}, "
        f"padded_size=0x{exe_size:x}, end=0x{exe_base + exe_size:08x}"
    )
    print()
    print("The MAP is the primary closure witness.  The CPE is not used as a")
    print("byte oracle: it contains an initial zero-fill plus later object loads")
    print("and does not reproduce the packaged executable by simple concatenation.")
    print()
    print("## Retail MAP section table")
    print()
    for section, start, end, size in map_sections:
        status = "exact" if end - start == size else "BAD SIZE"
        print(f"- `{section}`: 0x{start:08x}-0x{end:08x}, size 0x{size:x} ({status})")
    print()
    print("## Obj/org/size families")
    print()
    for stem, start, end, size, status in families:
        print(f"- `{stem}`: 0x{start:08x}-0x{end:08x}, size 0x{size:x} ({status})")
    print()
    print("## Per-record ledger")
    print()
    for name, value in sym_rows:
        map_status = "exact" if map_values.get(name) == {value} else (
            "missing" if name not in map_values else "CONFLICT"
        )
        if config_values.get(name) == value:
            config_status = "exact"
        elif name not in config_values:
            config_status = "not carried (optional linker-only symbol)"
        else:
            config_status = f"CONFLICT 0x{config_values[name]:08x}"
        role = "boundary"
        if name.endswith("_size"):
            role = "size; family " + arithmetic.get(name, "incomplete")
        elif name == "__SN_GP_BASE":
            role = "global-pointer base"
        elif name == "__SN_ENTRY_POINT":
            role = "entry point"
        print(
            f"- `{name}` = 0x{value:08x}: MAP {map_status}; "
            f"config {config_status}; {role}"
        )
    if map_missing or map_wrong or config_wrong:
        print()
        print("## Findings")
        print()
        for name, value in map_missing:
            print(f"- MAP missing `{name}` expected 0x{value:08x}")
        for name, value, values in map_wrong:
            print(f"- MAP conflict `{name}` expected 0x{value:08x}, has {values}")
        for name, value, actual in config_wrong:
            print(f"- Config conflict `{name}` expected 0x{value:08x}, has 0x{actual:08x}")


if __name__ == "__main__":
    main()

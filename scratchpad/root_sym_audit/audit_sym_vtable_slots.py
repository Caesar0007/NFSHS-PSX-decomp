"""Validate reconstructed vtable slots against raw retail words and symbols.

The table address/count comes from each reconstructed definition.  The source
slot comment is deliberately included in the check: it is the human-readable
retail target receipt next to the C++ expression that emits the relocation.
"""

from __future__ import annotations

import collections
import re
import struct
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
EXE = ROOT / "rom" / "nfs4-f.exe"
SYM = Path(r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt")


def main() -> None:
    config_by_va: dict[int, set[str]] = collections.defaultdict(set)
    config_text = (ROOT / "configs" / "symbol_addrs.txt").read_text(
        encoding="utf-8", errors="replace"
    )
    for name, va in re.findall(
        r"^\s*([A-Za-z_.$][A-Za-z0-9_.$]*)\s*=\s*0x([0-9a-fA-F]{8})\s*;",
        config_text,
        re.M,
    ):
        config_by_va[int(va, 16)].add(name)

    image = EXE.read_bytes()
    sym_vas = {
        int(va, 16)
        for va in re.findall(
            r"^\S+: [$]([0-9a-fA-F]{8}) 2 _vt[.][^\s]+$",
            SYM.read_text(encoding="utf-8", errors="replace"),
            re.M,
        )
    }
    definition = re.compile(
        r"__vtbl_ptr_type\s+([A-Za-z_]\w*)\s*\[(\d+)\]"
        r"(?:\s+__asm__\([^)]*\))?\s*=.*?"
        r"/\*\s*@0x([0-9a-fA-F]{8})"
    )
    slot = re.compile(
        r"^\s*\{\s*([^,]+),\s*([^,]+),\s*(.*?)\}\s*,?\s*"
        r"/\*\s*@0x([0-9a-fA-F]{8})\s+(.*?)\s*\*/"
    )

    table_count = 0
    sym_table_count = 0
    slot_count = 0
    sym_slot_count = 0
    issues: list[str] = []
    unknown_targets: list[str] = []
    extra_tables: list[str] = []
    for path in (ROOT / "recon").rglob("*.cpp"):
        lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
        index = 0
        while index < len(lines):
            match = definition.search(lines[index])
            if not match:
                index += 1
                continue
            table_count += 1
            table_name = match.group(1)
            expected_count = int(match.group(2))
            table_va = int(match.group(3), 16)
            is_sym_table = table_va in sym_vas
            if is_sym_table:
                sym_table_count += 1
            else:
                extra_tables.append(
                    f"{path.relative_to(ROOT)}:{index + 1} {table_name}[{expected_count}] "
                    f"@ 0x{table_va:08x}"
                )
            found = 0
            index += 1
            while index < len(lines) and not re.match(r"^\s*};", lines[index]):
                sm = slot.match(lines[index])
                if sm:
                    source_delta, _source_index, expr, slot_va_s, comment = sm.groups()
                    slot_va = int(slot_va_s, 16)
                    retail_off = 0x800 + (slot_va - 0x80010000)
                    retail_delta, retail_target = struct.unpack_from("<II", image, retail_off)
                    expected_slot_va = table_va + found * 8
                    where = f"{path.relative_to(ROOT)}:{index + 1} {table_name}[{found}]"
                    if slot_va != expected_slot_va:
                        issues.append(
                            f"{where}: comment VA 0x{slot_va:08x}, expected 0x{expected_slot_va:08x}"
                        )
                    try:
                        parsed_delta = int(source_delta.strip(), 0)
                    except ValueError:
                        parsed_delta = None
                    if parsed_delta is not None and parsed_delta & 0xFFFFFFFF != retail_delta:
                        issues.append(
                            f"{where}: source delta {source_delta.strip()}, retail 0x{retail_delta:08x}"
                        )
                    aliases = config_by_va.get(retail_target, set())
                    evidence = f"{expr} {comment}"
                    if retail_target == 0:
                        if not re.search(r"(?:\)|\b)0(?:\b|\})", expr):
                            issues.append(f"{where}: retail null target, source `{expr.strip()}`")
                    elif aliases:
                        # Exact linker spelling should occur either in an asm-labelled
                        # source expression or in the slot's retail-target comment.
                        normalized_aliases = {
                            re.sub(r"_800[0-9a-fA-F]{5}$", "", alias) for alias in aliases
                        }
                        has_raw_va_receipt = f"0x{retail_target:08x}" in evidence.lower()
                        if (not has_raw_va_receipt and
                                not any(alias in evidence for alias in normalized_aliases)):
                            # Destructor comments are demangled, but the expression is
                            # the exact ___<len><Class> symbol; aliases catches those.
                            issues.append(
                                f"{where}: retail 0x{retail_target:08x} aliases "
                                f"{sorted(aliases)!r}, evidence `{evidence.strip()}`"
                            )
                    else:
                        unknown_targets.append(
                            f"{where}: retail target 0x{retail_target:08x}, evidence `{evidence.strip()}`"
                        )
                    found += 1
                    slot_count += 1
                    if is_sym_table:
                        sym_slot_count += 1
                index += 1
            if found != expected_count:
                issues.append(
                    f"{path.relative_to(ROOT)}:{index + 1} {table_name}: "
                    f"parsed {found} slots, declared {expected_count}"
                )
            index += 1

    print("# Reconstructed vtable slot audit")
    print()
    print(f"- Tables parsed: {table_count}")
    print(f"- SYM-described tables parsed: {sym_table_count}/{len(sym_vas)}")
    print(f"- Slots parsed: {slot_count}")
    print(f"- Slots belonging to SYM-described tables: {sym_slot_count}")
    print(f"- Structural/target issues: {len(issues)}")
    print(f"- Retail targets absent from config map: {len(unknown_targets)}")
    print()
    print("## Issues")
    print()
    for issue in issues:
        print(f"- {issue}")
    print()
    print("## Unmapped retail targets")
    print()
    for issue in unknown_targets:
        print(f"- {issue}")
    print()
    print("## Reconstructed tables without opcode-2 `_vt.*` records")
    print()
    for issue in extra_tables:
        print(f"- {issue}")


if __name__ == "__main__":
    main()

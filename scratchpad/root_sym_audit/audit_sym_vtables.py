"""Cross-check SYM vtable linker records against reconstructed table definitions.

The opcode-2 `_vt.*` rows are authoritative names/addresses.  Reconstructed
tables are joined by their retail-VA comments, which avoids guessing how dots in
GCC-v2 nested-class names were sanitized for ELF/linker identifiers.
"""

from __future__ import annotations

import collections
import re
import struct
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
SYM = Path(r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt")
EXE = ROOT / "rom" / "nfs4-f.exe"


def main() -> None:
    sym_text = SYM.read_text(encoding="utf-8", errors="replace")
    sym_rows = [
        (int(va, 16), name)
        for va, name in re.findall(
            r"^\S+: [$]([0-9a-fA-F]{8}) 2 (_vt[.][^\s]+)$", sym_text, re.M
        )
    ]

    source_rows: dict[int, list[tuple[Path, int, str, int]]] = collections.defaultdict(list)
    definition = re.compile(
        r"__vtbl_ptr_type\s+([A-Za-z_]\w*)\s*\[(\d+)\]"
        r"(?:\s+__asm__\([^)]*\))?\s*=.*?"
        r"/\*\s*@0x([0-9a-fA-F]{8})",
    )
    for path in (ROOT / "recon").rglob("*.cpp"):
        for line_no, line in enumerate(
            path.read_text(encoding="utf-8", errors="replace").splitlines(), 1
        ):
            match = definition.search(line)
            if match:
                source_rows[int(match.group(3), 16)].append(
                    (path.relative_to(ROOT), line_no, match.group(1), int(match.group(2)))
                )

    config_by_va: dict[int, list[str]] = collections.defaultdict(list)
    config = (ROOT / "configs" / "symbol_addrs.txt").read_text(
        encoding="utf-8", errors="replace"
    )
    for name, va in re.findall(
        r"^\s*([A-Za-z_.$][A-Za-z0-9_.$]*)\s*=\s*0x([0-9a-fA-F]{8})\s*;",
        config,
        re.M,
    ):
        config_by_va[int(va, 16)].append(name)

    image = EXE.read_bytes() if EXE.exists() else b""
    print("# SYM vtable audit")
    print()
    print(f"- SYM opcode-2 vtable records: {len(sym_rows)}")
    print(f"- Unique vtable VAs: {len({va for va, _ in sym_rows})}")
    print(
        "- VAs with reconstructed array definitions: "
        f"{sum(va in source_rows for va, _ in sym_rows)}"
    )
    print(
        "- VAs present in configs/symbol_addrs.txt: "
        f"{sum(va in config_by_va for va, _ in sym_rows)}"
    )
    print()
    print("## Records")
    print()
    for va, sym_name in sym_rows:
        definitions = source_rows.get(va, [])
        configs = config_by_va.get(va, [])
        if definitions:
            rendered_defs = ", ".join(
                f"{path}:{line} {name}[{count}]" for path, line, name, count in definitions
            )
            count = definitions[0][3]
            slots = []
            file_offset = 0x800 + (va - 0x80010000)
            if 0 <= file_offset and file_offset + count * 8 <= len(image):
                for index in range(count):
                    delta_index, target = struct.unpack_from(
                        "<II", image, file_offset + index * 8
                    )
                    slots.append(f"{index}:{delta_index:08x}/{target:08x}")
            slot_text = " ".join(slots)
        else:
            rendered_defs = "MISSING"
            slot_text = ""
        config_text = ", ".join(configs) or "MISSING"
        print(
            f"- `{sym_name}` @ 0x{va:08x}; config `{config_text}`; "
            f"source {rendered_defs}"
        )
        if slot_text:
            print(f"  - raw slots: `{slot_text}`")


if __name__ == "__main__":
    main()

"""Compare reconstructed data-only ELF sections with the retail PS-X EXE.

Only relocation-free tables/storage are admitted here.  Relocated aggregate
objects (for example FEI_gList's pointers) need a linked-image/object-relocation
proof and are intentionally outside this byte-slice check.
"""

from __future__ import annotations

from pathlib import Path
import struct


ROOT = Path(__file__).resolve().parents[2]
RETAIL = ROOT / "rom/nfs4-f.exe"
LOAD_VA = 0x80010000
EXE_HEADER = 0x800

CASES = (
    ("FEColor.obj", "build/recon/frontend/common/fecolor.cpp.o", ".data", 0x800516C8),
    ("TABLE.obj", "build/recon/syslib/psx/libpress/TABLE.c.o", ".data", 0x80123838),
    ("SNDEF.obj", "build/recon/syslib/psx/libsn/SNDEF.c.o", ".data", 0x80136CD0),
    ("atantbl.obj", "build/recon/eaclib/psx/eacpsxz/atantbl.c.o", ".data", 0x80136CE8),
    ("CTYPE0.obj", "build/recon/syslib/psx/libc/CTYPE0.c.o", ".data", 0x801371D0),
    ("asintbl.obj", "build/recon/eaclib/psx/eacpsxz/asintbl.c.o", ".data", 0x80137260),
    ("sintbl.obj", "build/recon/eaclib/psx/eacpsxz/sintbl.c.o", ".data", 0x80137464),
    ("fatantbl.obj", "build/recon/eaclib/psx/eacpsxz/fatantbl.c.o", ".data", 0x80137868),
    ("CSTBL.obj", "build/recon/syslib/psx/libgte/CSTBL.c.o", ".data", 0x80137D20),
    ("isqrttbl.obj", "build/recon/eaclib/psx/eacpsxz/isqrttbl.c.o", ".data", 0x8013BE10),
    ("vars.obj", "build/recon/eaclib/psx/eacpsxz/vars.c.o", ".sdata", 0x8013DC64),
)


def elf_section(path: Path, wanted: str) -> bytes:
    data = path.read_bytes()
    if data[:4] != b"\x7fELF" or data[4] != 1 or data[5] != 1:
        raise ValueError(f"{path}: expected ELF32 little-endian object")
    section_offset = struct.unpack_from("<I", data, 0x20)[0]
    entry_size, count, strings_index = struct.unpack_from("<HHH", data, 0x2E)
    headers = [
        struct.unpack_from("<10I", data, section_offset + i * entry_size)
        for i in range(count)
    ]
    strings_header = headers[strings_index]
    strings = data[strings_header[4] : strings_header[4] + strings_header[5]]
    for header in headers:
        end = strings.find(b"\0", header[0])
        name = strings[header[0] : end].decode("ascii", errors="replace")
        if name == wanted:
            return data[header[4] : header[4] + header[5]]
    raise ValueError(f"{path}: no {wanted} section")


def main() -> None:
    retail = RETAIL.read_bytes()
    print("# Data-only object payload audit")
    print()
    print("| member | reconstructed section | retail VA | bytes | differing bytes |")
    print("|---|---|---:|---:|---:|")
    failures = 0
    for member, relative, section, va in CASES:
        ours = elf_section(ROOT / relative, section)
        offset = EXE_HEADER + va - LOAD_VA
        oracle = retail[offset : offset + len(ours)]
        diffs = sum(a != b for a, b in zip(ours, oracle))
        if len(oracle) != len(ours):
            diffs += abs(len(ours) - len(oracle))
        failures += bool(diffs)
        print(
            f"| `{member}` | `{section}` | `0x{va:08X}` | "
            f"`0x{len(ours):X}` | {diffs} |"
        )
    print()
    print(f"Result: {'PASS' if not failures else 'FAIL'} ({failures} failing members)")
    raise SystemExit(1 if failures else 0)


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Generate splat symbol_addrs.txt from the original PSYLINK map (NFS4.MAP).

The map's "Names in address order" table is the authoritative VA->name source
(it is a subset/superset cross-checked against the dumpsym SYM v3 database).
We classify each symbol as a function when its VA lands in an executable
section, else as a plain data label.  Section bounds come from the map's
section table (main `text` group + `front` overlay group).
"""
import re
import sys

MAP = sys.argv[1] if len(sys.argv) > 1 else r"C:\Temp\nfs4-clean\NFS4.MAP"
OUT = sys.argv[2] if len(sys.argv) > 2 else r"C:\Temp\nfs4-decomp\configs\symbol_addrs.txt"

# Executable VA ranges (inclusive) — anything here is a function start.
TEXT_RANGES = [
    (0x8005797C, 0x8010CCD3),  # main .text
    (0x800128F0, 0x8005125F),  # front overlay .text
]


def is_func(va):
    return any(lo <= va <= hi for lo, hi in TEXT_RANGES)


def main():
    lines = open(MAP, "r", errors="replace").read().splitlines()
    # locate the "Names in address order" table
    try:
        start = next(i for i, l in enumerate(lines) if "address order" in l)
    except StopIteration:
        sys.exit("could not find 'Names in address order' in map")

    def sanitize(name):
        # cfront/PSYLINK names contain chars illegal in C identifiers
        # (destructors `_._`, vtables `_vt.`). Byte-matching only depends on
        # addresses, not label spelling, so fold illegal chars to `_`.
        return re.sub(r"[^0-9A-Za-z_]", "_", name)

    seen = {}  # va -> first name (address-order table lists aliases; keep first)
    order = []
    row = re.compile(r"^\s*([0-9A-Fa-f]{8})\s+(\S+)\s*$")
    for l in lines[start + 1:]:
        m = row.match(l)
        if not m:
            continue
        va = int(m.group(1), 16)
        name = m.group(2)
        if not (0x80010000 <= va <= 0x80148B04):
            continue  # linker size-constants / out-of-image pseudo-symbols
        if va not in seen:
            seen[va] = sanitize(name)
            order.append(va)
        # else: alias at same VA (e.g. _bss_orgend) -> skip, keep canonical first

    order.sort()
    # disambiguate name collisions produced by sanitization AND
    # case-insensitive collisions (Windows: CD_init vs CD_Init share a file).
    used = {}  # lowercased name -> va
    for va in order:
        nm = seen[va]
        if nm.lower() in used and used[nm.lower()] != va:
            seen[va] = f"{nm}_{va:08X}"
        used[seen[va].lower()] = va

    nfunc = ndata = 0
    with open(OUT, "w") as f:
        f.write("// Auto-generated from NFS4.MAP by tools/gen_symbols.py\n")
        f.write("// Edit symbol *names* here; re-run only regenerates from map.\n\n")
        for va in order:
            name = seen[va]
            if is_func(va):
                f.write(f"{name} = 0x{va:08X}; // type:func\n")
                nfunc += 1
            else:
                f.write(f"{name} = 0x{va:08X};\n")
                ndata += 1
    print(f"wrote {OUT}: {len(order)} symbols ({nfunc} func, {ndata} data)")


if __name__ == "__main__":
    main()

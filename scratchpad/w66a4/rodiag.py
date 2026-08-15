#!/usr/bin/env python3
"""W66-A4  rodiag.py -- per-object `.rodata` window diagnosis.

For one recon object: print its `.rodata` byte-by-byte against retail at the
jump-table-implied base, marking every relocated word, every blob record
boundary inside the window, and every differing byte -- the instrument for the
"our .rodata is short/long against the blob span" question (the camera 44-vs-45
case) and for every E5 failure.

  python scratchpad/w66a4/rodiag.py <substring of the object path> [--words N]
"""
import json
import re
import struct
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
FBASE = 0x8000F800

sys.path.insert(0, str(HERE))
sys.path.insert(0, str(ROOT / "tools"))
import rodownmap as R  # noqa: E402
import vamap  # noqa: E402


def main():
    pat = sys.argv[1]
    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    names, _ = vamap.build()
    blobs = R.load_records()
    allrecs = sorted((r for stem, _, _ in R.BLOBS for r in blobs[stem]),
                     key=lambda r: r["va"])
    objdata = json.load(open(HERE / "objdata.json"))

    vas, dup = {}, set()
    for ln in open(ROOT / "configs" / "symbol_addrs.txt", errors="replace"):
        m = re.match(r"(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func", ln)
        if m:
            n, v = m.group(1), int(m.group(2), 16)
            if n in vas and vas[n] != v:
                dup.add(n)
            vas.setdefault(n, v)
    for n in dup:
        del vas[n]
    tbases = R.implied_text_bases(objdata, vas)

    rows = json.load(open(HERE / "rodownmap_all.json"))
    hits = [r for r in rows if pat in r["obj"]]
    assert hits, f"no anchored object matching {pat!r}"
    for row in hits:
        o = row["obj"]
        ob = bytearray(R.rodata_bytes([o])[o])
        base, size = row["base"], row["size"]
        print(f"\n===== {o}")
        print(f"  .rodata {size} B, implied base {base:#x}..{base+size:#x}")
        print(f"  anchored regions: {row['regions']}  bases={row['nbases']}")

        relmap = {}
        for rl in objdata[o]["relocs"]:
            if rl["sec"] != ".rodata":
                continue
            relmap[rl["off"]] = (rl["type"], rl["val"])
        # resolve
        for off, (typ, val) in sorted(relmap.items()):
            if typ != "R_MIPS_32" or off + 4 > len(ob):
                continue
            tgt = val.split("+")[0].strip()
            b0 = (tbases.get(o) if tgt == ".text" else
                  base if tgt == ".rodata" else names.get(tgt))
            if b0 is None:
                continue
            ad = struct.unpack_from("<I", ob, off)[0]
            struct.pack_into("<I", ob, off, (b0 + ad) & 0xFFFFFFFF)

        recstart = {r["va"]: r["name"] for r in allrecs}
        nd = 0
        for off in range(0, size, 4):
            va = base + off
            ours = ob[off:off + 4]
            theirs = rom[va - FBASE:va - FBASE + 4]
            mark = "" if ours == theirs else "   <-- DIFF"
            if ours != theirs:
                nd += 1
            lbl = recstart.get(va, "")
            rel = relmap.get(off)
            reltag = f" [{rel[0]} {rel[1]}]" if rel else ""
            print(f"  +{off:04x} {va:#010x} ours={ours.hex()} "
                  f"retail={theirs.hex()}{reltag}"
                  + (f"   {lbl}" if lbl else "") + mark)
        print(f"  differing words: {nd} of {size // 4}")
        nxt = [r for r in allrecs if r["va"] >= base + size]
        if nxt:
            print(f"  next blob record after window: {nxt[0]['name']} "
                  f"@{nxt[0]['va']:#x}")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""W64-A18  E4 DIAGNOSTIC: for every blob window, say EXACTLY why the end edge
is not a blob-label boundary, and what would fix it.

E4 (ownmap) = base in bounds and end in bounds and size > 0, where bounds is
the set of blob-record VAs plus the blob end.  A window whose ONLY blocker is
E4 is normally "our section is short by its TAIL DATUM": the recon TU emits
N-1 of the retail run's N objects, so our section size lands mid-record.

For each window this prints:
    base, our end, the record `end` falls inside (or the gap it falls in),
    the next boundary above `end` and the byte delta,
    the blob records between `end` and that boundary (the MISSING TAIL),
    whether each such record is already defined by some recon TU.

Usage:
  python scratchpad/w64a18/e4diag.py --blob scratchpad/w63a19/ctl_blob/data_8010CCD4.data.s --end 0x8013C54C
"""
import argparse
import re
import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import blobparse  # noqa: E402
import ownmap  # noqa: E402

ROOT = Path(__file__).resolve().parents[2]
FBASE = 0x8000F800
DRX = re.compile(r"^D_[0-9A-Fa-f]{8}$")
DATA_SECS = (".sdata", ".sbss", ".data", ".bss", ".rodata")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--blob", required=True)
    ap.add_argument("--end", required=True)
    ap.add_argument("--out", default="scratchpad/w64a18/e4diag.txt")
    a = ap.parse_args()

    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    nl, header, recs = blobparse.load(ROOT / a.blob, int(a.end, 16))
    by_name = {r["name"]: r for r in recs}
    bounds = {r["va"] for r in recs} | {recs[-1]["end"]}

    objs = sorted((ROOT / "build" / "recon").rglob("*.o"))
    data = ownmap.dump_objects(objs)

    wins = defaultdict(list)
    tu_defined = set()
    for obj, d in data.items():
        for name, sec, off, glob in d["syms"]:
            if name in by_name and sec in DATA_SECS:
                wins[(obj, sec)].append((name, off))
                tu_defined.add(name)

    L = []
    L.append(f"# W64-A18 E4 diagnostic  blob={a.blob}")
    L.append(f"# records={len(recs)}  TU-defined={len(tu_defined)}  "
             f"windows={len(wins)}")
    L.append("")
    rows = []
    for (obj, sec), members in sorted(wins.items()):
        bases = defaultdict(list)
        for name, off in members:
            bases[by_name[name]["va"] - off].append(name)
        base = max(bases.items(), key=lambda kv: len(kv[1]))[0]
        size = data[obj]["secs"].get(sec, 0)
        end = base + size
        inwin = [r for r in recs if base <= r["va"] < end]
        mine = {n for n, _ in members}
        foreign = [r["name"] for r in inwin
                   if r["name"] not in mine and r["name"] in tu_defined]
        unmig = [r["name"] for r in inwin
                 if r["name"] not in mine and r["name"] not in tu_defined
                 and not (DRX.match(r["name"]) and r["va"] > base)]
        outside = [n for n in mine if not (base <= by_name[n]["va"] < end)]
        e3 = len(bases) == 1
        e4b, e4e = base in bounds, end in bounds
        rb = rom[base - FBASE:end - FBASE]
        ob = bytes(data[obj]["bytes"].get(sec, b""))
        if sec in (".bss", ".sbss"):
            ob = b"\x00" * size
        e5 = (len(ob) == size and rb == ob)
        if e4b and e4e:
            continue
        # where does `end` land?
        nxt = min((b for b in bounds if b >= end), default=None)
        prv = max((b for b in bounds if b <= end), default=None)
        tail = [r for r in recs if end <= r["va"] < (nxt if nxt else end)]
        # what's between prv and nxt (the record end falls inside)
        host = next((r for r in recs if r["va"] <= end < r["end"]), None)
        blockers = []
        if not e3:
            blockers.append(f"E3x{len(bases)}")
        if foreign:
            blockers.append(f"E1f x{len(foreign)}")
        if unmig:
            blockers.append(f"E1u x{len(unmig)}")
        if outside:
            blockers.append(f"E2 x{len(outside)}")
        if not e5:
            nd = sum(1 for x, y in zip(rb, ob) if x != y) + abs(len(rb) - len(ob))
            blockers.append(f"E5 {nd}/{size}")
        only_e4 = not blockers
        rows.append((only_e4, base, end, size, obj, sec))
        L.append(f"{base:#010x}..{end:#010x} {size:6d} {sec:<7} {obj}")
        L.append(f"      E4: base_on_boundary={e4b}  end_on_boundary={e4e}")
        if host is not None:
            L.append(f"      end falls INSIDE record {host['name']} "
                     f"({host['va']:#x}..{host['end']:#x}, {host['end']-host['va']} B)")
        if nxt is not None:
            L.append(f"      next boundary {nxt:#010x}  (+{nxt-end} bytes)")
        if prv is not None and prv != end:
            L.append(f"      prev boundary {prv:#010x}  (-{end-prv} bytes)")
        # records between our end and the next TU-owned or foreign start
        follow = [r for r in recs if r["va"] >= (host["va"] if host else end)][:6]
        for r in follow:
            tag = "TU" if r["name"] in tu_defined else ("D_" if DRX.match(r["name"]) else "--")
            mineflag = "*" if r["name"] in mine else " "
            L.append(f"        {mineflag}{tag} {r['va']:#010x}..{r['end']:#010x} "
                     f"{r['end']-r['va']:6d}  {r['name']}")
        L.append(f"      other blockers: {', '.join(blockers) if blockers else 'NONE (E4-ONLY)'}")
        L.append("")

    only = [r for r in rows if r[0]]
    L.append(f"windows failing E4: {len(rows)}   of which E4-ONLY: {len(only)}")
    for r in sorted(only, key=lambda x: -x[3]):
        L.append(f"   E4-ONLY  {r[1]:#010x}..{r[2]:#010x} {r[3]:6d} {r[5]:<7} {r[4]}")
    (ROOT / a.out).write_text("\n".join(L) + "\n")
    print("\n".join(L[-30:]))
    print(f"-> {a.out}")


if __name__ == "__main__":
    main()

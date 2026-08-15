#!/usr/bin/env python3
"""W64-A18  E5 DIAGNOSTIC: for every blob window, show WHICH BYTES differ from
retail, attributed to the blob label that owns them.

ownmap's E5 leg is the anti-vacuity gate (retail bytes == our section bytes).
When it fails, the window is not an ownership problem at all -- it is a
DATA-MATERIALISATION defect (methodology sec.2 step 4b).  This tool turns the
"N of M bytes differ" summary into an actionable per-datum list:

    label            VA range          nbytes  retail hex      ours hex

Usage:
  python scratchpad/w64a18/e5diag.py --blob scratchpad/w63a19/ctl_blob/data_8010CCD4.data.s --end 0x8013C54C
  ... --only build/recon/game/psx/flare.cpp.o
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
    ap.add_argument("--only", default=None)
    ap.add_argument("--out", default="scratchpad/w64a18/e5diag.txt")
    ap.add_argument("--maxrun", type=int, default=64)
    a = ap.parse_args()

    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    nl, header, recs = blobparse.load(ROOT / a.blob, int(a.end, 16))
    by_name = {r["name"]: r for r in recs}

    objs = sorted((ROOT / "build" / "recon").rglob("*.o"))
    if a.only:
        objs = [o for o in objs
                if str(o.relative_to(ROOT)).replace("\\", "/") == a.only]
        assert objs, a.only
    data = ownmap.dump_objects(objs)

    wins = defaultdict(list)
    for obj, d in data.items():
        for name, sec, off, glob in d["syms"]:
            if name in by_name and sec in DATA_SECS:
                wins[(obj, sec)].append((name, off))

    L = [f"# W64-A18 E5 diagnostic  blob={a.blob}", ""]
    for (obj, sec), members in sorted(wins.items()):
        bases = defaultdict(list)
        for name, off in members:
            bases[by_name[name]["va"] - off].append(name)
        base = max(bases.items(), key=lambda kv: len(kv[1]))[0]
        size = data[obj]["secs"].get(sec, 0)
        end = base + size
        rb = rom[base - FBASE:end - FBASE]
        ob = bytes(data[obj]["bytes"].get(sec, b""))
        if sec in (".bss", ".sbss"):
            ob = b"\x00" * size
        if len(ob) != size:
            L.append(f"{obj} {sec}: objdump gave {len(ob)} bytes for a "
                     f"{size}-byte section -- SKIP")
            continue
        if rb == ob:
            continue
        diffs = [i for i in range(size) if rb[i] != ob[i]]
        L.append(f"{base:#010x}..{end:#010x} {size:6d} {sec:<7} {obj}")
        L.append(f"      {len(diffs)} differing bytes")
        # group contiguous runs
        runs = []
        s = diffs[0]
        p = diffs[0]
        for i in diffs[1:]:
            if i == p + 1:
                p = i
                continue
            runs.append((s, p))
            s = p = i
        runs.append((s, p))
        for (s, e) in runs[:60]:
            va0, va1 = base + s, base + e + 1
            owner = None
            for r in recs:
                if r["va"] <= va0 < r["end"]:
                    owner = r
                    break
            oname = owner["name"] if owner else "?"
            n = min(e - s + 1, a.maxrun)
            L.append(f"        {va0:#010x}..{va1:#010x} {e-s+1:5d} B  in {oname}"
                     f" (+{va0 - (owner['va'] if owner else va0):#x})")
            L.append(f"            retail {rb[s:s+n].hex(' ')}"
                     + (" ..." if e - s + 1 > n else ""))
            L.append(f"            ours   {ob[s:s+n].hex(' ')}"
                     + (" ..." if e - s + 1 > n else ""))
        if len(runs) > 60:
            L.append(f"        ... {len(runs)-60} more runs")
        L.append("")
    (ROOT / a.out).write_text("\n".join(L) + "\n")
    print("\n".join(L[:200]))
    print(f"-> {a.out}")


if __name__ == "__main__":
    main()

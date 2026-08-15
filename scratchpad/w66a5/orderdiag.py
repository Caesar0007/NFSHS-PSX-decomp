#!/usr/bin/env python3
"""W64-A18  E3 DIAGNOSTIC: our data-section symbol ORDER vs retail's VA order.

E3 (ownmap) fails when a TU's blob labels do not agree on ONE implied base --
i.e. our section emits them in a different ORDER (or with different sizes) than
retail.  The dominant cause found in region 1: a TENTATIVE DEFINITION (`u_int
x;`, no initialiser) is emitted AFTER the initialised objects, while retail
holds all of them in one declaration run.  Adding an explicit `= 0` puts the
object back in declaration order in the same section (proven on fastrand.cpp:
3 implied bases -> 1, window OWN).

Prints, per (obj, section): our offset, implied base, retail VA, the retail
order, and whether the symbol's bytes are all-zero in retail (a `= 0`
candidate).

  python scratchpad/w64a18/orderdiag.py --blob <ctl blob> --end 0xVA --only <obj>
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
DATA_SECS = (".sdata", ".sbss", ".data", ".bss", ".rodata")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--blob", required=True)
    ap.add_argument("--end", required=True)
    ap.add_argument("--only", action="append", required=True)
    ap.add_argument("--out", default="scratchpad/w64a18/orderdiag.txt")
    a = ap.parse_args()

    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    nl, header, recs = blobparse.load(ROOT / a.blob, int(a.end, 16))
    by_name = {r["name"]: r for r in recs}

    objs = [ROOT / o for o in a.only]
    for o in objs:
        assert o.exists(), o
    data = ownmap.dump_objects(objs)

    L = []
    for obj, d in sorted(data.items()):
        secs = defaultdict(list)
        for name, sec, off, glob in d["syms"]:
            if name in by_name and sec in DATA_SECS:
                secs[sec].append((off, name))
        for sec, members in sorted(secs.items()):
            size = d["secs"].get(sec, 0)
            L.append(f"== {obj} [{sec}] size {size} ({len(members)} blob labels)")
            bases = defaultdict(list)
            for off, name in members:
                bases[by_name[name]["va"] - off].append(name)
            base = max(bases.items(), key=lambda kv: len(kv[1]))[0]
            L.append(f"   majority implied base {base:#010x}  ({len(bases)} distinct)")
            L.append(f"   {'ouroff':>7} {'implied':>10} {'retailVA':>10} "
                     f"{'rsize':>6} {'zero':>4}  name")
            for off, name in sorted(members):
                r = by_name[name]
                rb = rom[r['va'] - FBASE:r['end'] - FBASE]
                z = "yes" if set(rb) <= {0} else "no"
                flag = "" if r["va"] - off == base else "   <-- DRIFT"
                L.append(f"   {off:7d} {r['va']-off:#010x} {r['va']:#010x} "
                         f"{r['end']-r['va']:6d} {z:>4}  {name}{flag}")
            L.append("   retail VA order: "
                     + " ".join(n for _, n in
                                sorted(((by_name[n]['va'], n) for _, n in members))))
            L.append("   our  offset order: "
                     + " ".join(n for _, n in sorted(members)))
            L.append("")
    (ROOT / a.out).write_text("\n".join(L) + "\n")
    print("\n".join(L))
    print(f"-> {a.out}")


if __name__ == "__main__":
    main()

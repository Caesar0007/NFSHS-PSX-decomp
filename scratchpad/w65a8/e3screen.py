#!/usr/bin/env python3
"""W65-A8  E3 SCREEN -- price the `= 0` / declaration-order lever BEFORE editing.

ownmap's E3 leg fails when a TU's blob labels imply more than one base, i.e.
our data section emits them in a different ORDER than retail.  W64-A18 found
the dominant cause (16E "the =0 pair"): a TENTATIVE definition is emitted after
every initialised object of the same section, so retail's interleaved run comes
out of our build as "all initialised, then all zero".

This screen answers, per (obj, section), WITHOUT touching a source file:

  Z  how many of our labels are all-zero in retail (the `= 0` candidates)
  P  PERMUTATION-ONLY?   our label SET sorted by retail VA is exactly retail's
                         order and retail's record sizes for our labels TILE
                         our section size with no gap  ->  reordering alone
                         (which the `= 0` lever performs) yields ONE base
  H  HOLE               retail's run contains a label we do NOT define at that
                        point, or our size does not tile: reordering cannot be
                        enough (a -G identity / migration / foreign issue)

Only `P` rows are cheap, codegen-inert wins.  Everything else needs the
heavier lever named in the report.

  python scratchpad/w65a8/e3screen.py --blob <ctl blob> --end 0xVA
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
DRX = re.compile(r"^D_[0-9A-Fa-f]{8}$")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--blob", required=True)
    ap.add_argument("--end", required=True)
    ap.add_argument("--out", required=True)
    a = ap.parse_args()

    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    _, _, recs = blobparse.load(ROOT / a.blob, int(a.end, 16))
    by_name = {r["name"]: r for r in recs}
    ordered = sorted(recs, key=lambda r: r["va"])
    idx = {r["name"]: i for i, r in enumerate(ordered)}

    objs = sorted((ROOT / "build" / "recon").rglob("*.o"))
    assert objs, "vacuous: no recon objects"
    data = ownmap.dump_objects(objs)

    rows = []
    for obj, d in sorted(data.items()):
        secs = defaultdict(list)
        for name, sec, off, glob in d["syms"]:
            if name in by_name and sec in DATA_SECS:
                secs[sec].append((off, name))
        for sec, members in sorted(secs.items()):
            if len(members) < 2:
                continue
            size = d["secs"].get(sec, 0)
            bases = {by_name[n]["va"] - o for o, n in members}
            if len(bases) < 2:
                continue                      # not an E3 window
            names = [n for _, n in members]
            byva = sorted(names, key=lambda n: by_name[n]["va"])
            # retail must hold OUR labels as one uninterrupted run.  ownmap
            # ABSORBS splat `D_<VA>` interior labels (its correction C), so a
            # D_ record between two of ours is NOT a run gap -- excluding them
            # keeps this screen and the ownership gate on the same rule.
            pos = [idx[n] for n in byva]
            mine = set(names)
            contiguous = all(r["name"] in mine or DRX.match(r["name"])
                             for r in ordered[pos[0]:pos[-1] + 1])
            # ... and their retail record sizes must tile our section exactly.
            # W65-A8 SOUNDNESS FIX: the SUM of our labels' retail record sizes
            # must equal BOTH our section size AND the retail span.  Comparing
            # the span alone to the section size is UNSOUND -- r3dcar.cpp
            # passed that test while retail holds a 96-byte FOREIGN run in the
            # middle of its label set (the two errors cancelled exactly).
            span = (by_name[byva[-1]]["end"] - by_name[byva[0]]["va"])
            recsum = sum(by_name[n]["end"] - by_name[n]["va"] for n in names)
            tiles = (span == recsum == size)
            z = sum(1 for n in names
                    if set(rom[by_name[n]["va"] - FBASE:
                               by_name[n]["end"] - FBASE]) <= {0})
            verdict = ("P PERMUTATION-ONLY" if contiguous and tiles
                       else "H " + ("run-gap" if not contiguous else "")
                       + (" size-gap" if not tiles else ""))
            rows.append((len(bases), obj, sec, size, len(names), z,
                         span, verdict))

    rows.sort(key=lambda r: (0 if r[7].startswith("P") else 1, -r[0]))
    L = [f"{'bases':>5} {'sec':<7} {'size':>6} {'lbls':>4} {'zero':>4} "
         f"{'retailspan':>10}  verdict / object", "-" * 100]
    for b, obj, sec, size, n, z, span, v in rows:
        L.append(f"{b:5d} {sec:<7} {size:6d} {n:4d} {z:4d} {span:10d}  "
                 f"{v:<22} {obj}")
    npm = sum(1 for r in rows if r[7].startswith("P"))
    L += ["", f"E3 windows: {len(rows)}   PERMUTATION-ONLY (cheap `=0` "
              f"candidates): {npm}   needing a heavier lever: {len(rows)-npm}"]
    (ROOT / a.out).write_text("\n".join(L) + "\n")
    print("\n".join(L))


if __name__ == "__main__":
    main()

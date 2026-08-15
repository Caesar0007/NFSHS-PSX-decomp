#!/usr/bin/env python3
"""W66-A4  mkplace.py -- turn the .rodata ownmap into a PLACEMENT LIST.

Two different questions, deliberately kept apart:

  OWNERSHIP (rodownmap E1-E5) answers "may the recon TU's .rodata REPLACE the
  splat blob's bytes over this window" -- it is the gate for CUTTING the blob.

  PLACEMENT answers "at which VA must this object's .rodata be linked so that
  its jump table lands where retail's does" -- that is decided by the ANCHOR
  alone (E3: one consistent implied base).  A TU whose .rodata content is a
  near-miss (E5 red) still needs its table at the retail VA, because the
  `%hi/%lo(.rodata+N)` relocations in its .text resolve through the section
  base and are otherwise wrong in every switch dispatch.

  --tier own    : only E1-E5-clean windows          (the conservative set)
  --tier e3     : every E3-consistent anchor        (the placement set)

Overlaps are reported and resolved by dropping the LATER (higher-base) window
of any overlapping pair -- never silently.
"""
import argparse
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--tier", choices=("own", "e3"), default="e3")
    ap.add_argument("--out", default=str(HERE / "rodata_placement.json"))
    ap.add_argument("--allow-overlap", action="store_true",
                    help="keep overlapping windows (the probe tolerates them; "
                         "a real .ld region does not)")
    a = ap.parse_args()

    rows = json.load(open(HERE / "rodownmap_all.json"))
    if a.tier == "own":
        sel = [r for r in rows if r["ok"]]
    else:
        sel = [r for r in rows if r["e3"]]
    sel.sort(key=lambda r: r["base"])

    # 🔴 OVERLAP RESOLUTION BY TRUST, not by address order.  A low-address
    # window whose base is WRONG (fixdatan: its 1032-byte table lives in a
    # different retail run than its jump table -- the `.rodata` SPLIT-STORAGE
    # class) swallows a dozen correct neighbours if the pruner simply keeps the
    # first.  Windows are therefore accepted in descending order of PROOF
    # STRENGTH; a lower-trust window that collides with an accepted one is
    # dropped and named.
    def trust(r):
        return (3 if r["ok"] else
                2 if r["e5"] else
                1 if r["anchor"] == "jtbl" else 0)

    kept, dropped = [], []
    for r in sorted(sel, key=lambda r: (-trust(r), r["size"], r["base"])):
        clash = next((k for k in kept
                      if r["base"] < k["end"] and k["base"] < r["end"]), None)
        if clash is not None and not a.allow_overlap:
            dropped.append((r, clash))
            continue
        kept.append(r)
    kept.sort(key=lambda r: r["base"])
    assert kept, "empty placement list -- refusing a vacuous probe"
    print(f"tier={a.tier}  candidates={len(sel)}  placed={len(kept)}  "
          f"dropped(overlap)={len(dropped)}")
    for r, k in dropped:
        print(f"   OVERLAP-DROPPED {r['base']:#010x}..{r['end']:#010x} "
              f"trust={trust(r)} {r['obj']}\n"
              f"                 clashes with {k['base']:#010x}..{k['end']:#010x} "
              f"trust={trust(k)} {k['obj']}")
    json.dump([dict(obj=r["obj"], base=r["base"], end=r["end"],
                    size=r["size"], ok=r["ok"], regions=r["regions"])
               for r in kept], open(a.out, "w"), indent=1)
    print(f"-> {a.out}")


if __name__ == "__main__":
    main()

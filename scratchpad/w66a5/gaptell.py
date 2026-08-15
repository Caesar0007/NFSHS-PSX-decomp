"""gaptell.py -- decode the INTERIOR GAPS that block a TU's data window (W66-A5).

Every region-1 E3 row I sampled turned out NOT to be an ordering problem: after
the extern-order law is applied the labels still disagree on a base, because
retail's run contains objects we never emit into that section at all.  This
prints, per (obj, section), the blob records that lie inside the TU's retail
span but are not defined by the TU, with their retail bytes decoded -- which
identifies the class immediately:

  * 1..8 printable bytes + NUL padding to 8  -> a -G8 STRING LITERAL tell
    (retail built with -G8 keeps <=8-byte literals in .sdata; our -G4 build
    puts them in .rodata, leaving exactly that hole).
  * all-zero 4/8 B  -> an un-migrated scalar / file-static.
  * anything else   -> decode by hand.

  python scratchpad/w66a5/gaptell.py --blob <ctl> --end 0xVA --only <obj.o> ...
"""
import argparse
import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import blobparse  # noqa: E402
import ownmap  # noqa: E402

ROOT = Path(__file__).resolve().parents[2]
FBASE = 0x8000F800
DATA_SECS = (".sdata", ".sbss", ".data", ".bss", ".rodata")


def classify(b):
    if not any(b):
        return "all-zero (un-migrated scalar / file-static)"
    txt = b.split(b"\x00", 1)[0]
    if txt and all(32 <= c < 127 for c in txt) and not any(b[len(txt):]):
        return f'STRING "{txt.decode()}"  -> -G8 LITERAL TELL'
    return "data: " + b.hex()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--blob", required=True)
    ap.add_argument("--end", required=True)
    ap.add_argument("--only", nargs="+", required=True)
    a = ap.parse_args()

    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    _, _, recs = blobparse.load(ROOT / a.blob, int(a.end, 16))
    by_name = {r["name"]: r for r in recs}
    data = ownmap.dump_objects([ROOT / o for o in a.only])

    for obj, d in sorted(data.items()):
        secs = defaultdict(list)
        for name, sec, off, glob in d["syms"]:
            if name in by_name and sec in DATA_SECS:
                secs[sec].append((off, name))
        for sec, members in sorted(secs.items()):
            mine = {n for _, n in members}
            vas = sorted(by_name[n]["va"] for n in mine)
            lo, hi = vas[0], max(by_name[n]["end"] for n in mine)
            gaps = [r for r in recs if lo <= r["va"] < hi and r["name"] not in mine]
            tot = sum(r["end"] - r["va"] for r in gaps)
            print(f"== {obj} [{sec}] our size {d['secs'].get(sec, 0)}  "
                  f"retail span {lo:#x}..{hi:#x} ({hi - lo} B)  "
                  f"{len(gaps)} foreign/un-migrated records, {tot} B")
            for r in gaps:
                n = r["end"] - r["va"]
                b = rom[r["va"] - FBASE:r["end"] - FBASE]
                print(f"   {r['va']:#010x} {n:3d} B  {r['name']:<22s} {classify(b)}")


main()

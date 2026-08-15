"""objruns.py -- per-.obj DATA runs in a VA window, straight from the SYM.

Uses symown's FILE-record block segmentation to print, for every object that
owns at least one data symbol in [lo,hi), its symbols in VA order -- i.e. the
retail emission order the extern-order law has to reproduce.

  python scratchpad/w66a5/objruns.py --lo 0x800514b4 --hi 0x80052b38
"""
import argparse
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import importlib.util

spec = importlib.util.spec_from_file_location(
    "symown_mod", str(Path(__file__).resolve().parent / "symown.py"))


def load_blocks():
    """re-implement symown.blocks() without running its __main__."""
    import re
    SYM = Path(r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt")
    DEF = re.compile(r"^[0-9a-f]+: \$([0-9a-f]{8}) (?:94 Def|96 Def2) class (\S+) (.*?)name (\S+)\s*$")
    FILEREC = re.compile(r"^[0-9a-f]+: \$[0-9a-f]{8} 94 Def class FILE type NULL size 0 name (\S+)")
    cur, out = [], []
    for ln in SYM.read_text(errors="replace").splitlines():
        m = FILEREC.match(ln)
        if m:
            out.append((m.group(1), cur))
            cur = []
            continue
        m = DEF.match(ln)
        if m and m.group(2) in ("EXT", "STAT"):
            cur.append((int(m.group(1), 16), m.group(2), m.group(3).strip(),
                        m.group(4)))
    if cur:
        out.append(("<tail>", cur))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--lo", required=True)
    ap.add_argument("--hi", required=True)
    a = ap.parse_args()
    lo, hi = int(a.lo, 16), int(a.hi, 16)
    rows = []
    for obj, recs in load_blocks():
        data = [r for r in recs if lo <= r[0] < hi and "FCN" not in r[2]]
        stat = [r for r in recs if r[0] < 0x1000 and r[1] == "STAT"
                and "FCN" not in r[2]]
        if data:
            rows.append((min(r[0] for r in data), obj, sorted(data), stat))
    rows.sort()
    for base, obj, data, stat in rows:
        print(f"== {obj}   first {base:#010x}  last {max(r[0] for r in data):#010x}")
        for va, cls, desc, name in data:
            print(f"     {va:#010x} {cls:<4s} {name:<38s} {desc}")
        for va, cls, desc, name in stat:
            print(f"     +{va:#06x}   STAT (obj-relative) {name:<26s} {desc}")


main()

"""symown.py -- THE OBJECT-ATTRIBUTION ORACLE for data labels (W66-A5).

The trusted SYM (`nfs4-f-v3.txt`) emits one symbol block per linked object and
TERMINATES each block with a `Def class FILE type NULL ... name <foo>.obj`
record.  Every `Def`/`Def2 class EXT|STAT` record that precedes a FILE record
(and follows the previous one) therefore belongs to THAT object -- which makes
the SYM an authoritative VA -> owning-.obj map for DATA, not just for code.

Discovered while deciding whether `gShowroomLights` @0x800514b4 belonged to
FEApp.obj (it is adjacent to FEApp's run) -- it does not, it is the last EXT of
fe3dmenu.obj.  Geometry alone cannot answer that; this can.

  python scratchpad/w66a5/symown.py --lo 0x800514b0 --hi 0x800514d0
  python scratchpad/w66a5/symown.py --obj FEApp.obj
  python scratchpad/w66a5/symown.py --name gShowroomLights
"""
import argparse
import re
from pathlib import Path

SYM = Path(r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt")
DEF = re.compile(r"^[0-9a-f]+: \$([0-9a-f]{8}) (?:94 Def|96 Def2) class (\S+) (.*?)name (\S+)\s*$")
FILEREC = re.compile(r"^[0-9a-f]+: \$[0-9a-f]{8} 94 Def class FILE type NULL size 0 name (\S+)")


def blocks():
    """yield (objname, [ (va, cls, desc, name), ... ]) in SYM order."""
    cur = []
    for ln in SYM.read_text(errors="replace").splitlines():
        m = FILEREC.match(ln)
        if m:
            yield m.group(1), cur
            cur = []
            continue
        m = DEF.match(ln)
        if m and m.group(2) in ("EXT", "STAT"):
            cur.append((int(m.group(1), 16), m.group(2), m.group(3).strip(),
                        m.group(4)))
    if cur:
        yield "<tail>", cur


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--lo")
    ap.add_argument("--hi")
    ap.add_argument("--obj")
    ap.add_argument("--name")
    a = ap.parse_args()
    lo = int(a.lo, 16) if a.lo else None
    hi = int(a.hi, 16) if a.hi else None

    for obj, recs in blocks():
        if a.obj and a.obj.lower() not in obj.lower():
            continue
        sel = recs
        if lo is not None:
            sel = [r for r in sel if lo <= r[0] < (hi if hi else lo + 1)]
        if a.name:
            sel = [r for r in sel if r[3] == a.name]
        if not sel:
            continue
        print(f"== {obj}   ({len(recs)} EXT/STAT records in block)")
        for va, cls, desc, name in (recs if (a.obj and not lo and not a.name)
                                    else sel):
            print(f"   {va:#010x}  {cls:<4s} {name:<40s} {desc}")


main()

"""side.py -- retail run vs OUR emitted layout, per (TU, section).

Prints the blob's record run that covers the TU's labels next to our object's
symbol offsets, so an ordering/size defect is readable at a glance.

  python scratchpad/w66a5/side.py --blob <ctl blob> --end 0xVA --obj <substr> [--sec .data]
"""
import argparse
import re
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import blobparse  # noqa: E402

ROOT = Path(__file__).resolve().parents[2]
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
SYMLINE = re.compile(r"^([0-9a-f]{8})\s+(\S+)\s+(?:\S+\s+)?(\S+)\s+([0-9a-f]{8})\s+(.*)$")


def our(obj, sec):
    r = subprocess.run([OBJDUMP, "-t", "-h", obj], capture_output=True, text=True)
    syms, size = [], None
    for ln in r.stdout.splitlines():
        m = re.match(r"^\s*\d+\s+(\S+)\s+([0-9a-f]+)\s", ln)
        if m and m.group(1) == sec:
            size = int(m.group(2), 16)
        m = SYMLINE.match(ln)
        if m and m.group(3) == sec and m.group(5).strip() and not m.group(5).startswith("."):
            syms.append((int(m.group(1), 16), m.group(5).strip(), m.group(2)))
    return sorted(syms), size


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--blob", required=True)
    ap.add_argument("--end", required=True)
    ap.add_argument("--obj", required=True)
    ap.add_argument("--sec", default=".data")
    a = ap.parse_args()

    _, _, recs = blobparse.load(ROOT / a.blob, int(a.end, 16))
    by_name = {r["name"]: r for r in recs}

    objs = [p for p in (ROOT / "build" / "recon").rglob("*.o") if a.obj in str(p)]
    if not objs:
        sys.exit("no object matches " + a.obj)
    obj = objs[0]
    syms, size = our(str(obj), a.sec)
    print(f"OBJ {obj.relative_to(ROOT)}  {a.sec} size={size}")
    hits = [(o, n) for o, n, b in syms if n in by_name]
    if not hits:
        sys.exit("none of our %s symbols is a blob label" % a.sec)
    lo = min(by_name[n]["va"] for _, n in hits)
    hi = max(by_name[n]["end"] for _, n in hits)
    print(f"retail run {lo:#x}..{hi:#x} ({hi - lo} B)   ours {size} B\n")
    print("  retail                              ours")
    ours_by_name = {n: o for o, n, b in syms}
    base = None
    for r in recs:
        if not (lo <= r["va"] < hi):
            continue
        o = ours_by_name.get(r["name"])
        if o is not None and base is None:
            base = r["va"] - o
        mark = ""
        if o is not None:
            imp = r["va"] - o
            mark = f"ours+{o:#06x}  implied base {imp:#010x}"
            if base is not None and imp != base:
                mark += "   <== DRIFT"
        else:
            mark = "(not ours)"
        print(f"  {r['va']:#010x}..{r['end']:#010x} {r['end'] - r['va']:5d}  "
              f"{r['name']:<34s} {mark}")
    extra = [(o, n) for o, n, b in syms if n not in by_name]
    if extra:
        print("\n  our %s symbols that are NOT blob labels:" % a.sec)
        for o, n in sorted(extra):
            print(f"    +{o:#06x}  {n}")


main()

#!/usr/bin/env python3
"""W65-A8  MISSING-INITIALISER DETECTOR (a REAL-BUG screen, not an ownership one).

ownmap's E5 leg reports "N bytes differ" per WINDOW, so a window whose labels
are merely out of ORDER drowns the real defects in alignment noise.  This
screen is per-SYMBOL and order-independent:

  for every blob label a recon TU defines, compare
      retail bytes at the label's retail VA   (rom/nfs4-f.exe)
  vs  our bytes at the label's offset in our section

  and report only the class that is a genuine defect rather than a layout
  artifact: retail's bytes are NON-ZERO, ours are ALL ZERO, and no relocation
  covers our bytes  ->  the object is INITIALISED in retail and we emitted a
  zero-valued tentative definition.

That is exactly the class behind W64-A18's aicop/fastrand finds, W65-A8's
font.cpp `font_clutx = -1` (a live runtime guard), and it is invisible to every
per-function gate because it is data.

Anti-vacuity: a symbol whose bytes we cannot read (size unknown, or the label
is the last in our section with no successor) is reported UNKNOWN, never
"clean"; relocation coverage is taken from `objdump -r`, never assumed.

  python scratchpad/w65a8/zeroinit.py --blob <ctl blob> --end 0xVA
"""
import argparse
import re
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import blobparse  # noqa: E402
import ownmap  # noqa: E402

ROOT = Path(__file__).resolve().parents[2]
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
FBASE = 0x8000F800
DATA_SECS = (".sdata", ".data", ".rodata")   # .bss/.sbss carry no bytes


def secbytes(obj, sec):
    r = subprocess.run([OBJDUMP, "-s", "-j", sec, str(obj)],
                       capture_output=True, text=True)
    out = bytearray()
    for ln in r.stdout.splitlines():
        # objdump -s prints the offset at the section VMA's width: an unlinked
        # object gives 4 hex digits, not 8.  Requiring 8 made every read come
        # back EMPTY -- the assert-to-UNKNOWN path is what surfaced it instead
        # of reporting 0 defects "clean".
        m = re.match(r"^\s*([0-9a-f]+) ((?:[0-9a-f]{2,8} ){1,4})", ln)
        if m:
            out += bytes.fromhex(m.group(2).replace(" ", ""))
    return bytes(out)


def relocs(obj, sec):
    r = subprocess.run([OBJDUMP, "-r", str(obj)], capture_output=True,
                       text=True)
    cur, cov = None, set()
    for ln in r.stdout.splitlines():
        m = re.match(r"^RELOCATION RECORDS FOR \[(\S+)\]:", ln)
        if m:
            cur = m.group(1)
            continue
        m = re.match(r"^([0-9a-f]{8}) (\S+)", ln)
        if m and cur == sec:
            o = int(m.group(1), 16)
            cov |= set(range(o, o + 4))
    return cov


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--blob", required=True)
    ap.add_argument("--end", required=True)
    ap.add_argument("--out", required=True)
    a = ap.parse_args()

    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    _, _, recs = blobparse.load(ROOT / a.blob, int(a.end, 16))
    by_name = {r["name"]: r for r in recs}

    objs = sorted((ROOT / "build" / "recon").rglob("*.o"))
    assert objs, "vacuous: no recon objects"
    data = ownmap.dump_objects(objs)

    hits, unknown, checked = [], [], 0
    for obj, d in sorted(data.items()):
        secs = defaultdict(list)
        for name, sec, off, glob in d["syms"]:
            if name in by_name and sec in DATA_SECS:
                secs[sec].append((off, name))
        for sec, members in sorted(secs.items()):
            body = secbytes(ROOT / obj, sec)
            cov = relocs(ROOT / obj, sec)
            members.sort()
            for i, (off, name) in enumerate(members):
                r = by_name[name]
                n = r["end"] - r["va"]
                rb = rom[r["va"] - FBASE:r["end"] - FBASE]
                ob = body[off:off + n]
                if len(ob) != n or len(rb) != n:
                    unknown.append((obj, sec, name, "short read"))
                    continue
                checked += 1
                if set(rb) <= {0}:
                    continue                       # retail is zero: fine
                if any(ob):
                    continue                       # we have SOME value
                    # (was `set(ob) > {0}` -- a SUPERSET test, which is False
                    #  for {0xff}: it reported already-fixed symbols as defects)
                if cov & set(range(off, off + n)):
                    continue                       # a relocation lives here
                hits.append((obj, sec, name, r["va"], n, rb))

    L = [f"checked {checked} TU-defined blob labels in {len(data)} objects",
         f"UNKNOWN (not readable, NOT counted clean): {len(unknown)}",
         "", "MISSING INITIALISER -- retail non-zero, ours all-zero, no reloc:",
         "-" * 96]
    for obj, sec, name, va, n, rb in sorted(hits, key=lambda h: h[3]):
        L.append(f"{va:#010x} {n:5d} B  {name:<34s} {sec:<8s} "
                 f"{obj.replace('build/recon/', '')}")
        L.append("            retail " + " ".join("%02x" % x for x in rb[:24])
                 + (" ..." if n > 24 else ""))
    L += ["", f"TOTAL: {len(hits)} symbols"]
    for u in unknown:
        L.append("UNKNOWN " + " ".join(str(x) for x in u))
    (ROOT / a.out).write_text("\n".join(L) + "\n")
    print("\n".join(L))


if __name__ == "__main__":
    main()

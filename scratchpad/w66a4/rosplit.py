#!/usr/bin/env python3
"""W66-A4  rosplit.py -- the `.rodata` SPLIT-STORAGE screen.

A window whose jump table anchors cleanly but whose LEADING content does not
match retail at the implied base has two possible causes:

  (a) SPLIT STORAGE -- retail put that TU's read-only data in TWO disjoint
      runs (typically a big table in the `.data` blob region and the switch
      jump table in the resident `.rodata` run).  Our single `.rodata` section
      cannot be linked into two places, so the window is UNPLACEABLE as one
      piece and must be reported, never forced.
  (b) ORDER DIVERGENCE -- the same content, emitted in a different order.

The test: take the run BEFORE the first anchored jump table, resolve what can
be resolved, and search the ROM for it independently.  A hit at a DIFFERENT
address than the window's base proves (a) and names the second run.

    python scratchpad/w66a4/rosplit.py
"""
import json
import re
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
FBASE = 0x8000F800

sys.path.insert(0, str(HERE))
sys.path.insert(0, str(ROOT / "tools"))
import rodownmap as R  # noqa: E402
import vamap  # noqa: E402


def main():
    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    names, _ = vamap.build()
    blobs = R.load_records()
    allrecs = sorted((r for stem, _, _ in R.BLOBS for r in blobs[stem]),
                     key=lambda r: r["va"])
    objdata = json.load(open(HERE / "objdata.json"))
    vas, dup = {}, set()
    for ln in open(ROOT / "configs" / "symbol_addrs.txt", errors="replace"):
        m = re.match(r"(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func", ln)
        if m:
            n, v = m.group(1), int(m.group(2), 16)
            if n in vas and vas[n] != v:
                dup.add(n)
            vas.setdefault(n, v)
    for n in dup:
        del vas[n]
    tb = R.implied_text_bases(objdata, vas)

    rows = [r for r in json.load(open(HERE / "rodownmap_all.json"))
            if r["regions"] and not r["e5"]]
    print(f"jtbl-anchored windows failing E5: {len(rows)}")
    ro = R.rodata_bytes([r["obj"] for r in rows])
    out = []
    for r in rows:
        o = r["obj"]
        ob = bytearray(ro[o])
        n = len(ob)
        wild = set()
        for rl in objdata[o]["relocs"]:
            if rl["sec"] != ".rodata":
                continue
            off = rl["off"]
            if off + 4 > n:
                continue
            tgt = rl["val"].split("+")[0].strip()
            b0 = (tb.get(o) if tgt == ".text" else
                  None if tgt == ".rodata" else names.get(tgt))
            if rl["type"] != "R_MIPS_32" or b0 is None:
                wild.update(range(off, min(off + 4, n)))
                continue
            ad = struct.unpack_from("<I", ob, off)[0]
            struct.pack_into("<I", ob, off, (b0 + ad) & 0xFFFFFFFF)
        J = min(next(x for x in allrecs if x["name"] == g)["va"] - r["base"]
                for g in r["regions"])
        head = bytes(ob[:J])
        if len(head) < 16 or all(k in wild for k in range(J)):
            out.append((o, r["base"], J, "HEAD-TOO-SMALL", []))
            continue
        hits, p = [], 0
        while True:
            p = rom.find(head, p)
            if p < 0:
                break
            hits.append(p + FBASE)
            p += 1
        verdict = ("SPLIT-STORAGE" if hits and r["base"] not in hits
                   else "IN-PLACE" if hits else "HEAD-NOT-IN-ROM")
        out.append((o, r["base"], J, verdict, hits[:4]))

    for o, b, J, v, hits in sorted(out, key=lambda x: x[3]):
        print(f"{v:16s} base={b:#010x} head={J:5d} B  {o}")
        if hits:
            print(f"                 head found at {[hex(h) for h in hits]}")
    (HERE / "rosplit.txt").write_text(
        "\n".join(f"{v}\t{b:#x}\t{J}\t{o}\t{[hex(h) for h in hits]}"
                  for o, b, J, v, hits in out) + "\n")
    print(f"-> {HERE / 'rosplit.txt'}")


if __name__ == "__main__":
    main()

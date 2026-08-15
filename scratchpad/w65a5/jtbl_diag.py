#!/usr/bin/env python3
"""W65-A5  jtbl_diag.py -- why is a jtbl region UNPROVEN?

For every region jtbl_own.py could not prove, name the recon object whose
implied text window CONTAINS the region's targets, and print that object's own
resolved `.rodata`-vs-`.text` word sequence beside the blob's, so the
difference is visible per word.  No verdict is inferred from a count.
"""
import json
import re
import struct
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import jtbl_own as J  # noqa: E402

ROOT = J.ROOT


def main():
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

    objdata = json.load(open(J.OBJDATA))
    bases = J.implied_bases(objdata, vas)
    spans = {}
    for o, b in bases.items():
        t = objdata[o].get("secs", {}).get(".text", 0)
        if t:
            spans[o] = (b, b + t)

    rows = json.load(open(HERE / "jtbl_own.json"))
    unp = [r for r in rows if not r["owner"]]
    cand = sorted(o for o, d in objdata.items()
                  if o.startswith("build/recon") and (ROOT / o).exists()
                  and any(rl["sec"] == ".rodata" and rl["type"] == "R_MIPS_32"
                          and rl["val"].split("+")[0].strip() == ".text"
                          for rl in d["relocs"]))
    ro = J.rodata_bytes(cand)
    seqs = {}
    for o in cand:
        b = ro.get(o, b"")
        offs = sorted(rl["off"] for rl in objdata[o]["relocs"]
                      if rl["sec"] == ".rodata" and rl["type"] == "R_MIPS_32"
                      and rl["val"].split("+")[0].strip() == ".text")
        seqs[o] = {off: bases[o] + struct.unpack("<I", b[off:off + 4])[0]
                   for off in offs if off + 4 <= len(b)}

    out = ["W65-A5  UNPROVEN jump-table regions -- per-word diagnosis", ""]
    for r in unp:
        t = r["targets"]
        owners = sorted({o for o, (lo, hi) in spans.items()
                         if t and lo <= t[0] < hi})
        out.append(f"== {r['name']} {r['va']:#010x}  {len(t)} .L words"
                   f" (+{len(r['nonlabel'])} zero pad)")
        out.append(f"   targets       : {' '.join(f'{x:08x}' for x in t)}")
        if not owners:
            out.append("   NO recon object's implied text window contains "
                       f"target[0]={t[0]:#010x}")
            out.append("")
            continue
        for o in owners:
            lo, hi = spans[o]
            out.append(f"   text window   : {o}  {lo:#010x}..{hi:#010x}")
            rec = seqs.get(o)
            if rec is None:
                out.append("   -> that object emits NO .rodata-vs-.text words")
                continue
            offs = sorted(rec)
            out.append("   its .rodata   : "
                       + " ".join(f"{rec[x]:08x}" for x in offs))
            # longest common run with the blob sequence
            best = 0
            for k in range(len(offs)):
                n = 0
                while (k + n < len(offs) and n < len(t)
                       and rec[offs[k + n]] == t[n]):
                    n += 1
                best = max(best, n)
            out.append(f"   longest prefix run matching the blob: {best}/{len(t)}")
        out.append("")
    (HERE / "jtbl_diag.txt").write_text("\n".join(out) + "\n")
    print("\n".join(out[:80]))
    print(f"-> {HERE / 'jtbl_diag.txt'}")


if __name__ == "__main__":
    main()

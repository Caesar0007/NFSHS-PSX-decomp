#!/usr/bin/env python3
"""W66-A4  ropad.py -- THE ALIGNMENT-PAD DIAGNOSIS for a `.rodata` window.

The camera 44-vs-45-word question, answered mechanically for every window.

MECHANISM.  gcc-2.8 emits `.rdata` + `.align 3` immediately before a switch
jump table.  `.align` is relative to the SECTION START, so whether it costs a
4-byte pad depends on how much `.rdata` the TU emitted BEFORE the table.  When
our reconstruction is missing (or has extra) leading `.rdata` content, the pad
appears (or disappears) and the whole section's implied base slides by 4 -- the
jump table still anchors correctly, but every OTHER `%hi/%lo(.rodata+N)` in
that TU's `.text` then resolves 4 bytes off.

THE TEST.  Let `B` be our anchored base and `R` the nearest blob-record
boundary at or above it, `d = R - B` (0 < d < 8), and `J` the offset of the
first anchored jump table in our `.rodata`.  If

    ours[0 : J-d]                 == retail[R : R + (J-d)]        (head)
    ours[J-d : J]                 == 00 00 00 00                   (the pad)
    ours[J : ]                    == retail[R + (J-d) : ]          (tail)

then the ONLY difference is an inserted `d`-byte alignment pad and the window's
true base is `R`.  Reported as PAD.  Anything else is reported with its first
divergence so it is never silently folded into this class.

    python scratchpad/w66a4/ropad.py
"""
import json
import re
import struct
import sys
from collections import defaultdict
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
    bounds = sorted({r["va"] for r in allrecs}
                    | {hi for _, _, hi in R.BLOBS})
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
    tbases = R.implied_text_bases(objdata, vas)

    rows = json.load(open(HERE / "rodownmap_all.json"))
    todo = [r for r in rows if not r["e4"] or not r["e5"]]
    print(f"windows failing E4 and/or E5: {len(todo)} of {len(rows)}")

    objs = [r["obj"] for r in todo]
    ro = R.rodata_bytes(objs)
    out = []
    klass = defaultdict(list)
    for r in todo:
        o = r["obj"]
        ob = bytearray(ro[o])
        n = len(ob)
        for rl in objdata[o]["relocs"]:
            if rl["sec"] != ".rodata" or rl["type"] != "R_MIPS_32":
                continue
            off = rl["off"]
            if off + 4 > n:
                continue
            tgt = rl["val"].split("+")[0].strip()
            b0 = (tbases.get(o) if tgt == ".text" else
                  r["base"] if tgt == ".rodata" else names.get(tgt))
            if b0 is None:
                continue
            ad = struct.unpack_from("<I", ob, off)[0]
            struct.pack_into("<I", ob, off, (b0 + ad) & 0xFFFFFFFF)

        B = r["base"]
        Rb = next((b for b in bounds if b >= B), None)
        d = (Rb - B) if Rb is not None else None
        verdict, detail = "OTHER", ""
        if d == 0:
            verdict, detail = "BASE-OK", "base is already a record boundary"
        elif d is not None and 0 < d < 8:
            # J = offset of the first anchored jump table in OUR .rodata
            J = None
            for reg in r["regions"]:
                rec = next(x for x in allrecs if x["name"] == reg)
                J = rec["va"] - B if J is None else min(J, rec["va"] - B)
            if J is None:
                verdict = "NO-JTBL"
            elif J - d < 0:
                verdict = "PAD?"
                detail = f"first table sits before the {d}-byte slide"
            else:
                head_ok = bytes(ob[:J - d]) == rom[Rb - FBASE:Rb - FBASE + J - d]
                pad_ok = set(ob[J - d:J]) <= {0}
                tail_ok = (bytes(ob[J:]) ==
                           rom[Rb - FBASE + J - d:Rb - FBASE + n - d])
                if head_ok and pad_ok and tail_ok:
                    verdict = "PAD"
                    detail = (f"{d}-byte `.align 3` pad at +{J-d:#x}; "
                              f"true base {Rb:#010x}")
                else:
                    verdict = "SHIFT?"
                    detail = (f"head={head_ok} pad-is-zero={pad_ok} "
                              f"tail={tail_ok} (d={d}, J={J:#x})")
        elif d is not None:
            verdict = "GAP"
            detail = f"nearest boundary {Rb:#010x} is {d} B above the anchor"
        klass[verdict].append(o)
        out.append((verdict, B, n, o, detail))

    print("\n== VERDICTS ==")
    for k in sorted(klass):
        print(f"  {k:8s} {len(klass[k]):3d}")
    print()
    for v, B, n, o, det in sorted(out):
        print(f"{v:8s} {B:#010x} {n:6d} B  {o}")
        if det:
            print(f"          {det}")
    (HERE / "ropad.txt").write_text(
        "\n".join(f"{v}\t{B:#x}\t{n}\t{o}\t{det}" for v, B, n, o, det in out)
        + "\n")
    json.dump({k: v for k, v in klass.items()},
              open(HERE / "ropad.json", "w"), indent=1)
    print(f"-> {HERE / 'ropad.txt'}")


if __name__ == "__main__":
    main()

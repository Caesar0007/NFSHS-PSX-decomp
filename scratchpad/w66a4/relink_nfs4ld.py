#!/usr/bin/env python3
"""W65-A5  relink_nfs4ld.py -- put the cut rodata blob's pieces into the
SPLAT-lane script `linkers/nfs4.ld`.

The splat lane links EVERY piece (residual + jump-table filler) in blob order,
so the image it produces is unchanged -- proven separately by proofs.py P3
(concatenation == control object) and the P6 control link diff.

The blob object's `.data` and `.bss` sections are EMPTY (objdump: size 0), so
their two one-line entries are replaced by a comment rather than by 94 no-op
lines; the assertion below re-proves emptiness every run instead of trusting
that note.

  python scratchpad/w65a5/relink_nfs4ld.py --stem rdata_80010000 --sec rodata \
      --order scratchpad/w65a5/rdata_80010000_pieces_order.txt [--apply]
"""
import argparse
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump"


def sec_sizes(obj):
    r = subprocess.run([OBJDUMP, "-h", str(obj)], capture_output=True,
                       text=True, cwd=ROOT)
    out = {}
    for ln in r.stdout.splitlines():
        m = re.match(r"^\s*\d+\s+(\S+)\s+([0-9a-f]{8})\s", ln)
        if m:
            out[m.group(1)] = int(m.group(2), 16)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--stem", required=True)
    ap.add_argument("--sec", required=True)
    ap.add_argument("--order", required=True)
    ap.add_argument("--apply", action="store_true")
    a = ap.parse_args()

    order = [l.strip() for l in
             (ROOT / a.order).read_text().splitlines() if l.strip()]
    assert order, "empty piece order file"

    # prove the non-primary sections really are empty in every piece
    for n in order:
        o = ROOT / "build" / "asm" / "data" / (n + ".o")
        if not o.exists():
            continue
        s = sec_sizes(o)
        for dead in (".data", ".bss", ".text"):
            assert s.get(dead, 0) == 0, f"{n}: {dead} is NOT empty ({s[dead]})"

    ld = ROOT / "linkers" / "nfs4.ld"
    txt = ld.read_text()
    nlk = "\r\n" if "\r\n" in txt else "\n"
    lines = txt.split(nlk)
    hits = [i for i, l in enumerate(lines)
            if f"build/asm/data/{a.stem}." in l]
    assert hits, f"no {a.stem} entries in nfs4.ld"
    print(f"{a.stem}: {len(hits)} entries in nfs4.ld at lines "
          f"{[h+1 for h in hits]}")

    for i in reversed(hits):
        indent = re.match(r"^(\s*)", lines[i]).group(1)
        m = re.search(r"\((\.\w+)\)", lines[i])
        assert m, lines[i]
        sec = m.group(1)
        if sec == "." + a.sec:
            lines[i:i + 1] = [f"{indent}build/asm/data/{n}.o({sec});"
                              for n in order]
        else:
            lines[i:i + 1] = [
                f"{indent}/* W65-A5: {a.stem} is now {len(order)} pieces "
                f"(the .L localize cut); every piece's {sec} is EMPTY "
                f"(objdump size 0, re-asserted by relink_nfs4ld.py). */"]

    if not a.apply:
        print("(dry run)")
        return
    ld.write_text(nlk.join(lines), newline="")
    print(f"wrote {ld}")


if __name__ == "__main__":
    main()

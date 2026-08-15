#!/usr/bin/env python3
"""W64-A18  GLOBAL name -> retail VA map.

Sources (union, later never overwrites earlier):
  1. configs/symbol_addrs.txt     `name = 0xVA;`
  2. every asm/**/*.s dlabel with a `/* fileoff VA ... */` comment on its first
     data line (the splat blobs and the oracle text files)

Used by ownmap2's reloc-aware E5 leg: an R_MIPS_32 word in our data section
holds only its ADDEND until link, so the raw bytes can never equal retail.
Resolving it needs the target symbol's retail VA.
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SA = re.compile(r"^\s*([A-Za-z_$.][\w$.]*)\s*=\s*(0x[0-9A-Fa-f]+)\s*;")
VA_RE = re.compile(r"/\*\s*[0-9A-Fa-f]+\s+([0-9A-Fa-f]{8})\s")
DLAB = re.compile(r"^\s*(?:dlabel|glabel|jlabel)\s+(\S+)")


def build(verbose=False):
    m = {}
    src = {}
    p = ROOT / "configs" / "symbol_addrs.txt"
    for ln in p.read_text(errors="replace").splitlines():
        g = SA.match(ln)
        if g:
            m.setdefault(g.group(1), int(g.group(2), 16))
            src.setdefault(g.group(1), "symbol_addrs")
    n1 = len(m)
    for f in sorted((ROOT / "asm").rglob("*.s")):
        txt = f.read_text(errors="replace")
        cur = None
        for ln in txt.splitlines():
            d = DLAB.match(ln)
            if d:
                cur = d.group(1)
                continue
            if cur is not None:
                v = VA_RE.search(ln)
                if v:
                    m.setdefault(cur, int(v.group(1), 16))
                    src.setdefault(cur, str(f.relative_to(ROOT)))
                    cur = None
    if verbose:
        print(f"vamap: {n1} from symbol_addrs, {len(m)} total")
    return m, src


if __name__ == "__main__":
    m, s = build(verbose=True)
    for k in ("twoLapCopGame", "isqrttbl", "Flare_SunFlarePieces"):
        print(k, hex(m[k]) if k in m else "MISSING", s.get(k))

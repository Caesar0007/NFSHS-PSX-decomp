#!/usr/bin/env python3
"""vfx_a6.py -- enumerate param-copy-dial subsets on vramfxya.c and gate each.

usage: python scratchpad/vfx_a6.py [spec ...]
  spec = 4 chars from {0,1} for IX,IY,CX,CY   (e.g. 1010)
  no args -> all 16
"""
import re, subprocess, sys, itertools
from pathlib import Path

ROOT = Path(r"C:\Temp\nfs4-wt35-a6")
BASE = ROOT / "recon/eaclib/psx/eacpsxz/vramfxya.c"
TMP = ROOT / "recon/eaclib/psx/eacpsxz/tmp_a6.c"

SRC = BASE.read_text()

DECL_IX = "    int ix = imgX;"
DECL_CX = "    int cx = clutX;"


def build(ix, iy, cx, cy):
    s = SRC
    # normalise: strip the two existing decl lines, rewrite uses to raw params
    s = re.sub(r"\n *int ix = imgX;[^\n]*", "", s)
    s = re.sub(r"\n *int cx = clutX;[^\n]*", "", s)
    s = s.replace("(unsigned int)ix & 0xfff", "(unsigned int)imgX & 0xfff")
    s = s.replace("scratch.rect.x = ix;", "scratch.rect.x = imgX;")
    s = s.replace("scratch.rect.x = cx;", "scratch.rect.x = clutX;")

    decls = []
    if ix:
        decls.append("    int ix = imgX;")
        s = s.replace("(unsigned int)imgX & 0xfff", "(unsigned int)ix & 0xfff")
        s = s.replace("scratch.rect.x = imgX;", "scratch.rect.x = ix;")
    if iy:
        decls.append("    int iy = imgY;")
        s = s.replace("(unsigned int)imgY & 0xfff", "(unsigned int)iy & 0xfff")
        s = s.replace("scratch.rect.y = imgY;", "scratch.rect.y = iy;")
    if cx:
        decls.append("    int cx = clutX;")
        s = s.replace("scratch.rect.x = clutX;", "scratch.rect.x = cx;")
    if cy:
        decls.append("    int cy = clutY;")
        s = s.replace("scratch.rect.y = clutY;", "scratch.rect.y = cy;")

    anchor = "    unsigned int maskLo  = ~0xFFFu;"
    assert anchor in s, "anchor missing"
    s = s.replace(anchor, ("\n".join(decls) + "\n" + anchor) if decls else anchor)
    return s


def gate(text):
    TMP.write_text(text)
    r = subprocess.run([sys.executable, "tools/verify_asm.py",
                        "recon/eaclib/psx/eacpsxz/tmp_a6.c", "vramfxya"],
                       cwd=ROOT, capture_output=True, text=True)
    out = r.stdout + r.stderr
    m = re.search(r"FAIL (\d+) diffs \(ours (\d+) / oracle (\d+)\)", out)
    if m:
        return int(m.group(1)), int(m.group(2)), int(m.group(3))
    if "PASS" in out:
        m2 = re.search(r"PASS \((\d+) insns\)", out)
        return 0, int(m2.group(1)) if m2 else 0, 0
    return None, out[:300], None


specs = sys.argv[1:] or ["".join(map(str, t)) for t in itertools.product([0, 1], repeat=4)]
best = None
for sp in specs:
    ix, iy, cx, cy = (int(ch) for ch in sp)
    d, n, o = gate(build(ix, iy, cx, cy))
    print(f"IX{ix} IY{iy} CX{cx} CY{cy} -> diffs={d} insns={n}/{o}", flush=True)

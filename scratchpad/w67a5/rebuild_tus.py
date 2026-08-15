#!/usr/bin/env python3
"""W67-A5 -- rebuild ONLY the src TUs this landing touches (importing
tools/build.py's compile_c; the tool itself is never edited).

usage: python scratchpad/w67a5/rebuild_tus.py
"""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
import build  # noqa: E402  (tools/build.py)

TUS = [
    "src/eaclib/psx/pad.c",
    "src/eaclib/psx/spchpsxz/spchrule.c",
    "src/game/common/aih_btcperp.c",
    "src/syslib/psx/libetc/INTR.c",
    "src/syslib/psx/libapi/PAD.c",
]

for t in TUS:
    p = ROOT / t
    assert p.exists(), t
    obj = build.compile_c(p, False)
    print("OK", t, "->", obj)

#!/usr/bin/env python3
"""W65-A6 batch 4: asm-label aliases in the game/frontend *_externs.h headers.

Each target is a reloc-referenced UNDEFINED symbol whose storage ALREADY exists in
a splat data blob under a `D_<VA>` dlabel; the VA + retail size come from the SYM's
`96 Def2 class STAT/EXT ... size N` record, not from a guess.  Aliasing changes only
the emitted relocation NAME (byte-neutral; verify_asm is reloc-name lenient).
"""
import os
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

JOBS = [
    # header, symbol, blob label, SYM evidence
    ("recon/game/common/simqueue_externs.h",     "output",                "D_8013DDC8"),
    ("recon/game/psx/psxcontroller_externs.h",   "hoff",                  "D_8013DAC0"),
    ("recon/game/psx/cario_externs.h",           "CarIO_textureName",     "D_8011E804"),
    ("recon/game/psx/drawc_externs.h",           "hilight_colors",        "D_8011F4B4"),
    ("recon/game/psx/loading_externs.h",         "loading_languageNames", "D_80120D00"),
    ("recon/frontend/common/feinput_externs.h",  "nextTick",              "D_80051738"),
    ("recon/frontend/common/feinput_externs.h",  "debounce",              "D_80052B60"),
]


def apply(rel, sym, blob):
    p = ROOT / rel
    data = p.read_bytes()
    txt = data.decode("latin-1")
    pat = re.compile(
        r"^(?P<head>[ \t]*extern[^\r\n;]*?\b" + re.escape(sym) +
        r"\b(?:\[[^\]\r\n]*\])?)(?P<tail>[ \t]*;)", re.M)
    n = len(pat.findall(txt))
    if n != 1:
        return "SKIP (%d declaration matches)" % n
    new = pat.sub(lambda m: m.group("head") + ' __asm__("' + blob + '")' +
                  m.group("tail"), txt, count=1)
    assert len(new) > len(txt)
    tmp = str(p) + ".w65a6tmp"
    with open(tmp, "wb") as f:
        f.write(new.encode("latin-1"))
    assert os.path.getsize(tmp) > len(data)
    os.replace(tmp, str(p))
    return "OK"


for rel, sym, blob in JOBS:
    print("%-42s %-22s -> %-12s %s" % (rel.split("/")[-1], sym, blob,
                                       apply(rel, sym, blob)))

#!/usr/bin/env python3
"""W65-A6: attach an asm-label alias to a declaration so its relocation names the
splat blob symbol that already defines that VA.  Byte-neutral: only the emitted
reloc NAME changes (verify_asm is reloc-name lenient; the real link resolves).

Byte-mode + explicit size-grew assert + os.replace (the pathlib.write_text
truncation hazard); line endings are preserved verbatim.
"""
import os
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

JOBS = [
    ("recon/syslib/psx/libetc/INTR.c",     "g_hooks_ptr",     "D_80135B80"),
    ("recon/syslib/psx/libetc/INTR.c",     "g_istat_ptr",     "D_80135B84"),
    ("recon/syslib/psx/libetc/INTR.c",     "g_imask_ptr",     "D_80135B88"),
    ("recon/syslib/psx/libetc/INTR.c",     "g_dpcr_ptr",      "D_80135B8C"),
    ("recon/syslib/psx/libetc/INTR.c",     "g_intr_timeout",  "D_80135B90"),
    ("recon/syslib/psx/libetc/INTR_DMA.c", "g_dicr_ptr",      "D_8013BD20"),
    ("recon/syslib/psx/libetc/INTR_DMA.c", "g_madr_ptr",      "D_8013BD44"),
    ("recon/syslib/psx/libetc/VSYNC.c",    "g_vsync_gp1_ptr", "D_80134A88"),
    ("recon/syslib/psx/libetc/VSYNC.c",    "g_vsync_t1_ptr",  "D_80134A8C"),
    ("recon/syslib/psx/libetc/VSYNC.c",    "vsync_lastcount", "D_80134A94"),
    ("recon/syslib/psx/libetc/INTR_VB.c",  "g_rcnt_ptr",      "D_80137D14"),
    ("recon/syslib/psx/libgpu/FONT.c",     "_fnt_count",      "D_80135FD8"),
    ("recon/syslib/psx/libgpu/FONT.c",     "_fnt_active",     "D_80135FDC"),
    ("recon/syslib/psx/libcd/cdread.c",    "_cdr",            "D_8013C290"),
]


def apply(rel, sym, blob):
    p = ROOT / rel
    data = p.read_bytes()
    txt = data.decode("latin-1")
    # a DECLARATION line: starts with `extern`, names the symbol, ends in `;`
    pat = re.compile(
        r"^(?P<head>[ \t]*extern[^\r\n;]*?\b" + re.escape(sym) +
        r"\b(?:\[[^\]\r\n]*\])?)(?P<tail>[ \t]*;)", re.M)
    hits = pat.findall(txt)
    if len(hits) != 1:
        return "SKIP (%d declaration matches)" % len(hits)
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
    print("%-40s %-18s -> %-12s %s" % (rel.split("/")[-1], sym, blob,
                                       apply(rel, sym, blob)))

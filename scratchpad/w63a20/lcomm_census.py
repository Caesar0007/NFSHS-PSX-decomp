#!/usr/bin/env python3
"""Which TUs does the .lcomm guard actually touch?

A `.lcomm SYM,N` only gets maspsx's bogus `.globl` when it lands in the BSS
bucket, i.e. N > the TU's -G threshold (maspsx: `size <= self.sdata_limit` ->
sbss, else bss; only the bss arm emits `.globl`).  Scans every cc1 .s under
build/ and prints the affected TUs + symbols.
"""
import importlib.util
import re
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
_s = importlib.util.spec_from_file_location("nfs4build", ROOT / "tools" / "build.py")
bp = importlib.util.module_from_spec(_s)
sys.modules["nfs4build"] = bp
_s.loader.exec_module(bp)

hits = {}
for p in sorted((ROOT / "build" / "recon").rglob("*.s")):
    rel = p.relative_to(ROOT / "build").as_posix()[:-2]
    src = ROOT / rel
    if not src.exists():
        continue
    g = int(bp.per_tu_flags(src).get("g_value", bp.G_VALUE))
    syms = []
    for ln in p.read_text(errors="replace").splitlines():
        m = re.match(r"^\s*\.lcomm\s+(\S+),(\d+)\s*$", ln)
        if m and int(m.group(2)) > g:
            syms.append((m.group(1), int(m.group(2))))
    if syms:
        hits[rel] = syms

print("TUs whose file-statics maspsx globalizes: %d  (symbols: %d)"
      % (len(hits), sum(len(v) for v in hits.values())))
for rel, syms in sorted(hits.items()):
    print("  %-50s %s" % (rel[6:], ", ".join("%s[%d]" % s for s in syms)))
print()
print("\n".join(sorted(hits)))

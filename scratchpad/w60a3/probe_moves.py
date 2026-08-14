#!/usr/bin/env python3
"""Probe a full PER_FN_TEXT_MOVES spec for one SYS.c fn WITHOUT touching
tools/build.py, scored by the REAL GATE.

Replicates _apply_text_moves verbatim (take/after/copy/slot/drop_nop), assembles
with build.py's own `as` line, then prints tools/verify_asm.py's OWN verdict via
gatecmp.py.

  python probe_moves.py <fn> '<json list of moves>'

CORRECTION 2026-08-14: the first cut scored with a home-grown "REAL vs reloc"
split that treated any same-mnemonic word mismatch as a reloc -- vacuous.  All
scoring now goes through the gate.  A take/after regex that fails to match is
now FATAL (it used to be skipped, which silently scored the unmodified object).
"""
import json
import os
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
AS = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-as.exe"
TU = "recon/syslib/psx/libgpu/SYS.c"
S = ROOT / "build" / (TU + ".s")
TMP = ROOT / "scratchpad/w60a3"
OUTS, OBJ = TMP / "probe.s", TMP / "probe.o"

name = sys.argv[1]
moves = json.loads(sys.argv[2])

txt = S.read_text(errors="replace")
m = re.search(r"^\t\.ent\t%s\b[^\n]*\n" % re.escape(name), txt, re.M)
assert m, "no .ent for %s" % name
m2 = re.search(r"^\t\.end\t%s[ \t]*$" % re.escape(name), txt[m.end():], re.M)
end = m.end() + m2.start()
region = txt[m.start():end]

for i, mv in enumerate(moves):
    tk = re.search(mv["take"], region)
    if not tk:
        sys.exit("move %d: take did not match -- refusing to score an unmodified "
                 "object" % i)
    line = tk.group(0)
    region2 = region if mv.get("copy") else region[:tk.start()] + region[tk.end():]
    an = re.search(mv["after"], region2)
    if not an:
        sys.exit("move %d: after did not match" % i)
    ins = an.end()
    if mv.get("drop_nop"):
        np = re.match(r"\t#?nop\n", region2[ins:])
        if np:
            region2 = region2[:ins] + region2[ins + np.end():]
    if mv.get("slot"):
        region = (region2[:an.start()] + "\t.set\tnoreorder\n" + an.group(0)
                  + line + "\t.set\treorder\n" + region2[an.end():])
    else:
        region = region2[:ins] + line + region2[ins:]

OUTS.write_text(txt[:m.start()] + region + txt[end:])
r = subprocess.run([AS, "-EL", "-march=r3000", "-mtune=r3000", "-G0",
                    "-I", str(ROOT / "include"), "-I", str(ROOT),
                    "-o", str(OBJ), str(OUTS)], capture_output=True, text=True)
if r.returncode:
    sys.exit("as failed:\n" + r.stdout + r.stderr)

subprocess.run([sys.executable, str(TMP / "gatecmp.py"), TU, name],
               env=dict(os.environ, GATE_OBJ=str(OBJ)))

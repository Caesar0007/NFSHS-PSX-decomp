#!/usr/bin/env python3
"""W60-A3 probe: per-FN cc1-VERSION splice for an arbitrary ladder rung, scored
by the REAL GATE.

  python probe_272.py <rung> <fn> [<fn> ...]

Compiles build.py's own .i with the rung's cc1 (272 recipe, dropping flags the
rung rejects -- every pre-2.8 cc1 errors on -mno-split-addresses), splices the
named functions' .ent/.end regions into the wired .s, assembles with build.py's
`as` line, then prints tools/verify_asm.py's OWN verdict for each function via
gatecmp.py.

CORRECTION 2026-08-14: the first cut of this script scored with a home-grown
"REAL vs reloc" split that called any same-mnemonic word mismatch a reloc.  That
was vacuous and produced a FALSE REAL=0 for _set_draw_mode (a commutative
or-operand swap in a function with zero relocations).  All scoring now goes
through the gate.
"""
import os
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
LADDER = Path(r"C:/Temp/windows-gcc-psx")
AS = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-as.exe"
TU = "recon/syslib/psx/libgpu/SYS.c"
I = ROOT / "build" / (TU + ".i")
S = ROOT / "build" / (TU + ".s")
TMP = ROOT / "scratchpad/w60a3"

MOVE_RE = re.compile(r"^(\tmove\t)(\$[a-z0-9]+),(\$[a-z0-9]+)[ \t]*$", re.M)

rung = sys.argv[1]
# accept both `fn fn fn` and `fn,fn,fn` -- an unsplit comma list used to make
# region() miss, print SKIP, and then score the UNSPLICED object (i.e. echo the
# live tree).  Any SKIP is now fatal rather than silently vacuous.
fns = [f for a in sys.argv[2:] for f in a.split(",") if f]
cc1 = LADDER / ("gcc-%s-psx" % rung) / "cc1.exe"
assert cc1.exists(), cc1

# build.py's 272 recipe flags for THIS TU, minus what the rung rejects.
flags = ["-quiet", "-O2", "-G0", "-mgas"]
if not re.match(r"2\.[67]|2\.[67]\.", rung):
    flags.append("-mno-split-addresses")

alt_s = TMP / ("alt_%s.s" % rung)
r = subprocess.run([str(cc1), *flags, str(I), "-o", str(alt_s)],
                   capture_output=True, text=True)
if r.returncode:
    sys.exit("cc1 failed:\n" + r.stdout + r.stderr)
alt = MOVE_RE.sub(lambda m: "\taddu\t%s,%s,$0" % (m.group(2), m.group(3)),
                  alt_s.read_text(errors="replace"))


def region(txt, name):
    m = re.search(r"^\t\.ent\t%s\b[^\n]*\n" % re.escape(name), txt, re.M)
    if not m:
        return None
    m2 = re.search(r"^\t\.end\t%s[ \t]*$" % re.escape(name), txt[m.end():], re.M)
    return m.start(), m.end() + m2.end()


base = S.read_text(errors="replace")
for fn in fns:
    a, b = region(alt, fn), region(base, fn)
    if not a or not b:
        sys.exit("probe_272: no .ent/.end region for %r -- refusing to score an "
                 "unspliced object (that is how the first cut faked results)" % fn)
    assert alt[a[0]:a[1]] != base[b[0]:b[1]] or True
    base = base[:b[0]] + alt[a[0]:a[1]] + base[b[1]:]

probe_s, probe_o = TMP / "probe272.s", TMP / "probe272.o"
probe_s.write_text(base)
r = subprocess.run([AS, "-EL", "-march=r3000", "-mtune=r3000", "-G0",
                    "-I", str(ROOT / "include"), "-I", str(ROOT),
                    "-o", str(probe_o), str(probe_s)],
                   capture_output=True, text=True)
if r.returncode:
    sys.exit("as failed:\n" + r.stdout + r.stderr)

env = dict(os.environ, GATE_OBJ=str(probe_o))
print("== rung %s ==" % rung)
sys.stdout.flush()
subprocess.run([sys.executable, str(TMP / "gatecmp.py"), TU, ",".join(fns)],
               env=env)

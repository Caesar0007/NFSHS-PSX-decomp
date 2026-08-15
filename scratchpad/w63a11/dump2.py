#!/usr/bin/env python3
"""dump.py SRC [G] [TAG] -- real-CC1PLPSX -dl/-dg dump of the CURRENT on-disk SRC
into scratchpad/w62a11/<TAG>.i{,.lreg,.greg} + <TAG>.s.

PRIVATE output dir: tools/fast.py writes tools/v.i* which OTHER agents in the wave
clobber mid-run (observed 2026-08-15).  Never read tools/v.i* here.
"""
import os
import subprocess
import sys

ROOT = r'C:\Temp\nfs4-decomp'
HERE = os.path.join(ROOT, 'scratchpad', 'w63a11')
CPP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-cpp.exe"
CC1PL = r"C:/Temp/psq43/COMPILER/CC1PLPSX.EXE"
RECON = os.path.join(ROOT, 'recon')

src = sys.argv[1]
g = sys.argv[2] if len(sys.argv) > 2 else "4"
tag = sys.argv[3] if len(sys.argv) > 3 else "d"
i_file = os.path.join(HERE, tag + ".i")
s_file = os.path.join(HERE, tag + ".s")

r = subprocess.run([CPP, "-x", "c", "-D__cplusplus=1", "-nostdinc", "-undef",
                    "-Dmips", "-D__mips__", "-D__psx__", "-I" + RECON,
                    os.path.join(ROOT, src), "-o", i_file],
                   capture_output=True, text=True, cwd=ROOT)
if r.returncode:
    sys.exit("cpp FAILED: " + r.stderr[-400:])
for ext in (".lreg", ".greg"):
    try:
        os.remove(i_file + ext)
    except OSError:
        pass
subprocess.run([CC1PL, "-quiet", "-O2", "-fno-exceptions", "-fno-rtti", "-G" + g, "-dl", "-dg", i_file,
                "-o", s_file], capture_output=True, cwd=HERE)
for ext in ("", ".lreg", ".greg"):
    p = i_file + ext
    print("%-40s %s" % (os.path.basename(p),
                        os.path.getsize(p) if os.path.exists(p) else "MISSING"))
print("%-40s %s" % (os.path.basename(s_file),
                    os.path.getsize(s_file) if os.path.exists(s_file) else "MISSING"))

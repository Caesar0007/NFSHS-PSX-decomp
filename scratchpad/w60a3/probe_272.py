#!/usr/bin/env python3
"""W60-A3 probe: per-FN cc1-VERSION splice for a sub-2.8 rung.

PER_FN_CC1_VER_SPLICE_272 cannot reach the 2.6/2.7 rungs on this TU today,
because SYS.c's wiring carries `-mno-split-addresses` and every pre-2.8 cc1
rejects that option outright.  This probe answers the question the mechanism
would answer if it dropped unsupported flags for the splice compile: does the
older rung emit retail's shape for the named function?

  python probe_272.py <rung> <fn> [<fn> ...]

It compiles the ALREADY-PREPROCESSED .i (build.py's own cpp output) with the
rung's cc1 using the 272 recipe MINUS -mno-split-addresses, splices only the
named functions' .ent/.end regions into the wired .s, assembles with build.py's
`as` line, and byte-diffs vs the oracle (reloc/branch-target classes excluded,
exactly like verify_asm).
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
LADDER = Path(r"C:/Temp/windows-gcc-psx")
AS = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-as.exe"
OD = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump"
I = ROOT / "build/recon/syslib/psx/libgpu/SYS.c.i"
S = ROOT / "build/recon/syslib/psx/libgpu/SYS.c.s"
TMP = ROOT / "scratchpad/w60a3"

MOVE_RE = re.compile(r"^(\tmove\t)(\$[a-z0-9]+),(\$[a-z0-9]+)[ \t]*$", re.M)

rung = sys.argv[1]
fns = sys.argv[2:]
cc1 = LADDER / ("gcc-%s-psx" % rung) / "cc1.exe"
assert cc1.exists(), cc1

alt_s = TMP / ("alt_%s.s" % rung)
r = subprocess.run([str(cc1), "-quiet", "-O2", "-G0", "-mgas", str(I),
                    "-o", str(alt_s)], capture_output=True, text=True)
if r.returncode:
    sys.exit("cc1 failed:\n" + r.stdout + r.stderr)
alt = alt_s.read_text(errors="replace")
alt = MOVE_RE.sub(lambda m: "\taddu\t%s,%s,$0" % (m.group(2), m.group(3)), alt)


def region(txt, name):
    m = re.search(r"^\t\.ent\t%s\b[^\n]*\n" % re.escape(name), txt, re.M)
    if not m:
        return None
    m2 = re.search(r"^\t\.end\t%s[ \t]*$" % re.escape(name), txt[m.end():], re.M)
    return m.start(), m.end() + m2.end()


base = S.read_text(errors="replace")
for fn in fns:
    a = region(alt, fn)
    b = region(base, fn)
    if not a or not b:
        print("%-24s SKIP (no region)" % fn)
        continue
    base = base[:b[0]] + alt[a[0]:a[1]] + base[b[1]:]

probe_s = TMP / "probe272.s"
probe_o = TMP / "probe272.o"
probe_s.write_text(base)
r = subprocess.run([AS, "-EL", "-march=r3000", "-mtune=r3000", "-G0",
                    "-I", str(ROOT / "include"), "-I", str(ROOT),
                    "-o", str(probe_o), str(probe_s)], capture_output=True, text=True)
if r.returncode:
    sys.exit("as failed:\n" + r.stdout + r.stderr)

out = subprocess.run([OD, "-d", str(probe_o)], capture_output=True, text=True).stdout
for fn in fns:
    ours, words, grab = [], [], False
    for ln in out.splitlines():
        if ln.endswith("<%s>:" % fn):
            grab = True
            continue
        if grab:
            if not ln.strip():
                break
            mm = re.match(r"\s*[0-9a-f]+:\s+([0-9a-f]{8})\s+(.*)", ln)
            if mm:
                h = mm.group(1)
                words.append("".join(reversed([h[i:i + 2] for i in range(0, 8, 2)])))
                ours.append(re.sub(r"\s+", " ", mm.group(2).strip()))
    orc, ow = [], []
    for ln in open(ROOT / ("asm/nonmatchings/main/%s.s" % fn)):
        if ln.strip().startswith("nonmatching"):
            continue
        mm = re.search(r"/\*\s+\S+\s+[0-9A-F]{8}\s+([0-9A-F]{8})\s+\*/\s+(\S+)\s*(.*)$", ln)
        if mm:
            ow.append(mm.group(1).lower())
            orc.append(re.sub(r"\s+", " ", (mm.group(2) + " " + mm.group(3)).strip()))
    real = reloc = 0
    rows = []
    for i in range(max(len(ours), len(orc))):
        a = ours[i] if i < len(ours) else ""
        b = orc[i] if i < len(orc) else ""
        wa = words[i] if i < len(words) else ""
        wb = ow[i] if i < len(ow) else ""
        if wa != wb:
            if a.split()[:1] == b.split()[:1]:
                reloc += 1
            else:
                real += 1
                rows.append("      %3d %-38s | %s" % (i, a, b))
    print("%-24s rung %-10s ours=%-4d oracle=%-4d REAL=%d reloc=%d"
          % (fn, rung, len(ours), len(orc), real, reloc))
    for x in rows[:12]:
        print(x)

#!/usr/bin/env python3
"""Probe a full PER_FN_TEXT_MOVES spec (list of move dicts) for one SYS.c fn,
replicating tools/build.py's _apply_text_moves EXACTLY, then re-assembling with
build.py's own `as` command line and byte-diffing against the oracle.

  python probe_moves.py <fn> '<json list of moves>'
"""
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
AS = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-as.exe"
OD = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump"
S = ROOT / "build/recon/syslib/psx/libgpu/SYS.c.s"
OUTS = ROOT / "scratchpad/w60a3/probe.s"
OBJ = ROOT / "scratchpad/w60a3/probe.o"

name = sys.argv[1]
moves = json.loads(sys.argv[2])

txt = S.read_text(errors="replace")
m = re.search(r"^\t\.ent\t%s\b[^\n]*\n" % re.escape(name), txt, re.M)
assert m, "no .ent"
m2 = re.search(r"^\t\.end\t%s[ \t]*$" % re.escape(name), txt[m.end():], re.M)
end = m.end() + m2.start()
region = txt[m.start():end]

for i, mv in enumerate(moves):
    tk = re.search(mv["take"], region)
    assert tk, "move %d: take did not match" % i
    line = tk.group(0)
    region2 = region if mv.get("copy") else region[:tk.start()] + region[tk.end():]
    an = re.search(mv["after"], region2)
    assert an, "move %d: after did not match" % i
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

out = subprocess.run([OD, "-d", str(OBJ)], capture_output=True, text=True).stdout
ours, words, grab = [], [], False
for ln in out.splitlines():
    if ln.endswith("<%s>:" % name):
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
for ln in open(ROOT / ("asm/nonmatchings/main/%s.s" % name)):
    if ln.strip().startswith("nonmatching"):
        continue
    mm = re.search(r"/\*\s+\S+\s+[0-9A-F]{8}\s+([0-9A-F]{8})\s+\*/\s+(\S+)\s*(.*)$", ln)
    if mm:
        ow.append(mm.group(1).lower())
        orc.append(re.sub(r"\s+", " ", (mm.group(2) + " " + mm.group(3)).strip()))

reloc = 0
real = 0
for i in range(max(len(ours), len(orc))):
    a = ours[i] if i < len(ours) else ""
    b = orc[i] if i < len(orc) else ""
    wa = words[i] if i < len(words) else ""
    wb = ow[i] if i < len(ow) else ""
    mark = ""
    if wa != wb:
        # a reloc/branch-target artifact iff the mnemonic matches
        if a.split()[:1] == b.split()[:1]:
            reloc += 1
            mark = "   ~reloc"
        else:
            real += 1
            mark = "   <<< REAL"
    print("%3d %-40s | %-42s%s" % (i, a, b, mark))
print("ours=%d oracle=%d  REAL=%d  reloc-class=%d" % (len(ours), len(orc), real, reloc))

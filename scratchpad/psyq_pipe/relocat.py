"""relocat.py OBJ VA [VA ...] -- for a recon object placed on the text spine, print the relocation
(symbol + addend) that produced the word at each retail VA, plus where that symbol landed in the
honest link map.  Use on single-word honest diffs to name the misplaced symbol."""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OBJDUMP = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
NM = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe'
obj = sys.argv[1]
rel = obj.replace('\\', '/')
ld = (ROOT / 'linkers/nfs4_recon.ld').read_text(errors='replace')
m = re.search(r'(0x[0-9a-f]+) : SUBALIGN\(4\) \{ ' + re.escape(rel) + r'\(\.text\)', ld)
base = int(m.group(1), 16)
syms = {}
for ln in subprocess.run([NM, str(ROOT / 'build/gen_ld/recon_multdef-ok.elf')], capture_output=True, text=True).stdout.splitlines():
    p = ln.split()
    if len(p) == 3:
        syms.setdefault(p[2], int(p[0], 16))
out = subprocess.run([OBJDUMP, '-dr', '-j', '.text', str(ROOT / rel)], capture_output=True, text=True).stdout.splitlines()
for a in sys.argv[2:]:
    off = int(a, 16) - base
    hit = False
    for i, ln in enumerate(out):
        mm = re.match(r'\s*([0-9a-f]+):\s+([0-9a-f]{8})\s+(.*)', ln)
        if mm and int(mm.group(1), 16) == off:
            hit = True
            rl = out[i + 1].strip() if i + 1 < len(out) and 'R_MIPS' in out[i + 1] else '(no reloc)'
            sym = rl.split()[-1] if 'R_MIPS' in rl else ''
            name = re.sub(r'[+-]0x[0-9a-f]+$', '', sym)
            where = syms.get(name)
            print(f'{a} +{off:#x}: {mm.group(3).strip():32s} {rl}   -> ours {where:#x}' if where else f'{a} +{off:#x}: {mm.group(3).strip():32s} {rl}   -> (not in map)')
    if not hit:
        print(a, 'offset not found')

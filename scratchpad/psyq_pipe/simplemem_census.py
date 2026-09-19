"""simplemem_census.py -- which reconstructed objects lack the retail "SimpleMem" head of their .rodata?
For every rodata placement row: is the retail image immediately before the row "SimpleMem\\0" (12 bytes, or 12 + 4
pad when the row's first item is 8-aligned), and is that head not yet covered by the object?  Also reports the
object's first non-leaf function and the function that emits its first read-only literal (from the built .s)."""
import json
import re
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
LOAD = 0x80010000
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()[0x800:]
rows = json.load(open(ROOT / 'linkers/nfs4_recon.rodata_placement.json'))
extra = ROOT / 'linkers/nfs4_recon.rodata_extra.json'
if extra.exists():
    rows += json.load(open(extra))
TAG = b'SimpleMem\0'
out = []
for r in rows:
    b = r['base']
    head = None
    for back in (12, 16):
        o = b - back - LOAD
        if o >= 0 and rom[o:o + 10] == TAG and not any(rom[o + 10:o + back]):
            head = back
    if head is None:
        continue
    src = ROOT / r['obj'].replace('build/', '', 1)[:-2]
    sfile = ROOT / (r['obj'][:-2] + '.s')
    first_nonleaf = first_lit = None
    if sfile.exists():
        cur = None
        jal = {}
        order = []
        in_ro = False
        for ln in sfile.read_text(errors='replace').splitlines():
            m = re.match(r'\s*\.ent\s+(\S+)', ln)
            if m:
                cur = m.group(1)
                order.append(cur)
                jal[cur] = 0
            elif cur and re.match(r'\s*jal\s', ln):
                jal[cur] += 1
        first_nonleaf = next((f for f in order if jal[f]), None)
    out.append((b, head, r['obj'].split('build/recon/')[-1], first_nonleaf, src.exists()))
for b, head, o, f, ok in sorted(out):
    print(f'{b:#010x} head-{head:2d}  {o:46s} first non-leaf: {f}')
print(len(out), 'objects lack the head')

#!/usr/bin/env python3
"""cert_neutral.py -- turn the four splat-style certificate .s files (asm/nonmatchings/main/
{FntFlush,MemCardGetDirentry,MemCardFormat,_st_dma}.s, included verbatim by FONT.c / LIBMCRD.c /
stcdint.c) into assembler-dialect-neutral copies under asm/cert/: no macro.inc macros
(glabel -> .globl + label, endlabel -> .size, nonmatching dropped), numeric registers, C
comments stripped.  `.type`/`.size` stay (GNU objdiff needs them); the PSYLINK lane drops them
because the SN object format has no such metadata.  Bytes are unchanged by construction."""
import re
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp')
import sys
sys.path.insert(0, str(Path(__file__).parent))
from asmblocks import REG, REGPAT
OUT = ROOT / 'asm' / 'cert'; OUT.mkdir(exist_ok=True)
for name in ('FntFlush', 'MemCardGetDirentry', 'MemCardFormat', '_st_dma'):
    src = ROOT / 'asm' / 'nonmatchings' / 'main' / (name + '.s')
    out = []
    for ln in src.read_text().split('\n'):
        ln = re.sub(r'/\*.*?\*/', '', ln).rstrip()
        s = ln.strip()
        if not s:
            continue
        m = re.match(r'glabel\s+(\S+)$', s)
        if m:
            out.append('\t.globl\t%s' % m.group(1)); out.append('\t.type\t%s, @function' % m.group(1)); out.append('%s:' % m.group(1)); continue
        m = re.match(r'endlabel\s+(\S+)$', s)
        if m:
            out.append('\t.size\t%s, . - %s' % (m.group(1), m.group(1))); continue
        if s.startswith('nonmatching '):
            continue
        if s.startswith('.set '):
            out.append('\t' + s); continue
        if re.match(r'\.L\w+:$', s):
            out.append(s); continue
        # instruction: mnemonic + operands, registers numeric, single-space separated
        s = REGPAT.sub(lambda m: '$' + str(REG[m.group(1)]), s)
        parts = s.split(None, 1)
        out.append('\t' + parts[0] + ('\t' + re.sub(r'\s*,\s*', ',', parts[1]) if len(parts) > 1 else ''))
    (OUT / (name + '.s')).write_text('\n'.join(out) + '\n')
    print(name, len(out), 'lines ->', (OUT / (name + '.s')).relative_to(ROOT).as_posix())

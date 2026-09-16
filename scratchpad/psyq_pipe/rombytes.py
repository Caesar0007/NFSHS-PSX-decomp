#!/usr/bin/env python3
"""rombytes.py ADDR LEN [ADDR LEN ...] -- retail words at ADDR plus every label the asm/data
residual files or the retail SYM put inside the range (who owns those bytes today)."""
import re, sys
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp')
rom = ROOT.joinpath('rom/nfs4-f.exe').read_bytes()[0x800:]
LOAD = 0x80010000
labels = {}
for p in ROOT.joinpath('asm/data').glob('*.s'):
    for m in re.finditer(r'^(?:[dag]label|glabel|jlabel)\s+(\S+)|^(\S+):', p.read_text(errors='replace'), re.M):
        n = m.group(1) or m.group(2)
        mm = re.search(r'_([0-9A-Fa-f]{8})$', n)
        if mm: labels.setdefault(int(mm.group(1), 16), []).append(n + ' [' + p.name + ']')
sym = {}
for l in Path('C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt').read_text(errors='replace').splitlines():
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) (?:[126]|9[46] Def2? class (?:EXT|STAT) type (?!FCN).*name) (\S+)$', l)
    if m: sym.setdefault(int(m.group(1), 16), []).append(m.group(2))
args = sys.argv[1:]
for a, n in zip(args[::2], args[1::2]):
    a = int(a, 16); n = int(n, 16) if n.startswith('0x') else int(n)
    print('== %#x + %#x' % (a, n))
    for off in range(0, n, 16):
        chunk = rom[a - LOAD + off: a - LOAD + min(off + 16, n)]
        words = ' '.join(chunk[i:i + 4][::-1].hex() for i in range(0, len(chunk), 4))
        tags = []
        for k in range(off, min(off + 16, n), 4):
            for src in (labels, sym):
                if a + k in src: tags.append('%+#x:%s' % (k, ','.join(src[a + k])))
        print('   %#x  %-40s %s' % (a + off, words, '  '.join(tags)))

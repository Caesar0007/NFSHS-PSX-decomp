#!/usr/bin/env python3
"""objinv.py KEY [KEY...] -- per retail object: data-symbol inventory from the retail SYM
(Def/Def2 class EXT/STAT records inside the object's FILE block) vs our GNU object's symbols
(nm -S: section, size) and our PSYLINK addresses.  KEY = retail object base name, case-insensitive
(aiphysic, bworldsm, ...)."""
import re, sys, subprocess
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from images import ROOT, W, NM, RETAIL_SYM, our_symbols
RET = [('front.rdata', 0x80010000, 0x800128F0), ('front.text', 0x800128F0, 0x80051260),
       ('front.data', 0x80051260, 0x80052B38), ('front.bss', 0x80052B38, 0x80054548),
       ('.rdata', 0x80054548, 0x8005797C), ('.text', 0x8005797C, 0x8010CCD4), ('.data', 0x8010CCD4, 0x8013C54C),
       ('.sdata', 0x8013C54C, 0x8013DD7C), ('.sbss', 0x8013DD7C, 0x8013DEE0), ('.bss', 0x8013DEE0, 0x80148B04)]
def sec(a):
    for n, lo, hi in RET:
        if lo <= a < hi: return n
    return '?'
lines = RETAIL_SYM.read_text(errors='replace').splitlines()
# FILE blocks: records between the first and second FILE record of the same name
blocks = {}; openb = {}
for i, l in enumerate(lines):
    m = re.match(r'^[0-9a-f]+: \$[0-9a-f]{8} 94 Def class FILE type NULL size 0 name (\S+)', l)
    if m:
        n = m.group(1)
        if n in openb: blocks[n] = (openb.pop(n), i)
        else: openb[n] = i
def key_of(n):
    m = re.search(r'\(([^)]+)\)$', n); base = m.group(1) if m else n.split('\\')[-1]
    return base.rsplit('.', 1)[0].lower()
ours_addr = our_symbols()
# our object for a key: from the LNK
lnk = (ROOT / 'build/psyq/nfs4.lnk').read_text()
def our_obj(key):
    for l in lnk.splitlines():
        m = re.match(r'\tinclude\t(\S+)\t; (.*)$', l)
        if m and key_of(m.group(2)) == key and not m.group(1).startswith('gap__'):
            return m.group(1)
    return None
for key in [k.lower() for k in sys.argv[1:]]:
    names = [n for n in blocks if key_of(n) == key]
    if not names:
        print('== %s: no retail FILE block' % key); continue
    n = names[0]; a, b = blocks[n]
    print('== %s  (%s, SYM lines %d..%d)' % (key, n.split('\\')[-1], a, b))
    rows = []
    for l in lines[a:b]:
        m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) 9[46] Def2? class (EXT|STAT) type (.*?) size (\d+) (?:dims [\d ]+ )?(?:tag \S* )?name (\S+)$', l)
        if m and 'FCN' not in m.group(3):
            rows.append((int(m.group(1), 16), m.group(2), m.group(3), int(m.group(4)), m.group(5)))
    rows.sort()
    ob = our_obj(key)
    print('   our object:', ob)
    oursyms = {}
    if ob:
        m = re.match(r'(recon__.*)\.obj$', ob)
        gnu = ROOT / 'build' / (m.group(1).replace('__', '/') + '.o')
        r = subprocess.run([NM, '-S', str(gnu)], capture_output=True, text=True)
        for l in r.stdout.splitlines():
            mm = re.match(r'^([0-9a-f]+) (?:([0-9a-f]+) )?(\w) (\S+)$', l)
            if mm: oursyms[mm.group(4)] = (mm.group(3), int(mm.group(2), 16) if mm.group(2) else 0)
    for addr, cls, typ, size, name in rows:
        o = oursyms.get(name); oa = ours_addr.get(name)
        flag = '' if o else '  <-- NOT IN OUR OBJECT'
        if o and cls == 'EXT' and o[0] in 'Uu': flag = '  <-- UNDEFINED in ours (owned elsewhere)'
        print('   %s %-11s %-4s %-32s size %-5d %-28s | ours %s%s' % (hex(addr), sec(addr) if addr > 0x80000000 else 'rel', cls, typ[:32], size, name[:28], ('%s sz %d @%s' % (o[0], o[1], hex(oa) if oa else '-')) if o else '-', flag))
    # our symbols the retail block does not list (extra definitions in our object)
    ret = {name for *_, name in rows}
    extra = [(nm_, s) for nm_, s in oursyms.items() if s[0] in 'DdBbSsRrCc' and nm_ not in ret and not nm_.startswith(('.L', '$L', 'L'))]
    if extra:
        print('   our object also DEFINES (not in retail block):', ', '.join('%s(%s,%d)' % (nm_, s[0], s[1]) for nm_, s in sorted(extra))[:600])

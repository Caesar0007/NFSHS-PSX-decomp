#!/usr/bin/env python3
"""boundary.py SYMBOL [SYMBOL...] -- for a retail symbol at a drift change point show the
bytes just before it in retail vs in our CPE image, plus the honest-map input section that
owns those retail bytes (the previous object's tail)."""
import re, sys, struct
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp'); W = ROOT / 'scratchpad' / 'psyq_pipe'
rom = ROOT.joinpath('rom/nfs4-f.exe').read_bytes()[0x800:]
LOAD = 0x80010000
# our image from the CPE
cpe = ROOT.joinpath('build/psyq/nfs4.cpe').read_bytes(); img = bytearray(len(rom)); i = 4
while i < len(cpe):
    t = cpe[i]; i += 1
    if t == 0: break
    if t == 1:
        addr, ln = struct.unpack_from('<II', cpe, i); i += 8; d = cpe[i:i + ln]; i += ln
        o = addr - LOAD
        if 0 <= o and o + ln <= len(rom): img[o:o + ln] = d
    else:
        i += {2: 4, 3: 6, 4: 2, 5: 4, 6: 4, 7: 4, 8: 1}[t]
ours = {}
for l in (W / 'nfs4_sym.txt').read_text().splitlines():
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) [126] (\S+)$', l)
    if m: ours.setdefault(m.group(2), int(m.group(1), 16))
retail = {}
for l in Path('C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt').read_text(errors='replace').splitlines():
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) 9[46] Def2? class (EXT|STAT) .* name (\S+)$', l)
    if m: retail.setdefault(m.group(3), int(m.group(1), 16))
maprows = []
for m in re.finditer(r'^ (\.\S+)\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(\S+\.o)$', ROOT.joinpath('build/gen_ld/recon_multdef-ok.map').read_text(errors='replace'), re.M):
    if int(m.group(3), 16): maprows.append((int(m.group(2), 16), int(m.group(3), 16), m.group(1), m.group(4)))
def owner(va):
    hits = [(a, s, sec, o) for a, s, sec, o in maprows if a <= va < a + s]
    return hits
for name in sys.argv[1:]:
    ra = retail.get(name); oa = ours.get(name)
    print('== %s retail %s ours %s' % (name, hex(ra) if ra else None, hex(oa) if oa else None))
    if ra:
        print('   retail bytes before:', rom[ra - LOAD - 16: ra - LOAD].hex(' ', 4), '| at:', rom[ra - LOAD: ra - LOAD + 8].hex(' ', 4))
        for a, s, sec, o in owner(ra - 4): print('   honest owner of retail-4:', hex(a), hex(s), sec, o)
        for a, s, sec, o in owner(ra): print('   honest owner of retail   :', hex(a), hex(s), sec, o)
    if oa:
        print('   ours   bytes before:', img[oa - LOAD - 16: oa - LOAD].hex(' ', 4), '| at:', img[oa - LOAD: oa - LOAD + 8].hex(' ', 4))

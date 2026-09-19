"""ps_stamps.py -- Sony library objects that carry a version stamp open their .data with 8 bytes `50 73 <lib> 25 9B 5x 43 00`
("Ps", library id, version).  List every stamp in the retail data image, the recon object placed right after it (its
likely owner: the stamp is the first 8 bytes of that object's .data) and whether the stamp bytes are still blob-only."""
import json
import re
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
LOAD = 0x80010000
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()[0x800:]
rows = json.load(open(ROOT / 'linkers/nfs4_recon.data_extra.json'))
lines = (ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace').splitlines()
own = {}
one = re.compile(r'^ (\.\S+)\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')
two = re.compile(r'^\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')
spans = []
for i, ln in enumerate(lines):
    m = one.match(ln)
    if m:
        spans.append((int(m.group(2), 16), int(m.group(3), 16), m.group(4)))
    elif re.match(r'^ \.\S+$', ln) and i + 1 < len(lines):
        m = two.match(lines[i + 1])
        if m:
            spans.append((int(m.group(1), 16), int(m.group(2), 16), m.group(3)))
spans = [(a, s, o.replace('\\', '/')) for a, s, o in spans if s]


def owner(a):
    rs = [o for b, s, o in spans if b <= a < b + s]
    rec = [o for o in rs if 'build/recon/' in o]
    return (rec or rs or ['-'])[0].replace('build/recon/', '').replace('build/asm/data/', 'BLOB:')


for m in re.finditer(rb'\x50\x73[\x00-\x20]\x25\x9b[\x50-\x5f]\x43\x00', rom):
    if m.start() % 4:
        continue
    a = LOAD + m.start()
    print('%#010x  lib %02x  %s   stamp: %-44s next: %s' % (a, rom[m.start() + 2], rom[m.start():m.start() + 8].hex(),
                                                          owner(a), owner(a + 8)))

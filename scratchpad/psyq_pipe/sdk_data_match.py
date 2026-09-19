"""sdk_data_match.py [--all] -- name the OWNER of unowned retail data by matching PsyQ 4.3 library objects' initialized data.
For every extracted SDK object (C:/Temp/nfs4-clean/psyq43/extracted/*/obj/*.obj) with a non-empty .data/.sdata, slide its
bytes (relocated words masked) over the retail data image and report placements that overlap a blob-only byte run
(same ownership logic as blob_runs.py).  A placement needs >= 6 matching NON-ZERO unmasked bytes to count.
--all: also print placements over bytes that a recon object already owns (cross-check of existing rows)."""
import re
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
import objtruth  # noqa: E402

SDK = Path('C:/Temp/nfs4-clean/psyq43/extracted')
LOAD = 0x80010000
DATA0 = 0x8010CCD4
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()[0x800:]
n = len(rom)
lines = (ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace').splitlines()
recon, blob = bytearray(n), bytearray(n)
one = re.compile(r'^ (\.\S+)\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')
two = re.compile(r'^\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')


def mark(a, sz, src):
    src = src.replace('\\', '/')
    t = recon if 'build/recon/' in src else blob if 'build/asm/' in src else None
    if t is None or not sz or not (LOAD <= a < LOAD + n):
        return
    for i in range(a - LOAD, min(a - LOAD + sz, n)):
        t[i] = 1


for i, ln in enumerate(lines):
    m = one.match(ln)
    if m:
        mark(int(m.group(2), 16), int(m.group(3), 16), m.group(4))
    elif re.match(r'^ \.\S+$', ln) and i + 1 < len(lines):
        m = two.match(lines[i + 1])
        if m:
            mark(int(m.group(1), 16), int(m.group(2), 16), m.group(3))
ALL = '--all' in sys.argv
lo = DATA0 - LOAD
for obj in sorted(SDK.glob('*/obj/*.obj')):
    try:
        r = objtruth.parse_obj(str(obj))
    except Exception:
        continue
    names = r['sections']
    for sid, data in r['code'].items():
        sec = names.get(sid, '?')
        if sec not in ('.data', '.sdata') or len(data) < 8:
            continue
        mask = bytearray(b'\x01' * len(data))
        for p in r['patches']:
            if p['sect'] == sid:
                for k in range(p['off'], min(p['off'] + 4, len(data))):
                    mask[k] = 0
        idx = [k for k in range(len(data)) if mask[k]]
        strong = [k for k in idx if data[k]]
        if len(strong) < 6:
            continue
        k0 = strong[0]
        pos = lo
        while True:
            pos = rom.find(data[k0:k0 + 1], pos)
            if pos < 0:
                break
            base = pos - k0
            pos += 1
            if base < lo or base + len(data) > n or base % 4:
                continue
            if all(rom[base + k] == data[k] for k in idx):
                unowned = sum(1 for k in range(len(data)) if blob[base + k] and not recon[base + k])
                if unowned or ALL:
                    print('%#010x +%-5d %-8s %s/%s   unowned %d B' % (LOAD + base, len(data), sec, obj.parent.parent.name,
                                                                     obj.name, unowned))

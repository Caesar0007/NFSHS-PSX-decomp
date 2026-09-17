"""Stage 2 rows: the AIHigh vtables now live in their owning TUs' .rodata.  Drop the 13 hand
vtables_aihigh_g*.cpp objects (data rows + sources + build objects) and (re)place each AI TU's
.rodata window at the retail address of its first table (vtdump.py 2026-09-17)."""
import json
import re
import subprocess
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
OBJDUMP = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
BASES = {
    'aihigh': 0x80054dcc, 'aih_basicperp': 0x80054e6c, 'aih_basiccop': 0x80054e9c,
    'aih_btccop': 0x80054ec4, 'aih_btcperp': 0x80054fa0, 'aih_play': 0x80055098,
    'aih_hum': 0x800550c8, 'aih_opp': 0x800550f8, 'aih_cop': 0x80055154, 'aih_traf': 0x800551b0,
}


def rodata_size(obj):
    out = subprocess.run([OBJDUMP, '-h', str(obj)], capture_output=True, text=True).stdout
    m = re.search(r'^\s*\d+\s+\.rodata\s+([0-9a-f]{8})', out, re.M)
    return int(m.group(1), 16) if m else 0


# 1. data rows of the hand tables
p = ROOT / 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
keep = [r for r in rows if 'vtables_aihigh_g' not in r['obj']]
print('data_extra rows dropped', len(rows) - len(keep))
json.dump(keep, open(p, 'w'), indent=1)

# 2. rodata rows
p = ROOT / 'linkers/nfs4_recon.rodata_placement.json'
rows = json.load(open(p))
by = {r['obj']: r for r in rows}
for tu, base in BASES.items():
    obj = f'build/recon/game/common/{tu}.cpp.o'
    size = rodata_size(ROOT / obj)
    assert size, tu
    r = by.get(obj)
    if r is None:
        r = {'obj': obj, 'base': base, 'end': base + size, 'size': size, 'ok': False, 'regions': []}
        rows.append(r)
        print('row NEW', tu, hex(base), hex(size))
    else:
        print('row', tu, hex(r['base']), hex(r['size']), '->', hex(base), hex(size))
        r['base'], r['end'], r['size'] = base, base + size, size
json.dump(rows, open(p, 'w'), indent=1)

# 3. sources + objects
srcs = sorted((ROOT / 'recon/game/common').glob('vtables_aihigh_g*.cpp'))
print('git rm', len(srcs))
subprocess.run(['git', 'rm', '-q'] + [str(s.relative_to(ROOT).as_posix()) for s in srcs], cwd=ROOT, check=True)
for s in srcs:
    for ext in ('.o', '.s', '.i'):
        f = ROOT / 'build' / (s.relative_to(ROOT).as_posix() + ext)
        if f.exists():
            f.unlink()
print('done')

"""fevirt_rodata_rows.py [--apply] -- rodata rows for front-end objects that now emit vtables.
For each object: the classes whose tables it emits (nm `_vt.`), retail's address+size of those tables (from the hand
tables kept on `main`), the object's built .rodata size.  A vtable batch closes the section, so
    end  = retail end of the object's LAST table,   base = end - built size
and that base must equal the existing row's base when there is one (strings precede the tables)."""
import glob
import json
import os
import re
import subprocess
import sys

R = 'C:/Temp/nfs4-decomp/'
NM = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe'
OD = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
APPLY = '--apply' in sys.argv
tab = {}
for ref in ('main', 'main~12'):
    ls = subprocess.run(['git', 'ls-tree', '--name-only', ref, 'recon/game/common/'], capture_output=True, text=True, cwd=R).stdout.split()
    for g in ls:
        if 'vtables_t' not in g:
            continue
        t = subprocess.run(['git', 'show', ref + ':' + g], capture_output=True, text=True, cwd=R).stdout
        for m in re.finditer(r'^__vtbl_ptr_type (\w+)_vtable\[(\d+)\] = \{\s*/\* @0x([0-9a-f]+)', t, re.M):
            tab.setdefault(m.group(1), (int(m.group(3), 16), int(m.group(2)) * 8))
P = R + 'linkers/nfs4_recon.rodata_placement.json'
rows = json.load(open(P))
byobj = {r['obj']: r for r in rows}
changed = 0
for o in sorted(glob.glob(R + 'build/recon/frontend/common/*.cpp.o')):
    o = o.replace('\\', '/')
    rel = o.replace(R, '')
    if not os.path.exists(o.replace('/build/recon/', '/recon/')[:-2]):
        continue
    nm = subprocess.run([NM, rel], capture_output=True, text=True, cwd=R).stdout
    cls = re.findall(r' [RrDd] _vt\.\d+(\w+)$', nm, re.M)
    known = [c for c in cls if c in tab]
    if not known:
        continue
    h = subprocess.run([OD, '-h', rel], capture_output=True, text=True, cwd=R).stdout
    m = re.search(r'\.rodata\s+([0-9a-f]{8})', h)
    size = int(m.group(1), 16)
    end = max(tab[c][0] + tab[c][1] for c in known)
    base = end - size
    old = byobj.get(rel)
    note = 'NEW' if not old else ('same base' if old['base'] == base else 'BASE WAS %#x' % old['base'])
    if not old or old['end'] != end or old['base'] != base:
        print('%-24s %#x..%#x  size %#x  %s%s' % (rel.split('/')[-1][:-6], base, end, size, note,
                                                 '' if not [c for c in cls if c not in tab] else '  unknown: ' + ','.join(c for c in cls if c not in tab)))
        if APPLY:
            if old:
                old.update({'base': base, 'end': end, 'size': size})
            else:
                rows.append({'obj': rel, 'base': base, 'end': end, 'size': size, 'ok': False, 'regions': []})
            changed += 1
if APPLY:
    json.dump(rows, open(P, 'w'), indent=1)
    print('rows written:', changed)

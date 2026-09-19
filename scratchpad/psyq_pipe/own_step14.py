"""Blob ownership step 14 (2026-09-19) -- the read-only window 0x800559D0..0x80055A28 between cars and control's jump table.
Retail bytes: tag 9D0, tag 9DC, tag 9E8, tag 9F4, up-vector {0,0x10000,0} @A00, tag A0C, tag A18, 4 B pad, jtbl A28.
collide.cpp is the only user of the up-vector (it read it through the dump label D_80055A00), so the vector ANCHORS the
window: an object's rodata opens with its tag => collide = 9F4..A0C, the two tags after it = color, control (link order),
and of the three tags before it two are chunk and clock.  The third (9E8, placed last here) belongs to an object with NO
text between cars and collide in link order -- still unidentified, left as retail bytes.
  collide  upVec becomes a local brace initializer (same law as aih_traf's trafficOffset)."""
import json
import re

R = 'C:/Temp/nfs4-decomp/'
STMT = '\n  if (0) sprintf((char *)0,"SimpleMem");   /* retail: this object\'s .rodata opens with the unreferenced "SimpleMem" tag */'
SITES = {
    'chunk': 'void Chunk::InstanceGroup(SerializedGroup *chunkGroup, SimpleMem *mem)\n{',
    'clock': 'void Clock_MasterInterruptHandler(void)\n{',
    'collide': 'void Collide_DoObjectFixedObjectCollision(BO_tNewtonObj *o,coorddef *p,coorddef *v,coorddef *n)\n{',
    'color': 'int Risk_ReadNextValue(char **aScript)\n{',
    'control': 'void Control_Human(Car_tObj *carObj)\n{',
}
for name, sig in SITES.items():
    f = R + 'recon/game/common/%s.cpp' % name
    s = open(f, encoding='utf-8').read()
    assert s.count(sig) == 1, name
    s = s.replace(sig, sig + STMT)
    if name == 'collide':
        a = '        coorddef upVec;\n'
        b = '        upVec = D_80055A00;   /* {0, 0x10000, 0} */\n'
        assert s.count(a) == 1 and s.count(b) == 1
        s = s.replace(b, '')
        s = s.replace(a, '        coorddef upVec = { 0, 0x10000, 0 };   /* local aggregate initializer: its constant is retail .rodata 0x80055A00 */\n')
    if not re.search(r'\bsprintf\s*\(', s.replace('if (0) sprintf', '')) and 'int sprintf' not in s:
        incs = [m.end() for m in re.finditer(r'^#include[^\n]*\n', s, re.M)]
        s = s[:incs[-1]] + 'extern "C" int sprintf(char *, const char *, ...);\n' + s[incs[-1]:]
    open(f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', name)

f = R + 'recon/game/common/collide_externs.h'
s = open(f, encoding='utf-8').read()
s, n = re.subn(r'^extern coorddef\s+D_80055A00;[^\n]*\n', '', s, flags=re.M)
assert n == 1
open(f, 'w', encoding='utf-8', newline='').write(s)

p = R + 'linkers/nfs4_recon.rodata_placement.json'
rows = json.load(open(p))
NEW = {'chunk': (0x800559D0, 0x800559DC), 'clock': (0x800559DC, 0x800559E8), 'collide': (0x800559F4, 0x80055A0C),
       'color': (0x80055A0C, 0x80055A18), 'control': (0x80055A18, 0x80055A54)}
rows = [r for r in rows if not any(r['obj'].endswith('game/common/%s.cpp.o' % k) for k in NEW)]
for k, (b, e) in NEW.items():
    rows.append({'obj': 'build/recon/game/common/%s.cpp.o' % k, 'base': b, 'end': e, 'size': e - b, 'ok': False, 'regions': []})
json.dump(rows, open(p, 'w'), indent=1)

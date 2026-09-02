"""M3_slotmap.py STREAM — map frame spill slot -> the this+K member address it holds.

Scans for `addiu rD,rB,K` (K = a member offset off `this`) whose register is then
stored by `sw rD,S(sp)` with S >= 156 (frame local area).  Prints slot -> K (hex).
"""
import re, sys
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w84')
from R02_norm import load

def get(p):
    if p.endswith('.s'):
        return [x for x in load(p) if not x.startswith('endlabel')]
    return [l for l in open(p).read().splitlines() if l.strip()]

st = get(sys.argv[1])
A = re.compile(r'^addiu (\w+),(\w+),(\d+)$')
S = re.compile(r'^sw (\w+),(\d+)\(sp\)$')
val = {}
out = []
for ins in st:
    m = A.match(ins)
    if m and int(m.group(3)) > 100:
        val[m.group(1)] = int(m.group(3))
        continue
    m = S.match(ins)
    if m and int(m.group(2)) >= 150:
        r, slot = m.group(1), int(m.group(2))
        if r in val:
            out.append((slot, val[r]))
        continue
    # any other def of a register kills its tracked value
    m = re.match(r'^(?:lw|li|addu|subu|lui|or|and|sll|srl|sra|ori|addiu|slt\w*) (\w+),', ins)
    if m:
        val.pop(m.group(1), None)
d = {}
for slot, k in out:
    d.setdefault(slot, []).append(k)
for slot in sorted(d):
    print('%4d : %s' % (slot, ' '.join('+0x%X' % k for k in d[slot])))

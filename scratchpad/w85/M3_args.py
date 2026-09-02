"""M3_args.py A B — per-call OUTGOING STACK ARGUMENT audit between two streams.

Splits each stream into the blocks delimited by `jal` (delay-slot instruction
hoisted ABOVE its jal, since it executes before the call), then records for each
call the set of outgoing-argument stack slots written in that block
(`sw rX,N(sp)` with N in the o32 outgoing area 16..152).  A call whose slot SET
differs between the two streams passes a different NUMBER (or arrangement) of
stack arguments => a real SOURCE difference, not an allocation difference.

Usage: python M3_args.py <A.s|A.txt> <B.s|B.txt>
"""
import re, sys
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w84')
from R02_norm import load

ARGMAX = 152   # slots at/above this are frame locals in this function


def get(p):
    if p.endswith('.s'):
        return [x for x in load(p) if not x.startswith('endlabel')]
    return [l for l in open(p).read().splitlines() if l.strip()]


def blocks(st):
    """[(arg_slots_set,)] per call, delay slot hoisted above its jal."""
    s = list(st)
    # hoist: swap jal with the following instruction
    i = 0
    while i < len(s) - 1:
        if s[i].startswith('jal'):
            s[i], s[i + 1] = s[i + 1], s[i]
            i += 2
        else:
            i += 1
    out = []
    cur = []
    for ins in s:
        if ins.startswith('jal'):
            out.append(cur)
            cur = []
        else:
            cur.append(ins)
    out.append(cur)
    return out


D = re.compile(r'^sw (\w+),(\d+)\(sp\)$')


def slots(blk):
    r = set()
    for ins in blk:
        m = D.match(ins)
        if m and int(m.group(2)) <= ARGMAX:
            r.add(int(m.group(2)))
    return r


A, B = get(sys.argv[1]), get(sys.argv[2])
ba, bb = blocks(A), blocks(B)
print('calls: %d vs %d' % (len(ba) - 1, len(bb) - 1))
n = min(len(ba), len(bb))
bad = 0
for i in range(n):
    sa, sb = slots(ba[i]), slots(bb[i])
    if sa != sb:
        bad += 1
        print('call %3d  A=%-28s B=%s' % (i, sorted(sa), sorted(sb)))
print('differing call blocks:', bad)

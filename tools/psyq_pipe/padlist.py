"""padlist.py <header> [--ccoord] [--pre "#define X" ...] -- the header stops defining NFS4_PADS_HOOK_AFTER/_BEFORE and
lists the core start itself: minimal core, [own types], pad records, [own types], pad tail.
Placed before the first #include that follows the last pad-hook define. Verify with ichk.sh."""
import re
import sys

p = sys.argv[1].replace(chr(92), '/')
s = open(p, encoding='latin-1', newline='').read()
nl = chr(13) + chr(10) if chr(13) in s else chr(10)
L = s.split(nl)
pre = '' if '/game/common/' in p else ('../common/' if '/game/psx/' in p else '../../game/common/')
base = p.split('/')[-1]
own = {}
last = -1
for i, x in enumerate(L):
    m = re.match(r'#define NFS4_PADS_HOOK_(AFTER|BEFORE) "([^"]+)"', x)
    if m:
        own[m.group(1)] = (i, m.group(2))
        last = max(last, i)
assert own, 'no pad hook in ' + p
k = next(i for i in range(last + 1, len(L)) if L[i].lstrip().startswith('#include'))
extra = []
a = sys.argv[2:]
while '--pre' in a:
    j = a.index('--pre')
    extra.append(a[j + 1])
    del a[j:j + 2]


def inc(v, marker):
    if v.split('/')[-1] == base:
        return ['#define ' + marker, '#include "%s"   /* this header again: its %s branch */' % (v, marker), '#undef ' + marker]
    if v == 'gamesetup_leaf_types.h' and pre:
        v = pre + v
    return ['#include "%s"   /* own types at this point */' % v]


blk = list(extra)
if '--ccoord' in a:
    blk.append('#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */')
blk += ['#define NFS4_CORE_FULL   /* this object lists the start of the core itself (retail record order) */',
        '#define NFS4_GAME_COMMON_MIN_TYPES_H', '#define NFS4_GAME_COMMON_PADS_TYPES_H',
        '#include "%sgame_common_min_core.h"' % pre]
if 'BEFORE' in own:
    blk += inc(own['BEFORE'][1], 'NFS4_PADS_IN_HOOK_BEFORE')
blk.append('#include "%spads_records.h"' % pre)
if 'AFTER' in own:
    blk += inc(own['AFTER'][1], 'NFS4_PADS_IN_HOOK')
blk += ['#include "%spads_tail.h"' % pre, '#undef NFS4_CORE_FULL']
if '--ccoord' in a:
    blk.append('#undef NFS4_CORE_CCOORD16')
L[k:k] = blk
for h, (i, v) in sorted(own.items(), key=lambda x: -x[1][0]):
    del L[i]
open(p, 'w', encoding='latin-1', newline='').write(nl.join(L))
print('PADLIST OK', p, sorted(own))

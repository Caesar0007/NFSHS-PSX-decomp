"""leaflist.py <header> -- the header stops defining NFS4_DRAW_LEAF_HOOK_* and lists the draw-leaf parts itself,
with its own headers at the hook points. The list is placed before the first #include that follows the last hook
define. Verify each object with ichk.sh (identical preprocessed source)."""
import re
import sys

p = sys.argv[1].replace(chr(92), '/')
s = open(p, encoding='latin-1', newline='').read()
nl = chr(13) + chr(10) if chr(13) in s else chr(10)
L = s.split(nl)
if '/game/common/' in p:
    pre = ''
elif '/game/psx/' in p:
    pre = '../common/'
else:
    pre = '../../game/common/'
own = {}
last = -1
for i, x in enumerate(L):
    m = re.match(r'#define NFS4_DRAW_LEAF_HOOK_(AFTER_\w+) "([^"]+)"', x)
    if m:
        own[m.group(1)] = (i, m.group(2))
        last = max(last, i)
assert own, 'no draw-leaf hook defined in ' + p
k = next(i for i in range(last + 1, len(L)) if L[i].lstrip().startswith('#include'))
order = [('draw_leaf_a_pads.h', 'AFTER_PADS'), ('draw_leaf_b_pixmap.h', 'AFTER_PIXMAP'), ('draw_leaf_c_cache.h', 'AFTER_CACHEHEADER'),
         ('draw_leaf_d_carvertex.h', 'AFTER_CARVERTEX')]
blk = (['#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */'] if '--ccoord' in sys.argv else []) + ['#include "%sdraw_leaf_core.h"' % pre,
       '#if !defined(NFS4_DRAW_LEAF_CORE_ONLY) && !defined(NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H)   /* this object lists the draw leaf itself (retail record order) */',
       '#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H']
for part, h in order:
    if part == 'draw_leaf_a_pads.h' and '--ccoord' in sys.argv:
        blk += ['#include "%s%s"' % (pre, part), '#undef NFS4_CORE_CCOORD16']
    else:
        blk.append('#include "%s%s"' % (pre, part))
    if h in own:
        v = own[h][1]
        blk.append('#include "%s"   /* own types at this point */' % v)
blk.append('#endif')
L[k:k] = blk
for h, (i, v) in sorted(own.items(), key=lambda x: -x[1][0]):
    del L[i]
open(p, 'w', encoding='latin-1', newline='').write(nl.join(L))
print('LEAFLIST OK', p, sorted(own))

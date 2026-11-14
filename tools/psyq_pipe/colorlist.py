"""colorlist.py <types.h> HOOK=header [HOOK=header ...]
Replace `#include "color_types.h"` in an object's types header by the plain list of the ten parts, with the
object's own headers at the given hook points (HOOK = GROUP_LATE_TRK, BEFORE_GROUP, AFTER_SIMSLICE, AFTER_RELCOORD,
AFTER_SAVE, AFTER_BWSM, AFTER_BO, AFTER_SCHED, AFTER_CAR). The object's `#define NFS4_COLOR_HOOK_*` lines are removed.
A header given as IN:<marker>:<file> is wrapped in #define/#undef of that marker (self-include second passes)."""
import re
import sys

HOOKS = ['GROUP_LATE_TRK', 'BEFORE_GROUP', 'AFTER_SIMSLICE', 'AFTER_RELCOORD', 'AFTER_SAVE', 'AFTER_BWSM', 'AFTER_BO',
         'AFTER_SCHED', 'AFTER_CAR']
NAMES = ['color_p0_draw.h', 'color_p1_pregroup.h', 'color_p2_group_trk.h', 'color_p3_trkobj.h', 'color_p4_save.h',
         'color_p5_bwsm.h', 'color_p6_bo.h', 'color_p7_sched.h', 'color_p8_car.h', 'color_p9_tail.h']
MARK = {'AFTER_RELCOORD': 'NFS4_COLOR_IN_HOOK5', 'AFTER_SAVE': 'NFS4_COLOR_IN_HOOK3', 'AFTER_BWSM': 'NFS4_COLOR_IN_BWSM',
        'AFTER_BO': 'NFS4_COLOR_IN_HOOK', 'AFTER_CAR': 'NFS4_COLOR_IN_HOOK2'}
p = sys.argv[1]
own = dict(a.split('=', 1) for a in sys.argv[2:])
s = open(p, encoding='latin-1', newline='').read()
nl = chr(13) + chr(10) if chr(13) in s else chr(10)
L = s.split(nl)
pre = '../common/' if '/psx/' in p.replace(chr(92), '/') else ''
k = [i for i, x in enumerate(L) if re.match(r'#include "(\.\./common/)?color_types\.h"', x.strip())]
assert len(k) == 1, k
k = k[0]
defined = {}
for i, x in enumerate(L):
    m = re.match(r'#define NFS4_COLOR_HOOK_(\w+) "([^"]+)"', x)
    if m:
        defined[m.group(1)] = (i, m.group(2))
assert set(defined) == set(own), (sorted(defined), sorted(own))
lst = ['#define NFS4_GAME_COMMON_COLOR_TYPES_H   /* this object lists the parts of the common type graph itself (retail record order) */']
for i, n in enumerate(NAMES):
    lst.append('#include "%s%s"' % (pre, n))
    if i < len(HOOKS) and HOOKS[i] in own:
        h = own[HOOKS[i]]
        if HOOKS[i] in MARK and h == defined[HOOKS[i]][1] and h.split('/')[-1] == p.replace(chr(92), '/').split('/')[-1]:
            lst += ['#define ' + MARK[HOOKS[i]], '#include "%s"   /* this header again: its %s branch */' % (h, MARK[HOOKS[i]]), '#undef ' + MARK[HOOKS[i]]]
        else:
            lst.append('#include "%s"   /* own types at this point of the retail record order */' % h)
L[k:k + 1] = lst
for h, (i, v) in sorted(defined.items(), key=lambda x: -x[1][0]):
    del L[i]
open(p, 'w', encoding='latin-1', newline='').write(nl.join(L))
print('LIST OK', p, sorted(own))

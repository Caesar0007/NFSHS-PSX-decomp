"""corelist.py <header> [--full] [--ea] [--ccoord] -- the header stops defining NFS4_CORE_HOOK_* and lists the five
parts of the root type graph itself with its own headers at the hook points. Placed before the first #include that
follows the last core-hook define. --full / --ea / --ccoord reproduce the switches that were active when the object
first reached nfs4_types.h. Verify with ichk.sh."""
import re
import sys

p = sys.argv[1].replace(chr(92), '/')
s = open(p, encoding='latin-1', newline='').read()
nl = chr(13) + chr(10) if chr(13) in s else chr(10)
L = s.split(nl)
own = {}
last = -1
for i, x in enumerate(L):
    m = re.match(r'#define NFS4_CORE_HOOK_(\w+) "([^"]+)"', x)
    if m:
        own[m.group(1)] = (i, m.group(2))
        last = max(last, i)
assert own, 'no core hook in ' + p
at = sys.argv[sys.argv.index("--at") + 1] if "--at" in sys.argv else "#include"
k = next(i for i in range(last + 1, len(L)) if L[i].lstrip().startswith("#include") and at in L[i])
sw = [('--ccoord', 'NFS4_CORE_CCOORD16'), ('--full', 'NFS4_CORE_FULL'), ('--ea', 'NFS4_CORE_EA')]
blk = ['#define %s' % m for f, m in sw if f in sys.argv]
blk.append('#define NFS4_TYPES_H   /* this object lists the root type graph itself (retail record order) */')
order = [('nfs4_core_0_kernel.h', 'AFTER_PADS'), ('nfs4_core_1_gpu.h', 'AFTER_DRMODE'), ('nfs4_core_2_shape.h', 'BEFORE_CD'),
         ('nfs4_core_3_cd.h', 'AFTER_CD'), ('nfs4_core_4_tail.h', None)]
for part, h in order:
    blk.append('#include "%s"' % part)
    if h in own:
        blk.append('#include "%s"   /* own types at this point */' % own[h][1])
blk += ['#undef %s' % m for f, m in reversed(sw) if f in sys.argv]
L[k:k] = blk
for h, (i, v) in sorted(own.items(), key=lambda x: -x[1][0]):
    del L[i]
open(p, 'w', encoding='latin-1', newline='').write(nl.join(L))
print('CORELIST OK', p, sorted(own))

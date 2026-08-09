import re
import sys
from collections import defaultdict

d = open(sys.argv[1], 'rb').read()
strs = re.findall(rb'[\x20-\x7e]{4,}', d)

paths = set()
exprs = []
for s in strs:
    t = s.decode(errors='replace')
    if re.search(r'\.(cpp|c|h)$', t) and ('\\' in t or '/' in t):
        paths.add(t)
    elif re.match(r'^[!\w][\w\.\->\[\]&|!=<> +*()]{5,}$', t) and any(
            k in t for k in ('_g', '->f', '.f', '!=', '==', 'NULL', '_data',
                             'Manager', 'Info', 'gData', 'num', 'index', 'car')):
        exprs.append(t)

nfs4 = sorted(p for p in paths if 'nfs4' in p.lower())
other = sorted(p for p in paths if 'nfs4' not in p.lower())
print(f"=== nfs4 source files ({len(nfs4)}) ===")
by_dir = defaultdict(list)
for p in nfs4:
    m = re.search(r'nfs4[\\/](.*)', p, re.I)
    rel = m.group(1) if m else p
    parts = rel.replace('/', '\\').rsplit('\\', 1)
    by_dir[parts[0] if len(parts) > 1 else '.'].append(parts[-1])
for dd in sorted(by_dir):
    print(f"  {dd}\\  ({len(by_dir[dd])})")
    print("    " + ", ".join(sorted(by_dir[dd])))
print(f"\n=== engine/framework paths ({len(other)}), sample dirs ===")
dirs = sorted(set(re.sub(r'[\\/][^\\/]+$', '', p) for p in other))
for x in dirs[:25]:
    print("  ", x)
print(f"\n=== candidate assert expressions ({len(exprs)}), first 40 ===")
for e in exprs[:40]:
    print("  ", e)

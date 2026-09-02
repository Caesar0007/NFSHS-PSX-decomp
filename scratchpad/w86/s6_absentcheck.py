"""For every ABSENT-in-C finding, re-check the RAW function text (comments kept)
so an existing SYM-OPTIMIZED / SYM-INLINE-LOCAL annotation counts as covered."""
import re, sys, importlib.util, os

sp = importlib.util.spec_from_file_location('sa', 'scratchpad/w86/s6_symaudit.py')
M = importlib.util.module_from_spec(sp)
sp.loader.exec_module(M)
syms = M.load()

# (tu, mangled, [names])
cur_tu = None
cur = None
items = []
for l in open('scratchpad/w86/S6_audit_raw.txt', errors='replace'):
    if l.startswith('=== '):
        cur_tu = l.split()[1]
        continue
    m = re.match(r'  \[ABS \] (\S+)\s+SYM=(\S+)', l)
    if m:
        cur = (cur_tu, m.group(1), m.group(2), [])
        items.append(cur)
        continue
    m = re.match(r'\s+ABSENT-in-C  : (\w+)\s+(.*?)\s{2,}(\S+)\s+d(\d+)', l)
    if m and cur:
        cur[3].append((m.group(1), m.group(2).strip(), m.group(3)))

for tu, cname, mn, names in items:
    raw = open(tu, errors='replace').read().splitlines()
    # locate the raw body of cname
    base = cname.split('::')[-1]
    idx = None
    for i, l in enumerate(raw):
        if re.search(r'(^|\s|\*)%s\s*\(' % re.escape(cname.replace('::', '::')), l) \
                and not l.strip().endswith(';') and not l.strip().startswith('/*'):
            idx = i
    if idx is None:
        for i, l in enumerate(raw):
            if re.search(r'\b%s\s*\(' % re.escape(base), l) and not l.strip().endswith(';'):
                idx = i
    if idx is None:
        print('%-34s %-34s ?? body not located' % (os.path.basename(tu), cname))
        continue
    # take from the fn header comment (2 lines above) to the closing brace
    start = max(0, idx - 25)
    depth = 0
    end = idx
    started = False
    for k in range(idx, len(raw)):
        depth += raw[k].count('{') - raw[k].count('}')
        if '{' in raw[k]:
            started = True
        if started and depth == 0:
            end = k
            break
    txt = '\n'.join(raw[start:end + 1])
    for cls, typ, nm in names:
        hit = re.search(r'(?<![\w.>])%s\b' % re.escape(nm), txt)
        ann = re.search(r'SYM-(?:OPTIMIZED|INLINE-LOCAL|MACRO-LOCALS|FOLDED|TEMP)[^\n]*\b%s\b'
                        % re.escape(nm), txt)
        state = 'ANNOTATED' if ann else ('mentioned' if hit else 'UNCOVERED')
        print('%-22s %-38s %-8s %-20s %s' % (os.path.basename(tu), cname, cls, nm, state))

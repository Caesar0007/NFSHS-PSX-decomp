"""purify.py <aggregator.h> [--apply] -- move the definition text of a switch/list header into plain leaf headers.
Each maximal run of non-directive text (brace-balanced, at file scope) becomes recon/shared/<FirstTypeName>.h (or
<base>_<n>.h) and is replaced by an #include. The header then holds only directives, so flatten.py can expand it.
Runs that are not brace-balanced, or conditionals inside a definition, are reported and left alone."""
import os
import re
import sys

p = sys.argv[1].replace(chr(92), '/')
apply = '--apply' in sys.argv
raw = open(p, encoding='latin-1', newline='').read()
nl = '\r\n' if '\r\n' in raw else '\n'
L = raw.split(nl)


def code(line, st):
    """strip comments; st = in-block-comment flag (list of one bool)"""
    out = ''
    i = 0
    while i < len(line):
        if st[0]:
            j = line.find('*/', i)
            if j < 0:
                return out
            st[0] = False
            i = j + 2
            continue
        if line.startswith('/*', i):
            st[0] = True
            i += 2
            continue
        if line.startswith('//', i):
            break
        out += line[i]
        i += 1
    return out


st = [False]
C = [code(x, st) for x in L]
runs = []
i = 0
n = len(L)
while i < n:
    t = C[i].strip()
    if not t or t.startswith('#'):
        i += 1
        continue
    j = i
    depth = 0
    bad = None
    while j < n:
        tj = C[j].strip()
        if tj.startswith('#'):
            if depth > 0:
                bad = 'directive inside a definition (line %d)' % (j + 1)
            break
        depth += tj.count('{') - tj.count('}')
        j += 1
    k = j
    while k > i and not C[k - 1].strip():
        k -= 1
    if depth != 0 and not bad:
        bad = 'unbalanced braces'
    runs.append((i, k, bad))
    if bad:
        # skip to the end of the damaged region: next line where text depth returns to 0 is unknown; stop extracting this file
        break
    i = j
fwd = re.compile(r'((struct|class|enum|union)\s+\w+\s*;\s*)+$')
todo = []
names = set()
for a, b, bad in runs:
    if bad:
        print('%s: lines %d-%d NOT extracted: %s' % (p, a + 1, b, bad))
        continue
    text = ' '.join(c.strip() for c in C[a:b])
    if fwd.match(text.strip()):
        continue
    m = re.search(r'\b(?:struct|class|union|enum)\s+(\w+)\s*(?::[^{]*)?\{', text) or re.search(r'\btypedef\b.*?\b(\w+)\s*(?:\[[^\]]*\])?\s*;', text) \
        or re.search(r'\(\s*\*\s*(\w+)\s*\)', text)
    name = m.group(1) if m else None
    if len(re.findall(r'(?:struct|class|union|enum)\s+\w*\s*(?::[^{;]*)?\{', text)) != 1 or text.count(';') > text.count('{') * 40 or len(re.findall(r'typedef', text)) > 1:
        name = None   # several definitions in one run: keep a part-local name
    todo.append((a, b, name))
base = os.path.basename(p)[:-2]
made = 0
out = list(L)
for idx, (a, b, name) in enumerate(reversed(todo)):
    num = len(todo) - idx
    fn = None
    if name:
        cand = 'recon/shared/%s.h' % name
        if not os.path.exists(cand) and cand not in names:
            fn = cand
    if fn is None:
        fn = '%s/%s_d%d.h' % (os.path.dirname(p), base, num)
    names.add(fn)
    inc = ('shared/' + os.path.basename(fn)) if fn.startswith('recon/shared/') else os.path.basename(fn)
    guard = 'NFS4_' + re.sub(r'\W', '_', (('SHARED_' if fn.startswith('recon/shared/') else '') + os.path.basename(fn)[:-2])).upper() + '_H'
    body = L[a:b]
    txt = '\n'.join(['/* %s -- moved verbatim out of %s so that header holds only its include list. */' % (os.path.basename(fn)[:-2], os.path.basename(p)),
                     '#ifndef ' + guard, '#define ' + guard] + body + ['#endif', ''])
    if apply:
        open(fn, 'w', encoding='latin-1', newline='').write(txt)
    out[a:b] = ['#include "%s"' % inc]
    made += 1
if apply and made:
    open(p, 'w', encoding='latin-1', newline='').write(nl.join(out))
print('%s: %d definition runs -> leaf headers%s' % (p, made, '' if apply else ' (dry run)'))

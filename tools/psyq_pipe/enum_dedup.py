"""enum_dedup.py [--apply] [--only NAME,...] -- one definition per duplicated enum.
Every file-scope enum defined in two or more recon headers with identical text (comments/whitespace ignored, same
plain-vs-typedef form) moves to recon/shared/<Name>.h; each copy becomes `#include "shared/<Name>.h"`, padded with
blank lines so the header keeps its line count. Token stream per object is unchanged. Differing copies are listed."""
import collections
import glob
import os
import re
import sys

apply = '--apply' in sys.argv
only = set(sys.argv[sys.argv.index('--only') + 1].split(',')) if '--only' in sys.argv else None
PAT = re.compile(r'(?m)^(typedef[ \t]+)?enum[ \t]+(\w+)[ \t\r\n]*\{([^{}]*)\}[ \t]*(\w+)?[ \t]*;')


def norm(t):
    t = re.sub(r'/\*.*?\*/|//[^\n]*', ' ', t, flags=re.S)
    return re.sub(r'\s+', '', t)


files = {}
for p in glob.glob('recon/**/*.h', recursive=True):
    q = p.replace(os.sep, '/')
    if '/mod/' in q or 'game-mod' in q or 'syslib-mod' in q or q.startswith('recon/shared/'):
        continue
    files[q] = open(q, encoding='latin-1', newline='').read()
G = collections.defaultdict(list)
for q, s in files.items():
    for m in PAT.finditer(s):
        name = m.group(2)
        if m.group(1) and m.group(4) != name:
            continue
        if not m.group(1) and m.group(4):
            continue
        G[name].append((q, m.start(), m.end(), norm(m.group(0))))
todo = {}
skipped = []
for name, c in sorted(G.items()):
    if only and name not in only:
        continue
    forms = collections.Counter(x[3] for x in c)
    sh = 'recon/shared/%s.h' % name
    have = None
    if os.path.exists(sh):
        t = open(sh, encoding='latin-1').read()
        m = PAT.search(t)
        have = norm(m.group(0)) if m else 'OTHER'
    if len(c) < 2 and have is None:
        continue
    best, n = forms.most_common(1)[0]
    if have is not None:
        if have not in forms:
            skipped.append((name, len(c), 'shared file exists with another text'))
            continue
        best = have
    if len(forms) > 1:
        skipped.append((name, len(c) - forms[best], 'copies with another text/form stay'))
    if forms[best] < 2 and have is None:
        continue
    todo[name] = (best, [x for x in c if x[3] == best], have is not None)
edits = collections.defaultdict(list)
nconv = 0
for name, (best, copies, exists) in todo.items():
    if not exists:
        q, a, b, _ = copies[0]
        body = files[q][a:b].replace('\r\n', '\n')
        guard = 'NFS4_SHARED_%s_H' % name.upper()
        txt = ('/* %s -- the one definition of this enum, shared by %d headers (moved verbatim by enum_dedup; every\n'
               '   former copy includes this file at the same place). */\n#ifndef %s\n#define %s\n\n%s\n#endif\n') % (name, len(copies), guard, guard, body)
        if apply:
            open('recon/shared/%s.h' % name, 'w', encoding='latin-1', newline='').write(txt)
    for q, a, b, _ in copies:
        edits[q].append((a, b, name))
        nconv += 1
for q, E in edits.items():
    s = files[q]
    for a, b, name in sorted(E, reverse=True):
        nlc = s[a:b].count('\n')
        nl = '\r\n' if '\r\n' in s else '\n'
        s = s[:a] + '#include "shared/%s.h"' % name + nl * nlc + s[b:]
    if apply:
        open(q, 'w', encoding='latin-1', newline='').write(s)
print('enums converted: %d names, %d copies in %d headers' % (len(todo), nconv, len(edits)))
for name, (best, copies, exists) in sorted(todo.items(), key=lambda x: -len(x[1][1]))[:15]:
    print('  %3d %s' % (len(copies), name))
print('skipped/partial:', len(skipped))
for x in skipped:
    print('  ', x)

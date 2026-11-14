"""dead_tests.py -- NFS4_* names that headers TEST (#if/#ifdef/#ifndef/#elif) but nothing defines any more.
Such tests are constant: `#ifdef X` blocks are dead text, `#ifndef X` blocks are unconditional. Report only."""
import collections
import glob
import os
import re

files = []
for e in ('h', 'cpp', 'c', 'inc'):
    for p in glob.glob('recon/**/*.' + e, recursive=True):
        q = p.replace(os.sep, '/')
        if '/mod/' in q or 'game-mod' in q or 'syslib-mod' in q:
            continue
        files.append(q)
defined = set()
tests = collections.defaultdict(list)
for q in files:
    s = open(q, encoding='latin-1').read()
    s = re.sub(r'\\[ \t]*\r?\n', ' ', s)
    for m in re.finditer(r'(?m)^[ \t]*#[ \t]*define[ \t]+(\w+)', s):
        defined.add(m.group(1))
    for m in re.finditer(r'(?m)^[ \t]*#[ \t]*(if|ifdef|ifndef|elif)\b(.*)$', s):
        for n in set(re.findall(r'\bNFS4_\w+', re.sub(r'/\*.*?\*/', ' ', m.group(2)))):
            tests[n].append(q)
for t in ('tools/build.py', 'tools/psyq_pipe/gdebug_compile.py'):
    if os.path.exists(t):
        defined.update(re.findall(r'-D(\w+)', open(t, encoding='latin-1').read()))
dead = {n: v for n, v in tests.items() if n not in defined}
print('tested names: %d   never defined: %d   test sites on them: %d' % (len(tests), len(dead), sum(len(v) for v in dead.values())))
by = collections.Counter()
for n, v in dead.items():
    for q in v:
        by[q] += 1
for q, c in by.most_common(25):
    print('%4d  %s' % (c, q))

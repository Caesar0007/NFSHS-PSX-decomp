"""g_codecmp.py A.s B.s -- do two cc1 outputs carry the same INSTRUCTION stream?  (everything that is not a directive, a label
or a comment; used to check that -g does not change code generation)."""
import re
import sys


def ins(p):
    out = []
    for l in open(p, errors='replace'):
        l = l.split('#')[0].rstrip()
        if re.match(r'^\t[a-z]', l) and not l.startswith('\t.'):
            out.append(re.sub(r'\$L\w+', '$L', re.sub(r'\s+', ' ', l.strip())))
    return out


a, b = ins(sys.argv[1]), ins(sys.argv[2])
print(len(a), len(b), 'identical' if a == b else 'DIFFERENT')
if a != b:
    import difflib
    for i, l in enumerate(difflib.unified_diff(a, b, lineterm='', n=1)):
        if i > 30:
            break
        print(l)

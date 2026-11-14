"""prune_defs.py <tu.cpp> <flattened header> -- remove NFS4_* #define / #undef lines the object no longer needs.
Tries removing all candidates, then bisects: a removal is kept only when the preprocessed source (cpp, same flags as
the build) is unchanged. Run from the tree root."""
import os
import re
import subprocess
import sys

CPP = os.environ.get('NFS4_CPP', 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-cpp.exe')
tu, hdr = sys.argv[1], sys.argv[2]


def pp():
    r = subprocess.run([CPP, '-x', 'c', '-D__cplusplus=1', '-nostdinc', '-undef', '-Dmips', '-D__mips__', '-D__psx__',
                        '-Irecon', tu], capture_output=True)
    if r.returncode:
        return None
    t = r.stdout.decode('latin-1')
    return '\n'.join(x.rstrip() for x in t.replace('\r', '').split('\n') if x.strip() and not x.startswith('#'))


raw = open(hdr, encoding='latin-1', newline='').read()
nl = '\r\n' if '\r\n' in raw else '\n'
L = raw.split(nl)
base = pp()
assert base is not None, 'baseline does not preprocess'
names = []
for x in L:
    m = re.match(r'\s*#\s*(define|undef)\s+(NFS4_\w+)', x)
    if m and not m.group(2).startswith('NFS4_FLAT_') and ('D', m.group(2)) not in names:
        names.append(('D', m.group(2)))
seen_inc = set()
for i, x in enumerate(L):
    m = re.match(r'\s*#\s*include\s+"([^"]+)"', x)
    if m:
        if m.group(1) in seen_inc:
            names.append(('I', i))
        seen_inc.add(m.group(1))


def write(drop):
    dn = set(v for k, v in drop if k == 'D')
    di = set(v for k, v in drop if k == 'I')
    out = []
    for i, x in enumerate(L):
        m = re.match(r'\s*#\s*(define|undef)\s+(NFS4_\w+)', x)
        if m and m.group(2) in dn:
            continue
        if i in di:
            continue
        out.append(x)
    open(hdr, 'w', encoding='latin-1', newline='').write(nl.join(out))


def ok(drop):
    write(drop)
    return pp() == base


removed = set()


def solve(cands):
    if not cands:
        return
    if ok(removed | set(cands)):
        removed.update(cands)
        return
    if len(cands) == 1:
        return
    h = len(cands) // 2
    solve(cands[:h])
    solve(cands[h:])


solve(names)
write(removed)
assert pp() == base
print('%s: %d of %d lines removed (switch names %d, repeated includes %d)' % (os.path.basename(hdr), len(removed), len(names), sum(1 for k, v in removed if k == 'D'), sum(1 for k, v in removed if k == 'I')))

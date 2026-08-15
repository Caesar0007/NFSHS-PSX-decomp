#!/usr/bin/env python3
"""probe.py <relfile> <fnlist> <variant-python-file>
Variant file defines PATCHES = [(name, [(old,new), ...]), ...] applied as exact
str replacements (latin-1, endings preserved).  Restores the original always.
"""
import sys, os, subprocess, pathlib, importlib.util

ROOT = pathlib.Path(r'C:/Temp/nfs4-decomp')
SCR = ROOT / 'scratchpad' / 'w64a14'
rel, fns, varfile = sys.argv[1], sys.argv[2], sys.argv[3]
tgt = ROOT / rel
orig = tgt.read_bytes()
bak = SCR / (tgt.name + '.probebak')
bak.write_bytes(orig)
(SCR / 'RESTORE.txt').write_text('if probe died: copy %s -> %s\n' % (bak, tgt))

spec = importlib.util.spec_from_file_location('v', varfile)
v = importlib.util.module_from_spec(spec); spec.loader.exec_module(v)

out = []
try:
    for name, edits in v.PATCHES:
        s = orig.decode('latin-1')
        ok = True
        for old, new in edits:
            n = s.count(old)
            if n != 1:
                out.append('%s: ANCHOR MISS (%d matches) for %r' % (name, n, old[:70]))
                ok = False
                break
            s = s.replace(old, new)
        if not ok:
            continue
        tgt.write_bytes(s.encode('latin-1'))
        env = dict(os.environ)
        env.update(getattr(v, 'ENV', {}))
        r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'verify_asm.py'), rel, fns],
                           capture_output=True, text=True, cwd=str(ROOT), env=env)
        got = False
        for ln in r.stdout.splitlines():
            if 'PASS' in ln or 'FAIL' in ln or 'NO ORACLE' in ln or 'NOT IN' in ln:
                out.append('%s: %s' % (name, ln.strip()))
                got = True
        if not got:
            out.append('%s: BUILD FAIL %s' % (name, (r.stderr or r.stdout).strip()[-400:]))
        print(out[-1], flush=True)
finally:
    tgt.write_bytes(orig)

print('---- SUMMARY ----')
print('\n'.join(out))

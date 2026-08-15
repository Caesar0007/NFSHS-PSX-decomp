#!/usr/bin/env python3
"""iprobe.py <relfile> <fnlist> <variant-file>
Variant file defines PATCHES = [(name, callable(text)->text), ...].
Each callable gets the ORIGINAL file text (latin-1) and returns the patched text.
Restores the original on every exit path.  Prints each result as it lands.
"""
import sys, os, subprocess, pathlib, importlib.util

ROOT = pathlib.Path(r'C:/Temp/nfs4-decomp')
SCR = ROOT / 'scratchpad' / 'w64a14'
rel, fns, varfile = sys.argv[1], sys.argv[2], sys.argv[3]
tgt = ROOT / rel
orig = tgt.read_bytes()
bak = SCR / (tgt.name + '.iprobebak')
bak.write_bytes(orig)
(SCR / 'RESTORE.txt').write_text('if probe died: copy %s -> %s\n' % (bak, tgt))

spec = importlib.util.spec_from_file_location('v', varfile)
v = importlib.util.module_from_spec(spec); spec.loader.exec_module(v)

out = []
try:
    for name, fnpatch in v.PATCHES:
        try:
            s = fnpatch(orig.decode('latin-1'))
        except Exception as e:
            print('%s: PATCH ERROR %s' % (name, e), flush=True); continue
        tgt.write_bytes(s.encode('latin-1'))
        r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'verify_asm.py'), rel, fns],
                           capture_output=True, text=True, cwd=str(ROOT))
        got = False
        for ln in r.stdout.splitlines():
            if 'PASS' in ln or 'FAIL' in ln or 'NO ORACLE' in ln or 'NOT IN' in ln:
                msg = '%s: %s' % (name, ln.strip()); out.append(msg); print(msg, flush=True); got = True
        if not got:
            msg = '%s: BUILD FAIL %s' % (name, (r.stderr or r.stdout).strip()[-500:])
            out.append(msg); print(msg, flush=True)
finally:
    tgt.write_bytes(orig)
print('---- SUMMARY ----')
print('\n'.join(out))

#!/usr/bin/env python3
"""probe.py FILE FN [FN...] --  apply a patch fn from variants.py, gate, restore.
Usage: python scratchpad/w63a14/probe.py <relfile> <fnlist> <variant-python-file>
The variant file defines PATCHES = [(name, [(old,new), ...]), ...] as *bytes-safe*
str replacements applied to the file text (latin-1, endings preserved verbatim).
Restores the original on every exit path (restore log written first).
"""
import sys, os, subprocess, pathlib, importlib.util

ROOT = pathlib.Path(r'C:/Temp/nfs4-decomp')
rel, fns, varfile = sys.argv[1], sys.argv[2], sys.argv[3]
tgt = ROOT / rel
orig = tgt.read_bytes()
bak = ROOT / 'scratchpad/w63a14' / (tgt.name + '.probebak')
bak.write_bytes(orig)
log = ROOT / 'scratchpad/w63a14' / 'RESTORE.txt'
log.write_text(f'if probe died: copy {bak} -> {tgt}\n')

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
                out.append(f'{name}: ANCHOR MISS ({n} matches) for {old[:60]!r}')
                ok = False
                break
            s = s.replace(old, new)
        if not ok:
            continue
        tgt.write_bytes(s.encode('latin-1'))
        env = dict(os.environ)
        extra = getattr(v, 'ENV', {})
        env.update(extra)
        r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'vprobe.py'), rel, fns],
                           capture_output=True, text=True, cwd=str(ROOT), env=env)
        for ln in r.stdout.splitlines():
            if 'PASS' in ln or 'FAIL' in ln or 'NO ORACLE' in ln or 'NOT IN' in ln:
                out.append(f'{name}: {ln.strip()}')
        if not any(l.startswith(name + ':') for l in out):
            out.append(f'{name}: BUILD FAIL {r.stderr.strip()[-300:]}')
finally:
    tgt.write_bytes(orig)

print('\n'.join(out))

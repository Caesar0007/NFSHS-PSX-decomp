#!/usr/bin/env python3
"""probe1.py <relfile> <fnlist> <variantfile> <patchname> -- apply ONE patch, print
the CONTEXT diff (VA_CTX), restore."""
import sys, os, subprocess, pathlib, importlib.util

ROOT = pathlib.Path(r'C:/Temp/nfs4-decomp')
rel, fns, varfile, want = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
tgt = ROOT / rel
orig = tgt.read_bytes()
(ROOT / 'scratchpad/w63a14' / (tgt.name + '.probebak')).write_bytes(orig)

spec = importlib.util.spec_from_file_location('v', varfile)
v = importlib.util.module_from_spec(spec); spec.loader.exec_module(v)
edits = dict(v.PATCHES)[want]
out = []
try:
    s = orig.decode('latin-1')
    for old, new in edits:
        assert s.count(old) == 1, ('ANCHOR', s.count(old), old[:60])
        s = s.replace(old, new)
    tgt.write_bytes(s.encode('latin-1'))
    env = dict(os.environ); env.update(getattr(v, 'ENV', {}))
    env['VA_CTX'] = os.environ.get('VA_CTX', '8')
    r = subprocess.run([sys.executable, str(ROOT / 'scratchpad/w63a14/vpctx.py'), rel, fns],
                       capture_output=True, text=True, cwd=str(ROOT), env=env)
    out.append(r.stdout)
    out.append(r.stderr[-500:] if r.returncode not in (0, 1) else '')
finally:
    tgt.write_bytes(orig)
print('\n'.join(out))

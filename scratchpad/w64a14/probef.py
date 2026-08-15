#!/usr/bin/env python3
"""probef.py <relfile> <fnlist> <variantfile> [only-name]
Variant file exposes PATCHES = [(name, callable(str)->str), ...].  Applies each,
gates via tools/vprobe.py, restores.  With [only-name] it prints the CONTEXT diff.
"""
import sys, os, subprocess, pathlib, importlib.util

ROOT = pathlib.Path(r'C:/Temp/nfs4-decomp')
rel, fns, varfile = sys.argv[1], sys.argv[2], sys.argv[3]
only = sys.argv[4] if len(sys.argv) > 4 else None
tgt = ROOT / rel
orig = tgt.read_bytes()
(ROOT / 'scratchpad/w63a14' / (tgt.name + '.probebak')).write_bytes(orig)

spec = importlib.util.spec_from_file_location('v', varfile)
v = importlib.util.module_from_spec(spec); spec.loader.exec_module(v)

runner = 'scratchpad/w63a14/vpctx.py' if only else 'tools/vprobe.py'
out = []
try:
    for name, fn in v.PATCHES:
        if only and name != only:
            continue
        try:
            s = fn(orig.decode('latin-1'))
        except AssertionError as e:
            out.append(f'{name}: PATCH FAIL {e}'); continue
        tgt.write_bytes(s.encode('latin-1'))
        env = dict(os.environ); env.update(getattr(v, 'ENV', {}))
        if only:
            env['VA_CTX'] = os.environ.get('VA_CTX', '6')
        r = subprocess.run([sys.executable, str(ROOT / runner), rel, fns],
                           capture_output=True, text=True, cwd=str(ROOT), env=env)
        if only:
            out.append(r.stdout)
        else:
            got = [l.strip() for l in r.stdout.splitlines() if 'PASS' in l or 'FAIL' in l]
            out.append(f'{name}: ' + ('; '.join(got) if got else 'BUILD FAIL ' + r.stderr.strip()[-250:]))
finally:
    tgt.write_bytes(orig)
print('\n'.join(out))

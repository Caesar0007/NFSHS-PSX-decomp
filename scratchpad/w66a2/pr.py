#!/usr/bin/env python3
"""pr.py MODE ARGS... -- run the repo's own gate/tugate/brdist with the maspsx
`--nop-before-label` OPT-IN flag injected IN MEMORY.  tools/build.py is never
edited (w65-a2's pr.py, extended with a maspsx-flag hook).

MODE = gate <TU> <Fn[,Fn...]> | tu <TU> | brd <TU>
Env  : W66_MASPSX_FLAGS = space-separated extra maspsx flags, e.g.
       W66_MASPSX_FLAGS=--nop-before-label
       (empty/unset => the untouched pipeline = the control run)
"""
import importlib.util
import os
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / 'tools'))
spec_mod = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec_mod)
spec_mod.loader.exec_module(bld)

EXTRA = [f for f in os.environ.get('W66_MASPSX_FLAGS', '').split() if f]
if EXTRA:
    _real_run = bld.subprocess.run

    def _run(cmd, *a, **kw):
        try:
            c = [str(x) for x in cmd]
        except TypeError:
            return _real_run(cmd, *a, **kw)
        if any(x.endswith('maspsx.py') for x in c):
            i = c.index('--run-assembler')
            c = c[:i] + EXTRA + c[i:]
            sys.stderr.write('# pr.py: maspsx += %s\n' % ' '.join(EXTRA))
            return _real_run(c, *a, **kw)
        return _real_run(cmd, *a, **kw)

    class _Shim:
        def __getattr__(self, k):
            return getattr(bld.subprocess, k)
        run = staticmethod(_run)

    bld.subprocess = _Shim()
sys.modules['bld'] = bld

va = (ROOT / 'tools' / 'verify_asm.py').read_text()
va = va.replace(
    "spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')\n"
    "bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)",
    "import sys as _s; bld = _s.modules['bld']")
assert 'bld = _s.modules' in va, 'verify_asm build.py loader shape changed'
va = va.replace("ROOT = Path(__file__).resolve().parent.parent", "ROOT = Path(r'%s')" % ROOT)
assert "ROOT = Path(r'" in va, 'verify_asm ROOT line shape changed'
PVA = HERE / '_va_patched.py'
PVA.write_text(va)

mode, rest = sys.argv[1], sys.argv[2:]
if mode == 'gate':
    sys.argv = ['verify_asm.py'] + rest
    exec(compile(va, str(ROOT / 'tools' / 'verify_asm.py'), 'exec'),
         {'__name__': '__main__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')})
elif mode == 'tu':
    tg = (ROOT / 'tools' / 'tugate.py').read_text()
    tg = tg.replace("ROOT/'tools'/'verify_asm.py'", "Path(r'%s')" % PVA)
    assert '_va_patched' in tg, 'tugate verify_asm path shape changed'
    sys.argv = ['tugate.py'] + rest
    exec(compile(tg, str(ROOT / 'tools' / 'tugate.py'), 'exec'),
         {'__name__': '__main__', '__file__': str(ROOT / 'tools' / 'tugate.py')})
elif mode == 'brd':
    bd = (ROOT / 'tools' / 'brdist.py').read_text()
    bd = bd.replace("src = (ROOT / 'tools' / 'verify_asm.py').read_text()",
                    "src = Path(r'%s').read_text()" % PVA)
    assert '_va_patched' in bd, 'brdist verify_asm path shape changed'
    sys.argv = ['brdist.py'] + rest
    exec(compile(bd, str(ROOT / 'tools' / 'brdist.py'), 'exec'), {'__name__': '__main__'})
else:
    sys.exit('mode must be gate|tu|brd')

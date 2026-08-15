"""alpha.py <variant> -- alpha-renamed structural comparison ours vs oracle.

Renames every register to a per-stream first-appearance index, then diffs.
A structurally-exact variant renames to an IDENTICAL stream => the residual is
PURE ALLOCATION (a register handout rotation), which is dial-able.
"""
import sys, os, re, difflib, importlib.util
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
ROOT = os.path.abspath(os.path.join(HERE, '..'))     # tools/ -> repo root


class Probe(object):
    """byte-exact variant harness with guaranteed restore.

    w64-a22: was `from probe import Probe, ROOT`, importing a SCRATCH-ONLY module
    (scratchpad/w61a18/probe.py) that is not on any path when alpha.py runs from
    tools/ -- the tool raised ModuleNotFoundError for every caller (catalog 13F
    listed it as promoted, BRIEF listed it as BROKEN).  The class is inlined here
    verbatim so the tool is self-contained; every edit asserts a match count so
    an anchor miss can never read as an inert result.
    """

    def __init__(self, relpath, fn):
        self.path = os.path.join(ROOT, relpath)
        self.rel = relpath
        self.fn = fn
        with open(self.path, 'rb') as f:
            self.orig = f.read()

    def _write(self, data):
        tmp = self.path + '.alphatmp'
        with open(tmp, 'wb') as f:
            f.write(data)
        assert os.path.getsize(tmp) > 0
        os.replace(tmp, self.path)

    def restore(self):
        self._write(self.orig)

    def apply(self, data, edits):
        for old, new in edits:
            n = data.count(old)
            assert n == 1, 'edit matched %d times: %r' % (n, old[:80])
            data = data.replace(old, new)
        return data

# w64-a22: the example target stays the default (the FontUpsideDownBlit row this
# tool was built for); ALPHA_SRC / ALPHA_FN let any belt point it at its own fn
# with no edit -- only the 'base' variant is meaningful when overridden.
FN = os.environ.get('ALPHA_FN', 'FontUpsideDownBlit__FiiPviiP12charactertbli')
SRC = os.environ.get('ALPHA_SRC', 'recon/frontend/psx/psxfront.cpp')
P = Probe(SRC, FN)

TINT = b'  *(u_long *)&prim->r0 = font_tint;\n'
RMW = (b'  ((PSXFront_PTag *)prim)->addr = pal->addr,\n'
       b'  pal->addr = (uint)prim;\n')
VARIANTS = {
    'base': [],
    'v1': [(TINT + RMW, RMW + TINT)],
}

REGS = ('zero|at|v0|v1|a0|a1|a2|a3|t0|t1|t2|t3|t4|t5|t6|t7|'
        's0|s1|s2|s3|s4|s5|s6|s7|t8|t9|k0|k1|gp|sp|fp|ra')
RX = re.compile(r'\b(%s)\b' % REGS)


def alpha(stream):
    m, out = {}, []
    for ins in stream:
        def sub(mo):
            r = mo.group(1)
            if r in ('zero', 'sp', 'ra'):
                return r
            if r not in m:
                m[r] = 'R%d' % len(m)
            return m[r]
        out.append(RX.sub(sub, ins))
    return out, m


def load(fn):
    spec = importlib.util.spec_from_file_location('va', os.path.join(ROOT, 'tools', 'verify_asm.py'))
    V = importlib.util.module_from_spec(spec)
    old = sys.argv[:]
    sys.argv = [old[0], SRC, '__none__']
    try:
        spec.loader.exec_module(V)
    except SystemExit:
        pass
    sys.argv = old
    return V.ours(fn), V.oracle(fn)


name = sys.argv[1] if len(sys.argv) > 1 else 'base'
try:
    P._write(P.apply(P.orig, VARIANTS[name]) if VARIANTS[name] else P.orig)
    a, b = load(FN)
finally:
    P.restore()

aa, ma = alpha(a)
bb, mb = alpha(b)
sm = difflib.SequenceMatcher(None, aa, bb, autojunk=False)
nd = sum(max(i2 - i1, j2 - j1) for t, i1, i2, j1, j2 in sm.get_opcodes() if t != 'equal')
print('%s: alpha-renamed structural diffs = %d (ours %d / oracle %d)' % (name, nd, len(aa), len(bb)))
print('ours  map:', ma)
print('oracle map:', mb)
for t, i1, i2, j1, j2 in sm.get_opcodes():
    if t == 'equal':
        continue
    n = max(i2 - i1, j2 - j1)
    for k in range(n):
        l = aa[i1 + k] if i1 + k < i2 else ''
        r = bb[j1 + k] if j1 + k < j2 else ''
        print('   %-30s X %s' % (l, r))

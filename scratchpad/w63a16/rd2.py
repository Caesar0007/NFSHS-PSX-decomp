import sys, os, re
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, '..', '..', 'tools'))
sys.path.insert(0, HERE)
import fast, dmp

SRC = "recon/frontend/common/feapp.cpp"
FN = "Redraw__14tFEApplication"
DFN = "tFEApplication::Redraw()"
ROOT = os.path.join(HERE, '..', '..')

def loopinfo(src, dfn):
    d = dmp.dump(src, dfn)
    sec = d.get('.loop', '')
    out = []
    for ln in sec.splitlines():
        if ln.startswith('Loop from') or ln.startswith('Insn ') or ln.startswith('Reg '):
            out.append('      ' + ln)
        if ln.startswith('(note') or ln.startswith('(insn'):
            break
    return "\n".join(out)

import importlib
def run(variants, old):
    full = os.path.join(ROOT, SRC)
    orig = open(full, 'rb').read()
    try:
        for tag, new in variants.items():
            data = orig if new is None else orig.replace(old, new)
            if new is not None and data == orig:
                print("=== %-28s ANCHOR-MISS" % tag); continue
            tmp = full + '.tmp'; open(tmp,'wb').write(data); os.replace(tmp, full)
            print("=== %-28s %s" % (tag, fast.gate(SRC, FN)))
            print(loopinfo(SRC, DFN))
    finally:
        tmp = full + '.tmp'; open(tmp,'wb').write(orig); os.replace(tmp, full)
        assert open(full,'rb').read() == orig
        print("(restored)")

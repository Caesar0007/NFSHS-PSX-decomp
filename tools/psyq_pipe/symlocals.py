"""symlocals.py FUNCTION [FUNCTION...] -- compact: the declaration order of locals (with scope depth) ours vs retail."""
import sys
from pathlib import Path

sys.argv = [sys.argv[0], (Path(__file__).resolve().parents[2] / 'build/psyq_g/nfs4_sym.txt').as_posix()] + sys.argv[1:]
import importlib.util

spec = importlib.util.spec_from_file_location('stc', str(Path(__file__).resolve().parent / 'symtree_parse.py'))
stc = importlib.util.module_from_spec(spec)
spec.loader.exec_module(stc)
ours, retail = stc.parse(sys.argv[1]), stc.parse(stc.RETAIL)
for fn in sys.argv[2:]:
    o, r = ours.get(fn), retail.get(fn)
    print('==', fn)
    for tag, x in (('ours  ', o), ('retail', r)):
        if x:
            print('  %s %s' % (tag, ' '.join('%s%s[%s]' % ('.' * d, n, h.split(':')[-1]) for n, h, ty, d in x['locals'])))

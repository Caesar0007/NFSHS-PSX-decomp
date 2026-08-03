#!/usr/bin/env python
"""Side-by-side ours|oracle for one fn, with a variant applied in place.
Usage: python scratch/sbs.py <tu> <fn> <variantfile> [lo] [hi]"""
import io, os, sys, importlib.util
sys.path.insert(0, os.path.abspath('tools'))
tu, fn, vf = sys.argv[1], sys.argv[2], sys.argv[3]
lo = int(sys.argv[4]) if len(sys.argv) > 4 else 0
hi = int(sys.argv[5]) if len(sys.argv) > 5 else 10 ** 6

s = io.open(tu, encoding='utf-8', newline='').read()
if vf != '-':
    spec = importlib.util.spec_from_file_location("v", vf)
    v = importlib.util.module_from_spec(spec); spec.loader.exec_module(v)
    assert s.count(v.OLD) == 1
    io.open(tu, 'w', encoding='utf-8', newline='').write(s.replace(v.OLD, v.NEW))
try:
    argv = sys.argv[:]
    sys.argv = ['verify_asm', tu, fn]
    sp = importlib.util.spec_from_file_location('va', 'tools/verify_asm.py')
    m = importlib.util.module_from_spec(sp)
    try:
        sp.loader.exec_module(m)
    except SystemExit:
        pass
    sys.argv = argv
    o = m.ours(fn); e = m.oracle(fn)
    n = max(len(o), len(e))
    for i in range(max(0, lo), min(n, hi)):
        a = o[i] if i < len(o) else ''
        b = e[i] if i < len(e) else ''
        print('%4d %-30s %s %s' % (i, a, ' ' if a == b else '*', b))
finally:
    if vf != '-':
        io.open(tu, 'w', encoding='utf-8', newline='').write(s)

import pathlib, importlib.util, sys, subprocess
ROOT = pathlib.Path(r'C:/Temp/nfs4-decomp')
spec = importlib.util.spec_from_file_location('v', ROOT / 'scratchpad/w64a14/vprim9.py')
v = importlib.util.module_from_spec(spec); spec.loader.exec_module(v)
p = ROOT / 'recon/game/psx/drawc.cpp'
orig = p.read_bytes()
s = v.at({0, 1})(orig.decode('latin-1')).encode('latin-1')
print('len', len(orig), '->', len(s), 'delta', len(s) - len(orig))
print('CRLF', s.count(b'\r\n'), 'LF', s.count(b'\n'))
# byte-level diff summary
import difflib
a = orig.decode('latin-1').splitlines()
b = s.decode('latin-1').splitlines()
print('lines', len(a), len(b))
for i, (x, y) in enumerate(zip(a, b)):
    if x != y:
        print('line', i + 1, repr(x[:90]), '->', repr(y[:90]))

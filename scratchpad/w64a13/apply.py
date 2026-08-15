"""apply.py MODULE VARIANT [--restore] -- apply one variant from a probe module to the
real TU (so opcen/posdiff/side_by_side can be run on it), or restore from the .w64a13bak.
Always writes a FRESH backup on apply (15F: one stale .applybak across landings is a trap).
"""
import importlib.util
import os
import sys
import pathlib

ROOT = pathlib.Path(r'C:/Temp/nfs4-decomp')
HERE = pathlib.Path(__file__).resolve().parent


def load(mod):
    spec = importlib.util.spec_from_file_location('probe', HERE / (mod + '.py'))
    m = importlib.util.module_from_spec(spec)
    sys.modules['probe'] = m
    spec.loader.exec_module(m)
    return m


def main():
    mod = sys.argv[1]
    m = load(mod)
    full = ROOT / m.SRC
    bak = HERE / (full.name + '.' + mod + '.applybak')
    if sys.argv[2] == '--restore':
        data = bak.read_bytes()
        assert len(data) > 1000
        full.write_bytes(data)
        print('restored', full, len(data))
        return
    orig = full.read_bytes()
    bak.write_bytes(orig)
    crlf = orig.count(b'\r\n') > orig.count(b'\n') // 2

    def fix(b):
        return b.replace(b'\n', b'\r\n') if (crlf and b'\r\n' not in b) else b
    pairs = m.VARIANTS[sys.argv[2]]
    if isinstance(pairs, tuple):
        pairs = [pairs]
    data = orig
    for old, new in pairs:
        old, new = fix(old), fix(new)
        assert data.count(old) == 1, ('anchor count %d' % data.count(old), old[:60])
        data = data.replace(old, new)
    assert len(data) > 1000
    tmp = str(full) + '.tmp'
    open(tmp, 'wb').write(data)
    os.replace(tmp, str(full))
    print('applied', sys.argv[2], 'to', full, len(orig), '->', len(data))


main()

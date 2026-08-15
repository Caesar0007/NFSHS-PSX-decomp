"""w63a7 generic in-place variant probe.

Usage: python scratchpad/w63a7/probe.py <relpath> <fn> <variants.py>
variants.py must define: ANCHOR (exact substring to replace, CRLF-normalized
automatically) and VARIANTS = [(name, replacement_text), ...]

Patches the REAL path (PER_TU_FLAGS are path-keyed), gates, restores in finally.
Writes a restore log BEFORE any print (truncating-pipe hazard).
"""
import os, subprocess, sys, io

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


def read_bytes(p):
    with open(p, 'rb') as f:
        return f.read()


def write_bytes(p, data):
    assert len(data) > 0
    tmp = p + '.w63a7tmp'
    with open(tmp, 'wb') as f:
        f.write(data)
    os.replace(tmp, p)


def main():
    rel, fn, vfile = sys.argv[1], sys.argv[2], sys.argv[3]
    path = os.path.join(ROOT, rel.replace('/', os.sep))
    ns = {}
    with open(vfile, 'r', encoding='utf-8') as f:
        exec(f.read(), ns)
    anchor = ns['ANCHOR']
    variants = ns['VARIANTS']
    orig = read_bytes(path)
    crlf = orig.count(b'\r\n') > 0
    def enc(s):
        s = s.replace('\r\n', '\n')
        if crlf:
            s = s.replace('\n', '\r\n')
        return s.encode('ascii')
    a = enc(anchor)
    n = orig.count(a)
    if n != 1:
        print('ANCHOR count = %d (need 1)' % n)
        return 2
    log = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'restore.log')
    with open(log, 'w') as f:
        f.write(path + '\n')
    with open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'orig.bak'), 'wb') as f:
        f.write(orig)
    results = []
    try:
        for name, rep in variants:
            body = enc(rep)
            new = orig.replace(a, body)
            assert new != orig or rep == anchor
            write_bytes(path, new)
            r = subprocess.run([sys.executable, 'tools/verify_asm.py', rel, fn],
                               cwd=ROOT, capture_output=True, text=True,
                               env=dict(os.environ, VA_MAX='400'))
            out = (r.stdout + r.stderr).strip().splitlines()
            line = ''
            for L in out:
                if fn in L and ('PASS' in L or 'FAIL' in L or 'NO ORACLE' in L or 'NOT IN' in L):
                    line = L.strip()
            if not line:
                line = 'ERR: ' + ' | '.join(out[-4:])
            results.append((name, line, out))
    finally:
        write_bytes(path, orig)
    with open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'probe_out.txt'), 'w') as f:
        for name, line, out in results:
            f.write('=== %s\n%s\n' % (name, line))
            for L in out:
                if L.strip().startswith(('-', '+')):
                    f.write('    %s\n' % L.strip())
    for name, line, out in results:
        print('%-42s %s' % (name, line))
    return 0


if __name__ == '__main__':
    sys.exit(main())

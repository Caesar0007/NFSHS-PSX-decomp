"""w64a7 multi-anchor probe that runs the VERFLAG harness (per-fn rung x flags).

Usage: python scratchpad/w64a7/probe3.py <relpath> <fn> <variants.py> <verflagkey>
  verflagkey e.g. "2.8.0|-mno-split-addresses"   ("" = plain wired lane)
variants.py: VARIANTS = [(name, [(anchor, replacement), ...]), ...]
"""
import json, os, subprocess, sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
HERE = os.path.dirname(os.path.abspath(__file__))


def write_bytes(p, data):
    assert len(data) > 0
    tmp = p + '.w64a7tmp'
    with open(tmp, 'wb') as f:
        f.write(data)
    os.replace(tmp, p)


def main():
    rel, fn, vfile = sys.argv[1], sys.argv[2], sys.argv[3]
    key = sys.argv[4] if len(sys.argv) > 4 else ''
    path = os.path.join(ROOT, rel.replace('/', os.sep))
    ns = {}
    with open(vfile, 'r', encoding='utf-8') as f:
        exec(f.read(), ns)
    variants = ns['VARIANTS']
    with open(path, 'rb') as f:
        orig = f.read()
    crlf = orig.count(b'\r\n') > 0

    def enc(s):
        s = s.replace('\r\n', '\n')
        if crlf:
            s = s.replace('\n', '\r\n')
        return s.encode('ascii')

    with open(os.path.join(HERE, 'orig3.bak'), 'wb') as f:
        f.write(orig)
    env = dict(os.environ, VA_MAX='400')
    if key:
        env['W64A7_VERFLAG'] = json.dumps({rel: {key: [fn]}})
        runner = [sys.executable, os.path.join(HERE, 'verflag.py')]
    else:
        runner = [sys.executable, 'tools/verify_asm.py']
    results = []
    try:
        for name, edits in variants:
            new = orig
            bad = None
            for anc, rep in edits:
                a = enc(anc)
                if new.count(a) != 1:
                    bad = 'ANCHOR count %d' % new.count(a)
                    break
                new = new.replace(a, enc(rep))
            if bad:
                results.append((name, bad, []))
                continue
            write_bytes(path, new)
            r = subprocess.run(runner + [rel, fn], cwd=ROOT,
                               capture_output=True, text=True, env=env)
            out = (r.stdout + r.stderr).strip().splitlines()
            line = ''
            for L in out:
                if fn in L and ('PASS' in L or 'FAIL' in L or 'NO ORACLE' in L
                                or 'NOT IN' in L):
                    line = L.strip()
            if not line:
                line = 'ERR: ' + ' | '.join(out[-4:])
            results.append((name, line, out))
    finally:
        write_bytes(path, orig)
    with open(os.path.join(HERE, 'probe3_out.txt'), 'w') as f:
        for name, line, out in results:
            f.write('=== %s\n%s\n' % (name, line))
            for L in out:
                if L.strip().startswith(('-', '+')):
                    f.write('    %s\n' % L.strip())
    for name, line, out in results:
        print('%-46s %s' % (name, line))
    return 0


if __name__ == '__main__':
    sys.exit(main())

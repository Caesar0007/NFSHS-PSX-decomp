"""w64a15 probe harness for stream.c STREAM_cancelrequest.
Applies a byte-level replacement to the TU, runs verify_asm + psyqproof, restores.
Usage: python probe_stream.py <variant-name> [--keep]
"""
import os, sys, subprocess

REPO = r'C:\Temp\nfs4-decomp'
TU = os.path.join(REPO, r'recon\eaclib\psx\eacpsxz\stream.c')
BAK = os.path.join(REPO, r'scratchpad\w64a15\stream.c.base')

FENCE = b'                        __asm__("" : : "i"(0));\r\n'
WHILEHEAD = b'                        while (p != s6) {\r\n'
LOOPTAIL = (b'                                p = (int *)((int)p + len);\r\n'
            b'                            }\r\n'
            b'                        }\r\n')
CIINC = b'                ci++;\r\n                sobj = out[0];\r\n'

DOHEAD = (b'                        if (p == s6) goto nextconsumer;\r\n'
          b'                        do {\r\n')
DOTAIL = (b'                                p = (int *)((int)p + len);\r\n'
          b'                            }\r\n'
          b'                        } while (p != s6);\r\n')
LBL = b'nextconsumer:\r\n                ci++;\r\n                sobj = out[0];\r\n'

VARIANTS = {
    'control': [],
    'nofence': [(FENCE, b'')],
    # explicit zero-trip guard as a goto to the ci++ join, keep the fence
    'gotoguard': [(WHILEHEAD, DOHEAD), (LOOPTAIL, DOTAIL), (CIINC, LBL)],
    # same but without the fence
    'gotoguard_nofence': [(WHILEHEAD, DOHEAD), (LOOPTAIL, DOTAIL), (CIINC, LBL), (FENCE, b'')],
}


def write_atomic(path, data):
    tmp = path + '.tmpw'
    with open(tmp, 'wb') as f:
        f.write(data)
    assert os.path.getsize(tmp) == len(data)
    os.replace(tmp, path)


def run(cmd):
    return subprocess.run(cmd, cwd=REPO, capture_output=True, text=True, timeout=900).stdout


def main():
    name = sys.argv[1]
    keep = '--keep' in sys.argv
    base = open(BAK, 'rb').read()
    d = base
    for old, new in VARIANTS[name]:
        assert d.count(old) == 1, (name, 'anchor count', d.count(old), old[:40])
        d = d.replace(old, new)
    write_atomic(TU, d)
    try:
        g = run([sys.executable, 'tools/verify_asm.py', 'recon/eaclib/psx/eacpsxz/stream.c', 'STREAM_cancelrequest'])
        print('GATE:', [l.strip() for l in g.splitlines() if 'PASS' in l or 'FAIL' in l][:1])
        p = run([sys.executable, 'tools/psyqproof.py', 'recon/eaclib/psx/eacpsxz/stream.c', 'STREAM_cancelrequest'])
        print('PROD:', p.strip()[:500])
    finally:
        if not keep:
            write_atomic(TU, base)


if __name__ == '__main__':
    main()

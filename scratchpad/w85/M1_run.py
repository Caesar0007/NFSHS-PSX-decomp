#!/usr/bin/env python3
"""M1_run.py -- apply a list of (old,new) subs to FONT.c, gate, print, revert.

Usage:  python scratchpad/w85/M1_run.py <edits.json>
edits.json = {"name": "...", "base": "path-to-base-copy", "subs": [[old,new],...]}
Strings use \n; converted to CRLF.
"""
import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
P = ROOT / 'recon/syslib/psx/libgpu/FONT.c'


def gate(fns='FntFlush,FntPrint'):
    r = subprocess.run([sys.executable, 'tools/verify_asm.py',
                        'recon/syslib/psx/libgpu/FONT.c', fns],
                       cwd=ROOT, capture_output=True, text=True)
    return (r.stdout + r.stderr).strip()


def main():
    cfg = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
    base = Path(cfg['base'])
    if not base.is_absolute():
        base = ROOT / base
    orig = base.read_bytes()
    s = orig.decode('utf-8')
    for old, new in cfg['subs']:
        old = old.replace('\n', '\r\n')
        new = new.replace('\n', '\r\n')
        if old not in s:
            print('NOT FOUND:', repr(old[:100]))
            return 2
        s = s.replace(old, new, 1)
    P.write_bytes(s.encode('utf-8'))
    out = gate(cfg.get('fns', 'FntFlush,FntPrint'))
    print('=== ' + cfg['name'])
    print(out)
    if cfg.get('keep'):
        print('[kept]')
    else:
        P.write_bytes(orig)
    return 0


if __name__ == '__main__':
    sys.exit(main())

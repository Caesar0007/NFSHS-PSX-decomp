#!/usr/bin/env python
"""W85-M9 try harness for recon/syslib/psx/libcd/stcdint.c.

Usage:  python scratchpad/w85/M9_try.py <edits.json>

edits.json = list of variants; each variant:
  {"name": "...", "subs": [[old, new], ...]}
Applies subs to the BACKUP copy, writes the target, gates the whole TU,
restores the backup at the end.  Never leaves the tree dirty.
"""
import json, subprocess, sys, os, shutil

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
TGT = os.path.join(ROOT, 'recon', 'syslib', 'psx', 'libcd', 'stcdint.c')
BAK = os.environ.get('M9_BASE') or os.path.join(ROOT, 'scratchpad', 'w85', 'M9_stcdint_backup.c')
FNS = 'StCdInterrupt,_st_copy_words,_st_dma'


def gate():
    p = subprocess.run([sys.executable, os.path.join(ROOT, 'tools', 'verify_asm.py'),
                        'recon/syslib/psx/libcd/stcdint.c', FNS],
                       cwd=ROOT, capture_output=True, text=True)
    out = p.stdout + p.stderr
    res = {}
    for ln in out.splitlines():
        ln = ln.strip()
        for fn in FNS.split(','):
            if ln.startswith(fn + ':'):
                res[fn] = ln.split(':', 1)[1].strip()
    return res, out


def main():
    base = open(BAK, 'r', newline='').read()
    variants = json.load(open(sys.argv[1]))
    verbose = '-v' in sys.argv
    try:
        for v in variants:
            src = base
            ok = True
            for old, new in v['subs']:
                if '\r\n' in src:
                    old = old.replace('\r\n', '\n').replace('\n', '\r\n')
                    new = new.replace('\r\n', '\n').replace('\n', '\r\n')
                if old not in src:
                    print('%-40s  SUBFAIL: %r' % (v['name'], old[:60]))
                    ok = False
                    break
                src = src.replace(old, new, 1)
            if not ok:
                continue
            open(TGT, 'w', newline='').write(src)
            res, out = gate()
            print('%-40s  %s | %s | %s' % (
                v['name'], res.get('_st_dma', '?'),
                res.get('StCdInterrupt', '?'), res.get('_st_copy_words', '?')))
            if verbose:
                print(out)
            sys.stdout.flush()
    finally:
        shutil.copyfile(BAK, TGT)


if __name__ == '__main__':
    main()

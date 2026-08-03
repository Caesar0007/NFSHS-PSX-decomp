#!/usr/bin/env python3
"""w46-a3 multi-variant harness.  usage: python scratch/tryset.py <setfile.py>
setfile defines TU, FNS, VARIANTS = [(name, [(old,new),...]), ...]"""
import importlib.util
import subprocess
import sys
import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def gate(tu_rel, fns):
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', tu_rel,
                        ','.join(fns)], cwd=ROOT, capture_output=True,
                       text=True)
    out = []
    for line in (r.stdout + r.stderr).splitlines():
        s = line.strip()
        if s.startswith('DrawC') or 'PASS' in s or 'FAIL' in s:
            out.append(s.split('(')[0].strip() if False else s)
        elif 'rror' in s and 'FAIL' not in s:
            out.append(s)
    return out


def main():
    spec = importlib.util.spec_from_file_location('vset', sys.argv[1])
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    tu = os.path.join(ROOT, mod.TU)
    with open(tu, 'r', encoding='utf-8', newline='') as f:
        orig = f.read()
    try:
        for name, edits in mod.VARIANTS:
            txt = orig
            bad = False
            for old, new in edits:
                n = txt.count(old)
                if n != 1:
                    print('%-34s ANCHOR %d %r' % (name, n, old[:50]))
                    bad = True
                    break
                txt = txt.replace(old, new, 1)
            if bad:
                continue
            with open(tu, 'w', encoding='utf-8', newline='') as f:
                f.write(txt)
            res = gate(mod.TU, mod.FNS)
            print('=== %s' % name)
            for l in res:
                print('    ' + l[:150])
    finally:
        with open(tu, 'w', encoding='utf-8', newline='') as f:
            f.write(orig)


if __name__ == '__main__':
    main()

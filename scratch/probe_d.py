#!/usr/bin/env python3
"""w46-a3: apply a variant, print the verify_asm diff, restore.
usage: python scratch/probe_d.py <setfile.py> <variant-substr> [VA_MAX]
"""
import importlib.util
import subprocess
import sys
import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def main():
    spec = importlib.util.spec_from_file_location('vset', sys.argv[1])
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    want = sys.argv[2]
    cap = sys.argv[3] if len(sys.argv) > 3 else '400'
    tu = os.path.join(ROOT, mod.TU)
    with open(tu, 'r', encoding='utf-8', newline='') as f:
        orig = f.read()
    edits = []
    if want != 'base':
        for name, e in mod.VARIANTS:
            if want in name:
                edits = e
                break
        else:
            print('no variant')
            return
    txt = orig
    for old, new in edits:
        assert txt.count(old) == 1, repr(old[:60])
        txt = txt.replace(old, new, 1)
    env = dict(os.environ, VA_MAX=cap)
    try:
        with open(tu, 'w', encoding='utf-8', newline='') as f:
            f.write(txt)
        r = subprocess.run([sys.executable, 'tools/verify_asm.py', mod.TU,
                            ','.join(mod.FNS)], cwd=ROOT, env=env,
                           capture_output=True, text=True)
        print(r.stdout)
        print(r.stderr[-2000:])
    finally:
        with open(tu, 'w', encoding='utf-8', newline='') as f:
            f.write(orig)


if __name__ == '__main__':
    main()

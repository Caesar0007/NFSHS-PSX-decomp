#!/usr/bin/env python3
"""w46-a3: apply a variant, print our compiled asm for a function, restore.
usage: python scratch/probe_s.py <setfile.py> <variant-substr> <grep-anchor>
"""
import importlib.util
import subprocess
import sys
import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, 'tools'))


def main():
    spec = importlib.util.spec_from_file_location('vset', sys.argv[1])
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    want = sys.argv[2]
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
    try:
        with open(tu, 'w', encoding='utf-8', newline='') as f:
            f.write(txt)
        r = subprocess.run([sys.executable, 'tools/ourdis.py', mod.TU,
                            mod.FNS[0]], cwd=ROOT, capture_output=True,
                           text=True)
        print(r.stdout[-40000:])
        print(r.stderr[-3000:])
    finally:
        with open(tu, 'w', encoding='utf-8', newline='') as f:
            f.write(orig)


if __name__ == '__main__':
    main()

#!/usr/bin/env python3
"""w46-a3 variant harness: apply (old,new) replacements to a TU, gate the
named functions, restore the file in a finally block.

usage: python scratch/try.py <patchfile.py>
where patchfile defines TU, FNS and EDITS = [(old, new), ...]
"""
import importlib.util
import subprocess
import sys
import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def main():
    spec = importlib.util.spec_from_file_location('patch', sys.argv[1])
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    tu = os.path.join(ROOT, mod.TU)
    with open(tu, 'r', encoding='utf-8', newline='') as f:
        orig = f.read()
    txt = orig
    for old, new in mod.EDITS:
        n = txt.count(old)
        if n != 1:
            print('ANCHOR COUNT %d for %r' % (n, old[:70]))
            return 2
        txt = txt.replace(old, new, 1)
    try:
        with open(tu, 'w', encoding='utf-8', newline='') as f:
            f.write(txt)
        r = subprocess.run([sys.executable, 'tools/verify_asm.py', mod.TU,
                            ','.join(mod.FNS)], cwd=ROOT,
                           capture_output=True, text=True)
        for line in (r.stdout + r.stderr).splitlines():
            if 'PASS' in line or 'FAIL' in line or 'error' in line.lower():
                print(line)
    finally:
        with open(tu, 'w', encoding='utf-8', newline='') as f:
            f.write(orig)
    return 0


if __name__ == '__main__':
    sys.exit(main())

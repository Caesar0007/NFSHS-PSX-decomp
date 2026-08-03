#!/usr/bin/env python3
"""w46-a3: apply a variant, dump RTL, run allocsim, restore.
usage: python scratch/probe.py <setfile.py> <variant-name-substring> [outdir]
"""
import importlib.util
import subprocess
import sys
import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FN = ("void DrawC_PrimMenu(struct matrixtdef *, struct coorddef *, "
      "struct Transformer_zObj *, struct Transformer_zOverlay *, int, "
      "struct Draw_CarCache *)")


def main():
    spec = importlib.util.spec_from_file_location('vset', sys.argv[1])
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    want = sys.argv[2]
    tu = os.path.join(ROOT, mod.TU)
    with open(tu, 'r', encoding='utf-8', newline='') as f:
        orig = f.read()
    edits = None
    for name, e in mod.VARIANTS:
        if want in name:
            edits = e
            break
    if edits is None:
        print('no variant')
        return
    txt = orig
    for old, new in edits:
        assert txt.count(old) == 1, repr(old[:60])
        txt = txt.replace(old, new, 1)
    try:
        with open(tu, 'w', encoding='utf-8', newline='') as f:
            f.write(txt)
        subprocess.run([sys.executable, 'tools/rtl_dump.py', mod.TU,
                        '-dg', '-dl'], cwd=ROOT, capture_output=True)
        r = subprocess.run([sys.executable, 'tools/allocsim.py',
                            'scratch/rtl/drawc.i.greg', 'scratch/rtl/drawc.i.lreg',
                            FN], cwd=ROOT, capture_output=True, text=True)
        print(r.stdout)
    finally:
        with open(tu, 'w', encoding='utf-8', newline='') as f:
            f.write(orig)


if __name__ == '__main__':
    main()

"""Variant probe harness for hud.cpp (LF file, -G8 PER_TU -> patch in place).

Usage:  python scratch/probe.py <variants.py>

The variants module must define:
    TU   = 'recon/game/psx/hud.cpp'
    FNS  = 'MangledA,MangledB'
    VARIANTS = [(name, old_text, new_text), ...]

Every variant is applied to the REAL path (PER_TU flags are path-keyed), gated,
and the file restored in a finally block.
"""
import importlib.util
import io
import os
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def read(p):
    with io.open(p, 'r', encoding='utf-8', newline='') as f:
        return f.read()


def write(p, s):
    with io.open(p, 'w', encoding='utf-8', newline='') as f:
        f.write(s)


def gate(tu, fns):
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', tu, fns],
                       cwd=ROOT, capture_output=True, text=True)
    out = []
    for line in (r.stdout + r.stderr).splitlines():
        s = line.strip()
        if ': PASS' in s or ': FAIL' in s or 'NOT IN OBJECT' in s or 'NO ORACLE' in s:
            out.append(s)
    if not out:
        out = ['<<no gate line>> ' + (r.stdout + r.stderr).strip()[-300:]]
    return out


def main():
    spec = importlib.util.spec_from_file_location('variants', sys.argv[1])
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    tu = os.path.join(ROOT, mod.TU)
    orig = read(tu)
    try:
        print('=== BASE ===')
        for l in gate(mod.TU, mod.FNS):
            print('   ', l)
        crlf = orig.count('\r\n') > orig.count('\n') / 2
        for entry in mod.VARIANTS:
            name = entry[0]
            pairs = entry[1] if len(entry) == 2 else [(entry[1], entry[2])]
            cur = orig
            bad = None
            for old, new in pairs:
                if crlf:
                    old = old.replace('\r\n', '\n').replace('\n', '\r\n')
                    new = new.replace('\r\n', '\n').replace('\n', '\r\n')
                n = cur.count(old)
                if n != 1:
                    bad = n
                    break
                cur = cur.replace(old, new, 1)
            if bad is not None:
                print('=== %s === ANCHOR COUNT %d -- SKIPPED' % (name, bad))
                continue
            write(tu, cur)
            print('=== %s ===' % name)
            for l in gate(mod.TU, mod.FNS):
                print('   ', l)
            sys.stdout.flush()
    finally:
        write(tu, orig)


main()

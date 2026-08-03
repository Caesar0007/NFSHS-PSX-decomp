#!/usr/bin/env python3
"""w47-a8 whole-TU gate: compile a recon TU, enumerate EVERY function symbol it
defines, run verify_asm on all of them, and print a machine-readable summary
(PASS count / total diff count / per-fn line).

Usage:  python scratch/w47_a8_tugate.py recon/eaclib/psx/eacpsxz/nfile.c [--json out.json]

Why: the flag sweep must judge on the WHOLE TU (net improvement AND zero
PASS->FAIL regressions), not on the handful of fns in the worklist.
"""
import json
import os
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'


def tu_funcs(tu: str):
    """Compile the TU and return the list of defined function symbol names."""
    import importlib.util
    sys.path.insert(0, str(ROOT / 'tools'))     # build.py does `import fix_symsizes`
    spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
    bld = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(bld)
    bld.OUT = bld.BUILD
    src = ROOT / tu
    obj = bld.compile_c(src, skip_asm=False) if src.suffix == '.c' else bld.compile_cpp(src)
    out = subprocess.run([OBJD, '-t', str(obj)], capture_output=True, text=True).stdout
    names = []
    for ln in out.splitlines():
        # objdump -t:  ADDR  l/g  F .text  SIZE  NAME
        if ' F ' not in ln or '*UND*' in ln:
            continue
        t = ln.split()
        if t and re.match(r'^[0-9a-f]{8}$', t[0]):
            names.append(t[-1])
    # de-dup preserving order (aliases share an address but each name is gated)
    seen, uniq = set(), []
    for n in names:
        if n not in seen:
            seen.add(n)
            uniq.append(n)
    return uniq


def gate(tu: str, names):
    env = dict(os.environ, VA_MAX='0')
    r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'verify_asm.py'), tu, ','.join(names)],
                       capture_output=True, text=True, env=env, cwd=str(ROOT))
    res = {}
    for ln in r.stdout.splitlines():
        m = re.match(r'\s*(\S+): PASS \((\d+) insns\)', ln)
        if m:
            res[m.group(1)] = 0
            continue
        m = re.match(r'\s*(\S+): FAIL (\d+) diffs \(ours (\d+) / oracle (\d+)\)', ln)
        if m:
            res[m.group(1)] = int(m.group(2))
            continue
        m = re.match(r'\s*(\S+): (NO ORACLE|NOT IN OBJECT)', ln)
        if m:
            res[m.group(1)] = m.group(2)
    return res


def main():
    tu = sys.argv[1]
    outp = None
    if '--json' in sys.argv:
        outp = sys.argv[sys.argv.index('--json') + 1]
    names = tu_funcs(tu)
    res = gate(tu, names)
    gated = {k: v for k, v in res.items() if isinstance(v, int)}
    npass = sum(1 for v in gated.values() if v == 0)
    total = sum(gated.values())
    print(f"TU {tu}: gated={len(gated)} PASS={npass} TOTALDIFF={total} "
          f"(no-oracle={sum(1 for v in res.values() if not isinstance(v, int))})")
    for k in sorted(gated, key=lambda k: -gated[k]):
        print(f"   {gated[k]:5d}  {k}")
    if outp:
        Path(outp).write_text(json.dumps(res, indent=1), encoding='utf-8', newline='')


if __name__ == '__main__':
    main()

#!/usr/bin/env python3
"""w48_a8 per-TU FLAG PROBE harness (report-only; patches tools/build.py in place, restores in finally).
Usage: python scratch/w48_a8_probe.py <unit> [<unit>...]
  unit = libmath/MULSF3 (recon/syslib/psx/<unit>.c)
Probes each flag setting, gates the WHOLE TU, prints per-fn results.
"""
import re, subprocess, sys, shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BUILDPY = ROOT / 'tools' / 'build.py'
BAK = ROOT / 'scratch' / 'w48_a8_build.py.bak'

MP = (ROOT / 'MATCH_PROGRESS.txt').read_text(errors='replace').splitlines()
units = {}
for ln in MP:
    m = re.match(r'^\s*(\S+)\s+([\d.]+)%\s+(\S+)\s+(\S+)\s*$', ln)
    if m and m.group(3).startswith('syslib/psx/') and not m.group(4).startswith('D_'):
        units.setdefault(m.group(3)[len('syslib/psx/'):], []).append(m.group(4))

PROBES = [
    ({}, 'baseline'),
    ({'no_delayed_branch': True}, '-fno-delayed-branch'),
    ({'no_schedule_insns': True}, '-fno-schedule-insns'),
    ({'no_schedule_insns2': True}, '-fno-schedule-insns2'),
    ({'g_value': '0'}, '-G0'),
    ({'g_value': '8'}, '-G8'),
    ({'no_split_addresses': True}, '-mno-split-addresses'),
    ({'no_strength_reduce': True}, '-fno-strength-reduce'),
]

def gate(unit):
    fns = units[unit]
    src = f'recon/syslib/psx/{unit}.c'
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', src, ','.join(fns)],
                       cwd=ROOT, capture_output=True, text=True, timeout=600)
    out = []
    tot = 0
    npass = 0
    for ln in (r.stdout + r.stderr).splitlines():
        m = re.match(r'\s*(\S+):\s+(PASS|FAIL (\d+) diffs \(ours (\d+) / oracle (\d+)\)|NO ORACLE|NOT IN OBJECT)', ln)
        if m:
            out.append(ln.strip())
            if m.group(2) == 'PASS':
                npass += 1
            elif m.group(3):
                tot += int(m.group(3))
    return tot, npass, out

def patch(unit, flags):
    txt = BAK.read_text()
    key = f'recon/syslib/psx/{unit}.c'
    if not flags:
        BUILDPY.write_text(txt); return
    ins = f'PER_TU_FLAGS = {{\n    "{key}": {flags!r},\n'
    txt2 = txt.replace('PER_TU_FLAGS = {\n', ins, 1)
    assert txt2 != txt, 'patch anchor failed'
    BUILDPY.write_text(txt2)

if __name__ == '__main__':
    shutil.copy(BUILDPY, BAK)
    try:
        for unit in sys.argv[1:]:
            print(f'##### {unit}')
            for flags, name in PROBES:
                patch(unit, flags)
                try:
                    tot, npass, out = gate(unit)
                except Exception as e:
                    print(f'  {name:26s} ERROR {e}'); continue
                print(f'  {name:26s} diffs={tot:5d} pass={npass}   {" | ".join(out)}')
    finally:
        shutil.copy(BAK, BUILDPY)
        print('[restored tools/build.py]')

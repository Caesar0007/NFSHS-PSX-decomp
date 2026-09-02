#!/usr/bin/env python3
"""M6_dump.py CAND LANE_AS [dumpflags...] -- run the real cpp+cc1plus lane on a
regional candidate inside a PRIVATE working dir and keep every RTL dump.

Read-only w.r.t. the repo: copies the candidate next to the base TU exactly like
verify_region.py does (so sibling #includes resolve), runs the same preprocessor
and CC1PLPSX flags build.py would use, adds the requested -d dump letters, and
leaves <workdir>/*.<pass> for inspection.  Does not touch tools/.
"""
import os, sys, shutil, subprocess, importlib.util
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)

cand = ROOT / sys.argv[1]
lane_as = sys.argv[2]
dumps = sys.argv[3:] or ['-dl', '-dg']
work = Path(os.environ.get('TEMP', '/tmp')) / ('m6dump_%d' % os.getpid())
work.mkdir(parents=True, exist_ok=True)

base = ROOT / lane_as
tmp = base.parent / ('%s__m6dump_%d%s' % (base.stem, os.getpid(), cand.suffix))
shutil.copyfile(cand, tmp)
try:
    tu_flags = bld.per_tu_flags(tmp)
    g = str(tu_flags.get('g_value', bld.G_VALUE))
    i_file = work / (base.stem + '.i')
    s_file = work / (base.stem + '.s')
    r = subprocess.run([str(bld.CPP), '-x', 'c', '-D__cplusplus=1', '-nostdinc', '-undef',
                        '-Dmips', '-D__mips__', '-D__psx__',
                        f'-I{bld.RECON}', str(tmp), '-o', str(i_file)],
                       capture_output=True, text=True)
    if r.returncode:
        sys.exit('[cpp] ' + r.stderr)
    flags = ['-quiet', '-O2', f'-G{g}']
    for k, f in (('no_delayed_branch', '-fno-delayed-branch'),
                 ('no_split_addresses', '-mno-split-addresses'),
                 ('no_schedule_insns', '-fno-schedule-insns'),
                 ('no_schedule_insns2', '-fno-schedule-insns2'),
                 ('no_strength_reduce', '-fno-strength-reduce'),
                 ('no_builtin', '-fno-builtin')):
        if tu_flags.get(k):
            flags.append(f)
    cmd = [str(bld.CC1PL), *flags, *dumps, str(i_file), '-o', str(s_file)]
    r = subprocess.run(cmd, capture_output=True, text=True, cwd=str(work))
    print('flags:', ' '.join(flags + dumps))
    print('cc1plus rc', r.returncode)
    if r.stderr[:2000]:
        print(r.stderr[:2000])
    print('workdir:', work)
    for p in sorted(work.iterdir()):
        print('   ', p.name, p.stat().st_size)
finally:
    tmp.unlink(missing_ok=True)

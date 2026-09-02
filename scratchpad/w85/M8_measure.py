#!/usr/bin/env python3
"""M8 measure: compile a candidate, align our insn stream index-wise with the
regional oracle (valid only when counts are equal) and classify each differing
line as REGONLY (same mnemonic + same non-register fields) vs STRUCT.

Also reports which pseudos our build allocated into $t0/$t1/$t2 (via -dg).

Usage: python scratchpad/w85/M8_measure.py <cand.cpp> [--rtl]
"""
import importlib.util, os, re, shutil, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
os.chdir(ROOT)
sys.path.insert(0, str(ROOT / 'tools'))
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
FUNC = 'CarIO_ReadInCarTextureData__FPcP8Car_tObjii'
LANE = ROOT / 'recon/game/psx/cario.cpp'
REGION = 'NFS4-R-JPN'
REG = re.compile(r'\b(zero|at|v[01]|a[0-3]|t[0-9]|s[0-8]|k[01]|gp|sp|fp|ra)\b')

cand = ROOT / sys.argv[1]
tmp = LANE.parent / ('%s__m8meas_%d%s' % (LANE.stem, os.getpid(), cand.suffix))
shutil.copyfile(cand, tmp)
base_rel = LANE.relative_to(ROOT).as_posix(); tmp_rel = tmp.relative_to(ROOT).as_posix()
for _n, _t in vars(bld).items():
    if isinstance(_t, dict) and base_rel in _t:
        _t[tmp_rel] = _t[base_rel]
try:
    if '--rtl' in sys.argv:
        outdir = ROOT / 'scratchpad' / 'w85' / 'm8rtl'; outdir.mkdir(parents=True, exist_ok=True)
        i_file = outdir / 'v.i'; s_file = outdir / 'v.s'
        g = str(bld.per_tu_flags(tmp).get('g_value', bld.G_VALUE))
        subprocess.run([str(bld.CPP), '-x', 'c', '-D__cplusplus=1', '-nostdinc', '-undef',
                        '-Dmips', '-D__mips__', '-D__psx__', f'-I{bld.RECON}', str(tmp),
                        '-o', str(i_file)], capture_output=True, text=True)
        subprocess.run([str(bld.CC1PL), '-quiet', '-O2', '-G' + g, '-dg', str(i_file),
                        '-o', str(s_file)], capture_output=True, text=True, cwd=str(outdir))
    obj = bld.compile_cpp(tmp)
    dis = subprocess.run([OBJD, '-d', '-r', '-z', str(obj)], capture_output=True, text=True).stdout
finally:
    if tmp.exists():
        tmp.unlink()

ours, cap = [], False
for ln in dis.splitlines():
    m = re.match(r'^[0-9a-f]{8} <(.+)>:', ln)
    if m:
        cap = (m.group(1) == FUNC); continue
    if not cap or not ln.strip() or 'R_MIPS' in ln:
        continue
    p = ln.split('\t')
    if len(p) < 3:
        continue
    ours.append((p[2].strip() + ' ' + (p[3].strip() if len(p) > 3 else '')).strip())

orc = []
for ln in (ROOT / 'regiondiff' / 'oracles' / REGION / (FUNC + '.s')).read_text().splitlines():
    m = re.match(r'^/\* [0-9A-F]{8} [0-9a-f]{8} \*/\s+(.*)$', ln)
    if m:
        orc.append(re.sub(r'\s+', ' ', m.group(1).strip()).replace('$', ''))

def skel(s):
    """mnemonic + operand SHAPE: registers -> R, immediates/targets -> N"""
    s = re.sub(r'[0-9a-fA-F]+ <[^>]*>', 'T', s)
    s = re.sub(r'<[^>]*>', 'T', s)
    s = re.sub(r'\.L[0-9A-F]+', 'T', s)
    s = re.sub(r'func_[0-9A-F]+', 'T', s)
    s = REG.sub('R', s)
    s = re.sub(r'-?(0x)?[0-9a-f]+', 'N', s)
    return re.sub(r'\s+', ' ', s).strip()

def regs(s):
    s = re.sub(r'<[^>]*>', '', s)
    return REG.findall(s)

print('ours %d / oracle %d' % (len(ours), len(orc)))
if len(ours) != len(orc):
    sys.exit('count mismatch -- index alignment invalid')
regonly = struct = 0
for i, (a, b) in enumerate(zip(ours, orc)):
    if skel(a) != skel(b):
        struct += 1
        print('STRUCT %4d  %-42s %s' % (i + 1, a, b))
    elif regs(a) != regs(b):
        regonly += 1
print('REGONLY diffs: %d   STRUCT diffs: %d' % (regonly, struct))

#!/usr/bin/env python3
"""M8: dump OUR compiled asm (and optionally cc1 RTL dumps) for a regiondiff
candidate compiled with a base TU's lane, plus a side-by-side against the
regional oracle slice.

Usage:
  python scratchpad/w85/M8_dump.py <cand> <lane-as> <FUNC> <REGION> [--rtl]
"""
import importlib.util, os, re, shutil, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
os.chdir(ROOT)
sys.path.insert(0, str(ROOT / 'tools'))
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
MIPS = Path(r'C:/Tools/mips-ps1/mips/bin')
OBJD = str(MIPS / 'mipsel-none-elf-objdump.exe')

cand = ROOT / sys.argv[1]
lane_as = sys.argv[2]
FUNC = sys.argv[3]
REGION = sys.argv[4] if len(sys.argv) > 4 else 'NFS4-R-JPN'
want_rtl = '--rtl' in sys.argv

base = ROOT / lane_as
tmp = base.parent / ('%s__m8dump_%d%s' % (base.stem, os.getpid(), cand.suffix))
shutil.copyfile(cand, tmp)
base_rel = base.relative_to(ROOT).as_posix()
tmp_rel = tmp.relative_to(ROOT).as_posix()
for _n, _t in vars(bld).items():
    if isinstance(_t, dict) and base_rel in _t:
        _t[tmp_rel] = _t[base_rel]
try:
    if want_rtl:
        # replicate build.py's cpp step, then run cc1plus with dump flags
        outdir = ROOT / 'scratchpad' / 'w85' / 'm8rtl'
        outdir.mkdir(parents=True, exist_ok=True)
        i_file = outdir / 'm8.i'
        s_file = outdir / 'm8.s'
        tu_flags = bld.per_tu_flags(tmp)
        g = str(tu_flags.get('g_value', bld.G_VALUE))
        r = subprocess.run([str(bld.CPP), '-x', 'c', '-D__cplusplus=1', '-nostdinc', '-undef',
                            '-Dmips', '-D__mips__', '-D__psx__', f'-I{bld.RECON}',
                            str(tmp), '-o', str(i_file)], capture_output=True, text=True)
        if r.returncode:
            print(r.stderr[-4000:]); sys.exit(1)
        cmd = [str(bld.CC1PL), '-quiet', '-O2', '-G' + g, '-dg', '-dl', str(i_file),
               '-o', str(s_file)]
        r = subprocess.run(cmd, capture_output=True, text=True, cwd=str(outdir))
        sys.stderr.write(r.stderr[-2000:])
        print('RTL dumps in', outdir)
    obj = bld.compile_cpp(tmp)
    dis = subprocess.run([OBJD, '-d', '-r', '-z', str(obj)], capture_output=True, text=True).stdout
finally:
    if tmp.exists():
        tmp.unlink()

ours = []
cap = False
for ln in dis.splitlines():
    m = re.match(r'^[0-9a-f]{8} <(.+)>:', ln)
    if m:
        cap = (m.group(1) == FUNC); continue
    if not cap:
        continue
    if not ln.strip():
        continue
    if 'R_MIPS' in ln:
        ours[-1] = ours[-1] + '   {' + ln.split()[-1] + '}'
        continue
    parts = ln.split('\t')
    if len(parts) < 3:
        continue
    ours.append(parts[2].strip() + ('  ' + parts[3].strip() if len(parts) > 3 else ''))

orc = []
p = ROOT / 'regiondiff' / 'oracles' / REGION / (FUNC + '.s')
for ln in p.read_text().splitlines():
    m = re.match(r'^/\* [0-9A-F]{8} [0-9a-f]{8} \*/\s+(.*)$', ln)
    if m:
        orc.append(re.sub(r'\s+', ' ', m.group(1).strip()))

outp = ROOT / 'scratchpad' / 'w85' / 'M8_ours.txt'
outp.write_text('\n'.join(ours))
(ROOT / 'scratchpad' / 'w85' / 'M8_oracle.txt').write_text('\n'.join(orc))
print('ours %d insns, oracle %d insns  -> M8_ours.txt / M8_oracle.txt' % (len(ours), len(orc)))

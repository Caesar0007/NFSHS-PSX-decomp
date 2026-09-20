"""symloop.py FRAGMENT [FRAGMENT...] [--quiet] -- the per-file loop for making source agree with the retail SYM:
  1. normal build of the TU(s) (tools/build.py --skip-asm --only) and a TEXT-BYTES check against the object the last honest
     link used (build/symloop_ref/<rel>.text, taken on first use) -- the code must not move;
  2. -g compile (gdebug_compile.py), ASPSX -g of just these TUs + relink of the full-debug lane, dumpsym;
  3. symtree_cmp restricted to the functions whose retail source file matches -> CLEAN / DIRTY list."""
import json
import os
import subprocess
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
PY = sys.executable
OBJCOPY = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objcopy.exe'
frs = [a for a in sys.argv[1:] if not a.startswith('--')]
quiet = '--quiet' in sys.argv


def text_of(obj):
    tmp = ROOT / 'build' / 'tmp' / 'symloop.bin'
    out = b''
    for sec in ('.text', '.rodata', '.data', '.sdata'):
        if tmp.exists():
            tmp.unlink()
        subprocess.run([OBJCOPY, '-O', 'binary', '-j', sec, str(obj), str(tmp)], capture_output=True)
        out += b'|' + sec.encode() + b'|' + (tmp.read_bytes() if tmp.exists() else b'')
    return out


srcs = [s for s in [*(ROOT / 'recon').rglob('*.cpp'), *(ROOT / 'recon').rglob('*.c')] if any(f in s.as_posix() for f in frs)]
assert srcs, 'no TU matches'
if '--ref-only' in sys.argv:          # record the CURRENT objects' bytes as the reference (run before editing)
    for s_ in srcs:
        rel = s_.relative_to(ROOT).as_posix()
        obj = ROOT / 'build' / (rel + '.o')
        ref = ROOT / 'build' / 'symloop_ref' / (rel + '.text')
        if obj.is_file() and not ref.exists():
            ref.parent.mkdir(parents=True, exist_ok=True); ref.write_bytes(text_of(obj))
    print('references recorded for', len(srcs), 'TUs'); sys.exit(0)
r = subprocess.run([PY, str(ROOT / 'tools/build.py'), '--skip-asm', '--only', ','.join(frs)], capture_output=True, text=True, cwd=ROOT)
if 'FAIL' in r.stdout or r.returncode:
    print(r.stdout[-1500:], r.stderr[-1500:]); sys.exit(1)
moved = []
for s in srcs:
    rel = s.relative_to(ROOT).as_posix()
    obj = ROOT / 'build' / (rel + '.o')
    ref = ROOT / 'build' / 'symloop_ref' / (rel + '.text')
    cur = text_of(obj)
    if not ref.exists():
        ref.parent.mkdir(parents=True, exist_ok=True)
        base = subprocess.run(['git', 'stash', 'list'], capture_output=True, text=True, cwd=ROOT)  # noqa: F841 (no stash games: first use = reference)
        ref.write_bytes(cur)
        print('  [ref] %s: reference section bytes recorded (first use -- run once BEFORE editing)' % rel)
    elif ref.read_bytes() != cur:
        moved.append(rel)
print('BYTES: %s' % ('UNCHANGED' if not moved else 'MOVED in ' + ', '.join(moved)))
r = subprocess.run([PY, str(ROOT / 'scratchpad/psyq_pipe/gdebug_compile.py'), *frs], capture_output=True, text=True, cwd=ROOT)
for ln in r.stdout.splitlines():
    if 'DIFF' in ln or 'FAILED' in ln:
        print('  [-g]', ln[:150])
env = dict(os.environ, NFS4_LANE_G='1', NFS4_LANE_OUT='build/psyq_g', NFS4_LANE_ONLY=','.join(frs))
r = subprocess.run([PY, str(ROOT / 'scratchpad/psyq_pipe/psylink_lane.py')], capture_output=True, text=True, cwd=ROOT, env=env)
for ln in r.stdout.splitlines():
    if ln.startswith('ASPSX ok') or ln.startswith('PSYLINK:'):
        print(' ', ln[:120])
subprocess.run([PY, str(ROOT / 'scratchpad/psyq_pipe/symtree_cmp.py'), str(ROOT / 'build/psyq_g/nfs4_sym.txt')], capture_output=True, text=True, cwd=ROOT)
rep = json.load(open(ROOT / 'build/psyq_g/symtree_report.json'))
names = {s.name.upper() for s in srcs}
mine = {f: v for f, v in rep.items() if v['file'].split(chr(92))[-1].upper() in names}
dirty = {f: v for f, v in mine.items() if v['issues']}
print('SYM  : %d functions, %d CLEAN, %d DIRTY' % (len(mine), len(mine) - len(dirty), len(dirty)))
if not quiet:
    for f, v in sorted(dirty.items()):
        print('   %-52s %s' % (f[:52], '; '.join(v['issues'])[:170]))

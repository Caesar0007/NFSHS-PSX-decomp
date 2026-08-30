#!/usr/bin/env python3
"""brdist.py CPP -- gate blind-spot detector: verify_asm normalises branch TARGETS,
so a branch whose OFFSET differs from retail's still reads PASS.  This compares the
per-branch DISTANCE (in instructions, branch -> target) of ours vs the oracle for
every function of a TU, using verify_asm's own compile + normalisation front end.

w63-a15 VACUITY FIX: the target-address regex was {4,8} hex digits, but objdump
prints targets UNPADDED -- any target below 0x1000 (1-3 digits) parsed as None
and was silently skipped, so the census printed "0 divergence" vacuously on most
TUs.  Regex is now +.  Every pre-w63 "clean" brdist run is unaudited.

Anti-drift (12H): loads tools/verify_asm.py's SOURCE; only the compare step is new.
"""
import re
import subprocess
import sys
from pathlib import Path

# Resolve the checkout that owns this script.  A hard-coded main checkout made
# worktree audits silently compile a different source tree and report false
# branch-distance results for otherwise verified candidates.
ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
BR = re.compile(r'^\s*(b\w*|j)\b')

src = (ROOT / 'tools' / 'verify_asm.py').read_text()
head = src.split('allpass=True')[0]
g = {'__name__': '__vsrc__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')}
cpp = sys.argv[1]
sys.argv = ['verify_asm.py', cpp, '__none__']
exec(compile(head, 'verify_asm_head', 'exec'), g)
obj = g['obj']
dis = subprocess.run([OBJD, '-d', '-r', '-z', str(obj)], capture_output=True, text=True).stdout


def ours_branches(fn):
    """[(index, distance_in_insns)] for our object's branches inside fn."""
    lab = g['_resolve'](fn)
    body, on = [], False
    for ln in dis.splitlines():
        m = re.match(r'^([0-9a-f]{8}) <(.+)>:', ln)
        if m:
            on = (m.group(2) == lab)
            continue
        if not on:
            continue
        m = re.match(r'^\s*([0-9a-f]+):\t[0-9a-f ]+\t(.*)$', ln)
        if m:
            body.append((int(m.group(1), 16), m.group(2).split(';')[0].strip()))
        elif ln.strip() == '':
            on = False
    out = []
    for i, (a, t) in enumerate(body):
        if BR.match(t):
            m = re.search(r'\b([0-9a-f]+)\b\s*<', t) or re.search(r',([0-9a-f]+)$', t)
            if m:
                out.append((i, (int(m.group(1), 16) - a) // 4))
            else:
                out.append((i, None))
    return out


def _exists_exact(p):
    """w63-a20: Path.exists() is CASE-INSENSITIVE on this NTFS checkout,
    so 'cd_read.s' silently resolves to the UNRELATED 'CD_Read.s' and the
    census compares one function's branches against another's oracle
    (cd_read reported 'BRANCH COUNT 0 vs 17').  Same guard verify_asm.py
    already carries; in-tree pairs: cd_read/CD_Read, CD_init/CD_Init."""
    return p.exists() and p.name in {e.name for e in p.parent.iterdir()}


def oracle_branches(fn):
    p = g['_find_oracle_path'](fn)   # verify_asm's resolver: case-exact
    if p is None:                    # first, then the symbol_addrs VA
        return None                  # fallbacks (func_<VA>.s etc.)
    idx, labels, brs = 0, {}, []
    for ln in p.read_text().splitlines():
        s = re.sub(r'/\*.*?\*/', '', ln).strip()
        if s.startswith('endlabel'):
            break
        if s.endswith(':') and s.startswith('.L'):
            labels[s[:-1]] = idx
            continue
        # w65-a1 (4th vacuity fix): splat writes jump-table entry points as
        # `jlabel .L<VA>` (no colon) -- skipping them dropped every branch
        # into a jump-table target (6 hidden branches in LoadGame alone).
        _m = re.match(r'^(?:jlabel|alabel|dlabel)\s+(\.L\w+)', s)
        if _m:
            labels.setdefault(_m.group(1), idx)
            continue
        if s.startswith('.word'):
            # w63-a20: spimdisasm emits every unrecognised instruction
            # (i.e. EVERY GTE/COP2 op) as `.word 0x4A480012`.  It is a
            # real 4-byte INSTRUCTION and occupies an index slot; the
            # blanket '.'-prefix skip below under-counted the oracle,
            # so every branch whose target label lay past a `.word`
            # reported a bogus distance.  26 false positives tree-wide,
            # all in the GTE-heavy render TUs (drawc/draww/flare/hrzsku/
            # sfx/trsproj/weather) -- fns that psyqproof scores REAL=0,
            # i.e. byte-identical to retail, so the 'divergence' was
            # impossible.  It also HID one real hit (_padInitSioMode).
            idx += 1
            continue
        if not s or s.startswith(('.', 'glabel', 'nonmatching', 'dlabel', 'jlabel', 'alabel')) or s.endswith(':'):
            continue
        if BR.match(s):
            m = re.search(r'(\.L\w+)\s*$', s)
            brs.append((idx, m.group(1) if m else None))
        idx += 1
    return [(i, (labels[t] - i) if (t and t in labels) else None) for i, t in brs]


fns = sorted({m.group(2) for m in (re.match(r'^([0-9a-f]{8}) <(.+)>:', l) for l in dis.splitlines()) if m})
bad = 0
for fn in fns:
    e = oracle_branches(fn)
    if e is None:
        continue
    o = ours_branches(fn)
    if len(o) != len(e):
        print('%-60s BRANCH COUNT %d vs %d' % (fn, len(o), len(e)))
        bad += 1
        continue
    d = [(k, a, b) for k, ((_, a), (_, b)) in enumerate(zip(o, e)) if a is not None and b is not None and a != b]
    if d:
        print('%-60s %d offset diffs %s' % (fn, len(d), d[:6]))
        bad += 1
print('# %d fns checked, %d with branch-offset/count divergence' % (len(fns), bad))

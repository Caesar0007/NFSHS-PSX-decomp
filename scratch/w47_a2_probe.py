#!/usr/bin/env python3
"""w47-a2 mini-TU probe harness (spchpsxz, C lane).

Compiles a hand-written .i containing ONE function under CC1PSX with the real
build.py flag set, then diffs the post-maspsx instruction stream against the
function's asm/nonmatchings oracle with a verify_asm-shaped normalizer.
~0.15 s per variant, so spelling/statement-order sweeps are cheap.
The GATE (tools/verify_asm.py on the real TU) remains the only authority --
this is a search accelerator, use it to rank, then confirm in-tree.

usage:  python scratch/w47_a2_probe.py <variants.py>
        (the variants file defines PRELUDE, FN, and VARIANTS = {name: body})
"""
import difflib
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
import cc1try  # noqa: E402

FLAGS = ("-O2", "-G4", "-g1", "-mgpOPT", "-fgnu-linker")


REGS = {'zero': 0, 'at': 1, 'v0': 2, 'v1': 3, 'a0': 4, 'a1': 5, 'a2': 6, 'a3': 7,
        's8': 30, 'fp': 30, 'sp': 29, 'gp': 28, 'ra': 31, 'k0': 26, 'k1': 27}
for _i in range(8):
    REGS['t%d' % _i] = 8 + _i
    REGS['s%d' % _i] = 16 + _i
REGS['t8'] = 24
REGS['t9'] = 25


def _reg(m):
    n = m.group(1)
    if n.isdigit():
        return 'r' + n
    return 'r%d' % REGS[n] if n in REGS else n


def norm(t):
    t = t.split('#')[0].strip()
    t = re.sub(r'%hi\([^)]*\)', '0', t)
    t = re.sub(r'%lo\([^)]*\)', '0', t)
    t = re.sub(r'%gp_rel\([^)]*\)', '0', t)
    t = re.sub(r'\$([A-Za-z0-9]+)', _reg, t)
    t = re.sub(r'\b0x([0-9a-fA-F]+)\b', lambda x: str(int(x.group(1), 16)), t)
    t = re.sub(r'\s+', ' ', t).replace(', ', ',')
    parts = t.split(' ', 1)
    op = parts[0]
    rest = parts[1] if len(parts) > 1 else ''
    a = [x.strip() for x in rest.split(',')] if rest else []
    # branch/jump targets -> T
    if op in ('b', 'j', 'jal') and a and not re.match(r'^r\d+$', a[0]):
        a = ['T']
    elif op in ('beq', 'bne') and len(a) == 3:
        a[2] = 'T'
        if a[1] == 'r0':
            op, a = ('beqz' if op == 'beq' else 'bnez'), [a[0], 'T']
    elif op in ('beqz', 'bnez', 'blez', 'bgtz', 'bltz', 'bgez') and len(a) == 2:
        a[1] = 'T'
    if op == 'j' and a and re.match(r'^r\d+$', a[0]):
        op = 'jr'
    if op in ('addu', 'subu') and len(a) == 3 and re.match(r'^-?\d+$', a[2]):
        v = int(a[2])
        op, a = 'addiu', [a[0], a[1], str(v if a[0] != a[0] or op == 'addu' else -v)]
        if t.startswith('subu'):
            a[2] = str(-v)
    if op == 'move' and len(a) == 2:
        op, a = 'addu', [a[0], a[1], 'r0']
    if op in ('addu', 'or') and len(a) == 3 and a[2] == 'r0':
        op, a = 'addu', [a[0], a[1], 'r0']
    if op == 'or' and len(a) == 3 and a[1] == 'r0':
        op, a = 'addu', [a[0], a[2], 'r0']
    if op in ('addiu', 'ori', 'li') and len(a) == 3 and a[1] == 'r0':
        op, a = 'li', [a[0], a[2]]
    if op == 'nop':
        a = []
    return (op + ' ' + ','.join(a)).strip()


def oracle_insns(fn):
    p = ROOT / 'asm' / 'nonmatchings' / 'main' / (fn + '.s')
    out = []
    for ln in p.read_text().splitlines():
        m = re.match(r'^\s*/\* [0-9A-F]+ [0-9A-F]+ [0-9A-F]+ \*/\s+(.*)$', ln)
        if m:
            out.append(norm(m.group(1)))
    return out


def run(prelude, fn, body, flags=FLAGS):
    src = prelude + '\n' + body + '\n'
    insns = cc1try.build(src, fn=None, flags=flags, cplusplus=False)
    if insns and insns[0].startswith('CC1FAIL'):
        return None, insns[0]
    return [norm(i) for i in insns], None


def score(ours, orac):
    sm = difflib.SequenceMatcher(None, ours, orac, autojunk=False)
    d = 0
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag != 'equal':
            d += (i2 - i1) + (j2 - j1)
    return d


def main():
    mod = {}
    exec(Path(sys.argv[1]).read_text(encoding='utf-8'), mod)
    fn = mod['FN']
    orac = oracle_insns(fn)
    show = sys.argv[2] if len(sys.argv) > 2 else None
    results = []
    for name, body in mod['VARIANTS'].items():
        ours, err = run(mod['PRELUDE'], fn, body)
        if err:
            print(f'{name:28s} {err}')
            continue
        results.append((score(ours, orac), len(ours), name, ours))
    for s, n, name, ours in sorted(results):
        print(f'{name:28s} diff={s:3d}  insns={n}/{len(orac)}')
    if show:
        for s, n, name, ours in results:
            if name == show:
                for ln in difflib.unified_diff(ours, orac, 'ours', 'oracle', n=1, lineterm=''):
                    print(ln)


if __name__ == '__main__':
    main()

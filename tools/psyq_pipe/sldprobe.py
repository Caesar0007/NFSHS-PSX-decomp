"""sldprobe.py recon/x.cpp [fn ...] -- FAST SLD/scope probe: compile the TU with -g (retail compiler, build.py flags) into a
temp dir and print, per function, the debug line structure the SN SYM will carry, next to retail's:
  hdr line, then per instruction the function-relative line tag (ours from the .loc stream incl. reorder #nop slots,
  retail from the SYM), and the block begin/end records (relative lines).  No object is written to build/."""
import bisect
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path[:0] = [str(ROOT / 'tools'), str(ROOT / 'tools/psyq_pipe')]
import build
import symtree_parse as P

build.OUT = ROOT / 'build/tmp/sldprobe_out'
build.CC1_FLAGS = ['-g' if f == '-g1' else f for f in build.CC1_FLAGS]
_run = build.run


def run(cmd, *a, **k):
    if Path(str(cmd[0])).name.upper().startswith('CC1PL') and '-g' not in [str(c) for c in cmd]:
        cmd = [cmd[0], '-g', *cmd[1:]]
    return _run(cmd, *a, **k)


build.run = run
src = ROOT / sys.argv[1]
want = sys.argv[2:]
try:
    if src.suffix == '.cpp':
        build.compile_cpp(src)
    else:
        build.compile_c(src, True)
except SystemExit as e:
    if 'cc1' in str(e) and 'gnu-as' not in str(e) and 'maspsx' not in str(e):
        print('COMPILE FAILED', str(e)[:400]); sys.exit(1)
s = build.OUT / (src.relative_to(ROOT).as_posix() + '.s')
lines = s.read_text(errors='replace').splitlines()

# ---- ours: walk the .s
retail = P.parse(P.RETAIL)
# retail SLD table
table = {}
for l in Path(P.RETAIL).read_text(errors='replace').splitlines():
    m = re.search(r'\$([0-9a-f]{8})\s+\S+\s+(?:Inc SLD linenum.*\(to (\d+)\)|Set SLD linenum to (\d+)|Set SLD to line (\d+) of file)', l)
    if m:
        table[int(m[1], 16)] = int(m[2] or m[3] or m[4])
keys = sorted(table)
rblocks = {}
name = None
for l in Path(P.RETAIL).read_text(errors='replace').splitlines():
    m = re.match(r'\s+name = (.*)', l)
    if m:
        name = m[1].strip(); rblocks.setdefault(name, [])
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]+) (90|92) Block (?:start|end)\s+line = (\d+)', l)
    if m and name:
        rblocks[name].append(('{' if m[2] == '90' else '}', int(m[3]), int(m[1], 16)))

fn = None; cur = None; out = {}
for l in lines:
    m = re.match(r'^\t\.ent\t(\S+)', l)
    if m:
        fn = m[1]; out[fn] = dict(hdr=None, ins=[], blocks=[], loc=None); cur = out[fn]; continue
    if fn is None:
        continue
    m = re.match(r'^\t\.loc\t\d+ (\d+)', l)
    if m:
        cur['loc'] = int(m[1]); continue
    m = re.match(r'^\t\.(begin|bend)\t\S+\t(\d+)', l)
    if m:
        cur['blocks'].append(('{' if m[1] == 'begin' else '}', int(m[2]), len(cur['ins']) * 4)); continue
    if re.match(r'^\t\.end\t', l):
        fn = None; continue
    if re.match(r'^\t\.', l) or re.match(r'^\S', l) or not l.strip():
        continue
    body = l.split('#')[0].strip()
    if body or l.strip() == '#nop':
        cur['ins'].append((cur['loc'], body or 'nop'))

import subprocess
OBJD = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
real_obj = ROOT / 'build' / (src.relative_to(ROOT).as_posix() + '.o')
dis = subprocess.run([OBJD, '-d', str(real_obj)], capture_output=True, text=True).stdout
real = {}; cur = None
for l in dis.splitlines():
    m = re.match(r'^[0-9a-f]+ <(.+)>:', l)
    if m:
        cur = m[1]; real[cur] = []; continue
    m = re.match(r'^\s*[0-9a-f]+:\s+[0-9a-f]{8}\s+(\S+)\s*(.*)', l)
    if m and cur:
        real[cur].append((m[1], m[2]))
BR = re.compile(r'^(j|jal|jr|jalr|b|beq|bne|beqz|bnez|blez|bgtz|bltz|bgez|bgezal)$')


def align(sins, rins):
    """map each REAL instruction to a .s instruction's tag (ASPSX reorder: delay/load nops, lw/sw macros = 2 words)."""
    out = []; i = 0; last = None
    for mn, ops in rins:
        if i < len(sins):
            t, b = sins[i]; smn = b.split()[0] if b else ''
        else:
            t, b, smn = last, '', ''
        if mn == 'nop' and smn != 'nop':
            out.append((last, 'nop')); continue
        if mn == 'lui' and smn in ('lw', 'sw', 'lh', 'lhu', 'lb', 'lbu', 'sh', 'sb') and '(' not in b and '%' not in b:
            out.append((t, b + '  [lui]')); last = t; continue      # macro: lui then the access
        out.append((t, b)); last = t; i += 1
        if mn in ('lui',) and smn != 'lui':
            pass
    return out


for fname, d in out.items():
    if want and fname not in want:
        continue
    r = retail.get(fname)
    locs = [t for t, _ in d['ins'] if t is not None]
    hdr = next((t for t, b in d['ins'] if re.match(r'(subu|addiu)\s+\$sp,\$sp,-?\d+', b)), locs[0] if locs else 0)
    sins = [(t, b) for t, b in d['ins'] if b != 'nop']
    rins = real.get(fname, [])
    al = align(sins, rins)
    rel = [(t - hdr) if (t is not None and hdr is not None) else None for t, _ in al]
    print('==', fname, 'hdr line', hdr, '(retail hdr', r['hdr']['line'] if r else '?', ') real words', len(rins))
    if r:
        rt = [table[keys[bisect.bisect_right(keys, r['start'] + off) - 1]] - int(r['hdr']['line']) for off in range(0, 4 * len(rins), 4)]
    else:
        rt = []
    diffs = 0
    for i, ((t, b), x) in enumerate(zip(al, rel)):
        y = rt[i] if i < len(rt) else None
        mark = '' if x == y else '  <<'
        diffs += x != y
        print('  +%03x ours %3s retail %3s  %-28s | %s%s' % (i * 4, x, y, (rins[i][0] + ' ' + rins[i][1])[:28], b[:44], mark))
    print('  tag diffs %d/%d' % (diffs, len(rel)))
    print('  blocks ours  :', ' '.join('%s%d' % (c, n) for c, n, o in d['blocks']))
    if r:
        print('  blocks retail:', ' '.join('%s%d@+%x' % (c, n, a - r['start']) for c, n, a in rblocks.get(fname, [])),
              '| retail fn end line', r['end_line'] - int(r['hdr']['line']))

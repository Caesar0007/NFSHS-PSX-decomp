"""sldprobe.py recon/x.cpp [fn ...] -- FAST SLD/scope probe: compile the TU with -g (retail compiler, build.py flags) into a
temp dir and print, per function, the debug line structure the SN SYM will carry, next to retail's:
  hdr line, then per instruction the function-relative line tag (ours from the .loc stream incl. reorder #nop slots,
  retail from the SYM), and the block begin/end records (relative lines).  No object is written to build/.
2026-09-28: use the pre-.ent .loc as the function-header anchor, matching the
native SYM header. First emitted instruction/prologue may belong to a later
statement; using it shifts every relative tag. No source/output rewriting.
Backup: scratchpad/sldprobe_before_header_20260928.py.
2026-10-31: macro-aware alignment (la / big li / bare-symbol mem ops / div-mul macros) plus an
ALIGN WARNING when .s and object word counts do not reconcile. Backup:
scratchpad/sldprobe_before_macro_20261031.py.
2026-10-31b (from agent DRAW): objdump -z keeps zero words, .word lines (GTE cop2 templates)
count as instructions, gcc #nop entries keep their own tag, and an assembler load-delay nop takes
the NEXT statement's tag (a branch-delay nop keeps the branch's). Backup: build/tmp/v/sldprobe_macro_only.py.
"""
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

fn = None; cur = None; out = {}; pending_loc = None; intext = True
for l in lines:
    sec = re.match(r'^\t\.(text|rdata|data|sdata|bss|sbss|section)\b', l)
    if sec:
        intext = sec[1] == 'text'; continue
    if not intext:
        continue                      # switch jump tables (.rdata .word $L..) are data, not code
    # GCC emits the defining/body header .loc immediately BEFORE .ent.
    # Preserve it even while outside a function; do not infer it from code.
    loc = re.match(r'^\t\.loc\t\d+ (\d+)', l)
    if loc:
        pending_loc = int(loc[1])
    m = re.match(r'^\t\.ent\t(\S+)', l)
    if m:
        fn = m[1]; out[fn] = dict(hdr=pending_loc, ins=[], blocks=[], loc=pending_loc); cur = out[fn]; continue
    if fn is None:
        continue
    m = re.match(r'^\t\.loc\t\d+ (\d+)', l)
    if m:
        cur['loc'] = int(m[1]); continue
    m = re.match(r'^\t\.(begin|bend)\t\S+\t(\d+)', l)
    if m:
        cur['blocks'].append(('{' if m[1] == 'begin' else '}', int(m[2]), len(cur['ins']) * 4)); continue
    if re.match(r'^\t\.end\t', l):
        fn = None; pending_loc = None; continue
    if (re.match(r'^\t\.', l) and not re.match(r'^\s*\.word\s', l)) or re.match(r'^\S', l) or not l.strip():
        continue
    body = l.split('#')[0].strip()
    if body or l.strip() == '#nop':
        cur['ins'].append((cur['loc'], body or 'nop'))

import subprocess
OBJD = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
# 2026-10-31c: disassemble the object compiled by THIS probe run (same code words as the
# normal build; -g changes debug records only), not build/<tu>.o, which can be stale after
# an edit or a file swap. Only names with a .ent in our .s start a new function: some TUs
# keep LM<n> line labels as object symbols, which used to cut a function after its first words.
real_obj = build.OUT / (src.relative_to(ROOT).as_posix() + '.o')
dis = subprocess.run([OBJD, '-d', '-z', str(real_obj)], capture_output=True, text=True).stdout
real = {}; cur = None
for l in dis.splitlines():
    m = re.match(r'^[0-9a-f]+ <(.+)>:', l)
    if m:
        nm = m[1]
        if nm not in out and nm.startswith('___') and '_._' + nm[3:] in out:
            nm = '_._' + nm[3:]       # destructor: the GNU-lane object spells _._X as ___X
        if nm in out or cur is None:
            cur = nm; real[cur] = []
        continue
    m = re.match(r'^\s*[0-9a-f]+:\s+[0-9a-f]{8}\s+(\S+)\s*(.*)', l)
    if m and cur:
        real[cur].append((m[1], m[2]))
BR = re.compile(r'^(j|jal|jr|jalr|b|beq|bne|beqz|bnez|blez|bgtz|bltz|bgez|bgezal)$')


MEM = {'lb', 'lbu', 'lh', 'lhu', 'lw', 'lwl', 'lwr', 'sb', 'sh', 'sw', 'swl', 'swr', 'lwc2', 'swc2'}
SYMOP = re.compile(r'[A-Za-z_.$][\w.$]*')


def _imm(s):
    try:
        return int(s.split('#')[0].strip(), 0)
    except ValueError:
        return None


def width(b, rins, j):
    """Real words one .s instruction occupies at real index j. GNU as macro expansion:
    la sym -> lui+addiu (+addu when indexed); li big -> lui[+ori]; mem op on a bare symbol or absolute
    address -> lui+op, on sym(reg) -> lui+addu+op;
    3-operand div/divu/rem/remu/mul -> the checked sequence ending at mflo/mfhi. gp-relative and %hi/%lo
    forms stay one word; the real stream decides (a non-lui first word means no expansion)."""
    smn, _, ops = b.partition(' ') if ' ' in b else b.partition('\t')
    smn = smn.strip(); ops = ops.strip()
    rmn = lambda k: rins[k][0] if k < len(rins) else ''
    if smn == 'li':
        v = _imm(ops.split(',', 1)[1]) if ',' in ops else None
        if v is None or -0x8000 <= v <= 0xffff or (v & 0xffff) == 0:
            return 1
        return 2
    if smn in ('li.d', 'li.s') and ',' in ops:
        # GPR float constant: each 32-bit half loads like li (lui and/or ori/addiu; zero = one move)
        import struct
        try:
            f = float(ops.split(',', 1)[1].split('#')[0])
        except ValueError:
            return 1
        halves = struct.unpack('<II', struct.pack('<d', f)) if smn == 'li.d' else struct.unpack('<I', struct.pack('<f', f))
        n = 0
        for h in halves:
            n += 1 if (h <= 0xffff or (h & 0xffff) == 0 or h >= 0xffff8000) else 2
        return n
    if '%' in ops:
        return 1
    if smn == 'la' and rmn(j) == 'lui':
        n = 2
        if '(' in ops and rmn(j + 2) == 'addu':
            n = 3
        return n
    if smn in MEM and rmn(j) == 'lui':
        addr = ops.split(',', 1)[1] if ',' in ops else ''
        if '(' not in addr:             # bare symbol or absolute address: lui + op
            return 2
        if SYMOP.match(addr.lstrip('-')) and rmn(j + 1) == 'addu':
            return 3                    # sym(reg): lui + addu + op
    if smn in ('div', 'divu', 'rem', 'remu', 'mul') and ops.count(',') == 2 and not ops.startswith('$0,'):
        for k in range(j, min(len(rins), j + 16)):
            if rmn(k) in ('mflo', 'mfhi'):
                return k - j + 1
    return 1


def align(sins, rins):
    """map each REAL instruction to a .s instruction's tag. ASPSX/as reorder inserts load/branch-delay nops
    (a load-delay nop takes the next statement's tag, a branch-delay nop the branch's); assembler macros expand to several words (see width()).
    2026-10-31: was lui-only for symbol loads/stores, so every `la`, big `li` and div macro shifted all
    following tags by its extra words. Returns (pairs, consumed .s count)."""
    out = []; i = 0; last = None; j = 0
    while j < len(rins):
        mn = rins[j][0]
        if i >= len(sins):
            out.append((last, '')); j += 1; continue
        t, b = sins[i]; smn = b.split()[0] if b else ''
        if smn == 'nop' and mn == 'nop':
            out.append((t, 'nop')); last = t; i += 1; j += 1; continue
        if smn == 'nop' and mn != 'nop':
            i += 1; continue          # gcc #nop that ASPSX dropped/filled
        if mn == 'nop' and smn != 'nop':
            prevbr = j > 0 and BR.match(rins[j - 1][0] or '')
            out.append((last if prevbr else t, 'nop')); j += 1; continue
        w = width(b, rins, j)
        for k in range(w):
            if j + k < len(rins):
                out.append((t, b if k == w - 1 else b + '  [macro]'))
        last = t; i += 1; j += w
    return out, i


for fname, d in out.items():
    if want and fname not in want:
        continue
    r = retail.get(fname)
    locs = [t for t, _ in d['ins'] if t is not None]
    hdr = d['hdr']
    if hdr is None:  # legacy/no pre-.ent .loc: retain the old heuristic explicitly
        hdr = next((t for t, b in d['ins'] if re.match(r'(subu|addiu)\s+\$sp,\$sp,-?\d+', b)), locs[0] if locs else 0)
    sins = list(d['ins'])
    rins = real.get(fname, [])
    al, used = align(sins, rins)
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
    if used != len(sins) or len(al) != len(rins):
        print('  ALIGN WARNING: .s instructions used %d/%d, real words %d -- tags past the first mismatch are unreliable'
              % (used, len(sins), len(rins)))
    print('  blocks ours  :', ' '.join('%s%d' % (c, n) for c, n, o in d['blocks']))
    if r:
        print('  blocks retail:', ' '.join('%s%d@+%x' % (c, n, a - r['start']) for c, n, a in rblocks.get(fname, [])),
              '| retail fn end line', r['end_line'] - int(r['hdr']['line']))

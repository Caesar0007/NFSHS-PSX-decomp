"""w46-a1: COMPOUND (PAIR) statement-position search.

`tools/stmtclimb2.py` is a def-use-guarded GREEDY SINGLE-move climber.  When it
converges (FontUpsideDownBlit: 50 is a proven single-move local optimum, w45),
the only positional neighbourhood left is COMPOUND moves -- two statements
relocated together.  A pair can win where neither single move does, because a
statement's emission position changes the live range of values the OTHER
statement's position also depends on (the w44/w45 "lever-order dependence is
basin-relative" law applied inside one dial).

Search shape (keeps the space affordable at ~1.2 s per gate):
  PHASE 1  full single-move sweep; record the gate score of EVERY (stmt -> slot)
           move that is def-use valid.  This is exactly stmtclimb2's neighbourhood
           but EXHAUSTIVE and RECORDED instead of first-improvement.
  PHASE 2  take the N best-scoring single moves (they need not improve -- a pair's
           winning halves are usually individually neutral or slightly worse) and
           gate every COMPOSITION of two of them that is still def-use valid.
  PHASE 3  greedy single-move climb from the best pair found (re-probing spellings
           from a new basin is the w45 law).

Usage:
  python tools/stmtclimb3.py <recon/path/tu.cpp> <MangledSymbol> "<c-sig-prefix>" \
         [--top N] [--minutes M] [--only i,j,k]

  --only  restrict PHASE 1/2 to these statement indices (printed by PHASE 0).
Always restores the TU; writes the best body to scratch/<sym>.pair.cpp.
"""
import re
import subprocess
import sys
import time
from itertools import combinations
from pathlib import Path

argv = sys.argv[1:]


def opt(name, default=None):
    if name in argv:
        return argv[argv.index(name) + 1]
    return default


TU = Path(argv[0])
SYM = argv[1]
CSIG = argv[2]
TOPN = int(opt('--top', 40))
MINUTES = float(opt('--minutes', 60))
ONLY = opt('--only')
ONLY = set(int(x) for x in ONLY.split(',')) if ONLY else None

ORIG = TU.read_text(newline='', encoding='utf-8')
H = ORIG.index(CSIG)
PRE, BODY = ORIG[:H], ORIG[H:]
E0 = BODY.index("  return;")

LOCALS = set()
for m in re.finditer(
        r'^\s{2,}(?:u_char|u_long|u_int|uint|ushort|byte|short|int|long|char|unsigned|signed)'
        r'[\w \*]*?\s+\*?(\w+)\s*(?:\[[^\]]*\])?\s*;', BODY[:E0], re.M):
    LOCALS.add(m.group(1))
PARAMS = set(re.findall(r'\w+\s*\*?\s*(\w+)\s*(?=[,)])',
                        BODY[BODY.index('('):BODY.index(')') + 1]))

lines = BODY[:E0].splitlines(keepends=True)
first_stmt = None
for i, l in enumerate(lines):
    s = l.strip()
    if not s or s.startswith(('/*', '*', '//', '{')) or s.endswith('{'):
        continue
    if re.match(r'^(u_char|u_long|u_int|uint|ushort|byte|short|int|long|char|unsigned|signed)\b', s):
        continue
    if s.endswith(';'):
        first_stmt = i
        break
S0 = sum(len(l) for l in lines[:first_stmt])
HEAD, TAIL = BODY[:S0], BODY[E0:]

STMTS, cur = [], []
for l in BODY[S0:E0].splitlines(keepends=True):
    cur.append(l)
    if l.rstrip().endswith(';'):
        STMTS.append(''.join(cur))
        cur = []
if cur:
    TAIL = ''.join(cur) + TAIL


def defs_uses(stmt):
    code = re.sub(r'/\*.*?\*/', ' ', stmt, flags=re.S)
    code = re.sub(r'//.*', ' ', code)
    code = re.sub(r'(->|\.)\s*\w+', ' ', code)
    d = set()
    m = re.match(r'\s*(\w+)\s*=[^=]', code)
    if m and m.group(1) in LOCALS:
        d.add(m.group(1))
        rhs = code[code.index('=') + 1:]
    else:
        rhs = code
    u = {t for t in re.findall(r'\b(\w+)\b', rhs) if t in LOCALS}
    return d, u


DU = [defs_uses(s) for s in STMTS]
N = len(STMTS)


def valid(order):
    live = set(PARAMS)
    for idx in order:
        d, u = DU[idx]
        if not u <= live:
            return False
        live |= d
    return True


def render(order):
    return PRE + HEAD + ''.join(STMTS[i] for i in order) + TAIL


_seen = {}


def gate(order):
    key = tuple(order)
    if key in _seen:
        return _seen[key]
    TU.write_text(render(order), newline='', encoding='utf-8')
    r = subprocess.run([sys.executable, 'tools/verify_asm.py',
                        str(TU).replace('\\', '/'), SYM],
                       capture_output=True, text=True)
    ln = next((l for l in (r.stdout + r.stderr).splitlines() if SYM in l), '')
    if 'PASS' in ln:
        v = (0, -1)
    else:
        m = re.search(r'FAIL (\d+) diffs \(ours (\d+)', ln)
        v = (int(m.group(1)), int(m.group(2))) if m else (9999, 0)
    _seen[key] = v
    return v


def move(order, i, pos):
    """move the statement currently at index i to slot pos."""
    rest = order[:i] + order[i + 1:]
    return rest[:pos] + [order[i]] + rest[pos:]


DEADLINE = time.time() + MINUTES * 60
out = Path('scratch') / (SYM + '.pair.cpp')
out.parent.mkdir(exist_ok=True)

try:
    base_order = list(range(N))
    assert valid(base_order), 'BASELINE fails the def-use check'
    best, ins0 = gate(base_order)
    print('PHASE 0: %d statements, baseline %d (ours %d)' % (N, best, ins0),
          flush=True)
    for i, s in enumerate(STMTS):
        print('   %2d  %s' % (i, s.strip().replace('\n', ' ')[:76]), flush=True)

    # ---------------- PHASE 1: exhaustive recorded single-move sweep ----------
    singles = []          # (score, i, pos)
    idxs = sorted(ONLY) if ONLY else range(N)
    for i in idxs:
        for pos in range(N):
            if pos == i or time.time() > DEADLINE:
                continue
            cand = move(base_order, i, pos)
            if not valid(cand):
                continue
            n, ins = gate(cand)
            if ins != ins0:
                continue
            singles.append((n, i, pos))
    singles.sort()
    print('\nPHASE 1: %d valid single moves; best %s' %
          (len(singles), singles[:5]), flush=True)
    if singles and singles[0][0] < best:
        best = singles[0][0]
        base_order = move(list(range(N)), singles[0][1], singles[0][2])
        out.write_text(render(base_order), newline='', encoding='utf-8')
        print('   single-move improvement adopted -> %d' % best, flush=True)

    # ---------------- PHASE 2: compositions of the TOPN single moves ---------
    top = singles[:TOPN]
    tried = 0
    for (na, ia, pa), (nb, ib, pb) in combinations(top, 2):
        if time.time() > DEADLINE:
            break
        if ia == ib:
            continue
        o = list(range(N))
        o = move(o, ia, pa)
        j = o.index(ib)
        o = move(o, j, pb)
        if not valid(o):
            continue
        tried += 1
        n, ins = gate(o)
        if ins == ins0 and n < best:
            best = n
            base_order = o
            out.write_text(render(base_order), newline='', encoding='utf-8')
            print('  PAIR (%d->%d, %d->%d): %d' % (ia, pa, ib, pb, n), flush=True)
    print('\nPHASE 2: %d pairs gated; best %d' % (tried, best), flush=True)

    # ---------------- PHASE 3: greedy single-move climb from the new basin ---
    improved = True
    while improved and time.time() < DEADLINE:
        improved = False
        for i in range(N):
            for pos in range(N):
                if pos == i or time.time() > DEADLINE:
                    continue
                cand = move(base_order, i, pos)
                if not valid(cand):
                    continue
                n, ins = gate(cand)
                if ins == ins0 and n < best:
                    best, base_order = n, cand
                    out.write_text(render(base_order), newline='',
                                   encoding='utf-8')
                    print('  climb %d->%d: %d' % (i, pos, n), flush=True)
                    improved = True
                    break
            if improved:
                break
    print('BEST %d  (gates: %d)  -> %s' % (best, len(_seen), out), flush=True)
finally:
    TU.write_text(ORIG, newline='', encoding='utf-8')

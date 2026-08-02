"""w45-a1: DEF-USE-GUARDED greedy statement-position hill-climb.

Successor to tools/stmtclimb.py, which is DATAFLOW-BLIND: it will happily lift a
statement that DEFINES a local above a statement that USES it (w45 caught it
moving `ytop = (ybase+5) - hoff;` past the `prim+0x1a` store that reads ytop --
an uninitialized-read the byte gate cannot see, because the gate only compares
instruction streams).

This version parses the target function's declared locals, derives per-statement
(defs, uses), and REJECTS any candidate ordering in which a local is used before
it is defined.  Sound for a single-basic-block function (no branches): the
straight-line order IS the dataflow order.  For a function with branches it is
still a conservative filter -- it never accepts an order that a straight-line
read would flag -- but review accepted moves by hand.

Usage:
  python tools/stmtclimb2.py <recon/path/tu.cpp> <MangledSymbol> <c-signature-prefix> [minutes]

e.g.
  python tools/stmtclimb2.py recon/frontend/psx/psxfront.cpp \
      FontUpsideDownBlit__FiiPviiP12charactertbli "void FontUpsideDownBlit(" 20

Always restores the TU on exit; writes the best body to scratch/<sym>.best.cpp.
"""
import re
import subprocess
import sys
import time
from pathlib import Path

TU = Path(sys.argv[1])
SYM = sys.argv[2]
CSIG = sys.argv[3]
MINUTES = float(sys.argv[4]) if len(sys.argv) > 4 else 20.0

ORIG = TU.read_text(newline='', encoding='utf-8')
H = ORIG.index(CSIG)
PRE, BODY = ORIG[:H], ORIG[H:]

# ---- carve the statement list out of the body -------------------------------
# decls end at the first statement; body ends at the closing `return;`
mdecl = re.search(r'\{\r?\n(.*?)\r?\n(?=[ \t]*\w[^;]*?;)', BODY, re.S)
E0 = BODY.index("  return;")
# locals = every declarator in the decl block (type name[,name];  / type name;)
declblock = BODY[:BODY.index('\n', BODY.index('{'))]
LOCALS = set()
for m in re.finditer(r'^\s{2,}(?:u_char|u_long|u_int|uint|ushort|byte|short|int|long|char|unsigned|signed)[\w \*]*?\s+\*?(\w+)\s*(?:\[[^\]]*\])?\s*;',
                     BODY[:E0], re.M):
    LOCALS.add(m.group(1))
# params are always live-in
PARAMS = set(re.findall(r'\w+\s*\*?\s*(\w+)\s*(?=[,)])', BODY[BODY.index('('):BODY.index(')') + 1]))

# statement start = first line after the decl block that is an assignment/expr
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
    HEAD_EXTRA = ''.join(cur)
    TAIL = HEAD_EXTRA + TAIL


def defs_uses(stmt):
    """locals DEFINED and USED by one statement (comments stripped)."""
    code = re.sub(r'/\*.*?\*/', ' ', stmt, flags=re.S)
    code = re.sub(r'//.*', ' ', code)
    # a struct MEMBER name is not a local reference: `ch->width` must not count
    # as a use of the local `width` (this false use is what made a naive parser
    # reject the baseline order).
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


def valid(order):
    """no local may be USED before it is DEFINED (straight-line dataflow)."""
    live = set(PARAMS)
    for idx in order:
        d, u = DU[idx]
        if not u <= live:
            return False
        live |= d
    return True


def gate(text):
    TU.write_text(text, newline='', encoding='utf-8')
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', str(TU).replace('\\', '/'), SYM],
                       capture_output=True, text=True)
    ln = next((l for l in (r.stdout + r.stderr).splitlines() if SYM in l), '')
    if 'PASS' in ln:
        return 0, -1
    m = re.search(r'FAIL (\d+) diffs \(ours (\d+)', ln)
    return (int(m.group(1)), int(m.group(2))) if m else (9999, 0)


def render(order):
    return PRE + HEAD + ''.join(STMTS[i] for i in order) + TAIL


DEADLINE = time.time() + MINUTES * 60
out = Path('scratch') / (SYM + '.best.cpp')
out.parent.mkdir(exist_ok=True)
try:
    order = list(range(len(STMTS)))
    assert valid(order), "BASELINE fails the def-use check -- fix the parser before trusting results"
    best, ins0 = gate(render(order))
    print(f'locals={sorted(LOCALS)}', flush=True)
    print(f'{len(STMTS)} statements; start={best} (ours {ins0})', flush=True)
    out.write_text(render(order), newline='', encoding='utf-8')
    rejected = 0
    improved = True
    while improved and time.time() < DEADLINE:
        improved = False
        for i in range(len(order)):
            if time.time() > DEADLINE:
                break
            rest = order[:i] + order[i + 1:]
            for pos in range(len(rest) + 1):
                if pos == i:
                    continue
                cand = rest[:pos] + [order[i]] + rest[pos:]
                if not valid(cand):
                    rejected += 1
                    continue
                n, ins = gate(render(cand))
                if n < best and ins == ins0:
                    best, order = n, cand
                    out.write_text(render(order), newline='', encoding='utf-8')
                    print(f'  stmt->slot {i}->{pos}: {n}   [{STMTS[order[pos]].strip()[:60]}]', flush=True)
                    improved = True
                    break
            if improved:
                break
    print(f'BEST {best}   (def-use rejected {rejected} candidate orders)', flush=True)
finally:
    TU.write_text(ORIG, newline='', encoding='utf-8')

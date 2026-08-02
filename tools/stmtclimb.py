"""w44-a2: FULL greedy statement-position hill-climb for FontUpsideDownBlit
(every statement x every slot, accumulating).  Time-capped; writes the best
body to scratch/font_best2_a2.cpp and always restores the TU."""
import subprocess, sys, re, time
from pathlib import Path
P = Path('recon/frontend/psx/psxfront.cpp')
ORIG = P.read_text(newline='', encoding='utf-8')
H = ORIG.index("void FontUpsideDownBlit(")
PRE, BODY = ORIG[:H], ORIG[H:]
S0 = BODY.index("  width = ch->width;\r\n"); E0 = BODY.index("  return;\r\n")
HEAD, TAIL = BODY[:S0], BODY[E0:]
out, cur = [], []
for l in BODY[S0:E0].splitlines(keepends=True):
    cur.append(l)
    if l.rstrip().endswith(';'): out.append(''.join(cur)); cur = []
STMTS = out
DEADLINE = time.time() + 40 * 60
def gate(text):
    P.write_text(text, newline='', encoding='utf-8')
    r = subprocess.run([sys.executable, 'tools/verify_asm.py',
                        'recon/frontend/psx/psxfront.cpp',
                        'FontUpsideDownBlit__FiiPviiP12charactertbli'],
                       capture_output=True, text=True)
    ln = next((l for l in (r.stdout+r.stderr).splitlines() if 'FontUpsideDownBlit' in l), '')
    if 'PASS' in ln: return 0, 82
    m = re.search(r'FAIL (\d+) diffs \(ours (\d+)', ln)
    return (int(m.group(1)), int(m.group(2))) if m else (9999, 0)
def render(ss): return PRE + HEAD + ''.join(ss) + TAIL
try:
    best, _ = gate(render(STMTS)); print('start', best, flush=True)
    Path('scratch/font_best2_a2.cpp').write_text(render(STMTS), newline='', encoding='utf-8')
    improved = True
    while improved and time.time() < DEADLINE:
        improved = False
        for i in range(len(STMTS)):
            if time.time() > DEADLINE: break
            rest = STMTS[:i] + STMTS[i+1:]
            for pos in range(len(rest) + 1):
                if pos == i: continue
                n, ins = gate(render(rest[:pos] + [STMTS[i]] + rest[pos:]))
                if n < best and ins == 82:
                    best = n
                    STMTS = rest[:pos] + [STMTS[i]] + rest[pos:]
                    Path('scratch/font_best2_a2.cpp').write_text(render(STMTS), newline='', encoding='utf-8')
                    print(f'  stmt {i} -> slot {pos}: {n}   [{STMTS[pos].strip()[:50]}]', flush=True)
                    improved = True
                    break
            if improved: break
    print('BEST', best, flush=True)
finally:
    P.write_text(ORIG, newline='', encoding='utf-8')

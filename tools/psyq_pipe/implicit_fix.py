"""implicit_fix.py [--apply] [fragment ...] -- give every implicitly-declared callee (scratchpad/psyq_pipe/implicit_sweep.json,
from implicit_sweep.py) a real prototype in the TU's own `<tu>_externs.h`.

CC1PLPSX 2.8.0 accepts a call to an undeclared function (an implicit `int f(...)`), but every such call statement is
wrapped in nested debug scopes that retail's SYM does not have (AI_CalcMeritsBasedOnSpeed: 30 scopes vs retail 1, all
gone with one real prototype, bytes unchanged).  Every name below is an unmangled symbol in the retail MAP (C linkage);
the parameter lists are the tree's / PsyQ 4.3's typed spellings.  Dry run by default; --apply edits the headers (gate
with symloop.py on the TUs afterwards)."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
APPLY = '--apply' in sys.argv
want = [a for a in sys.argv[1:] if not a.startswith('--')]
PROTO = {
    'fixedmult': 'int fixedmult(int a, int b)',
    'fixeddiv': 'int fixeddiv(int a, int b)',
    'rdiv': 'int rdiv(int a, int b)',
    'fixedsqrt': 'int fixedsqrt(int value)',
    'fixedatan': 'int fixedatan(int y, int x)',
    'intatan': 'int intatan(int y, int x)',
    'intarccos': 'int intarccos(int x)',
    'intsincos': 'void intsincos(int angle, int *psin, int *pcos)',
    'fixedxformx': 'void fixedxformx(matrixtdef *out, int angle)',
    'fixedxformy': 'void fixedxformy(matrixtdef *out, int angle)',
    'fixedxformz': 'void fixedxformz(matrixtdef *out, int angle)',
    'transpose': 'void transpose(matrixtdef *src, matrixtdef *dst)',
    'reorthogonalize': 'void reorthogonalize(matrixtdef *m)',
    'SetSp': 'void *SetSp(void *stack_pointer)',
    'memset': 'void *memset(void *dst, int value, unsigned int size)',
    'strncmp': 'int strncmp(char *a, char *b, int n)',
    'sprintf': 'int sprintf(char *out, const char *format, ...)',
    'purgememadr': 'int purgememadr(void *ptr)',
    'reservememadr': 'void *reservememadr(const char *name, int size, int memory_class)',
    'blockclear': 'void blockclear(void *dst, int n)',
    'systemtask': 'int systemtask(int)',
    'asyncloadfileat': 'unsigned int asyncloadfileat(char *name, char *destination)',
    'getasyncreadstatus': 'int getasyncreadstatus(unsigned int handle)',
    'SetShadeTex': 'void SetShadeTex(void *p, int tge)',
    'SetSemiTrans': 'void SetSemiTrans(void *p, int abe)',
    'SetPolyFT4': 'void SetPolyFT4(POLY_FT4 *p)',
    'SetGeomScreen': 'void SetGeomScreen(long h)',
    'PadGetState': 'int PadGetState(int port)',
    'DrawSync': 'int DrawSync(int mode)',
    'LoadImage': 'int LoadImage(RECT *rect, u_long *p)',
    'SNDover': 'int SNDover(int handle)',
    'SNDstop': 'int SNDstop(int handle)',
}
OVERRIDE = {   # per-TU spellings where the call site's operand types need them (C linkage either way)
    'recon/game/common/newton.cpp': {'SetSp': 'unsigned long SetSp(unsigned long stack_pointer)'},
}
sweep = json.loads((ROOT / 'scratchpad/psyq_pipe/implicit_sweep.json').read_text())
NOTE = ('/* Prototypes for callees this TU used to call undeclared: CC1PLPSX 2.8.0 accepts the implicit `int f(...)` but wraps\n'
        '   every such call statement in nested debug scopes retail\'s SYM does not have (tools/psyq_pipe/implicit_sweep.py). */\n')
done = 0
for tu, names in sorted(sweep.items()):
    if want and not any(w in tu for w in want):
        continue
    names = sorted({re.sub(r'\(.*$', '', n).split()[-1] for n in names})
    src = ROOT / tu
    hdr = src.with_name(src.stem + '_externs.h')
    missing = [n for n in names if n not in PROTO]
    rows = ['extern "C" %s;' % OVERRIDE.get(tu, {}).get(n, PROTO.get(n)) for n in names if n in PROTO]
    print('%-40s %s%s' % (tu, ' '.join(names), ('   NO PROTOTYPE FOR: ' + ' '.join(missing)) if missing else ''))
    if not APPLY or not rows:
        continue
    if not hdr.exists():
        print('   skipped: no', hdr.name); continue
    raw = hdr.read_bytes().decode('utf-8'); crlf = '\r\n' in raw; t = raw.replace('\r\n', '\n')
    block = NOTE + '\n'.join(rows) + '\n'
    m = list(re.finditer(r'^#endif[^\n]*\n?', t, re.M))
    if m and not t[m[-1].end():].strip():
        t = t[:m[-1].start()] + block + '\n' + t[m[-1].start():]
    else:
        t = t.rstrip('\n') + '\n\n' + block
    hdr.write_bytes((t.replace('\n', '\r\n') if crlf else t).encode('utf-8'))
    done += 1
print(('APPLIED to %d headers' % done) if APPLY else 'DRY RUN')

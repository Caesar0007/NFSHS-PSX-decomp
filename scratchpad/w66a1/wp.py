#!/usr/bin/env python3
"""wp.py TU FN -- the 15D objdump semantics proof, at WORD granularity.

For every PC-relative branch (b*/j-family excluded where absolute) in FN it
prints OUR encoded 32-bit word (objdump of the object build.py actually
produced) next to RETAIL's word (decoded from the oracle .s line comment,
which carries the retail bytes verbatim), plus both target indices.

`j`/`jal` are ABSOLUTE (R_MIPS_26, unresolved pre-link) -> their words cannot
be compared; they are printed as TARGET INDEX only, which is the whole content
of a `j`'s intra-function meaning.

Honours $W66_SPEC through br.py's patched build.py, so it proves the SHIPPED
object, not a hypothetical one.
"""
import importlib.util, os, re, subprocess, sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
BR = re.compile(r'^\s*(b\w*|j)\b')

va = (HERE / '_va_patched.py')
if not va.exists():
    sys.exit('run br.py once first (it writes _va_patched.py)')
src = va.read_text()
head = src.split('allpass=True')[0]
# br.py's patched verify_asm expects sys.modules['bld']; build it the same way
from mech import patched_source
spec_mod = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec_mod)
exec(compile(patched_source(), str(ROOT / 'tools' / 'build.py'), 'exec'), bld.__dict__)
import json
raw = os.environ.get('W66_SPEC', '{}')
if raw and not raw.lstrip().startswith('{'):
    raw = Path(raw).read_text()
spec = json.loads(raw or '{}')
for rel, fns in spec.get('branch_retarget', {}).items():
    tab = bld.PER_FN_BRANCH_RETARGET.setdefault(rel, {})
    for fn, rows in fns.items():
        tab[fn] = list(rows)
for rel, fns in spec.get('text_moves', {}).items():
    tab = bld.PER_FN_TEXT_MOVES.setdefault(rel, {})
    for fn, rows in fns.items():
        tab[fn] = list(tab.get(fn, [])) + list(rows)
for rel, fns in spec.get('text_moves_replace', {}).items():
    tab = bld.PER_FN_TEXT_MOVES.setdefault(rel, {})
    for fn, rows in fns.items():
        tab[fn] = list(rows)
sys.modules['bld'] = bld

tu, fn = sys.argv[1], sys.argv[2]
g = {'__name__': '__vsrc__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')}
sys.argv = ['verify_asm.py', tu, '__none__']
exec(compile(head, 'verify_asm_head', 'exec'), g)
obj = g['obj']
dis = subprocess.run([OBJD, '-d', '-r', '-z', str(obj)], capture_output=True, text=True).stdout
lab = g['_resolve'](fn)

body, on = [], False
for ln in dis.splitlines():
    m = re.match(r'^([0-9a-f]{8}) <(.+)>:', ln)
    if m:
        on = (m.group(2) == lab)
        continue
    if not on:
        continue
    m = re.match(r'^\s*([0-9a-f]+):\t([0-9a-f ]+)\t(.*)$', ln)
    if m:
        w = ''.join(m.group(2).split())
        body.append((int(m.group(1), 16), int(w, 16), m.group(3).split(';')[0].strip()))
    elif ln.strip() == '':
        on = False

p = g['_find_oracle_path'](fn)
o_idx, o_body, o_lab = 0, [], {}
for ln in p.read_text().splitlines():
    cm = re.search(r'/\*\s*[0-9A-Fa-f]+\s+[0-9A-Fa-f]+\s+([0-9A-Fa-f]{8})\s*\*/', ln)
    s = re.sub(r'/\*.*?\*/', '', ln).strip()
    if s.startswith('endlabel'):
        break
    if s.endswith(':') and s.startswith('.L'):
        o_lab[s[:-1]] = o_idx
        continue
    if s.startswith(('jlabel', 'alabel', 'dlabel')):
        nm = s.split()[1].rstrip(':')
        o_lab[nm] = o_idx
        continue
    if not s or s.startswith(('.', 'glabel', 'nonmatching')) or s.endswith(':'):
        if not s.startswith('.word'):
            continue
    w = 0
    if cm:
        h = cm.group(1)
        w = int(h[6:8] + h[4:6] + h[2:4] + h[0:2], 16)   # little-endian bytes
    o_body.append((o_idx, w, s))
    o_idx += 1

ours_br = [i for i, (a, w, t) in enumerate(body) if BR.match(t)]
o_br = [i for i, (a, w, s) in enumerate(o_body) if BR.match(s)]
print('%-4s %-9s %-9s %-6s %-6s %s' % ('#', 'ours_word', 'oracle_w', 'o_tgt', 'r_tgt', 'insn'))
bad = 0
for k, (bi, oi) in enumerate(zip(ours_br, o_br)):
    ua, uw, ut = body[bi]
    _, ow, os_ = o_body[oi]
    m = re.search(r'\b([0-9a-f]+)\b\s*<', ut) or re.search(r',([0-9a-f]+)$', ut)
    utgt = bi + (int(m.group(1), 16) - ua) // 4 if m else None
    om = re.search(r'(\.L\w+)\s*$', os_)
    otgt = o_lab.get(om.group(1)) if om else None
    absol = ut.split()[0] in ('j', 'jal')
    ok = (utgt == otgt) and (absol or uw == ow)
    bad += 0 if ok else 1
    print('%-4d %08x  %08x  %-6s %-6s %-4s %s' %
          (k, uw, ow, utgt, otgt, '' if ok else 'DIFF', ut))
print('MISMATCHES:', bad, '(j/jal compared by target index only -- R_MIPS_26)')

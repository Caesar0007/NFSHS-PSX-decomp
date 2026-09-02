"""S2 declaration-ORDER + SCOPE audit (W86-S5 convention: SYM Def-record order
IS the source declaration order; nested 90/92 blocks are real C blocks).

usage: s2_order.py <recon.cpp>
"""
import sys, re
from pathlib import Path
ROOT = Path(r"C:\Temp\nfs4-decomp")
SYM = r"C:\Temp\nfs4-psx\nfs4-psx-sym.txt"
cpp = Path(sys.argv[1])
raw = cpp.read_text(encoding='latin-1')

import importlib.util
sys.path.insert(0, str(ROOT / 'tools'))
_a = sys.argv[:]
sys.argv = [sys.argv[0], str(cpp), '__none__']
_sp = importlib.util.spec_from_file_location('va', ROOT / 'tools' / 'verify_asm.py')
V = importlib.util.module_from_spec(_sp)
try: _sp.loader.exec_module(V)
except SystemExit: pass
sys.argv = _a
names = set()
for nm in V._name2addr:
    if nm and not nm.startswith('.'):
        names.add(nm)
        if nm.startswith('___'): names.add('_._' + nm[3:])


def blank(s):
    out = list(s); i = 0; n = len(s)
    while i < n:
        c = s[i]
        if c == '/' and i + 1 < n and s[i+1] == '*':
            j = s.find('*/', i + 2); j = n if j < 0 else j + 2
            for k in range(i, j):
                if out[k] != '\n': out[k] = ' '
            i = j
        elif c == '/' and i + 1 < n and s[i+1] == '/':
            j = s.find('\n', i); j = n if j < 0 else j
            for k in range(i, j): out[k] = ' '
            i = j
        elif c in '"\'':
            q = c; j = i + 1
            while j < n and s[j] != q:
                if s[j] == '\\': j += 1
                j += 1
            for k in range(i + 1, min(j, n)):
                if out[k] != '\n': out[k] = ' '
            i = min(j + 1, n)
        else:
            i += 1
    return ''.join(out)


code = blank(raw)
funcs = []
i = 0; n = len(code); depth = 0; last_stop = 0
while i < n:
    c = code[i]
    if c == '{':
        if depth == 0:
            sig = code[last_stop:i]
            j = i; d = 0
            while j < n:
                if code[j] == '{': d += 1
                elif code[j] == '}':
                    d -= 1
                    if d == 0: break
                j += 1
            mm = None
            for cand in re.finditer(r'([A-Za-z_~][\w:~]*)\s*\(', sig):
                if not re.match(r'^(if|for|while|switch|return|sizeof)$', cand.group(1)):
                    mm = cand; break
            if mm: funcs.append((mm.group(1), code[i:j+1]))
            i = j + 1; last_stop = i; depth = 0
            continue
        depth += 1
    elif c == '}':
        depth = max(0, depth - 1)
    elif c == ';' and depth == 0:
        last_stop = i + 1
    i += 1


def demangle(mn):
    if mn.startswith('_._'):
        r = mn[3:]; m = re.match(r'(\d+)(.*)', r)
        c = m.group(2)[:int(m.group(1))] if m else r
        return f'{c}::~{c}'
    if re.match(r'__\d', mn):
        m = re.match(r'__(\d+)(.*)', mn); c = m.group(2)[:int(m.group(1))]
        return f'{c}::{c}'
    if '__' in mn:
        base, rest = mn.split('__', 1)
        m = re.match(r'(\d+)(.*)', rest)
        if m: return f"{m.group(2)[:int(m.group(1))]}::{base}"
        return base
    return mn


byname = {}
for k, b in funcs:
    byname.setdefault(k, []).append(b)

lines = open(SYM, encoding='latin-1').read().split('\n')
blocks = []
i = 0
while i < len(lines):
    if lines[i].endswith('8c Function start'):
        j = i + 1; blk = [lines[i]]
        while j < len(lines) and lines[j].startswith('    '):
            blk.append(lines[j]); j += 1
        while j < len(lines):
            if '8c Function start' in lines[j]: break
            blk.append(lines[j])
            if '8e Function end' in lines[j]:
                j += 1; break
            j += 1
        blocks.append(blk); i = j
    else:
        i += 1

KW = {'return', 'goto', 'break', 'continue', 'else', 'case', 'default', 'do',
      'while', 'if', 'extern', 'typedef', 'delete', 'new', 'throw', 'sizeof'}
nbad = 0
for blk in blocks:
    txt = '\n'.join(blk)
    m = re.search(r'name = (.*)', txt)
    fn = m.group(1).strip() if m else ''
    if fn not in names: continue
    dm = demangle(fn)
    cands = byname.get(dm) or byname.get(dm.split('::')[-1])
    if not cands: continue
    body = cands.pop(0)
    pnames = set(re.findall(r'9[46] Def2? class (?:REGPARM|ARG) type .*? name (\S+)', txt))
    d = 0; rows = []
    for l in blk:
        if '90 Block start' in l: d += 1
        elif '92 Block end' in l: d = max(0, d - 1)
        mm = re.match(r'^[0-9a-f]+: \$\S+ 9[46] Def2? class (\w+) type .*? name (\S+)\s*$', l)
        if mm and mm.group(1) not in ('REGPARM', 'ARG')            and mm.group(2) not in ('this', '__in_chrg') and mm.group(2) not in pnames:
            rows.append((d, mm.group(2)))
    if not rows: continue
    base = min(r[0] for r in rows)
    sym_fn = []
    for dd, nm2 in rows:
        if dd == base and nm2 not in sym_fn: sym_fn.append(nm2)
    sym_blk = [(dd, nm2) for dd, nm2 in rows if dd > base]
    # C function-scope decls (brace depth 1), in order
    cfn = []; cdeep = {}
    for mm in re.finditer(
            r'^[ \t]+([A-Za-z_][\w \t*]*?)\b([A-Za-z_]\w*)\s*(\[[^\]]*\])?\s*(=[^;]*)?;[ \t]*$',
            body, re.M):
        if mm.group(1).strip().split()[-1] in KW or mm.group(1).strip() in KW: continue
        dep = body[:mm.start()].count('{') - body[:mm.start()].count('}')
        if dep == 1: cfn.append(mm.group(2))
        else: cdeep.setdefault(mm.group(2), []).append(dep)
    common = [x for x in cfn if x in sym_fn]
    want = [x for x in sym_fn if x in cfn]
    probs = []
    if common != want:
        probs.append(f"ORDER  SYM {want}\n           C   {common}")
    # non-SYM carriers interleaved before the last SYM local?
    if want:
        lastsym = max(cfn.index(x) for x in want)
        inter = [x for x in cfn[:lastsym] if x not in sym_fn]
        if inter: probs.append(f"INTERLEAVED non-SYM before the SYM set: {inter}")
    miss = [x for x in sym_fn if x not in cfn and (x in cdeep)]
    if miss: probs.append(f"SCOPE  SYM fn-scope but C nested: {miss}")
    up = [nm2 for dd, nm2 in sym_blk if nm2 in cfn]
    if up: probs.append(f"SCOPE  SYM block-scope but C fn-scope: {sorted(set(up))}")
    if probs:
        nbad += 1
        print(f"### {fn} -> {dm}")
        for p in probs: print("    " + p)
        print()
print(f"# functions with order/scope findings: {nbad}")

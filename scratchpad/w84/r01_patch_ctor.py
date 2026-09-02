#!/usr/bin/env python3
"""R01: apply the NFS4-R-USA regional constant deltas to the tGlobalMenuDefs
initializer list of the CANDIDATE TU.

The regional oracle and the base oracle have the SAME 3207-instruction stream;
the deltas are per-ctor-argument integer constants.  This script:
  * reads both oracles, walks the (straight-line) ctor, and records for every
    `jal` the integer constant that reaches each argument position
    (a1/a2/a3 = args 1..3, 16/20/24/... (sp) = args 4..N);
  * diffs them per call;
  * the first 249 calls are the 249 top-level member initializers in order
    (calls 250-254 are the ctor BODY's five SetDimensions calls), so call #N
    is initializer #N;
  * rewrites argument #k of that initializer, preserving the source radix.

--apply writes the file; without it, it only reports.
"""
import re, sys

ROOT = 'C:/Temp/nfs4-decomp/'
CAND = ROOT + 'regiondiff/recon/NFS4-R-USA/frontend/common/femenudefs.cpp'
BASE_ORACLE = ROOT + 'asm/nonmatchings/front/__15tGlobalMenuDefs.s'
REG_ORACLE  = ROOT + 'regiondiff/oracles/NFS4-R-USA/__15tGlobalMenuDefs.s'

def norm(s):
    t = re.sub(r'\s+', ' ', s.strip()).replace('$', '')
    t = re.sub(r'\bs8\b', 'fp', t)
    t = re.sub(r',\s+', ',', t)
    t = re.sub(r'0x([0-9a-fA-F]+)', lambda m: str(int(m.group(1), 16)), t)
    t = re.sub(r'^move (\w+),(\w+)$', r'addu \1,\2,zero', t)
    t = re.sub(r'^(?:addiu|ori) (\w+),zero,(-?\d+)$', r'li \1,\2', t)
    return t

def load(p):
    out = []
    for ln in open(p, encoding='utf8', errors='replace'):
        s = re.sub(r'/\*.*?\*/', '', ln).strip()
        if (not s or s.endswith(':') or
                s.startswith(('.', 'glabel', 'nonmatching', 'dlabel', 'jlabel',
                              'alabel', 'endlabel'))):
            continue
        out.append(norm(s))
    return out

def scan(lines):
    imm = {}; simm = {}; calls = []; pend = {}; penda = {}
    for i, s in enumerate(lines):
        m = re.match(r'^jal ', s)
        if m:
            args = dict(pend)
            for rr, v in penda.items():
                args[int(rr[1])] = v
            calls.append(args); pend = {}; penda = {}
            continue
        m = re.match(r'^li (\w+),(-?\d+)$', s)
        if m:
            imm[m.group(1)] = int(m.group(2))
            if re.fullmatch(r'a[123]', m.group(1)):
                penda[m.group(1)] = int(m.group(2))
            continue
        m = re.match(r'^addu (\w+),(\w+),zero$', s)
        if m:
            d, a = m.group(1), m.group(2)
            if a in imm:
                imm[d] = imm[a]
                if re.fullmatch(r'a[123]', d): penda[d] = imm[a]
            else:
                imm.pop(d, None)
            continue
        m = re.match(r'^sw (\w+),(\d+)\(sp\)$', s)
        if m:
            rr, n = m.group(1), int(m.group(2))
            if 16 <= n < 64 and rr in imm: pend[(n - 16)//4 + 4] = imm[rr]
            simm[n] = imm.get(rr)
            continue
        m = re.match(r'^sw zero,(\d+)\(sp\)$', s)
        if m:
            n = int(m.group(1))
            if 16 <= n < 64: pend[(n - 16)//4 + 4] = 0
            simm[n] = 0
            continue
        m = re.match(r'^lw (\w+),(\d+)\(sp\)$', s)
        if m:
            rr, n = m.group(1), int(m.group(2))
            if simm.get(n) is not None: imm[rr] = simm[n]
            else: imm.pop(rr, None)
            continue
        m = re.match(r'^\w+ (\w+),', s)
        if m: imm.pop(m.group(1), None)
    return calls

B = scan(load(BASE_ORACLE)); R = scan(load(REG_ORACLE))
assert len(B) == len(R) == 254, (len(B), len(R))
deltas = {}
for n, (ba, ra) in enumerate(zip(B, R), 1):
    for k in sorted(set(ba) | set(ra)):
        bv, rv = ba.get(k), ra.get(k)
        if bv != rv and isinstance(bv, int) and isinstance(rv, int):
            deltas.setdefault(n, []).append((k, bv, rv))

# ---- parse the candidate's initializer list into (start,end) spans ----
txt = open(CAND, encoding='utf8', errors='replace').read()
mstart = re.search(r'^tGlobalMenuDefs::tGlobalMenuDefs\(\)\s*$', txt, re.M)
i = mstart.end()
mbody = re.compile(r'^\s*\{\s*$', re.M).search(txt, i)
region = txt[i:mbody.start()]
base_off = i

def strip_comments(s):
    """return s with /*..*/ replaced by spaces (same length)"""
    out = list(s)
    for m in re.finditer(r'/\*.*?\*/', s, re.S):
        for k in range(m.start(), m.end()): out[k] = ' '
    return ''.join(out)

flat = strip_comments(region)
items = []   # (start,end) absolute offsets into txt
depth = 0; cur = None
for k, ch in enumerate(flat):
    if ch in '([{': depth += 1
    elif ch in ')]}': depth -= 1
    if depth == 0 and ch in ',:':
        if cur is not None:
            items.append((cur, k)); cur = None
    elif cur is None and not ch.isspace():
        cur = k
if cur is not None: items.append((cur, len(flat)))
print("initializers found:", len(items))
assert len(items) == 249, len(items)

edits = []   # (abs_start, abs_end, oldtext, newtext)
for n in sorted(deltas):
    if n > 249:
        print(f"!! call#{n} is a BODY call, not an initializer:", deltas[n]); continue
    s, e = items[n-1]
    itemtxt = region[s:e]
    itemflat = flat[s:e]
    # split arguments at top level inside the outermost (...)
    op = itemflat.index('(')
    d = 0; astart = op + 1; args = []
    for k in range(op, len(itemflat)):
        ch = itemflat[k]
        if ch in '([{': d += 1
        elif ch in ')]}':
            d -= 1
            if d == 0:
                args.append((astart, k)); break
        elif ch == ',' and d == 1:
            args.append((astart, k)); astart = k + 1
    name = itemflat[:op].strip()
    for k, bv, rv in deltas[n]:
        if k - 1 >= len(args):
            print(f"!! call#{n} {name}: arg{k} out of range ({len(args)} args)"); continue
        a0, a1 = args[k-1]
        atxt = itemtxt[a0:a1]
        # find the integer literal whose value == bv
        found = None
        for m in re.finditer(r'0[xX][0-9a-fA-F]+|\b\d+\b', atxt):
            tok = m.group(0)
            v = int(tok, 16) if tok.lower().startswith('0x') else int(tok)
            if v == bv:
                found = m; break
        if not found:
            print(f"!! call#{n} {name}: arg{k} literal {bv} not found in {atxt!r}")
            continue
        tok = found.group(0)
        new = ('0x%x' % rv) if tok.lower().startswith('0x') else str(rv)
        if tok.lower().startswith('0x') and tok[2:].isupper():
            new = '0x%X' % rv
        abs_s = base_off + s + a0 + found.start()
        edits.append((abs_s, abs_s + len(tok), tok, new, n, name, k))

edits.sort()
print("planned edits:", len(edits))
for abs_s, abs_e, tok, new, n, name, k in edits:
    print(f"  init#{n:3d} {name:<42} arg{k}: {tok} -> {new}")

if '--apply' in sys.argv:
    out = txt
    for abs_s, abs_e, tok, new, n, name, k in reversed(edits):
        assert out[abs_s:abs_e] == tok, (out[abs_s:abs_e], tok)
        out = out[:abs_s] + new + out[abs_e:]
    open(CAND, 'w', encoding='utf8', newline='').write(out)
    print("APPLIED to", CAND)

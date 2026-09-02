"""S2 param/type audit: C signature parameter names vs SYM REGPARM/ARG rows.

usage: s2_params.py <recon.cpp>
"""
import sys, re
from pathlib import Path
ROOT = Path(r"C:\Temp\nfs4-decomp")
cpp = Path(sys.argv[1])
symtxt = (ROOT / 'scratchpad' / 'w86' / f'sym_{cpp.stem}.txt').read_text(encoding='utf-8')
raw = cpp.read_text(encoding='latin-1')


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
            if mm:
                nm = mm.group(1)
                q = sig.index('(', mm.end() - 1)
                d2 = 0; e = q
                while e < len(sig):
                    if sig[e] == '(': d2 += 1
                    elif sig[e] == ')':
                        d2 -= 1
                        if d2 == 0: break
                    e += 1
                funcs.append((nm, sig[q+1:e]))
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
        cls = m.group(2)[:int(m.group(1))] if m else r
        return f'{cls}::~{cls}'
    if re.match(r'__\d', mn):
        m = re.match(r'__(\d+)(.*)', mn); cls = m.group(2)[:int(m.group(1))]
        return f'{cls}::{cls}'
    if '__' in mn:
        base, rest = mn.split('__', 1)
        m = re.match(r'(\d+)(.*)', rest)
        if m: return f"{m.group(2)[:int(m.group(1))]}::{base}"
        return base
    return mn


byname = {}
for k, ps in funcs:
    byname.setdefault(k, []).append(ps)

bad = 0
for b in symtxt.split('\n\n'):
    if not b.strip().startswith('@'): continue
    head = b.split('\n')[0]; mn = head.split()[1]; dm = demangle(mn)
    prm = []
    for l in b.split('\n')[1:]:
        m = re.match(r'\s+(REGPARM|ARG)\s+\$\S+\s+(\S+)\s+(.*)', l)
        if m and m.group(2) not in ('this', '__in_chrg'):
            prm.append(m.group(2))
    # SYM may list a REGPARM and a same-named REG copy; dedupe keeping order
    seen = set(); prm = [p for p in prm if not (p in seen or seen.add(p))]
    cands = byname.get(dm) or byname.get(dm.split('::')[-1])
    if not cands: continue
    ps = cands.pop(0)
    cn = []
    depth = 0; cur = ''
    for ch in ps:
        if ch in '(<[': depth += 1
        elif ch in ')>]': depth -= 1
        if ch == ',' and depth == 0:
            cn.append(cur); cur = ''
        else:
            cur += ch
    cn.append(cur)
    names = []
    for a in cn:
        a = a.strip()
        if not a or a == 'void': continue
        m = re.search(r'([A-Za-z_]\w*)\s*(\[[^\]]*\])?\s*$', a)
        names.append(m.group(1) if m else '?')
    if names != prm:
        bad += 1
        print(f"### {head} -> {dm}")
        print(f"    SYM params: {prm}")
        print(f"    C   params: {names}")
        print()
print(f"# param mismatches: {bad}")

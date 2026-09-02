"""S2 reverse audit v3: brace-matched function bodies, demangled SYM pairing.

usage: s2_rev3.py <recon.cpp>     (reads scratchpad/w86/sym_<stem>.txt)
"""
import sys, re
from pathlib import Path
ROOT = Path(r"C:\Temp\nfs4-decomp")
cpp = Path(sys.argv[1])
symtxt = (ROOT / 'scratchpad' / 'w86' / f'sym_{cpp.stem}.txt').read_text(encoding='utf-8')
raw = cpp.read_text(encoding='latin-1')

# ---- strip comments + string/char literals, keeping offsets ------------------
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

# ---- split into top-level function bodies -----------------------------------
funcs = []          # (key, sig, body_text)
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
            body = raw[i:j+1]
            m = re.findall(r'([A-Za-z_~][\w:~]*)\s*\(', sig)
            nm = m[-1] if m else ''
            if nm and not re.match(r'^(if|for|while|switch|return|sizeof)$', nm) \
               and 'struct' not in sig.split('\n')[-1][:0]:
                funcs.append((nm, ' '.join(sig.split())[-160:], body, i))
            i = j + 1; last_stop = i; depth = 0
            continue
        depth += 1
    elif c == '}':
        depth = max(0, depth - 1)
    elif c == ';' and depth == 0:
        last_stop = i + 1
    i += 1

# ---- demangle SYM names -----------------------------------------------------
def demangle(mn):
    if mn.startswith('_._'):
        r = mn[3:]
        m = re.match(r'(\d+)(.*)', r)
        cls = m.group(2)[:int(m.group(1))] if m else r
        return f'{cls}::~{cls}'
    if mn.startswith('__') and re.match(r'__\d', mn):
        m = re.match(r'__(\d+)(.*)', mn)
        cls = m.group(2)[:int(m.group(1))]
        return f'{cls}::{cls}'
    if '__' in mn:
        base, rest = mn.split('__', 1)
        m = re.match(r'(\d+)(.*)', rest)
        if m:
            cls = m.group(2)[:int(m.group(1))]
            return f'{cls}::{base}'
        return base
    return mn

symblocks = []
for b in symtxt.split('\n\n'):
    if not b.strip().startswith('@'): continue
    head = b.split('\n')[0]; fn = head.split()[1]
    recs = []
    for l in b.split('\n')[1:]:
        m = re.match(r'\s+(\w+)\s+\$\S+\s+(\S+)\s+(.*)', l)
        if m: recs.append((m.group(1), m.group(2), m.group(3)))
    symblocks.append((head, fn, demangle(fn), recs))

byname = {}
for k, sig, body, off in funcs:
    byname.setdefault(k, []).append((sig, body, off))

DECL = re.compile(
    r'^[ \t]+(?:const\s+|static\s+|volatile\s+|unsigned\s+|signed\s+|struct\s+|register\s+)*'
    r'([A-Za-z_]\w*)\s+((?:\*\s*)?[A-Za-z_]\w*(?:\s*\[[^\]]*\])?'
    r'(?:\s*,\s*(?:\*\s*)?[A-Za-z_]\w*(?:\s*\[[^\]]*\])?)*)\s*(?:=[^;]*)?;\s*$', re.M)
KW = {'return','goto','break','continue','else','case','default','do','while','if','extern','typedef','delete','new','throw','sizeof'}

used = set()
nmatch = 0
for head, mn, dm, recs in symblocks:
    cands = byname.get(dm, []) or byname.get(dm.split('::')[-1], [])
    pick = None
    for c in cands:
        if id(c) not in used: pick = c; break
    if pick is None:
        print(f"!! NO BODY for {mn}  (demangled {dm})\n"); continue
    used.add(id(pick)); nmatch += 1
    sig, body, off = pick
    bnc = blank(body)
    decls = []
    for m in DECL.finditer(bnc):
        if m.group(1) in KW: continue
        for d in m.group(2).split(','):
            d = re.sub(r'\[.*', '', d.strip().lstrip('*').strip()).strip()
            if d and d not in KW: decls.append(d)
    snset = {n for c, n, _ in recs}
    pnames = {n for c, n, _ in recs if c in ('REGPARM', 'ARG')}
    conly = [d for d in decls if d not in snset]
    sonly = [n for c, n, _ in recs if n not in decls and c not in ('REGPARM','ARG')
             and n not in pnames and n not in ('this','__in_chrg')]
    notes = ' '.join(re.findall(r'/\*.*?\*/', body, re.S))
    docd = [d for d in conly if re.search(r'CARRIER[^*]*%s' % re.escape(d), notes)
            or re.search(r'%s[^*]{0,200}(carrier|CARRIER|temp)' % re.escape(d), notes)]
    conly = [d for d in conly if d not in docd]
    if conly or sonly:
        print(f"### {head}   -> {dm}")
        print(f"    SYMrec: {[(c,n) for c,n,_ in recs if n not in ('this','__in_chrg')]}")
        print(f"    Cdecl : {decls}")
        if docd: print(f"    (documented carriers: {docd})")
        if conly: print(f"    C-ONLY  : {conly}")
        if sonly: print(f"    SYM-ONLY: {sonly}")
        print()
print(f"# matched {nmatch}/{len(symblocks)} SYM blocks; {len(funcs)} bodies in file")

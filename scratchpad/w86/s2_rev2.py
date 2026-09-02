"""S2 reverse audit v2: name-anchored pairing of SYM blocks to recon sections.

usage: s2_rev2.py <recon.cpp>     (reads scratchpad/w86/sym_<stem>.txt)
"""
import sys, re
from pathlib import Path
ROOT = Path(r"C:\Temp\nfs4-decomp")
cpp = Path(sys.argv[1])
symtxt = (ROOT / 'scratchpad' / 'w86' / f'sym_{cpp.stem}.txt').read_text(encoding='utf-8')
src = cpp.read_text(encoding='latin-1')

symblocks = []
for b in symtxt.split('\n\n'):
    if not b.strip().startswith('@'):
        continue
    head = b.split('\n')[0]
    fn = head.split()[1]
    recs = []
    for l in b.split('\n')[1:]:
        m = re.match(r'\s+(\w+)\s+\$\S+\s+(\S+)\s+(.*)', l)
        if m:
            recs.append((m.group(1), m.group(2), m.group(3)))
    symblocks.append((head, fn, recs))

parts = re.split(r'(/\* ---- .*? ---- \*/)', src, flags=re.S)
secs = []
for i in range(1, len(parts), 2):
    title = re.sub(r'/\* ---- (.*?)(\s+\[.*)? ---- \*/', r'\1', parts[i].replace('\n', ' ')).strip()
    secs.append((title, parts[i + 1] if i + 1 < len(parts) else ''))

DECL = re.compile(
    r'^[ \t]+(?:const\s+|static\s+|volatile\s+|unsigned\s+|signed\s+|struct\s+|register\s+)*'
    r'([A-Za-z_]\w*)\s+((?:\*\s*)?[A-Za-z_]\w*(?:\s*\[[^\]]*\])?'
    r'(?:\s*,\s*(?:\*\s*)?[A-Za-z_]\w*(?:\s*\[[^\]]*\])?)*)\s*(?:=[^;]*)?;\s*$', re.M)
KW = {'return', 'goto', 'break', 'continue', 'else', 'case', 'default', 'do', 'while', 'if', 'extern'}


def base(mangled):
    if mangled.startswith('_._'):
        return '~' + mangled[3:].lstrip('0123456789')
    if mangled.startswith('__') and not mangled.startswith('___'):
        c = mangled[2:].lstrip('0123456789')
        return c.split('P')[0] if False else c
    b = mangled.split('__')[0]
    return b


si = 0
for head, fn, recs in symblocks:
    bn = base(fn)
    hit = None
    for k in range(si, len(secs)):
        if re.search(r'(^|[^A-Za-z0-9_])%s([^A-Za-z0-9_]|$)' % re.escape(bn.split('__')[0]), secs[k][0]) \
           or fn in secs[k][0]:
            hit = k; break
    if hit is None:
        print(f"!! NO SECTION for {fn} (base {bn})"); print(); continue
    si = hit + 1
    title, body = secs[hit]
    body_nc = re.sub(r'/\*.*?\*/', '', body, flags=re.S)
    body_nc = re.sub(r'//.*', '', body_nc)
    decls = []
    for m in DECL.finditer(body_nc):
        if m.group(1) in KW:
            continue
        for d in m.group(2).split(','):
            d = re.sub(r'\[.*', '', d.strip().lstrip('*').strip()).strip()
            if d and d not in KW:
                decls.append(d)
    sn = [n for c, n, _ in recs]
    snset = set(sn)
    conly = [d for d in decls if d not in snset]
    pnames = {n for c, n, _ in recs if c in ('REGPARM', 'ARG')}
    sonly = [n for c, n, _ in recs if n not in decls and c not in ('REGPARM', 'ARG')
             and n not in pnames and n not in ('this', '__in_chrg')]
    order_bad = [d for d in decls if d in snset] != [n for c, n, _ in recs if n in set(decls) and c not in ('REGPARM', 'ARG')]
    print(f"### {head}")
    print(f"    SRC   : {title}")
    print(f"    SYMrec: {[(c,n) for c,n,_ in recs]}")
    print(f"    Cdecl : {decls}")
    if conly: print(f"    C-ONLY  : {conly}")
    if sonly: print(f"    SYM-ONLY: {sonly}")
    print()

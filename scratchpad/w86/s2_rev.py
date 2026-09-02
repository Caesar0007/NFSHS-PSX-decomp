"""S2 reverse audit: C-declared locals per recon function vs the SYM record set.

usage: s2_rev.py <symfile.txt-from-s2_audit> <recon.cpp>
Pairs SYM blocks (VA order) with the recon's `/* ---- Name ... */` sections in
file order and prints, per function:
   SYM-only names   (a SYM local not spelled in the C body)
   C-only names     (a declared C local with no SYM record  => compiler temp?)
"""
import sys, re

OFF = int(sys.argv[3]) if len(sys.argv) > 3 else 0
symtxt = open(sys.argv[1], encoding='latin-1').read()
src = open(sys.argv[2], encoding='latin-1').read()

symblocks = []
for b in symtxt.split('\n\n'):
    if not b.strip().startswith('@'):
        continue
    head = b.split('\n')[0]
    names = []
    for l in b.split('\n')[1:]:
        m = re.match(r'\s+(\w+)\s+\$\S+\s+(\S+)\s+(.*)', l)
        if m:
            names.append((m.group(1), m.group(2), m.group(3).replace('  !!MISSING', '')))
    symblocks.append((head, names))

# split source into sections at the /* ---- ... ---- */ markers
parts = re.split(r'(/\* ---- .*? ---- \*/)', src, flags=re.S)
secs = []
for i in range(1, len(parts), 2):
    title = re.sub(r'/\* ---- (.*?)\s+\[.*', r'\1', parts[i]).strip()
    secs.append((title, parts[i + 1] if i + 1 < len(parts) else ''))

DECL = re.compile(
    r'^[ \t]+(?:const\s+|static\s+|volatile\s+|unsigned\s+|signed\s+|struct\s+|register\s+)*'
    r'([A-Za-z_]\w*)\s+((?:\*\s*)?[A-Za-z_]\w*(?:\s*\[[^\]]*\])?'
    r'(?:\s*,\s*(?:\*\s*)?[A-Za-z_]\w*(?:\s*\[[^\]]*\])?)*)\s*(?:=[^;]*)?;\s*$', re.M)
KW = {'return', 'goto', 'break', 'continue', 'else', 'case', 'default', 'do', 'while', 'if'}

for idx, (title, body) in enumerate(secs):
    body_nc = re.sub(r'/\*.*?\*/', '', body, flags=re.S)
    body_nc = re.sub(r'//.*', '', body_nc)
    decls = []
    for m in DECL.finditer(body_nc):
        if m.group(1) in KW:
            continue
        for d in m.group(2).split(','):
            d = d.strip().lstrip('*').strip()
            d = re.sub(r'\[.*', '', d).strip()
            if d and d not in KW:
                decls.append(d)
    print(f"--- SRC[{idx}] {title}")
    print(f"    C  : {decls}")
    k = idx + OFF
    if 0 <= k < len(symblocks):
        h, nm = symblocks[k]
        print(f"    SYM: {h}")
        print(f"       : {[(c,n) for c,n,_ in nm]}")
        sn = {n for c, n, _ in nm}
        conly = [d for d in decls if d not in sn]
        sonly = [n for c, n, _ in nm if n not in decls and c not in ('REGPARM', 'ARG')]
        if conly: print(f"    C-ONLY : {conly}")
        if sonly: print(f"    SYM-ONLY: {sonly}")
    print()

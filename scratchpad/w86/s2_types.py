"""S2 type audit: SYM local TYPE vs the C declaration's type, per function.

usage: s2_types.py <recon.cpp>
Only reports SYM-named locals whose C declaration exists but whose base type
does not agree with the SYM row.
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
                funcs.append((mm.group(1), blank(raw[i:j+1]), raw[i:j+1]))
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
        m = re.match(r'__(\d+)(.*)', mn); return f"{m.group(2)[:int(m.group(1))]}"*1 and f"{m.group(2)[:int(m.group(1))]}::{m.group(2)[:int(m.group(1))]}"
    if '__' in mn:
        base, rest = mn.split('__', 1)
        m = re.match(r'(\d+)(.*)', rest)
        if m: return f"{m.group(2)[:int(m.group(1))]}::{base}"
        return base
    return mn


byname = {}
for k, b, rb in funcs:
    byname.setdefault(k, []).append((b, rb))

# SYM base type -> acceptable C spellings
OK = {
    'SHORT': {'short', 'signed short'},
    'USHORT': {'u_short', 'ushort', 'unsigned short', 'word'},
    'INT': {'int', 'signed int', 'long'},
    'UINT': {'uint', 'unsigned int', 'u_int', 'unsigned long', 'u_long', 'ulong'},
    'LONG': {'long', 'int'},
    'ULONG': {'u_long', 'ulong', 'unsigned long', 'uint', 'u_int', 'unsigned int'},
    'CHAR': {'char', 'signed char'},
    'UCHAR': {'u_char', 'uchar', 'byte', 'unsigned char'},
    'BOOL': {'bool', 'int'},
    'VOID': {'void'},
    'FLOAT': {'float'},
}

bad = 0
for b in symtxt.split('\n\n'):
    if not b.strip().startswith('@'): continue
    L = b.split('\n'); head = L[0]; mn = head.split()[1]; dm = demangle(mn)
    cands = byname.get(dm) or byname.get(dm.split('::')[-1])
    if not cands: continue
    body, rawbody = cands.pop(0)
    issues = []
    for l in L[1:]:
        m = re.match(r'\s+(\w+)\s+\$\S+\s+(\S+)\s+(.*)', l)
        if not m: continue
        cls, nm2, ty = m.groups()
        if nm2 in ('this', '__in_chrg'): continue
        ty = ty.strip()
        # find C declaration of nm2 inside the body
        dm2 = re.search(r'^[ \t]+([A-Za-z_][\w \t*]*?)\b(%s)\s*(\[[^\]]*\])?\s*(=[^;]*)?;\s*$'
                        % re.escape(nm2), body, re.M)
        if not dm2: continue
        ctype = ' '.join(dm2.group(1).split())
        ptr = '*' in ctype or bool(dm2.group(3))
        cbase = ctype.replace('*', '').replace('const', '').replace('static', '').strip()
        # SYM shape
        sym_ptr = ty.startswith('PTR') or ty.startswith('ARY')
        core = re.sub(r'^(PTR |ARY )+', '', ty)
        core = re.sub(r'\s*size \d+.*', '', core).strip()
        tag = re.search(r'tag (\S+)', ty)
        if sym_ptr != ptr:
            issues.append(f"{nm2}: SYM {ty!r} vs C '{ctype}' [ptr/array shape]")
            continue
        if core in ('STRUCT', 'ENUM', 'UNION'):
            want = tag.group(1) if tag else None
            if want and want not in cbase:
                issues.append(f"{nm2}: SYM {core} {want} vs C '{cbase}'")
        elif core in OK:
            if cbase.lower() not in OK[core] and cbase not in OK[core]:
                issues.append(f"{nm2}: SYM {core} vs C '{cbase}'")
    if issues:
        bad += len(issues)
        print(f"### {head} -> {dm}")
        for x in issues: print("    " + x)
        print()
print(f"# type mismatches: {bad}")

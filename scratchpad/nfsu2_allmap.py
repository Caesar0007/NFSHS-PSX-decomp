import re
import sys
from pathlib import Path

IDA = r"C:/Temp/nfs4-clean/nfs4-mobile/nfs4-mobile-IDA.c"
RECON = Path(r"C:/Temp/nfs4-decomp/recon/game/common")

def literals(text, x86=False):
    out = set()
    for m in re.finditer(r'0x[0-9a-fA-F]+|\b\d{2,}\b', text):
        t = m.group(0)
        v = int(t, 16) if t.lower().startswith('0x') else int(t)
        if v < 32:
            continue
        if x86 and 0x400000 <= v <= 0x700000:
            continue
        if 0x80000000 <= v <= 0x80200000:
            continue
        out.add(v)
    return out

def weight(v):
    r = 1
    if v >= 0x10000: r += 4
    elif v >= 0x1000: r += 2
    if v > 0xff and (v & 0xfff) not in (0, 0x800):
        r += 4
    return r

# IDA functions
text = open(IDA, encoding='utf-8', errors='replace').read()
hdrs = [(m.start(), m.group(1)) for m in
        re.finditer(r'\n[^\n;{}]*?\b(sub_[0-9A-F]{6})\([^;\n]*\)\s*\n\{', text)]
ida = {}
for i, (pos, name) in enumerate(hdrs):
    end = hdrs[i + 1][0] if i + 1 < len(hdrs) else len(text)
    body = text[pos:end]
    if len(body) >= 250:
        ida[name] = literals(body, x86=True)

fn_hdr = re.compile(r'^[A-Za-z_][\w \*&:]*?\b([A-Za-z_]\w+)\s*\([^;]*$')

for cpp in sorted(RECON.glob("*.cpp")):
    src = open(cpp, encoding='utf-8', errors='replace').read()
    src = re.sub(r'/\*.*?\*/', '', src, flags=re.S)
    src = re.sub(r'//[^\n]*', '', src)
    lines = src.splitlines()
    fns = []
    for i, ln in enumerate(lines):
        if len(ln) > 5 and ln[0].isalpha() and '(' in ln and ';' not in ln \
                and '=' not in ln and not ln.startswith(('if', 'while', 'for',
                                                        'switch', 'return', 'else')):
            m = re.search(r'\b([A-Za-z_]\w{4,})\s*\(', ln)
            if m:
                fns.append((i, m.group(1)))
    anchors = []
    for j, (i, name) in enumerate(fns):
        end = fns[j + 1][0] if j + 1 < len(fns) else len(lines)
        lset = literals("\n".join(lines[i:end]))
        if len(lset) < 3:
            continue
        best = None
        for sub, sl in ida.items():
            common = lset & sl
            if not common:
                continue
            sc = sum(weight(v) for v in common)
            distinct = sum(1 for v in common if v > 0xff and (v & 0xfff) not in (0, 0x800))
            if best is None or sc > best[0]:
                best = (sc, sub, distinct)
        if best and best[0] >= 20 and best[2] >= 1:
            anchors.append((int(best[1][4:], 16), name, best[0], best[2]))
    if not anchors:
        continue
    anchors.sort()
    vas = [a[0] for a in anchors]
    print(f"\n=== {cpp.name} ({len(fns)} fns, {len(anchors)} anchors) ===")
    for va, name, sc, dst in anchors:
        print(f"  {va:#x}  {name:44s} score={sc} distinct={dst}")

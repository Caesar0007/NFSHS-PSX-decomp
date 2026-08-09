import re
from collections import Counter

IDA = r"C:/Temp/nfs4-clean/nfs4-mobile/nfs4-mobile-IDA.c"
PSX = r"C:/Temp/nfs4-decomp/recon/game/common/physics.cpp"

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
    # non-round values are far more distinctive
    r = 1
    if v >= 0x10000: r += 4
    elif v >= 0x1000: r += 2
    if v & 0xfff not in (0, 0x800) and v > 0xff:
        r += 4
    return r

# --- split PSX physics.cpp into functions
src = open(PSX, encoding='utf-8', errors='replace').read()
src = re.sub(r'/\*.*?\*/', '', src, flags=re.S)
src = re.sub(r'//[^\n]*', '', src)
lines = src.splitlines()
hdr_re = re.compile(r'^[A-Za-z_][\w \*]*\bPhysics_\w+\s*\(')
fns = []
for i, ln in enumerate(lines):
    if hdr_re.match(ln):
        name = re.search(r'\b(Physics_\w+)\s*\(', ln).group(1)
        fns.append((i, name))
psx = {}
for j, (i, name) in enumerate(fns):
    end = fns[j + 1][0] if j + 1 < len(fns) else len(lines)
    body = "\n".join(lines[i:end])
    psx[name] = literals(body)

# --- split IDA file into functions
text = open(IDA, encoding='utf-8', errors='replace').read()
hdrs = [(m.start(), m.group(1)) for m in
        re.finditer(r'\n[^\n;{}]*?\b(sub_[0-9A-F]{6})\([^;\n]*\)\s*\n\{', text)]
ida = {}
for i, (pos, name) in enumerate(hdrs):
    end = hdrs[i + 1][0] if i + 1 < len(hdrs) else len(text)
    body = text[pos:end]
    if len(body) >= 250:
        ida[name] = literals(body, x86=True)

print(f"{'PSX function':44s} best-sub    score  runner-up  shared distinctive literals")
for name, lset in psx.items():
    if len(lset) < 2:
        print(f"{name:44s} (too few literals: {sorted(hex(v) for v in lset)})")
        continue
    scored = []
    for sub, sl in ida.items():
        common = lset & sl
        if not common:
            continue
        sc = sum(weight(v) for v in common)
        scored.append((sc, sub, common))
    scored.sort(reverse=True)
    if not scored:
        print(f"{name:44s} NO MATCH")
        continue
    sc, sub, common = scored[0]
    ru = f"{scored[1][1]}:{scored[1][0]}" if len(scored) > 1 else "-"
    lits = ", ".join(hex(v) for v in sorted(common, reverse=True)[:8])
    print(f"{name:44s} {sub}  {sc:5d}  {ru:16s} {lits}")

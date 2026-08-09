import re
import sys
from collections import Counter, defaultdict

IDA = r"C:/Temp/nfs4-clean/nfs4-mobile/nfs4-mobile-IDA.c"
PSX = r"C:/Temp/nfs4-decomp/recon/game/common/physics.cpp"

def literals(text):
    out = Counter()
    for m in re.finditer(r'0x[0-9a-fA-F]+|\b\d{2,}\b', text):
        t = m.group(0)
        v = int(t, 16) if t.lower().startswith('0x') else int(t)
        # skip trivial / address-like values
        if v in (0, 1) or v < 10:
            continue
        if 0x400000 <= v <= 0x700000:      # x86 image addresses
            continue
        if 0x80000000 <= v <= 0x80200000:  # PSX addresses
            continue
        out[v] += 1
    return out

psx_src = open(PSX, encoding='utf-8', errors='replace').read()
# strip comments so receipts don't pollute
psx_src = re.sub(r'/\*.*?\*/', '', psx_src, flags=re.S)
psx_src = re.sub(r'//[^\n]*', '', psx_src)
psx_lits = literals(psx_src)
# distinctive = value that appears in physics.cpp, weight rare/large values higher
def weight(v):
    if v >= 0x10000: return 6
    if v >= 0x1000: return 4
    if v >= 0x100: return 2
    return 1
print(f"physics.cpp distinct literals: {len(psx_lits)}")

# split IDA file into functions
text = open(IDA, encoding='utf-8', errors='replace').read()
# IDA definition lines look like:  ret __conv sub_4xxxxx(args)\n{ ... }\n
parts = re.split(r'\n(?=[\w /*]+?\b(sub_[0-9A-F]+)\()', text)
# simpler: find each "sub_XXXX(" header position where next non-empty line is "{"
hdrs = [(m.start(), m.group(1)) for m in
        re.finditer(r'\n[^\n;{}]*?\b(sub_[0-9A-F]{6})\([^;\n]*\)\s*\n\{', text)]
scores = []
for i, (pos, name) in enumerate(hdrs):
    end = hdrs[i + 1][0] if i + 1 < len(hdrs) else len(text)
    body = text[pos:end]
    if len(body) < 300:
        continue
    lits = literals(body)
    common = set(lits) & set(psx_lits)
    if not common:
        continue
    sc = sum(weight(v) for v in common)
    scores.append((sc, name, len(body), sorted(common, key=lambda v: -v)[:12]))
scores.sort(reverse=True)
print(f"functions parsed: {len(hdrs)}")
print("top candidates (score, sub=VA, bodylen, shared literals):")
for sc, name, blen, com in scores[:30]:
    print(f"  {sc:4d}  {name}  len={blen:6d}  " +
          ", ".join(hex(v) if v > 255 else str(v) for v in com))

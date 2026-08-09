import re

IDA = r"C:/Temp/nfs4-clean/nfs4-mobile/nfs4-mobile-IDA.c"
text = open(IDA, encoding='utf-8', errors='replace').read()

# all string variables with values
sval = {}
for m in re.finditer(r'char (\w+)\[\d*\] = "((?:[^"\\]|\\.)*)"', text):
    sval[m.group(1)] = m.group(2)

# function bodies in the EA game band
hdrs = [(m.start(), m.group(1)) for m in
        re.finditer(r'\n[^\n;{}]*?\b(sub_[0-9A-F]{6})\([^;\n]*\)\s*\n\{', text)]
LO, HI = 0x4CB000, 0x52C000
rows = []
for i, (pos, name) in enumerate(hdrs):
    va = int(name[4:], 16)
    if not (LO <= va <= HI):
        continue
    end = hdrs[i + 1][0] if i + 1 < len(hdrs) else len(text)
    body = text[pos:end]
    refs = []
    for var in re.findall(r'\ba[A-Z]\w+\b', body):
        if var in sval and sval[var] not in refs:
            refs.append(sval[var])
    if refs:
        rows.append((va, name, refs))

rows.sort()
print(f"{len(rows)} EA-band functions reference strings\n")
for va, name, refs in rows:
    # keep name-bearing / informative strings only
    good = [r for r in refs
            if len(r) > 4 and not r.startswith(('%', ' ', '\\n'))
            and not re.fullmatch(r'[\d\s%.dxs\\n-]+', r)]
    if not good:
        continue
    print(f"{name}:")
    for r in good[:6]:
        print(f"    {r[:100]}")

import re

IDA = r"C:/Temp/nfs4-clean/nfs4-mobile/nfs4-mobile-IDA.c"
text = open(IDA, encoding='utf-8', errors='replace').read()

# --- 1) paths.cpp: locate any var whose value mentions PATHS.cpp or Paths_,
#        then find the enclosing/nearest function for each textual reference
targets = {}
for m in re.finditer(r'char (\w+)\[\d*\] = "((?:[^"\\]|\\.)*)"', text):
    if 'PATHS.cpp' in m.group(2) or 'Paths_' in m.group(2):
        targets[m.group(1)] = m.group(2)[:70]
print("paths string vars:", targets)

sub_def = re.compile(r'\b(sub_[0-9A-F]{6})\([^;\n]*\)\s*\n\{')
defs = [(m.start(), m.group(1)) for m in sub_def.finditer(text)]
import bisect
positions = [p for p, _ in defs]
for var, val in targets.items():
    for m in re.finditer(r'\b' + var + r'\b', text):
        # skip the definition line itself
        line_start = text.rfind('\n', 0, m.start())
        if text[line_start:m.start()].lstrip().startswith('char '):
            continue
        k = bisect.bisect_right(positions, m.start()) - 1
        if k >= 0:
            print(f"  ref to {var} ({val!r}) inside/after {defs[k][1]}")

# --- 2) lower region 0x400000-0x4CB000: subs referencing EA-flavored strings
sval = {}
for m in re.finditer(r'char (\w+)\[\d*\] = "((?:[^"\\]|\\.)*)"', text):
    sval[m.group(1)] = m.group(2)
EA_HINTS = ('slice', 'perp', 'cop', 'chase', 'lap', 'Car', 'car ', 'track',
            'race', 'heat', 'pursuit', 'ticket', 'nfs', 'NFS', 'Glue',
            'spike', 'roadblock', 'BUSTED', 'arrest')
hdrs = [(m.start(), m.group(1)) for m in
        re.finditer(r'\n[^\n;{}]*?\b(sub_[0-9A-F]{6})\([^;\n]*\)\s*\n\{', text)]
count = 0
for i, (pos, name) in enumerate(hdrs):
    va = int(name[4:], 16)
    if not (0x430000 <= va < 0x4CB000):
        continue
    end = hdrs[i + 1][0] if i + 1 < len(hdrs) else len(text)
    body = text[pos:end]
    refs = []
    for var in set(re.findall(r'\ba[A-Z]\w+\b', body)):
        v = sval.get(var)
        if v and any(h in v for h in EA_HINTS) and 'Jez' not in v:
            refs.append(v[:80])
    if refs:
        count += 1
        print(f"{name}: " + " | ".join(sorted(refs)[:4]))
        if count > 30:
            break

import re
from collections import defaultdict

IDA = r"C:/Temp/nfs4-clean/nfs4-mobile/nfs4-mobile-IDA.c"
text = open(IDA, encoding='utf-8', errors='replace').read()

# 1) find IDA string variables holding nfs4 source paths
#    char aFoo[NN] = "C:\\Jez\\Dev\\nfs4\\...";
svar = {}
for m in re.finditer(r'char (\w+)\[\d*\] = "((?:[^"\\]|\\.)*)"', text):
    var, val = m.group(1), m.group(2)
    if 'nfs4' in val.lower() and ('.cpp' in val or '.h' in val):
        svar[var] = val.replace('\\\\', '\\')
print(f"nfs4 path string vars: {len(svar)}")

# 2) split into functions, note which reference each path var
hdrs = [(m.start(), m.group(1)) for m in
        re.finditer(r'\n[^\n;{}]*?\b(sub_[0-9A-F]{6})\([^;\n]*\)\s*\n\{', text)]
file_refs = defaultdict(set)   # source file -> set of sub names
for i, (pos, name) in enumerate(hdrs):
    end = hdrs[i + 1][0] if i + 1 < len(hdrs) else len(text)
    body = text[pos:end]
    for var, path in svar.items():
        if re.search(r'\b' + var + r'\b', body):
            fname = path.split('\\')[-1]
            file_refs[fname].add(name)

for f in sorted(file_refs):
    subs = sorted(file_refs[f])
    vas = [int(s[4:], 16) for s in subs]
    print(f"{f:28s} {len(subs):3d} fns  band {min(vas):#x}-{max(vas):#x}")
    if len(subs) <= 12:
        print("     " + ", ".join(subs))

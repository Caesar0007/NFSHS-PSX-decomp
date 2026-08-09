import re

IDA = r"C:/Temp/nfs4-clean/nfs4-mobile/nfs4-mobile-IDA.c"
text = open(IDA, encoding='utf-8', errors='replace').read()

# find the string vars for the paths/psad strings and other name-bearers
WANT = ["Paths_File", "psad", "PATHS.cpp", "Track.cpp", "FINISHED LOADING PERPS",
        "ERROR IN PERP FILE", "Perp %d: Model", "Adding fog key", "Add Key slice",
        "Lane %d Slice", "install.psx", "Object_gBuf", "perpToAxisV",
        "Perfect Shift", "%d laps", "Getting rid of %d palett"]
vars_ = {}
for m in re.finditer(r'char (\w+)\[\d*\] = "((?:[^"\\]|\\.)*)"', text):
    for w in WANT:
        if w in m.group(2):
            vars_[m.group(1)] = m.group(2)[:80]

hdrs = [(m.start(), m.group(1)) for m in
        re.finditer(r'\n[^\n;{}]*?\b(sub_[0-9A-F]{6})\([^;\n]*\)\s*\n\{', text)]
for i, (pos, name) in enumerate(hdrs):
    end = hdrs[i + 1][0] if i + 1 < len(hdrs) else len(text)
    body = text[pos:end]
    found = [v for var, v in vars_.items() if re.search(r'\b' + var + r'\b', body)]
    if found:
        print(f"{name}:")
        for v in found[:6]:
            print(f"    {v}")

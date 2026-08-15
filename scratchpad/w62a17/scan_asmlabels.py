"""W62-A17: enumerate every TU-local asm-label declaration in recon/ and pair it with
the shared-header declaration of the same underlying symbol.

Read-only.  Writes nothing but stdout.
"""
import os
import re
import sys
import json

ROOT = r"C:\Temp\nfs4-decomp"
RECON = os.path.join(ROOT, "recon")

BLOCK = re.compile(r"/\*.*?\*/", re.S)
LINE = re.compile(r"//[^\n]*")


def strip_comments(text):
    # keep line count stable so line numbers still line up
    def repl(m):
        return re.sub(r"[^\n]", " ", m.group(0))
    text = BLOCK.sub(repl, text)
    text = LINE.sub(lambda m: " " * len(m.group(0)), text)
    return text


def walk(root, exts=(".c", ".cpp", ".h")):
    for dp, dn, fn in os.walk(root):
        for f in fn:
            if f.endswith(exts):
                yield os.path.join(dp, f)


ASM = re.compile(r'asm\s*\(\s*"([A-Za-z_][A-Za-z0-9_$.]*)"\s*\)')

records = []
for path in walk(RECON):
    raw = open(path, "r", encoding="utf-8", errors="replace").read()
    src = strip_comments(raw)
    for i, line in enumerate(src.split("\n"), 1):
        m = ASM.search(line)
        if not m:
            continue
        # skip register pins asm("$4") -- those have $ and are filtered by the regex anyway
        sym = m.group(1)
        decl = line.strip()
        records.append(
            dict(file=os.path.relpath(path, ROOT).replace("\\", "/"), line=i,
                 sym=sym, decl=decl)
        )

# group by symbol
bysym = {}
for r in records:
    bysym.setdefault(r["sym"], []).append(r)

print("TOTAL asm-label decls: %d over %d symbols" % (len(records), len(bysym)))
print()

# now find shared-header decls for each symbol
HEADERS = [p for p in walk(RECON, (".h",))]
hdrtext = {}
for h in HEADERS:
    hdrtext[h] = strip_comments(open(h, "r", encoding="utf-8", errors="replace").read())

for sym in sorted(bysym):
    print("=== %s ===" % sym)
    for r in bysym[sym]:
        print("   USE %s:%d  %s" % (r["file"], r["line"], r["decl"][:160]))
    # header decls
    pat = re.compile(r"^[^\n]*\b%s\b[^\n]*;" % re.escape(sym), re.M)
    for h in HEADERS:
        t = hdrtext[h]
        for m in pat.finditer(t):
            ln = t[: m.start()].count("\n") + 1
            txt = m.group(0).strip()
            if "asm" in txt and sym in txt.split("asm")[-1]:
                continue  # this IS an asm-label view already listed
            print("   HDR %s:%d  %s" % (os.path.relpath(h, ROOT).replace("\\", "/"), ln, txt[:160]))
    print()

"""w66-a2: census of the REMAINING fabricated _vtdtor_ wrappers (all recon TUs):
for each, is retail's slot symbol `___<len><Class>` DEFINED in the recon lane?
(= is the same rewiring available there?)"""
import os
import re
import subprocess

ROOT = r"C:/Temp/nfs4-decomp"
NM = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe"

wr = {}
for dp, dn, fns in os.walk(os.path.join(ROOT, "recon")):
    for f in fns:
        if not f.endswith((".cpp", ".c")):
            continue
        p = os.path.join(dp, f)
        txt = open(p, encoding="utf-8", errors="replace").read()
        for cls in re.findall(r"^static int _vtdtor_(\w+)\(", txt, re.M):
            wr.setdefault(os.path.relpath(p, ROOT).replace("\\", "/"), []).append(cls)

objs = []
for dp, dn, fns in os.walk(os.path.join(ROOT, "build", "recon")):
    for f in fns:
        if f.endswith(".o"):
            objs.append(os.path.join(dp, f))
defined = {}
for i in range(0, len(objs), 60):
    r = subprocess.run([NM] + objs[i:i + 60], capture_output=True, text=True)
    cur = None
    for ln in r.stdout.splitlines():
        if ln.endswith(":"):
            cur = os.path.relpath(ln[:-1], ROOT).replace("\\", "/")
            continue
        m = re.match(r"^[0-9a-f]{8}\s+([A-Za-z])\s+(\S+)$", ln.strip())
        if m and m.group(1) in "TtRrDd":
            defined.setdefault(m.group(2), []).append(cur)

tot = ok = 0
for f, cls in sorted(wr.items()):
    print(f)
    for c in sorted(cls):
        sym = "___%d%s" % (len(c), c)
        d = defined.get(sym, [])
        tot += 1
        ok += bool(d)
        print("    %-34s %-36s %s" % (c, sym, d[0] if d else "*** NOT DEFINED ***"))
print("\n%d wrappers left, %d whose real dtor symbol is already defined" % (tot, ok))

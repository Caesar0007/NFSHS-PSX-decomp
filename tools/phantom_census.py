#!/usr/bin/env python3
"""Regenerate the phantom-signature census (08A class).

Scans every recon build object for UNDEFINED `__Fe` (variadic) manglings --
these come from `Type f(...)` decls and never resolve at link time -- then
classifies each base name against configs/symbol_addrs.txt:

  MEMBER   real symbol is a member mangling f__<digits>Class...  -> needs the
           call-site obj->f(args) conversion + struct member decl (the W56
           follow-up class; this table replaces the lost sweep_final2.txt)
  FREE     real symbol is a free-fn mangling f__F<args>          -> header-fixable
  UNKNOWN  no mangling with this base name in symbol_addrs

nm is fed object files via batching (never one giant glob: the ARG_MAX
vacuous-pass pitfall).  Output: scratchpad/member_phantoms.txt (tracked).
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
NM = "C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm"

objs = sorted(ROOT.joinpath("build").rglob("*.o"))
if not objs:
    sys.exit("no build objects -- run tools/build.py first")

undef = {}  # mangled -> set(referencing objects)
for i in range(0, len(objs), 50):
    batch = objs[i:i + 50]
    p = subprocess.run([NM, "-u"] + [str(o) for o in batch],
                       capture_output=True, text=True)
    cur = None
    for line in p.stdout.splitlines():
        if line.endswith(".o:"):
            cur = line[:-1]
            continue
        m = re.match(r"\s*U\s+(\S+)$", line)
        if m and "__Fe" in m.group(1):
            undef.setdefault(m.group(1), set()).add(
                Path(cur).name if cur else "?")

syms = ROOT.joinpath("configs", "symbol_addrs.txt").read_text(errors="replace")
sym_names = set(re.findall(r"^(\S+?)\s*=", syms, re.M))

rows = []
for mangled in sorted(undef):
    base = mangled.split("__Fe")[0]
    member = sorted(s for s in sym_names
                    if re.match(re.escape(base) + r"__\d", s))
    free = sorted(s for s in sym_names
                  if re.match(re.escape(base) + r"__F(?!e)", s))
    cls = "MEMBER" if member else ("FREE" if free else "UNKNOWN")
    real = (member or free or ["-"])[0]
    rows.append((cls, base, mangled, real, sorted(undef[mangled])))

out = ROOT / "scratchpad" / "member_phantoms.txt"
with open(out, "w", newline="") as f:
    f.write("# phantom-signature census (08A) -- regenerated; replaces the lost sweep_final2.txt\n")
    f.write("# CLASS\tBASE\tPHANTOM_MANGLING\tREAL_SYMBOL\tREFERENCING_OBJS\n")
    for cls, base, mangled, real, refs in rows:
        f.write(f"{cls}\t{base}\t{mangled}\t{real}\t{','.join(refs)}\n")

n = {}
for cls, *_ in rows:
    n[cls] = n.get(cls, 0) + 1
print(f"{len(rows)} phantom __Fe bases -> {out.relative_to(ROOT)}  {n}")

"""W62-A17: classify the raw phantom list into real link debt vs name-form aliasing.

For each undefined-and-nowhere-defined symbol U:
  BASE      = U up to the first `__` (the cfront mangling separator)
  ALIAS     -> some DEFINED symbol, or some symbol_addrs entry, shares that BASE
               (i.e. the same function exists under a different mangling /
               demangled spelling -- catalog 0c leniency class, still a REAL link
               bug because the linker matches by exact name)
  ORPHAN    -> no symbol anywhere in the tree shares that BASE  (a genuine gap)
"""
import re
import subprocess
import collections
from pathlib import Path

ROOT = Path(r"C:\Temp\nfs4-decomp")
NM = "C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm"

objs = sorted(o for o in ROOT.joinpath("build").rglob("*.o") if "diffsrc" not in o.parts)
undef = collections.defaultdict(set)
defined = collections.defaultdict(set)
for i in range(0, len(objs), 50):
    p = subprocess.run([NM] + [str(o) for o in objs[i:i + 50]], capture_output=True, text=True)
    cur = None
    for line in p.stdout.splitlines():
        if line.endswith(".o:"):
            cur = Path(line[:-1]).name
            continue
        m = re.match(r"^\s*(?:[0-9a-fA-F]+)?\s*([A-Za-z])\s+(\S+)$", line)
        if not m:
            continue
        t, n = m.groups()
        (undef if t == "U" else defined)[n].add(cur)

syms = ROOT.joinpath("configs", "symbol_addrs.txt").read_text(errors="replace")
sym_names = set(re.findall(r"^\s*(\S+?)\s*=", syms, re.M))
und_auto = set(re.findall(r"^\s*(\S+?)\s*=",
    (ROOT / "linkers" / "undefined_syms_auto.txt").read_text(errors="replace"), re.M))

known = set(defined) | sym_names | und_auto


def base(n):
    return n.split("__", 1)[0]


bases_known = collections.defaultdict(set)
for n in known:
    bases_known[base(n)].add(n)

alias, orphan = {}, {}
for n, refs in undef.items():
    if n in known:
        continue
    b = base(n)
    if b in bases_known:
        alias[n] = (refs, sorted(bases_known[b]))
    else:
        orphan[n] = refs

print("undefined-and-unknown: %d   ALIAS(base exists under another name): %d   ORPHAN: %d"
      % (len(alias) + len(orphan), len(alias), len(orphan)))
print()
print("=" * 78)
print("ALIAS CLASS -- the function/datum EXISTS but under a different exact name")
print("(exact-name mismatch = a real PSYLINK failure; the gate is blind to it)")
print("=" * 78)
for n in sorted(alias):
    refs, cands = alias[n]
    print("%-50s <- %-30s => %s" % (n[:50], ", ".join(sorted(refs))[:30], ", ".join(cands[:2])[:70]))
print()
print("=" * 78)
print("ORPHAN CLASS -- no symbol anywhere shares the base name")
print("=" * 78)
for n in sorted(orphan):
    print("%-58s <- %s" % (n[:58], ", ".join(sorted(orphan[n]))[:80]))

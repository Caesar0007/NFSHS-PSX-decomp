"""W62-A17: extern-vs-definition audit over the recon LINK objects.

For every UNDEFINED symbol in build/**/*.o (excluding build/diffsrc, the -g SLD
instrument objects that are never linked -- catalog 10A/verify-gate ARG_MAX law),
ask: is it DEFINED by some other object, or listed in configs/symbol_addrs.txt
(= a retail address the linker script supplies), or listed in
linkers/undefined_syms_auto.txt?  Anything in none of those buckets is a PHANTOM
EXTERN: declared, referenced, defined nowhere -- a real link failure.

nm is fed in batches of 50 (never one glob: the ARG_MAX vacuous-pass pitfall).
"""
import re
import subprocess
import sys
import collections
from pathlib import Path

ROOT = Path(r"C:\Temp\nfs4-decomp")
NM = "C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm"

objs = sorted(o for o in ROOT.joinpath("build").rglob("*.o")
              if "diffsrc" not in o.parts)
print("link objects scanned: %d" % len(objs))
assert objs, "no build objects"

undef = collections.defaultdict(set)
defined = collections.defaultdict(set)
for i in range(0, len(objs), 50):
    batch = objs[i:i + 50]
    p = subprocess.run([NM] + [str(o) for o in batch], capture_output=True, text=True)
    cur = None
    for line in p.stdout.splitlines():
        if line.endswith(".o:"):
            cur = Path(line[:-1]).name
            continue
        m = re.match(r"^\s*(?:[0-9a-fA-F]+)?\s*([A-Za-z])\s+(\S+)$", line)
        if not m:
            continue
        t, nm_ = m.group(1), m.group(2)
        if t == "U":
            undef[nm_].add(cur)
        elif t in "TDBRGSVWA":
            defined[nm_].add(cur)

print("distinct undefined: %d   distinct defined: %d" % (len(undef), len(defined)))

syms = ROOT.joinpath("configs", "symbol_addrs.txt").read_text(errors="replace")
sym_names = set(re.findall(r"^\s*(\S+?)\s*=", syms, re.M))
und_auto = set(re.findall(r"^\s*(\S+?)\s*=",
    ROOT.joinpath("linkers", "undefined_syms_auto.txt").read_text(errors="replace"), re.M))
und_funcs = ROOT.joinpath("linkers", "undefined_funcs_auto.txt").read_text(errors="replace")
und_auto |= set(re.findall(r"^\s*(\S+?)\s*=", und_funcs, re.M))

phantom = {}
for nm_, refs in undef.items():
    if nm_ in defined:
        continue
    if nm_ in sym_names or nm_ in und_auto:
        continue
    phantom[nm_] = refs

print()
print("=" * 78)
print("PHANTOM EXTERNS: %d  (undefined, defined nowhere, absent from symbol_addrs"
      " AND undefined_syms_auto)" % len(phantom))
print("=" * 78)
for nm_ in sorted(phantom):
    print("%-64s <- %s" % (nm_, ", ".join(sorted(phantom[nm_]))[:110]))

# --- the `__Fe` variadic sub-class (10C: `(...)` decls) -----------------------
fe = {k: v for k, v in undef.items() if "__Fe" in k}
print()
print("=" * 78)
print("`__Fe` VARIADIC MANGLINGS (from `(...)`/K&R decls): %d" % len(fe))
print("=" * 78)
for nm_ in sorted(fe):
    base = nm_.split("__F")[0]
    real = sorted(s for s in sym_names if s.startswith(base + "__") and s != nm_)
    print("%-52s <- %-38s  real: %s" % (nm_, ", ".join(sorted(fe[nm_]))[:38],
                                        ", ".join(real[:3]) or "NONE"))

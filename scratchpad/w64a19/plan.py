#!/usr/bin/env python3
"""W64-A19: build the exact per-declaration fix plan for the ALIAS class.

For every (unresolved-symbol, referencing-TU) pair, resolve the DECLARATION the
TU actually sees (the TU itself + its transitive recon-local includes), and emit
one patch record per declaration line.

Fix device (default): append an asm-label alias to the declaration so the call
site emits the retail symbol.  BYTE-NEUTRAL by construction -- only the emitted
relocation NAME changes, never an instruction.
"""
import json
import re
import collections
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SA = {}
for line in (ROOT / "configs/symbol_addrs.txt").read_text().splitlines():
    m = re.match(r"^\s*(\S+)\s*=\s*(0x[0-9A-Fa-f]+)", line)
    if m:
        SA.setdefault(m.group(1), m.group(2))

BLOCKED = {
    "recon/nfs4_types.h",
    "recon/frontend/common/fedialog_externs.h",
    "recon/frontend/common/femenuextended_externs.h",
    "recon/frontend/common/screenusername_externs.h",
    "recon/frontend/common/femenudefs.cpp",
    "recon/frontend/common/femenu.cpp",
    "recon/frontend/common/fetv.cpp",
    "recon/frontend/common/screenpost.cpp",
    "recon/frontend/common/screenusername.cpp",
    "recon/lib/libfns.h",
    "recon/frontend/psx/psxfront.cpp",
}

inc_re = re.compile(r'^\s*#\s*include\s+"([^"]+)"')


def includes(p, seen=None):
    if seen is None:
        seen = set()
    p = p.resolve()
    if p in seen or not p.exists():
        return seen
    seen.add(p)
    for L in p.read_text(errors="replace").splitlines():
        m = inc_re.match(L)
        if m:
            cand = (p.parent / m.group(1))
            if not cand.exists():
                for root in (ROOT / "recon", ROOT / "recon/lib"):
                    c2 = root / m.group(1)
                    if c2.exists():
                        cand = c2
                        break
            if cand.exists() and ROOT in cand.resolve().parents:
                includes(cand, seen)
    return seen


rows = json.loads((ROOT / "scratchpad/w64a19/unres_classified.json").read_text())
alias = [r for r in rows if r["kind"] == "ALIAS"]

# obj path -> source path
def obj2src(o):
    rel = o.split("build/")[-1]
    rel = re.sub(r"\.o$", "", rel)
    p = ROOT / rel
    return p if p.exists() else None


patches = collections.defaultdict(list)   # file -> [(lineno, sym, want, text)]
unfound = []
ambiguous = []

for r in alias:
    sym = r["sym"]
    i = sym.find("__")
    b = sym[:i] if i > 0 else sym
    # pick the retail-named candidate
    cands = [c for c in r["cands"] if c in SA]
    if len(cands) != 1:
        ambiguous.append((sym, r["cands"], cands, r["objs"]))
        continue
    want = cands[0]
    pat = re.compile(r"(?<![A-Za-z0-9_])" + re.escape(b) + r"\s*\(")
    for o in r["objs"]:
        src = obj2src(o)
        if src is None:
            unfound.append((sym, o, "no source"))
            continue
        found = []
        for f in sorted(includes(src)):
            rel = str(f.relative_to(ROOT)).replace("\\", "/")
            lines = f.read_text(errors="replace").splitlines()
            for n, L in enumerate(lines, 1):
                s = L.strip()
                if not pat.search(L):
                    continue
                if s.startswith(("*", "//", "/*", "#")):
                    continue
                if "::" in L.split("(")[0]:      # out-of-line definition
                    continue
                if not s.rstrip().endswith(";"):  # not a declaration
                    continue
                if "asm(" in L:                   # already aliased
                    found.append((rel, n, L, "ALREADY"))
                    continue
                found.append((rel, n, L, "DECL"))
        if not found:
            unfound.append((sym, str(src.relative_to(ROOT)).replace("\\", "/"), "no decl"))
        for rel, n, L, kind in found:
            patches[rel].append((n, sym, want, L, kind))

# dedupe
for f in patches:
    patches[f] = sorted(set(patches[f]))

out = [f"ALIAS symbols: {len(alias)}   ambiguous(want): {len(ambiguous)}",
       f"decl files to patch: {len(patches)}",
       f"blocked files touched: "
       f"{sorted(set(patches) & BLOCKED)}", ""]
tot = 0
for f in sorted(patches):
    out.append(f"--- {f}{'   [BLOCKED]' if f in BLOCKED else ''}")
    for n, sym, want, L, kind in patches[f]:
        tot += 1
        out.append(f"  {n}\t{kind}\t{want}\n\t{L.strip()[:160]}")
out.insert(3, f"total decl lines: {tot}")
out.append("")
out.append("=== AMBIGUOUS (manual) ===")
for sym, cands, sa_c, objs in ambiguous:
    out.append(f"{sym}\n   cands={cands}\n   in_symaddrs={sa_c}\n   objs={[x.split('build/')[-1] for x in objs]}")
out.append("")
out.append("=== UNFOUND DECL ===")
for u in unfound:
    out.append(str(u))
(ROOT / "scratchpad/w64a19/plan.txt").write_text("\n".join(out) + "\n")
json.dump({"patches": {k: v for k, v in patches.items()},
           "ambiguous": ambiguous, "unfound": unfound},
          open(ROOT / "scratchpad/w64a19/plan.json", "w"), indent=1)
print("\n".join(out[:5]))
print("ambiguous:", len(ambiguous), " unfound:", len(unfound))

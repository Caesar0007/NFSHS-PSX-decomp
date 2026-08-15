#!/usr/bin/env python3
"""W64-A19: classify the reloc-filtered unresolved set.

ALIAS  = we DO define a symbol whose demangled BASE name matches -> wrong
         mangling at the reference site (fixable by a decl correction).
ORPHAN = nothing in the link set shares the base name -> genuinely undefined
         (data-mat debt / missing TU / external).

Base name = the part before '__' for a GCC 2.x mangled name, else the whole
name.  Also consults configs/symbol_addrs.txt so a name retail HAS but we
have not defined is reported separately.
"""
import json
import re
import collections
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
C = json.loads((ROOT / "scratchpad/w64a19/census_recon.json").read_text())
defined = C["defined"]
unres = C["real_unres"]
hits = C["real_unres_hits"]

# symbol_addrs: name -> va
sa = {}
for line in (ROOT / "configs/symbol_addrs.txt").read_text().splitlines():
    m = re.match(r"^\s*(\S+)\s*=\s*(0x[0-9A-Fa-f]+)", line)
    if m:
        sa.setdefault(m.group(1), m.group(2))


def base(n):
    # gcc2 mangling: name__F<args> / name__<len><Class><args> / ctor __<len>Class
    if n.startswith("__") and len(n) > 2:
        return n            # ctor/dtor forms: keep whole
    i = n.find("__")
    return n[:i] if i > 0 else n


bydef = collections.defaultdict(list)
for d in defined:
    bydef[base(d)].append(d)

rows = []
for s in sorted(unres):
    b = base(s)
    cands = bydef.get(b, [])
    kind = "ALIAS" if cands else ("IN_SYMADDRS" if s in sa else "ORPHAN")
    rows.append((kind, s, hits[s], cands, sorted(set(
        o.split("build/")[-1] for o in unres[s]))))

cnt = collections.Counter(r[0] for r in rows)
out = [f"reloc-filtered unresolved = {len(rows)}   {dict(cnt)}", ""]
for kind in ("ALIAS", "IN_SYMADDRS", "ORPHAN"):
    out.append(f"===== {kind} ({cnt[kind]}) =====")
    for k, s, h, c, objs in rows:
        if k != kind:
            continue
        out.append(f"{s}\t[{h} relocs]")
        if c:
            out.append("    have: " + ", ".join(c[:6]) + (" ..." if len(c) > 6 else ""))
        out.append("    from: " + ", ".join(objs[:8]) + (" ..." if len(objs) > 8 else ""))
    out.append("")
(ROOT / "scratchpad/w64a19/unres_classified.txt").write_text("\n".join(out) + "\n")
json.dump([{"kind": k, "sym": s, "hits": h, "cands": c, "objs": o}
           for k, s, h, c, o in rows],
          open(ROOT / "scratchpad/w64a19/unres_classified.json", "w"), indent=1)
print("\n".join(out[:2]))
print(dict(cnt))

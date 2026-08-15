#!/usr/bin/env python3
"""W64-A19: for every ALIAS unresolved symbol, locate the DECLARATION(s) that
produce the wrong mangling.  A declaration is a file-scope line containing
'<base>(' that is not a definition body opener in a .c/.cpp of the OWNER.

Emits a TSV: sym, want, referencing objs, candidate decl file:line
"""
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
rows = json.loads((ROOT / "scratchpad/w64a19/unres_classified.json").read_text())
alias = [r for r in rows if r["kind"] == "ALIAS"]

srcs = sorted(list((ROOT / "recon").rglob("*.h")) +
              list((ROOT / "recon").rglob("*.cpp")) +
              list((ROOT / "recon").rglob("*.c")))
text = {}
for p in srcs:
    try:
        text[p] = p.read_text(errors="replace").splitlines()
    except Exception:
        pass

out = []
for r in alias:
    b = r["sym"]
    i = b.find("__")
    base = b[:i] if i > 0 else b
    pat = re.compile(r"(?<![A-Za-z0-9_])" + re.escape(base) + r"\s*\(")
    hits = []
    for p, lines in text.items():
        for n, L in enumerate(lines, 1):
            if pat.search(L) and not L.lstrip().startswith(("*", "//", "/*")):
                rel = str(p.relative_to(ROOT)).replace("\\", "/")
                hits.append(f"{rel}:{n}:{L.strip()[:150]}")
    out.append({"sym": b, "base": base, "want": r["cands"],
                "objs": r["objs"], "hits": hits})

lines = []
for o in out:
    lines.append(f"### {o['sym']}")
    lines.append(f"    WANT: {', '.join(o['want'])}")
    lines.append(f"    OBJS: {', '.join(x.split('build/')[-1] for x in o['objs'])}")
    for h in o["hits"]:
        lines.append("    " + h)
    lines.append("")
(ROOT / "scratchpad/w64a19/alias_decls.txt").write_text("\n".join(lines) + "\n")
json.dump(out, open(ROOT / "scratchpad/w64a19/alias_decls.json", "w"), indent=1)
print(f"{len(alias)} alias symbols; decl candidates written")

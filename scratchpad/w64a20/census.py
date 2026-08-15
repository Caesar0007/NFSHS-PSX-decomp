#!/usr/bin/env python3
"""w64-a20 mission-1 census: find every recon TU whose SOURCE carries a GNU-as
spelling ASPSX 2.77 rejects (the 5 shim rules).  Reports per-TU counts so the
source pass has an exact worklist.

Rules (from tools/psyqproof.py to_aspsx_dialect, probe-derived w63-a20):
  1. ABI register NAMES  ($a0)             -> numeric ($4)
  2. .set push / .set pop                  -> explicit axis save/restore
  3. sym2 = sym                            -> a 2nd label at the same address
  4. 3-operand div/divu with $0/$zero dest -> the 2-operand raw form
  5. .type / .size / .weak                 -> dropped
"""
import re, sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
REGS = ("zero at v0 v1 a0 a1 a2 a3 t0 t1 t2 t3 t4 t5 t6 t7 "
        "s0 s1 s2 s3 s4 s5 s6 s7 t8 t9 k0 k1 gp sp fp s8 ra").split()
RE_REG = re.compile(r"\$(" + "|".join(sorted(REGS, key=len, reverse=True)) + r")\b")
RE_PUSHPOP = re.compile(r"\.set\s+(push|pop)\b")
RE_ALIAS = re.compile(r"^\s*\\?[nt]*\s*([A-Za-z_$.][\w$.]*)\s*=\s*([A-Za-z_$.][\w$.]*)\s*\\n")
RE_ALIAS2 = re.compile(r"[\"']\s*([A-Za-z_$.][\w$.]*)\s*=\s*([A-Za-z_$.][\w$.]*)\s*\\n")
RE_RAWDIV = re.compile(r"\b(div|divu)\s+\$(0|zero)\s*,")
RE_DROP = re.compile(r"\.(type|size|weak)\b")

rows = {}
for p in sorted(ROOT.joinpath("recon").rglob("*")):
    if p.suffix.lower() not in (".c", ".cpp", ".h"):
        continue
    txt = p.read_text(encoding="utf-8", errors="replace")
    if "__asm__" not in txt and "asm(" not in txt:
        continue
    # only count inside asm string literals -- approximate by scanning lines
    # that live in an __asm__ block region.
    c = {"reg": 0, "pushpop": 0, "alias": 0, "rawdiv": 0, "drop": 0}
    for ln in txt.split("\n"):
        if '"' not in ln:
            continue
        # crude: only lines with an asm-ish payload
        if not re.search(r'"[^"]*(\\t|\\n|\.set|\.type|\.size|\.weak|\$)', ln):
            continue
        c["reg"] += len(RE_REG.findall(ln))
        c["pushpop"] += len(RE_PUSHPOP.findall(ln))
        c["alias"] += len(RE_ALIAS2.findall(ln))
        c["rawdiv"] += len(RE_RAWDIV.findall(ln))
        c["drop"] += len(RE_DROP.findall(ln))
    if any(c.values()):
        rows[str(p.relative_to(ROOT)).replace("\\", "/")] = c

tot = {k: 0 for k in ("reg", "pushpop", "alias", "rawdiv", "drop")}
print(f"{'TU':<52} {'reg':>5} {'push':>5} {'alias':>6} {'rawdiv':>7} {'drop':>5}")
for rel, c in sorted(rows.items()):
    print(f"{rel:<52} {c['reg']:>5} {c['pushpop']:>5} {c['alias']:>6} "
          f"{c['rawdiv']:>7} {c['drop']:>5}")
    for k in tot:
        tot[k] += c[k]
print(f"\n{len(rows)} TUs; totals reg={tot['reg']} pushpop={tot['pushpop']} "
      f"alias={tot['alias']} rawdiv={tot['rawdiv']} drop={tot['drop']}")

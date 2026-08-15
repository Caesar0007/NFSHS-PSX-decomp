"""W62-A17: oracle access-WIDTH census for a list of symbols.

For each symbol, count every load/store in asm/nonmatchings/ (and asm/**) whose
operand is %lo(SYM) or %gp_rel(SYM), grouped by mnemonic.  A symbol reached only
by `lw`/`sw` is 4 bytes; only by `lb/lbu/sb` is 1 byte; `addiu`-only means its
ADDRESS is taken (it is storage, not a pointer cell).
"""
import re
import sys
import collections
from pathlib import Path

ROOT = Path(r"C:\Temp\nfs4-decomp")
SYMS = sys.argv[1:]

files = list((ROOT / "asm").rglob("*.s"))
blob = []
for f in files:
    try:
        blob.append(f.read_text(errors="replace"))
    except Exception:
        pass
blob = "\n".join(blob)

for s in SYMS:
    pat = re.compile(r"\b(lw|sw|lb|lbu|sb|lh|lhu|sh|addiu|lui|la)\b[^\n]*?%(?:lo|gp_rel)\("
                     + re.escape(s) + r"\)")
    c = collections.Counter(m.group(1) for m in pat.finditer(blob))
    tot = sum(c.values())
    print("%-34s total=%-4d %s" % (s, tot, dict(c) if c else "-- NO ORACLE REFERENCE --"))

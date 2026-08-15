#!/usr/bin/env python3
"""Emit scratchpad/w63a20/brdist_guard.patch -- the two proposed tools/brdist.py
fixes, as a unified diff against the current file (tools/*.py is orchestrator-
owned, so this is a spec + proof, not a landing)."""
import ast
import difflib
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
src = (ROOT / "tools" / "brdist.py").read_text()
orig = src

# ---- fix 1: a spimdisasm `.word` IS an instruction --------------------------
OLD_W = ("        if not s or s.startswith(('.', 'glabel', 'nonmatching', "
         "'dlabel', 'jlabel', 'alabel')) or s.endswith(':'):\n"
         "            continue\n")
NEW_W = ("        if s.startswith('.word'):\n"
         "            # w63-a20: spimdisasm emits every unrecognised instruction\n"
         "            # (i.e. EVERY GTE/COP2 op) as `.word 0x4A480012`.  It is a\n"
         "            # real 4-byte INSTRUCTION and occupies an index slot; the\n"
         "            # blanket '.'-prefix skip below under-counted the oracle,\n"
         "            # so every branch whose target label lay past a `.word`\n"
         "            # reported a bogus distance.  26 false positives tree-wide,\n"
         "            # all in the GTE-heavy render TUs (drawc/draww/flare/hrzsku/\n"
         "            # sfx/trsproj/weather) -- fns that psyqproof scores REAL=0,\n"
         "            # i.e. byte-identical to retail, so the 'divergence' was\n"
         "            # impossible.  It also HID one real hit (_padInitSioMode).\n"
         "            idx += 1\n"
         "            continue\n") + OLD_W
assert src.count(OLD_W) == 1, "oracle_branches filter anchor moved"
src = src.replace(OLD_W, NEW_W)

# ---- fix 2: case-exact oracle path ------------------------------------------
OLD_P = ("def oracle_branches(fn):\n"
         "    p = ROOT / 'asm' / 'nonmatchings' / 'main' / (fn + '.s')\n"
         "    if not p.exists():\n"
         "        p = ROOT / 'asm' / 'nonmatchings' / 'front' / (fn + '.s')\n"
         "    if not p.exists():\n"
         "        return None\n")
NEW_P = ("def _exists_exact(p):\n"
         "    \"\"\"w63-a20: Path.exists() is CASE-INSENSITIVE on this NTFS checkout,\n"
         "    so 'cd_read.s' silently resolves to the UNRELATED 'CD_Read.s' and the\n"
         "    census compares one function's branches against another's oracle\n"
         "    (cd_read reported 'BRANCH COUNT 0 vs 17').  Same guard verify_asm.py\n"
         "    already carries; in-tree pairs: cd_read/CD_Read, CD_init/CD_Init.\"\"\"\n"
         "    return p.exists() and p.name in {e.name for e in p.parent.iterdir()}\n"
         "\n"
         "\n"
         "def oracle_branches(fn):\n"
         "    p = g['_find_oracle_path'](fn)   # verify_asm's resolver: case-exact\n"
         "    if p is None:                    # first, then the symbol_addrs VA\n"
         "        return None                  # fallbacks (func_<VA>.s etc.)\n")
if src.count(OLD_P) == 1:
    src = src.replace(OLD_P, NEW_P)
    note = "both fixes"
else:
    note = "fix 1 only (oracle_branches header shape differs -- apply fix 2 by hand)"

ast.parse(src)
diff = difflib.unified_diff(orig.splitlines(keepends=True), src.splitlines(keepends=True),
                            "a/tools/brdist.py", "b/tools/brdist.py")
out = ROOT / "scratchpad" / "w63a20" / "brdist_guard.patch"
out.write_bytes("".join(diff).encode("utf-8"))
print("wrote", out, "--", note)

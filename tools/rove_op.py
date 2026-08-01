#!/usr/bin/env python3
"""Per-symbol opcode census vs the oracle (w39/w40-a10 roving sweeper, promoted).

For every function of a TU (or of all game/psx TUs), count occurrences of the
signedness/width-sensitive opcodes in OUR built .s next to the ORACLE's .s and
print the deltas.  A non-zero delta in this opcode set is a high-probability
bug/lever site:

  sra vs srl   -> signed vs unsigned shift (packed colors, Q16.16 divides)
  lb  vs lbu   -> signed-char reads (offsets, metrics, kerning)
  lh  vs lhu   -> short signedness; paired sll+sra deficit = purged short local
  mult/div/... -> missing or duplicated arithmetic
  sb/sh/sw     -> access-width (byte-store soup vs word stores)
  nor/sltu/... -> canonicalization tells

Interpretation caveats (measured in w40):
  * an `sra` deficit that tracks an `sll` deficit is MISSING SHORT SIGN-EXTENSION
    PAIRS (wrong-typed locals), not missing divisions (Hud_BTCStats lesson);
  * always re-census after big rewrites -- hits go stale fast (cario lesson).

Usage:
  python tools/rove_op.py                          # all game/psx TUs
  python tools/rove_op.py recon/game/psx/hud.cpp   # one TU
Run tools/build.py first (reads build/<rel>.s cc1 output + asm/nonmatchings).
"""
import os
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OBJDUMP = os.environ.get("NFS4_OBJDUMP",
                         r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe")
ORACLE_DIRS = [ROOT / "asm" / "nonmatchings" / "main",
               ROOT / "asm" / "nonmatchings" / "front"]
OPS = ("sra srl sll lb lbu lh lhu sb sh sw lw mult multu div divu mflo mfhi "
       "nor slt slti sltu sltiu andi xori break").split()
LABEL = re.compile(r"^([A-Za-z_$][\w$]*):")
INSN = re.compile(r"^\s+([a-z][a-z0-9.]*)\s")

def count_ops(lines):
    c = {}
    for ln in lines:
        ln = re.sub(r"/\*.*?\*/", "", ln)
        s = ln.strip()
        if not s or s.startswith((".", "#", "glabel", "dlabel", "jlabel",
                                  "nonmatching", "endlabel")) or s.endswith(":"):
            continue
        m = INSN.match(ln) or re.match(r"^([a-z][a-z0-9.]*)\s", s)
        if m and m.group(1) in OPS:
            c[m.group(1)] = c.get(m.group(1), 0) + 1
    return c

def split_ours(obj_path):
    """objdump -d of the BUILT object (post-maspsx/as, so assembler macro
    expansion -- expand-div break guards, li+slt->slti folds -- matches the
    oracle's level) -> {symbol: [insn lines]}."""
    out = subprocess.run([OBJDUMP, "-d", str(obj_path)],
                         capture_output=True, text=True).stdout
    fns, cur = {}, None
    for ln in out.splitlines():
        m = re.match(r"^[0-9a-f]+ <(.+)>:$", ln)
        if m:
            cur = m.group(1)
            fns[cur] = []
        elif cur is not None and re.match(r"^\s+[0-9a-f]+:\s", ln):
            # "  offset:  rawbytes  mnemonic operands" -> keep mnemonic on
            parts = ln.split(None, 2)
            if len(parts) == 3:
                fns[cur].append("\t" + parts[2])
    return fns

def oracle_path(name):
    for d in ORACLE_DIRS:
        p = d / (name + ".s")
        if p.exists():
            return p
    return None

def census_tu(rel):
    obj_path = ROOT / "build" / (rel + ".o")
    if not obj_path.exists():
        print(f"[skip] no build .o for {rel} (run tools/build.py)")
        return
    hits = []
    for name, body in split_ours(obj_path).items():
        op = oracle_path(name)
        if op is None:
            continue
        ours = count_ops(body)
        orac = count_ops(op.read_text(encoding="utf-8",
                                      errors="replace").splitlines())
        delta = {k: (ours.get(k, 0), orac.get(k, 0))
                 for k in OPS if ours.get(k, 0) != orac.get(k, 0)}
        if delta:
            hits.append((name, delta))
    if hits:
        print(f"== {rel}")
        for name, delta in hits:
            ds = " ".join(f"{k} {a}v{b}" for k, (a, b) in delta.items())
            print(f"  {name}: {ds}")

def main():
    if len(sys.argv) > 1:
        tus = [sys.argv[1].replace("\\", "/")]
    else:
        tus = sorted(str(p.relative_to(ROOT)).replace("\\", "/")
                     for p in (ROOT / "recon" / "game" / "psx").glob("*.c*"))
    for rel in tus:
        census_tu(rel)

if __name__ == "__main__":
    main()

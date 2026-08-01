#!/usr/bin/env python3
"""Per-symbol BRANCH-opcode census (ours vs oracle) -- the arm/polarity companion
to tools/rove_op.py, which only covers the width/signedness opcode set.

  python scratch/brcensus.py <TU.cpp> [SYMBOL ...]

Reads the built object (build/<rel>.o, so post-maspsx/as like rove_op) and the
spimdisasm oracle under asm/nonmatchings/{main,front}.  Prints only the opcodes
whose counts differ.  A beqz/bnez delta = a missing or polarity-flipped GUARD
(structural); a beqz<->bnez swap at equal totals = an arm-order flip.
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
BR = "beqz bnez beq bne blez bgtz bltz bgez b j jal jalr jr".split()
ORACLE_DIRS = [ROOT / "asm" / "nonmatchings" / "main",
               ROOT / "asm" / "nonmatchings" / "front"]


def norm(op):
    return {"beql": "beq", "bnel": "bne"}.get(op, op)


def count(lines):
    c = {}
    for ln in lines:
        ln = re.sub(r"/\*.*?\*/", "", ln)
        m = re.match(r"\s*([a-z][a-z0-9.]*)\s", ln)
        if m and norm(m.group(1)) in BR:
            k = norm(m.group(1))
            c[k] = c.get(k, 0) + 1
    return c


def ours(tu):
    obj = ROOT / "build" / (str(Path(tu).as_posix()) + ".o")
    out = subprocess.run([OBJDUMP, "-d", str(obj)], capture_output=True,
                         text=True).stdout
    syms, cur = {}, None
    for ln in out.split("\n"):
        m = re.match(r"^[0-9a-f]+ <(.+)>:", ln)
        if m:
            cur = m.group(1)
            syms[cur] = []
        elif cur and "\t" in ln:
            syms[cur].append(ln.split("\t", 2)[-1])
    return syms


def oracle(sym):
    for d in ORACLE_DIRS:
        p = d / (sym + ".s")
        if p.exists():
            return p.read_text().split("\n")
    return None


def main():
    tu = sys.argv[1]
    want = sys.argv[2:]
    syms = ours(tu)
    for sym in (want or sorted(syms)):
        o = oracle(sym)
        if o is None or sym not in syms:
            continue
        a, b = count(syms[sym]), count(o)
        d = [f"{k} {a.get(k,0)}v{b.get(k,0)}"
             for k in BR if a.get(k, 0) != b.get(k, 0)]
        if d:
            print(f"  {sym}: " + " ".join(d))


main()

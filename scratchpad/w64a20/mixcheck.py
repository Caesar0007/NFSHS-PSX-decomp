#!/usr/bin/env python3
"""Does a TU spell the SAME asm template both ways (ABI names and numeric)?
If so, converting the ABI ones makes previously-DIFFERENT asm templates
IDENTICAL -- and gcc-2.8's cross_jump compares ASM_OPERANDS_TEMPLATE, so the
blocks start merging and codegen moves (catalog 12C, the same-source-line rule's
template twin).  That is the draww.cpp regression."""
import re, sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
REGS = ("zero at v0 v1 a0 a1 a2 a3 t0 t1 t2 t3 t4 t5 t6 t7 "
        "s0 s1 s2 s3 s4 s5 s6 s7 t8 t9 k0 k1 gp sp fp s8 ra").split()
NUM = {"zero": 0, "at": 1, "v0": 2, "v1": 3, "a0": 4, "a1": 5, "a2": 6, "a3": 7,
       "t0": 8, "t1": 9, "t2": 10, "t3": 11, "t4": 12, "t5": 13, "t6": 14,
       "t7": 15, "s0": 16, "s1": 17, "s2": 18, "s3": 19, "s4": 20, "s5": 21,
       "s6": 22, "s7": 23, "t8": 24, "t9": 25, "k0": 26, "k1": 27, "gp": 28,
       "sp": 29, "fp": 30, "s8": 30, "ra": 31}
RE_REG = re.compile(r"\$(" + "|".join(sorted(REGS, key=len, reverse=True)) + r")\b")
RE_STRLIT = re.compile(r'"(?:[^"\\]|\\.)*"', re.S)


def norm(lit):
    return RE_REG.sub(lambda m: "$%d" % NUM[m.group(1)], lit)


for rel in sys.argv[1:]:
    txt = (ROOT / rel).read_text(encoding="utf-8", errors="replace")
    groups = {}
    for m in RE_STRLIT.finditer(txt):
        lit = m.group(0)
        if "\\t" not in lit and "\t" not in lit:
            continue
        groups.setdefault(norm(lit), set()).add(lit)
    mixed = {k: v for k, v in groups.items() if len(v) > 1}
    print(f"{rel}: {len(groups)} distinct asm templates (after normalisation), "
          f"{len(mixed)} that are spelled BOTH ways")
    for k, v in list(mixed.items())[:4]:
        print("   collapses ->", k[:64].replace("\n", "|"))
        for s in v:
            print("      from:", s[:64].replace("\n", "|"))

# -*- coding: utf-8 -*-
"""w48-a10: scan the retail oracle .s of the syslib worklist for the three
floor-class signatures.

  class1  = a %hi/lui (or any half-macro) sitting in a CONDITIONAL-branch delay slot
  class3  = epilogue shape `addiu sp,N / jr ra / nop`  (delayed-branch-OFF signature)
            vs `jr ra / addiu sp,N`                     (delayed-branch-ON signature)
  atmac   = `lui $at` absolute address materialisation (the .lcomm/-G class)
"""
import os, re, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ASM = os.path.join(ROOT, "asm", "nonmatchings", "main")
WORKLIST = r"C:\Temp\nfs4-clean\syslib_fails_2026-08-04_w48.txt"

BR = re.compile(r"^\s+(b(?:eq|ne|eqz|nez|gez|gtz|lez|ltz|c[01][tf])?z?|b)\b")
JR = re.compile(r"^\s+(jr|jal|jalr|j)\b")


def rows():
    out = []
    for ln in open(WORKLIST):
        if ln.startswith("#") or not ln.strip():
            continue
        p = ln.split()
        out.append((p[0], p[1], p[2], p[3]))
    return out


def insns(path):
    """-> list of (va, word, text) """
    r = []
    for ln in open(path):
        m = re.match(r"\s*/\* \w+ ([0-9A-F]{8}) ([0-9A-F]{8}) \*/\s+(.*?)\s*$", ln)
        if m:
            r.append((m.group(1), m.group(2), m.group(3)))
    return r


def main():
    want = sys.argv[1] if len(sys.argv) > 1 else "all"
    c1 = []
    c3on, c3off = [], []
    atm = []
    for va, pct, tu, fn in rows():
        p = os.path.join(ASM, fn + ".s")
        if not os.path.exists(p):
            continue
        ins = insns(p)
        for i in range(len(ins) - 1):
            t = ins[i][2]
            nxt = ins[i + 1][2]
            if BR.match(" " + t) and not JR.match(" " + t):
                if re.match(r"lui\b", nxt) or "%hi" in nxt:
                    c1.append((fn, tu, ins[i][0], t, nxt))
        # epilogue
        for i in range(len(ins) - 1):
            if ins[i][2].startswith("jr ") and "$ra" in ins[i][2]:
                nxt = ins[i + 1][2] if i + 1 < len(ins) else ""
                prv = ins[i - 1][2] if i else ""
                if re.match(r"addiu\s+\$sp", nxt):
                    c3on.append((fn, tu, ins[i][0]))
                elif nxt.startswith("nop") and re.match(r"addiu\s+\$sp", prv):
                    c3off.append((fn, tu, ins[i][0]))
        for i, (v, w, t) in enumerate(ins):
            if re.match(r"lui\s+\$at", t):
                atm.append((fn, tu, v, t, ins[i + 1][2] if i + 1 < len(ins) else ""))
    if want in ("all", "c1"):
        print("== CLASS 1: %%hi/lui in a CONDITIONAL-branch delay slot (%d sites)" % len(c1))
        for r in c1:
            print("   %-28s %-34s %s  [%s] / [%s]" % r)
    if want in ("all", "c3"):
        print("\n== CLASS 3: epilogue signatures")
        print("   delayed-branch ON  (jr ra ; addiu sp) : %d fns" % len(set(x[0] for x in c3on)))
        print("   delayed-branch OFF (addiu sp ; jr ra ; nop) : %d fns" % len(set(x[0] for x in c3off)))
        for r in sorted(set((x[1], x[0]) for x in c3off)):
            print("     OFF  %-34s %s" % r)
    if want in ("all", "at"):
        print("\n== lui $at absolute materialisation (%d sites)" % len(atm))
        for r in atm:
            print("   %-28s %-34s %s  [%s] / [%s]" % r)


main()

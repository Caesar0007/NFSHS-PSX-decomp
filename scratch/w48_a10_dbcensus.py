# -*- coding: utf-8 -*-
"""w48-a10 CLASS-3 census: per-function delayed-branch state read off the retail
oracle .s, plus a per-TU rollup.

A function compiled `-fno-delayed-branch` has EVERY delay slot = nop (reorg.c
never ran); a delayed-branch-ON function has at least one filled slot.  The
epilogue shape (`addiu sp / jr ra / nop` vs `jr ra / addiu sp`) is the cheap
tell, but the whole-function slot census is the real discriminator.

usage: python w48_a10_dbcensus.py [cluster-prefix]
"""
import collections, os, re, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ASM = os.path.join(ROOT, "asm", "nonmatchings", "main")
PROG = os.path.join(ROOT, "MATCH_PROGRESS.txt")

BRANCH = re.compile(
    r"^(b(eq|ne|eqz|nez|gez|gtz|lez|ltz|gezal|ltzal)?|j|jr|jal|jalr)\b")


def insns(path):
    r = []
    for ln in open(path):
        m = re.match(r"\s*/\* \w+ ([0-9A-F]{8}) ([0-9A-F]{8}) \*/\s+(.*?)\s*$", ln)
        if m:
            r.append((m.group(1), m.group(2), m.group(3)))
    return r


def classify(path):
    ins = insns(path)
    if not ins:
        return None
    slots = 0
    filled = 0
    epi = None
    for i in range(len(ins) - 1):
        if BRANCH.match(ins[i][2]):
            slots += 1
            if not ins[i + 1][2].startswith("nop"):
                filled += 1
        if ins[i][2].startswith("jr ") and "$ra" in ins[i][2]:
            nxt = ins[i + 1][2]
            prv = ins[i - 1][2] if i else ""
            if re.match(r"addiu\s+\$sp", nxt):
                epi = "ON"
            elif nxt.startswith("nop") and re.match(r"addiu\s+\$sp", prv):
                epi = "OFF"
            elif nxt.startswith("nop"):
                epi = "OFF?"        # leaf / no frame, slot still nop
    return dict(n=len(ins), slots=slots, filled=filled, epi=epi)


def main():
    pref = sys.argv[1] if len(sys.argv) > 1 else "syslib"
    rows = []
    for ln in open(PROG):
        p = ln.split()
        tu = [x for x in p if "/" in x]
        if len(p) < 4 or not tu:
            continue
        tu = tu[0]
        if not tu.startswith(pref):
            continue
        fn = p[-1]
        f = os.path.join(ASM, fn + ".s")
        if not os.path.exists(f):
            continue
        c = classify(f)
        if c:
            rows.append((tu, fn, c))
    per = collections.defaultdict(lambda: [0, 0, 0, 0])  # allnop, some, epiON, epiOFF
    for tu, fn, c in rows:
        allnop = (c["filled"] == 0 and c["slots"] > 0)
        per[tu][0 if allnop else 1] += 1
        if c["epi"] == "ON":
            per[tu][2] += 1
        elif c["epi"] and c["epi"].startswith("OFF"):
            per[tu][3] += 1
    print("%-38s %5s %5s %6s %6s   verdict" %
          ("TU", "ALLnop", "some", "epiON", "epiOFF"))
    for tu in sorted(per):
        a, s, on, off = per[tu]
        v = ("DB-OFF candidate" if a and not s else
             ("MIXED" if a and s else "DB-ON"))
        print("%-38s %5d %5d %6d %6d   %s" % (tu, a, s, on, off, v))
    print("\n-- per-function ALL-SLOTS-NOP list (the strongest -fno-delayed-branch evidence)")
    for tu, fn, c in rows:
        if c["filled"] == 0 and c["slots"] > 0:
            print("   %-34s %-28s insns=%-4d slots=%d  epi=%s" %
                  (tu, fn, c["n"], c["slots"], c["epi"]))


main()

#!/usr/bin/env python3
"""Auto-decompile trivial, relocation-free functions and rank the rest.

Two outputs:
  1. tools/_todo.csv  — every still-asm function ranked easy-first
     (instr count, has_jal, has_lui/gp, has_gte) for manual decomp.
  2. Splices C for the few unambiguous self-contained patterns directly into
     src/main.c (empty / return 0 / return const / return arg / return *(arg+off)).
     These have NO relocations so they compile standalone and, under -O2, emit
     the original bytes. Verify with objdiff afterwards; non-matches are harmless.

Only emits C when the whole function is one of the recognised patterns — never
guesses.
"""
import csv
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ASM = ROOT / "asm" / "nonmatchings" / "main"
MAIN = ROOT / "src" / "main.c"

INSTR = re.compile(r'/\* \w+ \w+ ([0-9A-Fa-f]{8}) \*/\s+(\S+)\s*(.*)$')


def insns(text):
    out = []
    for line in text.splitlines():
        m = INSTR.search(line)
        if m:
            out.append((m.group(2), m.group(3).strip()))
    return out


def nargs_from_mangle(sym):
    # crude: count pointer/int params from cfront mangle tail after __F
    m = re.search(r'__F(.*)$', sym)
    if not m or m.group(1) in ('v', ''):
        return 0
    return None  # unknown -> use a0 generically


def gen_c(sym, ins):
    """Return C body string if the function is a recognised trivial pattern."""
    ops = [o for o, _ in ins]
    # strip a trailing nop
    body = ins[:]
    # pure empty: only jr ra (+ nop)
    real = [(o, a) for o, a in ins if o != 'nop']
    if real == [('jr', '$ra')]:
        return f"void {sym}(void) {{\n}}"
    # return 0 :  jr ra ; addu/or v0,zero,zero   (any order, +nop)
    nonjr = [(o, a) for o, a in real if o != 'jr']
    if len(nonjr) == 1 and real[-1][0] != 'jr' or (len(nonjr) == 1):
        o, a = nonjr[0]
        a = a.replace(' ', '')
        if o in ('addu', 'or') and a in ('$v0,$zero,$zero', '$v0,$zero,$0'):
            return f"int {sym}(void) {{\n    return 0;\n}}"
        if o == 'move' and a == '$v0,$zero':
            return f"int {sym}(void) {{\n    return 0;\n}}"
        # return constant: addiu v0,zero,N  /  ori v0,zero,N
        m = re.match(r'\$v0,\$zero,(-?0x[0-9A-Fa-f]+|-?\d+)$', a)
        if o in ('addiu', 'ori', 'li') and m:
            return f"int {sym}(void) {{\n    return {m.group(1)};\n}}"
        # return arg: addu/move v0,a0,zero
        if o in ('addu', 'move') and a in ('$v0,$a0,$zero', '$v0,$a0'):
            return f"void *{sym}(void *a0) {{\n    return a0;\n}}"
        # return *(int*)(a0+off): lw v0, OFF($a0)
        m = re.match(r'\$v0,(0x[0-9A-Fa-f]+|\d+)\(\$a0\)$', a)
        if o == 'lw' and m:
            return (f"int {sym}(void *a0) {{\n"
                    f"    return *(int *)((char *)a0 + {m.group(1)});\n}}")
    return None


def main():
    src = MAIN.read_text()
    still = set(re.findall(r'INCLUDE_ASM\("asm/nonmatchings/main", (\w+)\);', src))
    rows = []
    spliced = 0
    for s in sorted(ASM.glob("*.s")):
        sym = s.name[:-2]
        if sym not in still:
            continue
        ins = insns(s.read_text())
        ops = [o for o, _ in ins]
        has_jal = any(o in ('jal', 'jalr') for o in ops)
        has_lui = any(o == 'lui' for o in ops)
        has_gp = '%gp_rel' in s.read_text()
        has_gte = any(o == '.word' for o in ops)
        rows.append((len(ins), sym, int(has_jal), int(has_lui or has_gp), int(has_gte)))
        # only auto-decompile fully self-contained (no reloc) functions
        if has_jal or has_lui or has_gp or has_gte:
            continue
        c = gen_c(sym, ins)
        if c:
            pat = re.compile(r'^INCLUDE_ASM\("asm/nonmatchings/main", '
                             + re.escape(sym) + r'\);\s*$', re.M)
            if pat.search(src):
                src = pat.sub(lambda m: c, src, count=1)
                spliced += 1

    rows.sort()
    with open(ROOT / "tools" / "_todo.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["instrs", "symbol", "has_jal", "has_lui_or_gp", "has_gte"])
        w.writerows(rows)
    MAIN.write_text(src)
    print(f"ranked {len(rows)} still-asm fns -> tools/_todo.csv; "
          f"auto-spliced {spliced} trivial bodies")


if __name__ == "__main__":
    main()

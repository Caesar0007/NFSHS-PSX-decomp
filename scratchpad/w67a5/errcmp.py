"""Compare two srclink .err files at the DEFECT level (not raw lines):
the set of (referencing object, undefined symbol) pairs, the multiple
definitions, truncations and discards.  Raw line counts shift with object
ORDER because ld coalesces consecutive same-symbol messages ("more undefined
references to `X' follow") differently -- that is presentation, not defects."""
import re
import sys

def classify(path):
    undef_pairs = set()
    undef_syms = set()
    mult = set()
    trunc = set()
    disc = set()
    cur_obj = None
    for l in open(path, encoding="utf-8", errors="replace"):
        l = l.rstrip("\n")
        m = re.match(r"(?:.*ld(?:\.exe)?: )?(\S+\.o):", l)
        if m and ".o" in l:
            cur_obj = m.group(1)
        m = re.search(r"undefined reference to [`'](.+?)'", l)
        if m:
            undef_syms.add(m.group(1))
            undef_pairs.add((cur_obj, m.group(1)))
        m = re.search(r"multiple definition of [`'](.+?)'", l)
        if m:
            mult.add(m.group(1))
        m = re.search(r"relocation truncated to fit: (\S+) against [`'](.+?)'", l)
        if m:
            trunc.add(m.groups())
        if "defined in discarded section" in l:
            disc.add(l.strip())
    return undef_pairs, undef_syms, mult, trunc, disc

a = classify(sys.argv[1])
b = classify(sys.argv[2])
names = ("undef (obj,sym) pairs", "undef distinct syms", "multiple-defs",
         "truncations", "discards")
for n, x, y in zip(names, a, b):
    extra_b = y - x
    extra_a = x - y
    print(f"{n}: A={len(x)}  B={len(y)}  onlyA={len(extra_a)}  onlyB={len(extra_b)}")
    for e in sorted(extra_b)[:10]:
        print("   only-B:", e)
    for e in sorted(extra_a)[:10]:
        print("   only-A:", e)

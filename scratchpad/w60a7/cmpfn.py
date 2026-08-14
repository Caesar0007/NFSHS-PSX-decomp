"""Compare one function body between two cc1 .s outputs (label-normalised).

  python cmpfn.py <a.s> <b.s> <mangled-fn>
Prints IDENTICAL / DIFFERS (+ first N differing lines).
"""
import io, re, sys


def body(path, fn):
    txt = io.open(path, encoding="latin-1").read().splitlines()
    out, on = [], False
    for ln in txt:
        s = ln.strip()
        if s.startswith(".ent") and fn in s:
            on = True
            continue
        if on and s.startswith(".end"):
            break
        if on:
            if not s or s.startswith(("#", ".set", ".frame", ".mask", ".fmask",
                                      ".loc", ".stab", ".file", ".def", ".type",
                                      ".size", ".align", ".globl", ".sdata", ".text",
                                      ".rdata", ".data", ".word", ".byte", ".ascii")):
                continue
            s = re.sub(r"\$L[A-Za-z0-9_$.]+", "L", s)
            s = re.sub(r"\s+", " ", s)
            out.append(s)
    return out


a, b, fn = sys.argv[1], sys.argv[2], sys.argv[3]
A, B = body(a, fn), body(b, fn)
print("A %d insns / B %d insns" % (len(A), len(B)))
if A == B:
    print("IDENTICAL")
else:
    print("DIFFERS")
    n = 0
    for i in range(max(len(A), len(B))):
        x = A[i] if i < len(A) else "<eof>"
        y = B[i] if i < len(B) else "<eof>"
        if x != y:
            print("  %4d  A:%-34s B:%s" % (i, x, y))
            n += 1
            if n >= 25:
                print("  ...")
                break

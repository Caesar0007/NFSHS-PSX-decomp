#!/usr/bin/env python3
"""CdControl-only probe: the three CdControl* bodies are textually identical in
their preamble, so every edit is applied INSIDE the CdControl function region
only (sliced on its signature .. the next `extern int`)."""
import os
import subprocess
import sys

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
TU = "recon/syslib/psx/libcd/cdcont.c"
PATH = os.path.join(REPO, TU)
SIG = "extern int CdControl(int com, unsigned char *param, unsigned char *result)\n"
FNS = ["CdControl", "CdControlB", "CdControlF"]

CMP = "        if (command != 1) {\n"
PRE = "    status = 0;\n    sentinel = -1;\n"
DECL = "    unsigned char *arg;\n"

VARIANTS = {
    # `one` set in the PREAMBLE -> live across the loop's calls -> a 10th
    # call-crossing GLOBAL allocno; s0-s7+fp are already full, so global.c's
    # CALLER_SAVE_PROFITABLE retry should hand it a caller-saved t-reg.
    "pre-one":      [(DECL, DECL + "    int one;\n"), (CMP, CMP.replace("!= 1", "!= one")),
                     (PRE, PRE + "    one = 1;\n")],
    "pre-one-rof":  [(DECL, DECL + "    int one;\n"), (CMP, CMP.replace("!= 1", "!= one")),
                     (PRE, PRE + "    one = 1;\n    __asm__(\"\" : : \"r\"(one));\n")],
    "pre-one-idf":  [(DECL, DECL + "    int one;\n"), (CMP, CMP.replace("!= 1", "!= one")),
                     (PRE, PRE + "    one = 1;\n    __asm__(\"\" : \"=r\"(one) : \"0\"(one));\n")],
    "pre-one-first": [(DECL, DECL + "    int one;\n"), (CMP, CMP.replace("!= 1", "!= one")),
                      ("    arg = param;\n", "    one = 1;\n    arg = param;\n")],
    # a 10th call-crossing value that is NOT the constant: the sentinel already
    # is one; try making `retries` comparison constant live too
    "pre-one-and-two": [(DECL, DECL + "    int one;\n    int two;\n"),
                        (CMP, CMP.replace("!= 1", "!= one")),
                        ("            if (CD_cw(2, arg, resultReg, 0) != 0)\n",
                         "            if (CD_cw((unsigned char)two, arg, resultReg, 0) != 0)\n"),
                        (PRE, PRE + "    one = 1;\n    two = 2;\n")],
}


def gate():
    out = []
    for fn in FNS:
        r = subprocess.run([sys.executable, os.path.join(REPO, "tools", "verify_asm.py"), TU, fn],
                           cwd=REPO, capture_output=True, text=True)
        t = (r.stdout or "") + (r.stderr or "")
        hit = [l.strip() for l in t.splitlines() if fn + ":" in l]
        out.append(hit[0] if hit else "?" + fn)
    return " | ".join(out)


def main():
    orig = open(PATH, "rb").read()
    txt = orig.decode("utf-8")
    a = txt.index(SIG)
    b = txt.index("\nextern ", a + len(SIG))
    head, body, tail = txt[:a], txt[a:b], txt[b:]
    for name, subs in VARIANTS.items():
        nb = body
        ok = True
        for old, new in subs:
            if nb.count(old) != 1:
                print("%-16s ANCHOR %r x%d" % (name, old[:40], nb.count(old)))
                ok = False
                break
            nb = nb.replace(old, new)
        if not ok:
            continue
        try:
            tmp = PATH + ".w63a5tmp"
            with open(tmp, "wb") as f:
                f.write((head + nb + tail).encode("utf-8"))
            os.replace(tmp, PATH)
            print("%-16s %s" % (name, gate()))
        finally:
            with open(PATH + ".w63a5tmp", "wb") as f:
                f.write(orig)
            os.replace(PATH + ".w63a5tmp", PATH)
    assert open(PATH, "rb").read() == orig


if __name__ == "__main__":
    main()

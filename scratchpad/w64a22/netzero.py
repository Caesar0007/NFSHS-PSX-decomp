"""W64-A22 MISSION A/3 -- NET-ZERO INC/DEC PAIR: fix, or diagnostic?

catalog SS.A row: "NET-ZERO POINTER INC/DEC PAIR -- insert a semantically-void
`p++; p--;` ... keep verbatim once found, don't clean up."  Witness =
BworldSm_UpdateSimQuad (recon/game/common/bworldSm.cpp:377-379).
tenchu cookbook 3.9 rules the identical device a DIAGNOSTIC to be rejected, on
the grounds that a real identity always existed behind it.

This probe runs on a COPY of the sealed TU (scratchpad/w64a22/lab/...), never the
sealed file.  Question: is the pair LOAD-BEARING, and is it REPLACEABLE by a
documented zero-insn instrument (a read-only fence / identity launder) so the
receipt can carry a real device instead of dead code?
"""
import os
import subprocess
import sys

ROOT = r"C:/Temp/nfs4-decomp"
REL = "scratchpad/w64a22/lab/game/common/bworldSm.cpp"
FN = "BworldSm_UpdateSimQuad__FP12BWorldSm_Pos"
PATH = os.path.join(ROOT, REL)

PAIR = ("""  slicePos->simSlice++;   /* @codegen-device: net-zero pair forces pTVar2 into oracle's a1
                              (permuter-derived; do NOT simplify away, see verify_asm) */
  slicePos->simSlice--;
""")

VARIANTS = {
    "00_base            ": PAIR,
    "01_pair_removed    ": "",
    "02_pair_reversed   ": "  slicePos->simSlice--;\n  slicePos->simSlice++;\n",
    "03_pair_on_pTVar2  ": "  pTVar2++;\n  pTVar2--;\n",
    "04_fence_pTVar2_x1 ": '  __asm__("" : : "r"(pTVar2));\n',
    "05_fence_pTVar2_x2 ": '  __asm__("" : : "r"(pTVar2), "r"(pTVar2));\n',
    "06_fence_pTVar2_x3 ": '  __asm__("" : : "r"(pTVar2), "r"(pTVar2), "r"(pTVar2));\n',
    "07_fence_slicePos  ": '  __asm__("" : : "r"(slicePos));\n',
    "08_fence_both      ": '  __asm__("" : : "r"(pTVar2), "r"(slicePos));\n',
    "09_launder_pTVar2  ": '  __asm__("" : "=r"(pTVar2) : "0"(pTVar2));\n',
    "10_fence_simSlice  ": '  __asm__("" : : "r"(slicePos->simSlice));\n',
    "11_void_fence      ": '  __asm__("" : : "i"(0));\n',
}


def gate():
    r = subprocess.run([sys.executable, "tools/verify_asm.py", REL, FN],
                       capture_output=True, text=True, cwd=ROOT)
    out = [l.strip() for l in r.stdout.splitlines() if l.strip()]
    hit = [l for l in out if l.startswith(FN + ":")]
    return hit[0] if hit else ((out[-1] if out else "") + " |ERR "
                               + r.stderr.strip()[-160:])


def main():
    orig = open(PATH, "rb").read()
    assert orig.count(PAIR.encode().replace(b"\n", b"\r\n")) == 1 or \
        orig.count(PAIR.encode()) == 1, "PAIR anchor not unique"
    crlf = orig.count(b"\r\n") > 0
    pair_b = PAIR.encode().replace(b"\n", b"\r\n") if crlf else PAIR.encode()
    try:
        for tag in sorted(VARIANTS):
            new = VARIANTS[tag].encode()
            if crlf:
                new = new.replace(b"\n", b"\r\n")
            data = orig.replace(pair_b, new)
            open(PATH, "wb").write(data)
            print("  %s %s" % (tag, gate()))
            sys.stdout.flush()
    finally:
        open(PATH, "wb").write(orig)
        print("(restored)")


main()

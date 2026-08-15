# =====================================================================
# W65-A1 -- PER_FN_TEXT_MOVES SPEC (orchestrator wires; do NOT edit tools/)
# =====================================================================
# Three functions whose class-d branch-word divergence is a jump.c / reorg
# decision with NO source expression (every spelling tried is receipted in
# scratchpad/w65a1/RECEIPTS.md).  All are PURE LABEL MOVES: zero instruction
# change, verify_asm stays PASS, and psyqproof goes REAL>0 -> REAL=0.
#
# Probe apparatus (tools/ untouched):
#   scratchpad/w65a1/mkprobe.py <this file>   -> build_probe.py
#   scratchpad/w65a1/verify_probe.py / tugate_probe.py / brdist_probe.py
#   tools/psyqproof.py with W64_PQ_TEXT_MOVES_FILE=scratchpad/w65a1/pq_rows.json
#
# 🔴 WIRING TRAP (cost one probe cycle): fescreen.cpp and screencarselect.cpp
# may already own a PER_FN_TEXT_MOVES entry -- fescreen.cpp DOES
# (GoNonInterlaced__7tScreen).  A second dict-literal key for the same TU is
# silently dropped by Python.  These fragments therefore use setdefault(); when
# transcribing into tools/build.py, ADD the fn key to the existing TU dict.
#
# All anchors are label-AGNOSTIC (w60-a8) and asserted region-unique.

# ---------------------------------------------------------------------
# 1. fememcard LoadGame__FsbT1 -- 3 branch words (17/21/23).
#    Three byte-identical `li $17,1 / j <loop head>` tails exist; our jump.c
#    cross-jump made the FIRST (the SetPads arm) the shared partner, retail the
#    LAST (the getcard arm).  Move the label off the SetPads tail onto the
#    getcard tail; the SetPads arm keeps its own tail by fall-through.
#    Probe: verify_asm PASS 374 2x, tugate 18/18, brdist 0, psyqproof REAL 1->0 2x.
PER_FN_TEXT_MOVES.setdefault("recon/frontend/common/fememcard.cpp", {})[
    "LoadGame__FsbT1"] = [
    {"take": r"\$L\d+:\n(?=\t\.set\tnoreorder\n\t\.set\tnomacro\n"
             r"\tj\t\$L\d+\n\tli\t\$17,1)",
     "after": r" \#NO_APP\n"},
]

# ---------------------------------------------------------------------
# 2. fescreen InitializeShapes__7tScreenR17tShapeInformationUi -- branch word 17.
#    Two consecutive `if (numShapes != 0)` guards; retail threads the FIRST
#    guard's false edge straight to the epilogue, past the second.  The label
#    that guard targets has exactly one user, so relocating it onto the epilogue
#    label's position is exact.
#    Probe: verify_asm PASS 42 2x, tugate 27/27, brdist 0, psyqproof REAL 1->0 2x.
PER_FN_TEXT_MOVES.setdefault("recon/frontend/common/fescreen.cpp", {})[
    "InitializeShapes__7tScreenR17tShapeInformationUi"] = [
    {"take": r"\$L\d+:\n(?=\t\.set\tnoreorder\n\t\.set\tnomacro\n"
             r"\tbeq\t\$17,\$0,\$L\d+\n\tmove\t\$4,\$0\n)",
     "after": r"\tbne\t\$2,\$0,\$L\d+\n\tandi\t\$2,\$4,0xffff\n"
              r"\t\.set\tmacro\n\t\.set\treorder\n\n"},
]

# ---------------------------------------------------------------------
# 3. screencarselect DrawBackground__25tScreenCarSelectTwoPlayer -- 5 branch
#    words (106 / 130 / 132 / 139 / 143), three rows.
#    (a) word 106: retail's "no showroom car" guard lands on the SECOND identical
#        gCarObj->0x8D8 test (which falls through to the same block); ours skips
#        past it.  Relocate that label up in front of the re-test.
#    (b) words 130/132/139: reorg STOLE `move $4,$16` into the preceding `bne`'s
#        delay slot, so retail redirected the three guards PAST the now-redundant
#        copy straight to the `jal`; ours still targets the copy.
#    (c) word 143: the same target-steal, on the SetBrightness/TurnOn arm.
#    Probe: verify_asm PASS 342 2x, tugate 59/59, brdist TU 0, psyqproof
#    REAL 5 -> 0 2x.
_W65A1_SB = (r"\t\.set\tnoreorder\n\t\.set\tnomacro\n"
             r"\tjal\tSetBrightness__16tScreenCarSelectss\n\tmove\t\$6,\$0\n"
             r"\t\.set\tmacro\n\t\.set\treorder\n\n"
             r"\t\.set\tnoreorder\n\t\.set\tnomacro\n\tjal\tTurnOn__10tVideoWall\n")
PER_FN_TEXT_MOVES.setdefault("recon/frontend/common/screencarselect.cpp", {})[
    "DrawBackground__25tScreenCarSelectTwoPlayer"] = [
    {"take": r"\$L\d+:\n(?=\tlh\t\$3,884\(\$16\)\n)",
     "after": r"\tsw\t\$2,892\(\$16\)\n"},
    {"take": r"\$L\d+:\n(?= \#APP\n \#NO_APP\n\tmove\t\$4,\$16\n)",
     "after": r" \#APP\n \#NO_APP\n\tmove\t\$4,\$16\n"},
    {"take": r"\$L\d+:\n(?=\tmove\t\$4,\$16\n" + _W65A1_SB + r")",
     "after": r"\tmove\t\$4,\$16\n(?=" + _W65A1_SB + r")"},
]

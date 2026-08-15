# ============================ w65-a1 SPEC ROWS ============================
# Both are PURE LABEL MOVES (zero instruction change, gate stays PASS) that fix
# a REAL branch-word divergence behind a green gate -- 04Q class-d rows from
# W64-A21's census.  Anchors are label-AGNOSTIC (w60-a8) and region-unique;
# each probe-verified 2x with verify_asm + brdist + psyqproof (the latter via
# W64_PQ_TEXT_MOVES_FILE).  tools/build.py itself is untouched.
#
# NOTE FOR WIRING: fememcard.cpp has no existing PER_FN_TEXT_MOVES entry (a new
# dict key is correct); fescreen.cpp ALREADY HAS ONE (GoNonInterlaced__7tScreen)
# -- the InitializeShapes row must be ADDED to that dict, never given a second
# literal key (Python keeps only the last).  That trap cost one probe cycle.

# LoadGame__FsbT1 (3 branch words: 17/21/23).  Our jump.c cross-jump picked the
# FIRST of three byte-identical `li $17,1 / j <loop head>` tails as the shared
# partner; retail picked the LAST (the getcard arm's own).  Moving the label off
# the SetPads-arm tail onto the getcard-arm tail reproduces retail exactly; the
# SetPads arm keeps its own tail by fall-through.
# Source axis FALSIFIED (all re-gated from PASS 374): void fence after either
# `finished = true` +1 insn (kills the delay-slot fill), fence before it inert,
# explicit goto to a labelled shared tail inert x2, flat-&& inert, statement
# reorderings 375/381, -fno-thread-jumps 373 (routing unchanged).
PER_FN_TEXT_MOVES.setdefault("recon/frontend/common/fememcard.cpp", {})[
    "LoadGame__FsbT1"] = [
    {"take": r"\$L\d+:\n(?=\t\.set\tnoreorder\n\t\.set\tnomacro\n"
             r"\tj\t\$L\d+\n\tli\t\$17,1)",
     "after": r" \#NO_APP\n"},
]

# InitializeShapes__7tScreenR17tShapeInformationUi (branch word 17).  Two
# consecutive `if (numShapes != 0)` guards; retail threads the FIRST guard's
# false edge straight to the epilogue, past the second (identical, therefore
# never-taken-from-there) test.  The label the first guard targets is used by
# that guard ALONE, so relocating it to the epilogue label's position is exact.
# Source axis FALSIFIED (all re-gated from PASS 42): `else goto` / early-out
# `goto` 41 (gcc then DELETES the second test), `i = 0` hoisted before the first
# if 43, `i = 0` moved inside the first if 41, `i = 0` at the declaration 43; an
# identity launder on numShapes DOES keep both tests and thread the guard at
# EXACT count 42 -- but recolours 36 instructions.
PER_FN_TEXT_MOVES.setdefault("recon/frontend/common/fescreen.cpp", {})[
    "InitializeShapes__7tScreenR17tShapeInformationUi"] = [
    {"take": r"\$L\d+:\n(?=\t\.set\tnoreorder\n\t\.set\tnomacro\n"
             r"\tbeq\t\$17,\$0,\$L\d+\n\tmove\t\$4,\$0\n)",
     "after": r"\tbne\t\$2,\$0,\$L\d+\n\tandi\t\$2,\$4,0xffff\n"
              r"\t\.set\tmacro\n\t\.set\treorder\n\n"},
]
# w65-a1 candidate rows for screencarselect DrawBackground__25tScreenCarSelectTwoPlayer
_SB = (r"\t\.set\tnoreorder\n\t\.set\tnomacro\n"
       r"\tjal\tSetBrightness__16tScreenCarSelectss\n\tmove\t\$6,\$0\n"
       r"\t\.set\tmacro\n\t\.set\treorder\n\n"
       r"\t\.set\tnoreorder\n\t\.set\tnomacro\n\tjal\tTurnOn__10tVideoWall\n")

PER_FN_TEXT_MOVES.setdefault("recon/frontend/common/screencarselect.cpp", {})[
    "DrawBackground__25tScreenCarSelectTwoPlayer"] = [
    # (a) branch word 106: retail's `beqz` for the "no showroom car" arm lands on
    #     the SECOND identical gCarObj test (which then falls through to the same
    #     block); ours skips straight past it.  Relocate the label up.
    {"take": r"\$L\d+:\n(?=\tlh\t\$3,884\(\$16\)\n)",
     "after": r"\tsw\t\$2,892\(\$16\)\n"},
    # (b) branch words 130/132/139: reorg STOLE `move $4,$16` into the preceding
    #     `bne`'s delay slot, so retail redirected the three guards PAST the now
    #     redundant copy, straight to the `jal`.  Ours still targets the copy.
    {"take": r"\$L\d+:\n(?= \#APP\n \#NO_APP\n\tmove\t\$4,\$16\n)",
     "after": r" \#APP\n \#NO_APP\n\tmove\t\$4,\$16\n"},
    # (c) branch word 143: same target-steal class, the SetBrightness/TurnOn arm.
    {"take": r"\$L\d+:\n(?=\tmove\t\$4,\$16\n" + _SB + r")",
     "after": r"\tmove\t\$4,\$16\n(?=" + _SB + r")"},
]

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

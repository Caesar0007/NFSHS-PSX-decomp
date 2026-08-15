    # w65-a1 SPEC (class-d 04Q, LoadGame__FsbT1 3 branch words): pure LABEL move.
    # Our jump.c cross-jump picked the FIRST of three byte-identical
    # `li $17,1 / j <loop-head>` tails as the shared partner; retail picked the
    # LAST (the getcard arm's own).  Semantically identical, source-unreachable
    # (goto/fence/-fno-thread-jumps all inert or +1 insn -- see RECEIPTS).
    # Move the label off the SetPads-arm tail onto the getcard-arm tail; the
    # SetPads arm keeps its tail by fall-through, exactly as retail.
    # Anchors are label-AGNOSTIC (w60-a8) and region-unique (asserted).
    "recon/frontend/common/fememcard.cpp": {
        "LoadGame__FsbT1": [
            {"take": r"\$L\d+:\n(?=\t\.set\tnoreorder\n\t\.set\tnomacro\n"
                     r"\tj\t\$L\d+\n\tli\t\$17,1)",
             "after": r" \#NO_APP\n"},
        ],
    },

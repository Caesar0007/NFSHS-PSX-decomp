SRC = 'recon/syslib/psx/libgpu/SYS.c'
FNS = ['MoveImage']

GUARD = """    if (r[2] == 0 || r[3] == 0)
        return -1;
"""

BODYHEAD = "    p = &_move_prim[2];\n"

SPEC = [
    # V1 -- two separate ifs
    ("V1 two separate ifs", [(GUARD,
     "    if (r[2] == 0)\n        return -1;\n    if (r[3] == 0)\n        return -1;\n")]),

    # V2 -- skip-goto: second guard branches TO the body, -1 block falls through
    ("V2 skip-goto (bnez->body)", [(GUARD,
     "    if (r[2] == 0)\n        goto ret_m1;\n    if (r[3] != 0)\n        goto body;\n"
     "  ret_m1:\n    return -1;\n  body:\n"),
     (BODYHEAD, BODYHEAD)]),

    # V3 -- positive && wrapping nothing (equivalent negation)
    ("V3 !(a && b)", [(GUARD,
     "    if (!(r[2] != 0 && r[3] != 0))\n        return -1;\n")]),

    # V4 -- first guard plain, second guard skip-goto only
    ("V4 or-guard1 + skip-goto guard2", [(GUARD,
     "    if (r[2] == 0)\n        return -1;\n    if (r[3] != 0)\n        goto body;\n"
     "    return -1;\n  body:\n")]),

    # V5 -- nested if with goto body
    ("V5 nested if + goto body", [(GUARD,
     "    if (r[2] != 0) {\n        if (r[3] != 0)\n            goto body;\n    }\n"
     "    return -1;\n  body:\n")]),

    # V6 -- both guards as skip-gotos to a shared ret label placed before body
    ("V6 both skip-goto", [(GUARD,
     "    if (r[2] != 0)\n        goto g2;\n    goto ret_m1;\n  g2:\n"
     "    if (r[3] != 0)\n        goto body;\n  ret_m1:\n    return -1;\n  body:\n")]),
]

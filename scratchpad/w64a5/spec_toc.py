TU = "recon/syslib/psx/libcd/toc.c"
FUNC = "CdGetToc2"

BASE = """    i = 1;
    if (track_first <= track_last) {
        magic = 0x66666667;
        do {
            __asm__("" : : "r"(magic), "r"(track_first));   /* MATCH (W60-A4): see the receipt above */
            param[0] = (u_char)(((track_first / 10) << 4) + track_first % 10);   /* track # -> BCD */
            if (CdControlB(0x14, param, result) == 0)
                goto err;
            loc[i].minute = result[1];
            loc[i].second = result[2];
            loc[i].sector = 0;
            i++;
            track_first++;
        } while (track_first <= track_last);
    }
"""

BODY_TAIL = """            param[0] = (u_char)(((track_first / 10) << 4) + track_first % 10);
            if (CdControlB(0x14, param, result) == 0)
                goto err;
            loc[i].minute = result[1];
            loc[i].second = result[2];
            loc[i].sector = 0;
            i++;
            track_first++;
        } while (track_first <= track_last);
    }
"""


def mk(pre, head):
    """pre = preheader statements (inside the guard, before do);
       head = statements at the top of the loop body."""
    s = "    i = 1;\n    if (track_first <= track_last) {\n"
    for l in pre:
        s += "        " + l + "\n"
    s += "        do {\n"
    for l in head:
        s += "            " + l + "\n"
    s += BODY_TAIL
    return s


M = "magic = 0x66666667;"
F_mt = '__asm__("" : : "r"(magic), "r"(track_first));'
F_tm = '__asm__("" : : "r"(track_first), "r"(magic));'
F_t = '__asm__("" : : "r"(track_first));'
F_tt = '__asm__("" : : "r"(track_first), "r"(track_first));'
F_mtt = '__asm__("" : : "r"(magic), "r"(track_first), "r"(track_first));'

VARIANTS = {
    "ctl":        BASE,
    "A_in_mt":    mk([], [M, F_mt]),
    "B_in_tm":    mk([], [M, F_tm]),
    "C_in_t":     mk([], [M, F_t]),
    "D_in_tt":    mk([], [M, F_tt]),
    "E_both_mt":  mk([M], [M, F_mt]),
    "F_in_mtt":   mk([], [M, F_mtt]),
    "G_fence1st": mk([], [F_mt, M]),
    "H_pre_in_t": mk([M], [M, F_t]),
}

import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from spec_toc import TU, FUNC, BASE, M, F_mt, F_tm, F_t, F_tt, F_mtt

HEAD = "    i = 1;\n    if (track_first <= track_last) {\n"
DO = "        do {\n"
P0 = "            param[0] = (u_char)(((track_first / 10) << 4) + track_first % 10);\n"
CALL = ("            if (CdControlB(0x14, param, result) == 0)\n"
        "                goto err;\n")
ST = ("            loc[i].minute = result[1];\n"
      "            loc[i].second = result[2];\n"
      "            loc[i].sector = 0;\n")
INC = "            i++;\n            track_first++;\n"
END = "        } while (track_first <= track_last);\n    }\n"


def mk(pre=(), a=(), b=(), c=(), d=(), e=()):
    """a=top of body, b=after param[0], c=after call, d=after stores, e=after incr"""
    s = HEAD
    for l in pre:
        s += "        " + l + "\n"
    s += DO
    for l in a:
        s += "            " + l + "\n"
    s += P0
    for l in b:
        s += "            " + l + "\n"
    s += CALL
    for l in c:
        s += "            " + l + "\n"
    s += ST
    for l in d:
        s += "            " + l + "\n"
    s += INC
    for l in e:
        s += "            " + l + "\n"
    s += END
    return s


F_ttt = '__asm__("" : : "r"(track_first), "r"(track_first), "r"(track_first));'
F_mttt = '__asm__("" : : "r"(magic), "r"(track_first), "r"(track_first), "r"(track_first));'
F_m = '__asm__("" : : "r"(magic));'

VARIANTS = {
    "ctl":          BASE,
    "G_fm_then_m":  mk(a=[F_mt, M]),
    "G2_ft_then_m": mk(a=[F_t, M]),
    "G3_fmtt_m":    mk(a=[F_mtt, M]),
    "G4_fmttt_m":   mk(a=[F_mttt, M]),
    "G5_fttt_m":    mk(a=[F_ttt, M]),
    "I_m_fb":       mk(a=[M], b=[F_mt]),
    "J_m_fc":       mk(a=[M], c=[F_mt]),
    "K_m_fd":       mk(a=[M], d=[F_mt]),
    "L_m_fe":       mk(a=[M], e=[F_mt]),
    "N_m_ft_fmb":   mk(a=[M, F_t], b=[F_m]),
    "O_m_fttt":     mk(a=[M, F_ttt]),
    "P_m_ft_fmd":   mk(a=[M, F_t], d=[F_m]),
}

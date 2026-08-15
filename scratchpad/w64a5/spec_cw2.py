import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from spec_cw import TU, FUNC, EXTRA_FUNCS, A, B, b, FIP

A_notbl = """    ip = &Intr;
    __asm__("" : "=r"(ip) : "0"(ip));
    ip->sync = 0;
"""
GUARD = """    if (*(int *)((com << 2) + (int)_cd_result_flag))
        ip->ready = 0;
    CDREG0 = 0;
"""
CNT = "    cnt = tbl + 0x40;\n"
T = "    tbl = _cd_result_flag;\n"
IPB = [(B, b(pre=FIP))]

VARIANTS = {
    "ctl":          [],
    "ipB":          IPB,
    # move the tbl assignment progressively later (shortens pseudo 82's live range)
    "ipB_tbl_cnt":  IPB + [(A, A_notbl), (CNT, T + CNT)],
    "ipB_tbl_mid":  IPB + [(A, A_notbl),
                           (GUARD, GUARD.rstrip("\n").rsplit("\n", 1)[0] + "\n" + T + "    CDREG0 = 0;\n")],
    "ipB_tbl_aftg": IPB + [(A, A_notbl), (GUARD, GUARD + T)],
    "tbl_cnt_only": [(A, A_notbl), (CNT, T + CNT)],
}

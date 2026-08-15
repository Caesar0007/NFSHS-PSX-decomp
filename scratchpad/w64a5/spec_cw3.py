import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from spec_cw import TU, FUNC, EXTRA_FUNCS, A, B, b, FIP

CNT = "    cnt = tbl + 0x40;\n"
GUARD = """    if (*(int *)((com << 2) + (int)_cd_result_flag))
        ip->ready = 0;
    CDREG0 = 0;
"""
F1 = '    __asm__("" : : "r"(tbl));\n'
F2 = '    __asm__("" : : "r"(tbl), "r"(tbl));\n'
F3 = '    __asm__("" : : "r"(tbl), "r"(tbl), "r"(tbl));\n'
IPB = [(B, b(pre=FIP))]

VARIANTS = {
    "ipB":            IPB,
    "ipB_f2_cnt":     IPB + [(CNT, F2 + CNT)],
    "ipB_f1_cnt":     IPB + [(CNT, F1 + CNT)],
    "ipB_f3_cnt":     IPB + [(CNT, F3 + CNT)],
    "ipB_f2_guard":   IPB + [(GUARD, GUARD + F2)],
    "ipB_f2_A":       IPB + [(A, A + F2)],
    "ipB_f2_cnt_af":  IPB + [(CNT, CNT + F2)],
}

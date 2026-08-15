TU = "recon/syslib/psx/libcd/drv.c"
FUNC = "CD_cw"
EXTRA_FUNCS = ["CD_sync", "CD_ready", "CD_datasync"]

# anchor A: the ip/tbl preamble
A = """    ip = &Intr;
    __asm__("" : "=r"(ip) : "0"(ip));
    ip->sync = 0;
    tbl = _cd_result_flag;
"""
# anchor B: after the parameter loop (before the first call that follows)
B = """    CD_com = (unsigned char)com;
    CDREG1 = CD_com;
    if (arg3 != 0)
        return 0;
"""
FIP = '__asm__("" : : "r"(ip));'
FTB = '__asm__("" : : "r"(tbl));'
FTB2 = '__asm__("" : : "r"(tbl), "r"(tbl));'


def a(extra=""):
    return A + (("    " + extra + "\n") if extra else "")


def b(pre="", mid="", post=""):
    s = ""
    if pre:
        s += "    " + pre + "\n"
    s += "    CD_com = (unsigned char)com;\n    CDREG1 = CD_com;\n"
    if mid:
        s += "    " + mid + "\n"
    s += "    if (arg3 != 0)\n        return 0;\n"
    if post:
        s += "    " + post + "\n"
    return s


VARIANTS = {
    "ctl":            [],
    "ip_at_B":        [(B, b(pre=FIP))],
    "ip_at_Bmid":     [(B, b(mid=FIP))],
    "ip_at_Bpost":    [(B, b(post=FIP))],
    "tbl2":           [(A, a(FTB2))],
    "tbl1":           [(A, a(FTB))],
    "tbl2_ip_B":      [(A, a(FTB2)), (B, b(pre=FIP))],
    "tbl2_ip_Bpost":  [(A, a(FTB2)), (B, b(post=FIP))],
    "tbl1_ip_B":      [(A, a(FTB)), (B, b(pre=FIP))],
}

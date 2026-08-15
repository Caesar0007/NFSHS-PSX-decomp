TU = "recon/syslib/psx/libcd/drv.c"
FUNC = "CD_init_80108140"
EXTRA_FUNCS = []

DECL = """    volatile unsigned char *state;
    volatile unsigned char *reg;
    unsigned char c;
"""
DECL_R = DECL + "    int syncRet;\n"

TAIL = """    if (CD_sync(0, 0) != 2) {
        __asm__("" : : "i"(0));
        return -1;
    }
    __asm__("" : : "i"(0));
    return 0;
"""


def tail(pre="", fence="", cond="syncRet != 2", vf=True):
    s = ""
    if pre:
        s += "    " + pre + "\n"
    if fence:
        s += "    " + fence + "\n"
    s += "    if (%s) {\n" % cond
    if vf:
        s += '        __asm__("" : : "i"(0));\n'
    s += "        return -1;\n    }\n"
    if vf:
        s += '    __asm__("" : : "i"(0));\n'
    s += "    return 0;\n"
    return s


ID = '__asm__("" : "=r"(syncRet) : "0"(syncRet));'
RO = '__asm__("" : : "r"(syncRet));'
CALL = "syncRet = CD_sync(0, 0);"

VARIANTS = {
    "ctl":     [],
    "R2a_id":  [(DECL, DECL_R), (TAIL, tail(CALL, ID))],
    "R2b_ro":  [(DECL, DECL_R), (TAIL, tail(CALL, RO))],
    "R2c_id_novf": [(DECL, DECL_R), (TAIL, tail(CALL, ID, vf=False))],
    "R2d_yoda":[(DECL, DECL_R), (TAIL, tail(CALL, ID, cond="2 != syncRet"))],
    "R2e_plain":[(DECL, DECL_R), (TAIL, tail(CALL, ""))],
    "R2f_id2": [(DECL, DECL_R), (TAIL, tail(CALL, ID + " " + ID))],
}

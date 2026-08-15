TU = "recon/syslib/psx/libcd/iso9660.c"
FUNC = "CD_newmedia"
EXTRA_FUNCS = []

BLK = """    idx = 0;
    rec = buf;
    end = buf + 0x800;
    while (rec < end) {
"""
ID = '    __asm__("" : "=r"(end) : "0"(end));\n'
IDR = '    __asm__("" : "=r"(rec) : "0"(rec));\n'
RO = '    __asm__("" : : "r"(end));\n'


def mk(pre="", post="", order="ire"):
    m = {"i": "    idx = 0;\n", "r": "    rec = buf;\n", "e": "    end = buf + 0x800;\n"}
    return pre + "".join(m[c] for c in order) + post + "    while (rec < end) {\n"


VARIANTS = {
    "ctl":       [],
    "id_end":    [(BLK, mk(post=ID))],
    "id_end_ri": [(BLK, mk(post=ID, order="rei"))],
    "ro_end":    [(BLK, mk(post=RO))],
    "id_rec":    [(BLK, mk(post=IDR))],
    "id_both":   [(BLK, mk(post=ID + IDR))],
    "id_end_pre":[(BLK, mk(pre="", order="ier", post="") .replace("    rec = buf;\n", ID + "    rec = buf;\n"))],
    "lim_copy":  [(BLK, "    idx = 0;\n    rec = buf;\n    {\n        u_char *lim = buf + 0x800;\n"
                        '        __asm__("" : "=r"(lim) : "0"(lim));\n'
                        "        end = lim;\n    }\n    while (rec < end) {\n")],
}

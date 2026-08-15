TU = "recon/syslib/psx/libapi/FIRST.c"
FUNC = "firstfile"
EXTRA_FUNCS = ["_first_patch"]

INIT = """    p = _first_devname;
    scan = (signed char *)name;
"""
SWAP = """    scan = (signed char *)name;
    p = _first_devname;
"""
F = lambda *o: '    __asm__("" : : %s);\n' % ", ".join('"r"(%s)' % x for x in o)
ID = lambda v: '    __asm__("" : "=r"(%s) : "0"(%s));\n' % (v, v)

VARIANTS = {
    "ctl":         [],
    "swap":        [(INIT, SWAP)],
    "swap_fp":     [(INIT, SWAP + F("p"))],
    "swap_fp2":    [(INIT, SWAP + F("p", "p"))],
    "swap_fs":     [(INIT, SWAP + F("scan"))],
    "swap_fs2":    [(INIT, SWAP + F("scan", "scan"))],
    "swap_idp":    [(INIT, SWAP + ID("p"))],
    "swap_ids":    [(INIT, SWAP + ID("scan"))],
    "swap_fp_pre": [(INIT, "    scan = (signed char *)name;\n" + F("p").replace("p", "name") + "    p = _first_devname;\n")],
}

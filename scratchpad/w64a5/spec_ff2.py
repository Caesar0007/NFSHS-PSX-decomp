TU = "recon/syslib/psx/libapi/FIRST.c"
FUNC = "firstfile"
EXTRA_FUNCS = ["_first_patch"]

BLK = """    p = _first_devname;
    scan = (signed char *)name;
    while (*scan > ':')
        *p++ = (unsigned char)*scan++;
    *p = '\\0';
"""
F = lambda *o: '    __asm__("" : : %s);\n' % ", ".join('"r"(%s)' % x for x in o)


def mk(swap=True, s1="", s2="", s3="", body=""):
    a = "    scan = (signed char *)name;\n    p = _first_devname;\n" if swap else \
        "    p = _first_devname;\n    scan = (signed char *)name;\n"
    s = a + s1
    if body:
        s += "    while (*scan > ':') {\n" + "    " + body + \
             "        *p++ = (unsigned char)*scan++;\n    }\n"
    else:
        s += "    while (*scan > ':')\n        *p++ = (unsigned char)*scan++;\n"
    s += s2 + "    *p = '\\0';\n" + s3
    return s


VARIANTS = {
    "swap":        [(BLK, mk())],
    "sw_s2_scan":  [(BLK, mk(s2=F("scan")))],
    "sw_s3_scan":  [(BLK, mk(s3=F("scan")))],
    "sw_s2_scan2": [(BLK, mk(s2=F("scan", "scan")))],
    "sw_s2_p":     [(BLK, mk(s2=F("p")))],
    "sw_s3_p":     [(BLK, mk(s3=F("p")))],
    "sw_s2_np":    [(BLK, mk(s2=F("name")))],
    "no_s2_scan":  [(BLK, mk(swap=False, s2=F("scan")))],
    "no_s3_scan":  [(BLK, mk(swap=False, s3=F("scan")))],
    "no_s2_p":     [(BLK, mk(swap=False, s2=F("p")))],
}

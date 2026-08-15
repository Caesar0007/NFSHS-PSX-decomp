TU = "recon/syslib/psx/libcd/iso9660.c"
FUNC = "CD_newmedia"
EXTRA_FUNCS = []

RO_BUF = '    __asm__("" : : "r"(buf));\n'
ID_BUF = '    __asm__("" : "=r"(buf) : "0"(buf));\n'
LAUNDER = [(RO_BUF, ID_BUF)]

BLK = """    idx = 0;
    rec = buf;
    end = buf + 0x800;
    while (rec < end) {
"""
ID_END = '    __asm__("" : "=r"(end) : "0"(end));\n'
RO_END = '    __asm__("" : : "r"(end));\n'
RO_REC = '    __asm__("" : : "r"(rec));\n'

VARIANTS = {
    "L":          LAUNDER,
    "L_id_end":   LAUNDER + [(BLK, "    idx = 0;\n    rec = buf;\n    end = buf + 0x800;\n"
                                   + ID_END + "    while (rec < end) {\n")],
    "L_ro_end":   LAUNDER + [(BLK, "    idx = 0;\n    rec = buf;\n    end = buf + 0x800;\n"
                                   + RO_END + "    while (rec < end) {\n")],
    "L_ro_rec":   LAUNDER + [(BLK, "    idx = 0;\n    rec = buf;\n    end = buf + 0x800;\n"
                                   + RO_REC + "    while (rec < end) {\n")],
    "L_eri":      LAUNDER + [(BLK, "    end = buf + 0x800;\n    rec = buf;\n    idx = 0;\n"
                                   "    while (rec < end) {\n")],
    "L_rei":      LAUNDER + [(BLK, "    rec = buf;\n    end = buf + 0x800;\n    idx = 0;\n"
                                   "    while (rec < end) {\n")],
    "L_end_rec":  LAUNDER + [(BLK, "    idx = 0;\n    end = buf + 0x800;\n    rec = buf;\n"
                                   "    while (rec < end) {\n")],
}

TU = "recon/syslib/psx/libcd/iso9660.c"
FUNC = "CD_newmedia"
EXTRA_FUNCS = []

RO_BUF = '    __asm__("" : : "r"(buf));\n'
ID_BUF = '    __asm__("" : "=r"(buf) : "0"(buf));\n'
PT = "    pt_lba = *(RawWord *)(buf + 140);"

VARIANTS = {
    "ctl":        [],
    "id_only":    [(RO_BUF, ID_BUF)],
    "ro_plus_id": [(PT, ID_BUF.rstrip("\n").strip() + "\n" + PT)],
    "id_plus_id": [(RO_BUF, ID_BUF), (PT, ID_BUF.rstrip("\n").strip() + "\n" + PT)],
    "ro_then_ro": [(PT, RO_BUF.rstrip("\n").strip() + "\n" + PT)],
}

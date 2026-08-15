TU = "recon/syslib/psx/libcd/drv.c"
FUNC = "CD_cw"
EXTRA_FUNCS = []

LOOP = """    cnt = tbl + 0x40;
    i = 0;
    if (cnt[com] > 0)
        do {
            CDREG2 = param[i];
            i++;
        } while (i < cnt[com]);
"""
# xenogears-decomp src/slus_006.64/psyq/libcd/bios.c:378 CD_cw (matched, zero INCLUDE_ASM):
#   for (i = 0; i < ComAttr[0x40 + arg0]; ++i) { *reg2 = arg1[i]; }
XG_FOR = """    cnt = tbl + 0x40;
    for (i = 0; i < cnt[com]; i++)
        CDREG2 = param[i];
"""
XG_FOR_TBL = """    for (i = 0; i < tbl[0x40 + com]; i++)
        CDREG2 = param[i];
"""
XG_GUARD_FOR = """    cnt = tbl + 0x40;
    i = 0;
    if (cnt[com] > 0)
        for (; i < cnt[com]; i++)
            CDREG2 = param[i];
"""

VARIANTS = {
    "ctl":        [],
    "xg_for":     [(LOOP, XG_FOR)],
    "xg_for_tbl": [(LOOP, XG_FOR_TBL)],
    "xg_gfor":    [(LOOP, XG_GUARD_FOR)],
}

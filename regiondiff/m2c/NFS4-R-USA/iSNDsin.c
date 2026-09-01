/* NFS4-R-USA CHANGED @8010D89C | base 8010CC40 iSNDsin */
/* callers: iSNDlibatodlrv */
u16 func_8010D89C(s32 arg0) {
    s32 temp_a0;
    s32 temp_v1;
    s32 var_v0;

    temp_v1 = (arg0 >> 8) & 3;
    temp_a0 = arg0 & 0xFF;
    switch (temp_v1) {                              /* irregular */
    case 0:
        var_v0 = temp_a0 * 2;
        return *(0x8013D638 + var_v0);
    case 1:
        var_v0 = (0x100 - temp_a0) * 2;
        /* Duplicate return node #2. Try simplifying control flow for better match */
        return *(0x8013D638 + var_v0);
    default:
        return (u16) -(s32) *(0x8013D638 + ((0x100 - temp_a0) * 2));
    case 2:
        return (u16) -(s32) *(0x8013D638 + (temp_a0 * 2));
    }
}

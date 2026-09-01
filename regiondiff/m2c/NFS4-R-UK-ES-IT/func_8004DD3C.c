/* NFS4-R-UK-ES-IT REGION-ONLY @8004DD3C */
/* callers: Redraw__14tFEApplication */
? func_800EECDC(s32 *, void *, s32, void *);        /* extern */

void func_8004DD3C(s16 arg0, s32 arg1) {
    s32 *temp_a0;
    s32 *temp_a1;
    s32 temp_a2;
    void *temp_a3;

    *(s16 *)0x800532F4 = arg0;
    temp_a3 = (s16 *)0x80050000 + 0x32F4;
    temp_a3->unk2 = (s16) (arg1 + (*(s32 *)0x8013EAC8 << 8));
    temp_a0 = *(s32 **)0x1F800004;
    temp_a1 = *(s32 **)0x1F800000;
    *temp_a0 = (*temp_a0 & 0xFF000000) | (*temp_a1 & 0xFFFFFF);
    temp_a2 = (s32) temp_a0 & 0xFFFFFF;
    *(s32 **)0x1F800004 = temp_a0 + 0xC;
    *temp_a1 = (*temp_a1 & 0xFF000000) | temp_a2;
    func_800EECDC(temp_a0, temp_a3, temp_a2, temp_a3);
}

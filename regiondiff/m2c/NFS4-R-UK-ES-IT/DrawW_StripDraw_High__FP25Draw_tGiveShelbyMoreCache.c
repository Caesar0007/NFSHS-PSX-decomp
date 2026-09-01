/* NFS4-R-UK-ES-IT CHANGED @800C7C5C | base 800C6EB8 DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache */
/* callers: DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry, DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry */
? func_800C72B4(void *, u16 *);                     /* extern */

void func_800C7C5C(void *arg0) {
    u16 sp10;
    s8 sp12;
    s8 sp13;
    s8 sp14;
    s8 sp15;
    s32 var_s0;
    s8 temp_v0_3;
    s8 temp_v1;
    u16 *var_s2;
    u16 temp_v0;
    u16 temp_v0_2;
    u8 temp_s3;
    void *var_s1;

    var_s1 = arg0->unk100;
    arg0->unkDA = 1;
loop_1:
    temp_v0 = arg0->unk104 - 1;
    arg0->unk104 = temp_v0;
    var_s0 = 0;
    if ((s16) temp_v0 != -1) {
        temp_s3 = var_s1->unk2;
        var_s2 = var_s1 + 4;
loop_3:
        if (var_s0 < (s32) temp_s3) {
            temp_v0_2 = *var_s2;
            var_s2 += 2;
            sp10 = temp_v0_2;
            temp_v0_3 = var_s1->unk0 + var_s0;
            sp13 = temp_v0_3;
            temp_v1 = var_s1->unk1 + var_s0;
            sp14 = temp_v1;
            sp12 = temp_v0_3 + 1;
            sp15 = temp_v1 + 1;
            func_800C72B4(arg0, &sp10);
            var_s0 += 1;
            goto loop_3;
        }
        var_s1 += var_s1->unk3;
        goto loop_1;
    }
}

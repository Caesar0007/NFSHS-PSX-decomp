/* NFS4-R-UK-ES-IT CHANGED @8007E71C | base 8007DD74 SetupChunkBuildList__FP13DRender_tView */
/* callers: BWorld_OnyxBuildFacets__FP13DRender_tView */
s32 func_8007DF6C(void *, s32);                     /* extern */
s8 func_8007E6FC(s32);                              /* extern */
? func_800E2784(? *);                               /* extern */
? func_800E27D4();                                  /* extern */
? func_800E2804(s32 *, ? *);                        /* extern */
? func_800E2890(s32, s32 *, ?);                     /* extern */

s32 func_8007E71C(void *arg0) {
    s32 sp10;
    s32 sp40;
    s32 sp44;
    s32 sp48;
    ? sp50;
    s32 sp60;
    s32 sp64;
    s16 temp_s2;
    s32 temp_a2;
    s32 temp_s0_2;
    s32 temp_v0;
    s32 var_s5;
    s32 var_s6;
    u16 *var_s3;
    void *temp_s0;
    void *temp_v1;
    void *var_s1;

    temp_v1 = saved_reg_gp->unk248;
    var_s6 = 0;
    sp64 = temp_v1->unk8C;
    temp_a2 = temp_v1->unk88;
    sp60 = (s32) *(*(s32 *)0x8013E7C0 + temp_a2);
    if ((u32) (*(s32 *)0x8011450C - 8) < 3U) {
        if ((temp_a2 < 5) || (var_s5 = 0, ((((*(void **)0x8013E7C4)->unk1C - 5) < temp_a2) != 0))) {
            sp64 = 0x1FA40;
            goto block_4;
        }
    } else {
block_4:
        var_s5 = 0;
    }
    var_s3 = *(s32 *)0x8013E7BC + (temp_a2 << 6);
    var_s1 = (0 * 4) + 0x801102DC;
loop_6:
    if (var_s5 < sp60) {
        temp_s2 = *var_s3 & 0x3FF;
        temp_s0 = *(s32 *)0x8013DB3C + (temp_s2 * 0xC);
        temp_v0 = func_8007DF6C(temp_s0, arg0 + 8);
        if ((sp64 >= temp_v0) && !(*var_s3 & 0x800) && ((sp40 = temp_s0->unk0 - arg0->unk8, sp44 = ((temp_s2 << 8) + *(s32 *)0x8013DAE0)->unk4 - arg0->unkC, sp48 = temp_s0->unk8 - arg0->unk10, temp_s0_2 = *(s32 *)0x8013E7C8 + (temp_s2 * 0x70), func_800E27D4(), func_800E2804(&sp40, &sp50), func_800E2784(&sp50), func_800E2890(temp_s0_2, &sp10, 4), ((sp18 < sp10) == 0)) || (sp24 >= sp1C) || (sp30 >= sp28) || (sp3C >= sp34)) && ((sp18 >= -sp10) || (sp24 >= -sp1C) || (sp30 >= -sp28) || (sp3C >= -sp34)) && ((sp18 >= 0) || (sp24 >= 0) || (sp30 >= 0) || (sp3C >= 0))) {
            var_s1->unk3 = 3U;
            if (temp_v0 < saved_reg_gp->unk248->unk98) {
                var_s1->unk3 = 7U;
            }
            if (*var_s3 & 0x4000) {
                var_s1->unk3 = (u8) (var_s1->unk3 & 0xFD);
            }
            if (*var_s3 & 0x2000) {
                var_s1->unk3 = (u8) (var_s1->unk3 & 0xFE);
            }
            var_s1->unk2 = func_8007E6FC(temp_v0);
            var_s1->unk0 = temp_s2;
            var_s1 += 4;
            var_s6 += 1;
        }
        var_s3 += 2;
        var_s5 += 1;
        goto loop_6;
    }
    return var_s6;
}

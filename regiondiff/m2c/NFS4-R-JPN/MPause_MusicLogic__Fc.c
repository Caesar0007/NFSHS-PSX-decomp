/* NFS4-R-JPN CHANGED @8009EEAC | base 8009E3E8 MPause_MusicLogic__Fc */
/* callers: MPause_Logic__Fv */
s32 func_80076E60(s32);                             /* extern */
s32 func_80078D5C(s32, ?, ?, s32, s32);             /* extern */
? func_8007BC44(s32);                               /* extern */
? func_8007BE00(?, s32);                            /* extern */
s32 func_800E84EC(s32);                             /* extern */
? func_800E8858(s32);                               /* extern */
? func_800F0944(? *);                               /* extern */
? func_800F0A00(? *);                               /* extern */

void func_8009EEAC(u8 arg0) {
    ? sp18;
    u8 sp28;
    s32 *temp_a0;
    s32 temp_v1;
    s32 temp_v1_2;
    s32 var_a0;
    s32 var_s0;
    s32 var_v0;

    var_s0 = 1;
    func_800F0944(&sp18);
    temp_v1 = *(s32 *)0x8011437C;
    if (temp_v1 != 1) {
        if (temp_v1 < 2) {
            var_v0 = arg0 & 0xFF;
            if (temp_v1 != 0) {

            } else {
                *(s32 *)0x8013D754 = 1;
                if (sp28 == 1) {
                    sp28 = 2;
                    goto block_10;
                }
                goto block_11;
            }
        } else {
            var_v0 = arg0 & 0xFF;
            if (temp_v1 != 2) {

            } else {
                *(void *)0x8013D754 = 1;
                if (sp28 == 1) {
                    sp28 = (u8) temp_v1;
                    func_800F0A00(&sp18);
                }
                *(s32 *)0x8013E5D0 = 1;
                var_v0 = arg0 & 0xFF;
            }
        }
    } else {
        *(void *)0x8013D754 = 0;
        if (sp28 == 2) {
            sp28 = 1;
block_10:
            func_800F0A00(&sp18);
        }
block_11:
        *(void *)0x8013E5D0 = 0;
        var_v0 = arg0 & 0xFF;
    }
    if (var_v0 != 0) {
        if (saved_reg_gp->unkCF0 == 0) {
            func_8007BE00(0x1F4, func_80076E60(*(s32 *)0x8013D730));
        }
        temp_v1_2 = *saved_reg_gp->unk188C;
        var_a0 = 0;
        if ((temp_v1_2 == 1) || (temp_v1_2 == 2)) {
            var_a0 = 1;
        }
        if (var_a0 != 0) {
            func_8007BC44(func_80076E60(*(void *)0x8013D730));
        }
        temp_a0 = saved_reg_gp->unk188C;
        saved_reg_gp->unkCF1 = 0U;
        if (*temp_a0 == 3) {
            saved_reg_gp->unkCF1 = 1U;
            saved_reg_gp->unkCF4 = (s32) *(s32 *)0x8013D734;
        }
        if (*temp_a0 == 4) {
            saved_reg_gp->unkCF1 = 1U;
            saved_reg_gp->unkCF4 = (s32) *(s32 *)0x8013D73C;
        }
        if (*temp_a0 == 5) {
            saved_reg_gp->unkCF1 = 1U;
            saved_reg_gp->unkCF4 = (s32) *(s32 *)0x8013D738;
        }
        if (*temp_a0 == 6) {
            saved_reg_gp->unkCF1 = 1U;
            saved_reg_gp->unkCF4 = (s32) *(s32 *)0x8013D740;
        }
        if (saved_reg_gp->unkCF1 != 0) {
            if (saved_reg_gp->unkCF2 == 0) {
                saved_reg_gp->unkCF2 = 1U;
            } else {
                var_s0 = func_800E84EC(saved_reg_gp->unkCF8);
            }
            if ((var_s0 != 0) && ((*(s32 *)0x8013ED78 - saved_reg_gp->unkCFC) >= 0xC1)) {
                saved_reg_gp->unkCFC = (s32) *(void *)0x8013ED78;
                saved_reg_gp->unkCF8 = func_80078D5C(*(s32 *)0x8010F97C, 0x10, 0, saved_reg_gp->unkCF4, 0x40);
            }
        } else if (saved_reg_gp->unkCF2 == 1) {
            func_800E8858(saved_reg_gp->unkCF8);
            saved_reg_gp->unkCF2 = 0U;
        }
    } else if (saved_reg_gp->unkCF0 != 0) {
        func_800E8858(saved_reg_gp->unkCF8);
        func_8007BE00(0x1F4, 0);
    }
    saved_reg_gp->unkCF0 = arg0;
}

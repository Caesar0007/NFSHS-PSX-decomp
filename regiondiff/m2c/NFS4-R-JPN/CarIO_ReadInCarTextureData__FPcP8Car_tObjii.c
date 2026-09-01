/* NFS4-R-JPN CHANGED @800BD2A0 | base 800BC704 CarIO_ReadInCarTextureData__FPcP8Car_tObjii */
/* callers: R3DCar_Instantiate3DCar__FP8Car_tObji, R3DCar_Instantiate3DCar__FP8Car_tObji, R3DCar_Instantiate3DCar__FP8Car_tObji, R3DCar_Instantiate3DCar__FP8Car_tObji, R3DCar_ReadInCarTextureMenu__FP8Car_tObjPcii */
? func_800BD204(s32, s32 *, s32 *, void *, s32);    /* extern */
? func_800BF240(s32, ?);                            /* extern */
? func_800E0070(s32, s32);                          /* extern */
? func_800E0910(?, s32, s32, s32, s32, s32, u32, s32); /* extern */
s32 func_800EB8B8(s32, s32);                        /* extern */

void func_800BD2A0(s32 arg0, void *arg1, s32 arg2, s32 arg3) {
    s32 sp20;
    s32 sp24;
    s32 sp28;
    s32 sp2C;
    s32 sp30;
    s32 sp34;
    s32 sp38;
    s32 sp3C;
    s32 sp40;
    s32 sp44;
    s32 sp48;
    s32 sp4C;
    s32 *sp50;
    s32 *sp54;
    void *sp58;
    s16 temp_t1;
    s16 var_s6;
    s16 var_s7;
    s32 temp_a1;
    s32 temp_s0;
    s32 temp_s0_2;
    s32 temp_t1_2;
    s32 temp_v0_3;
    s32 temp_v0_4;
    s32 temp_v0_5;
    s32 temp_v1;
    s32 temp_v1_3;
    s32 temp_v1_4;
    s32 temp_v1_7;
    s32 var_a0;
    s32 var_s0;
    s32 var_s0_2;
    s32 var_s1;
    s32 var_s1_2;
    s32 var_s2;
    s32 var_s3;
    s32 var_s4;
    s32 var_v0;
    s32 var_v1;
    u16 temp_a0;
    u16 temp_a0_2;
    u16 temp_a0_3;
    u16 temp_a0_4;
    u16 temp_v0;
    u16 temp_v0_2;
    u16 temp_v1_2;
    u32 temp_s5;
    void *temp_v1_5;
    void *temp_v1_6;
    void *temp_v1_8;
    void *temp_v1_9;
    void *var_a1;
    void *var_s8;
    void *var_t0;

    var_a0 = arg0;
    var_a1 = arg1;
    sp48 = 8;
    temp_t1 = var_a1->unk8BC;
    sp40 = (s32) temp_t1;
    if (!(arg2 & 1)) {
        if (*(s32 *)0x8013E3F4 == 0) {
            var_a0 = saved_reg_gp->unk11EC;
            temp_v1 = var_a0 * 4;
            temp_v0 = *(0x8011FB44 + temp_v1);
            var_a1->unk8C4 = temp_v0;
            var_s6 = (s16) temp_v0;
            temp_v1_2 = (temp_v1 + 0x8011FB44)->unk2;
            var_s7 = (s16) temp_v1_2;
            arg1->unk8C6 = temp_v1_2;
            if (temp_t1 < 0x1C) {
                if (arg1->unk8C0 & 1) {
                    saved_reg_gp->unk11EC = (s32) (var_a0 + (*(0x8011FBA4 + ((saved_reg_gp->unk11EC / 3) * 2)) * 3));
                } else {
                    saved_reg_gp->unk11EC = (s32) (var_a0 + 3);
                }
            } else {
                saved_reg_gp->unk11EC = (s32) (var_a0 + 1);
            }
        } else {
            temp_a1 = saved_reg_gp->unk11EC;
            temp_v1_3 = temp_a1 * 4;
            temp_v0_2 = *(0x8011FB8C + temp_v1_3);
            arg1->unk8C4 = temp_v0_2;
            var_s6 = (s16) temp_v0_2;
            temp_a0 = (temp_v1_3 + 0x8011FB8C)->unk2;
            arg1->unk8C6 = temp_a0;
            var_a0 = temp_a0 << 0x10;
            var_a1 = temp_a1 + *(0x8011FBA4 + (temp_a1 * 2));
            saved_reg_gp->unk11EC = (s32) var_a1;
            var_s7 = (s16) temp_a0;
        }
    } else {
        var_s6 = (s16) arg1->unk8C4;
        var_s7 = (s16) arg1->unk8C6;
    }
    if (!(arg2 & 0x10)) {
        temp_v0_3 = saved_reg_gp->unk11E8;
        sp44 = temp_v0_3;
        arg1->unk844 = temp_v0_3;
    } else {
        sp44 = arg1->unk844;
    }
    if (arg2 & 8) {
        var_v0 = var_s6 & 0x3F;
        if (arg1->unk8C0 & 1) {
            var_v1 = var_s6 - 0x200;
            if (*(void *)0x8013E3F4 == 0) {
                var_v1 = var_s6 - 0x280;
            }
            var_s6 += *(0x8011FBB0 + ((var_v1 >> 6) * 2));
            var_v0 = var_s6 & 0x3F;
        }
        arg1->unk8C8 = (s16) (var_v0 * 4);
        arg1->unk8CA = (s16) (var_s7 & 0xFF);
    }
    var_s4 = 0;
    if (*(void *)0x8013E3F4 == 0) {
        sp48 |= 0x10;
    }
    *(s32 *)0x8013EBD8 = arg1->unk884;
    var_s2 = sp44 * 0x10;
    func_800E0070(var_a0, (s32) var_a1);
    temp_v1_4 = arg3 * 4;
    sp50 = temp_v1_4 + 0x8013E81C;
    var_t0 = arg1;
    var_s8 = (void *)0x8011F8E0;
    sp54 = temp_v1_4 + 0x8013E824;
loop_21:
    sp58 = var_t0;
    if (var_s4 < 0x33) {
        var_s1 = 1;
        temp_t1_2 = var_s8->unk8;
        var_s3 = func_800EB8B8(arg0, var_s8->unk4);
        sp4C = temp_t1_2;
        if (var_s3 == 0) {
            if (temp_t1_2 == 0) {
                var_s1 = 0;
                var_s3 = func_800EB8B8(arg0, var_s8->unk0);
            }
        }
        if (var_s4 == 0x14) {
            sp48 = 0;
        }
        if (var_s3 != 0) {
            temp_v0_4 = sp40 * 0xC;
            temp_v1_5 = temp_v0_4 + 0x8011FBBC;
            temp_a0_2 = *(0x8011FBBC + temp_v0_4);
            var_s0 = 0;
            if (sp48 != 0) {
                sp58->unk88A = (u16) *(u16 *)0x8013EBDC;
            }
            if ((sp40 < 0x16) && ((s16) temp_a0_2 >= 0)) {
                if (var_s4 == (s16) temp_a0_2) {
                    sp20 = var_s6 + temp_v1_5->unk2;
                    sp24 = var_s7 + temp_v1_5->unk4;
                    func_800BD204(arg2, &sp20, &sp24, arg1, 0);
                    func_800E0910(0, *sp50, sp48, sp20, sp24, -1, -1U, saved_reg_gp->unk11C8 + var_s2);
                    var_s0 = 1;
                    (var_s2 + saved_reg_gp->unk11C8)->unkE = 1;
                } else if (var_s4 == temp_v1_5->unk6) {
                    sp28 = var_s6 + temp_v1_5->unk8;
                    sp2C = var_s7 + temp_v1_5->unkA;
                    func_800BD204(arg2, &sp28, &sp2C, arg1, 1);
                    func_800E0910(0, *sp54, sp48, sp28, sp2C, -1, -1U, saved_reg_gp->unk11C8 + var_s2);
                    var_s0 = 1;
                    (var_s2 + saved_reg_gp->unk11C8)->unkE = 2;
                }
            }
            if (var_s0 == 0) {
                func_800E0910(0, var_s3, sp48, (s32) var_s6, (s32) var_s7, -1, -1U, saved_reg_gp->unk11C8 + var_s2);
            }
            if (var_s4 == 0x20) {
                func_800BF240(saved_reg_gp->unk11C8 + var_s2 + 6, 2);
            }
            temp_v1_6 = var_s2 + saved_reg_gp->unk11C8;
            temp_v1_6->unkE = (u16) (temp_v1_6->unkE | 0x80);
        }
        if (var_s1 != 0) {
            var_s0_2 = sp44;
            if (sp4C != 0) {
                temp_s0 = sp4C - 1;
                if (sp48 != 0) {
                    sp58->unk88A = (u16) (arg1 + (temp_s0 * 2))->unk88A;
                }
                var_s0_2 = temp_s0 + arg1->unk844;
            }
            temp_v0_5 = func_800EB8B8(arg0, var_s8->unk0);
            if (temp_v0_5 != 0) {
                temp_v1_7 = sp40 * 0xC;
                temp_a0_3 = ((var_s0_2 * 0x10) + saved_reg_gp->unk11C8)->unk2;
                temp_v1_8 = temp_v1_7 + 0x8011FBBC;
                temp_s0_2 = (temp_a0_3 & 0x3F) * 0x10;
                temp_s5 = temp_a0_3 >> 6;
                temp_a0_4 = *(0x8011FBBC + temp_v1_7);
                var_s1_2 = 0;
                if ((sp40 < 0x16) && ((s16) temp_a0_4 >= 0)) {
                    if (var_s4 == (s16) temp_a0_4) {
                        sp30 = var_s6 + temp_v1_8->unk2;
                        sp34 = var_s7 + temp_v1_8->unk4;
                        func_800BD204(arg2, &sp30, &sp34, arg1, 0);
                        func_800E0910(0, *sp50, 0x20, sp30, sp34, temp_s0_2, temp_s5, saved_reg_gp->unk11C8 + var_s2);
                        var_s1_2 = 1;
                        (var_s2 + saved_reg_gp->unk11C8)->unkE = 1;
                    } else if (var_s4 == temp_v1_8->unk6) {
                        sp38 = var_s6 + temp_v1_8->unk8;
                        sp3C = var_s7 + temp_v1_8->unkA;
                        func_800BD204(arg2, &sp38, &sp3C, arg1, 1);
                        func_800E0910(0, *sp54, 0x20, sp38, sp3C, temp_s0_2, temp_s5, saved_reg_gp->unk11C8 + var_s2);
                        var_s1_2 = 1;
                        (var_s2 + saved_reg_gp->unk11C8)->unkE = 2;
                    }
                }
                if (var_s1_2 == 0) {
                    func_800E0910(0, temp_v0_5, 0x20, (s32) var_s6, (s32) var_s7, temp_s0_2, temp_s5, saved_reg_gp->unk11C8 + var_s2);
                }
                if (var_s4 == 0x20) {
                    func_800BF240(saved_reg_gp->unk11C8 + var_s2 + 6, 2);
                }
                if (sp4C == 0) {
                    temp_v1_9 = var_s2 + saved_reg_gp->unk11C8;
                    temp_v1_9->unkE = (u16) (temp_v1_9->unkE | 0x80);
                }
            }
        }
        var_s2 += 0x10;
        var_s8 += 0xC;
        var_s4 += 1;
        var_t0 = sp58 + 2;
        sp44 += 1;
        goto loop_21;
    }
    if (arg2 & 0x80) {
        saved_reg_gp->unk11E8 = sp44;
    }
}

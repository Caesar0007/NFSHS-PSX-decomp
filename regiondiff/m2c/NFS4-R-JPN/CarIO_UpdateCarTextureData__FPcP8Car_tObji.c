/* NFS4-R-JPN CHANGED @800BDA58 | base 800BCEB0 CarIO_UpdateCarTextureData__FPcP8Car_tObji */
/* callers: R3DCar_Instantiate3DCar__FP8Car_tObji, DrawC_MenuColorData__FiP8Car_tObji */
? func_800BF240(s32, ?);                            /* extern */
? func_800E0070();                                  /* extern */
? func_800E0910(?, s32, s32, s32, s32, s32, u32, s32); /* extern */
s32 func_800EB8B8(s32, s32);                        /* extern */

void func_800BDA58(s32 arg0, void *arg1, s32 arg2) {
    s32 sp20;
    s32 sp24;
    s32 sp28;
    s32 sp2C;
    s32 sp30;
    s32 sp34;
    s32 sp38;
    void *sp3C;
    s16 var_a3;
    s16 var_a3_2;
    s32 temp_s0;
    s32 temp_s3;
    s32 temp_s3_2;
    s32 temp_t0;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 var_s0;
    s32 var_s0_2;
    s32 var_s0_3;
    s32 var_s1;
    s32 var_s5;
    s32 var_s6;
    s32 var_s8;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v1;
    u16 temp_v1;
    u16 temp_v1_2;
    u16 temp_v1_4;
    u16 temp_v1_5;
    u32 temp_s4;
    u32 temp_s4_2;
    void *temp_a1;
    void *temp_s2;
    void *temp_v1_3;
    void *temp_v1_6;
    void *var_s7;
    void *var_t0;

    sp2C = arg1->unk844;
    sp20 = (s32) arg1->unk8BC;
    sp24 = (s32) arg1->unk8C4;
    var_s8 = 8;
    sp28 = (s32) arg1->unk8C6;
    if (*(s32 *)0x8013E3F4 == 0) {
        var_s8 = 0x18;
    }
    var_s6 = 0;
    *(s32 *)0x8013EBD8 = arg1->unk884;
    var_s5 = sp2C * 0x10;
    func_800E0070();
    sp38 = arg2 * 4;
    temp_v0 = sp20 * 0xC;
    temp_s2 = temp_v0 + 0x8011FBBC;
    var_t0 = arg1;
    var_s7 = (void *)0x8011F8E0;
loop_3:
    sp3C = var_t0;
    if (var_s6 < 0x33) {
        sp34 = 1;
        temp_t0 = var_s7->unk8;
        var_s1 = func_800EB8B8(arg0, var_s7->unk4);
        sp30 = temp_t0;
        if (var_s1 == 0) {
            if (temp_t0 == 0) {
                sp34 = 0;
                var_s1 = func_800EB8B8(arg0, var_s7->unk0);
            }
        }
        if (var_s6 == 0x14) {
            var_s8 = 0;
        }
        if (var_s1 != 0) {
            temp_a1 = var_s5 + saved_reg_gp->unk11C8;
            var_s0 = 0;
            if (temp_a1->unkE & 0x80) {
                temp_v1 = temp_a1->unk2;
                temp_s4 = temp_v1 >> 6;
                temp_v1_2 = *(0x8011FBBC + temp_v0);
                temp_s3 = (temp_v1 & 0x3F) * 0x10;
                if (var_s8 != 0) {
                    *(s32 *)0x8013EBDC = (s32) sp3C->unk88A;
                }
                if ((sp20 < 0x16) && ((s16) temp_v1_2 >= 0)) {
                    if (var_s6 == (s16) temp_v1_2) {
                        var_s0 = 1;
                        var_a3 = temp_s2->unk2;
                        var_v0 = 0x8013E81C;
                        goto block_20;
                    }
                    if (var_s6 == temp_s2->unk6) {
                        var_s0 = 1;
                        var_a3 = temp_s2->unk8;
                        var_v0 = 0x8013E824;
block_20:
                        func_800E0910(0, *(sp38 + var_v0), var_s8, sp24 + var_a3);
                    }
                }
                if (var_s0 == 0) {
                    func_800E0910(0, var_s1, var_s8, sp24, sp28, temp_s3, temp_s4, saved_reg_gp->unk11C8 + var_s5);
                }
                if (var_s6 == 0x20) {
                    func_800BF240(saved_reg_gp->unk11C8 + var_s5 + 6, 2);
                }
                temp_v1_3 = var_s5 + saved_reg_gp->unk11C8;
                temp_v1_3->unkE = (u16) (temp_v1_3->unkE | 0x80);
                goto block_26;
            }
        } else {
block_26:
            if (sp34 != 0) {
                var_s0_2 = sp2C;
                if (sp30 != 0) {
                    temp_s0 = sp30 - 1;
                    if (var_s8 != 0) {
                        sp3C->unk88A = (s16) (arg1 + (temp_s0 * 2))->unk88A;
                    }
                    var_s0_2 = temp_s0 + arg1->unk844;
                }
                temp_v0_2 = func_800EB8B8(arg0, var_s7->unk0);
                if (temp_v0_2 != 0) {
                    temp_v1_4 = ((var_s0_2 * 0x10) + saved_reg_gp->unk11C8)->unk2;
                    temp_s3_2 = (temp_v1_4 & 0x3F) * 0x10;
                    temp_s4_2 = temp_v1_4 >> 6;
                    temp_v1_5 = *(0x8011FBBC + temp_v0);
                    var_s0_3 = 0;
                    if ((sp20 < 0x16) && ((s16) temp_v1_5 >= 0)) {
                        if (var_s6 == (s16) temp_v1_5) {
                            var_s0_3 = 1;
                            var_a3_2 = temp_s2->unk2;
                            var_v1 = sp28 + temp_s2->unk4;
                            var_v0_2 = 0x8013E81C;
                            goto block_38;
                        }
                        if (var_s6 == temp_s2->unk6) {
                            var_s0_3 = 1;
                            var_a3_2 = temp_s2->unk8;
                            var_v1 = sp28 + temp_s2->unkA;
                            var_v0_2 = 0x8013E824;
block_38:
                            func_800E0910(0, *(sp38 + var_v0_2), 0x20, sp24 + var_a3_2, var_v1, temp_s3_2, temp_s4_2);
                        }
                    }
                    if (var_s0_3 == 0) {
                        func_800E0910(0, temp_v0_2, 0x20, sp24, sp28, temp_s3_2, temp_s4_2, saved_reg_gp->unk11C8 + var_s5);
                    }
                    if (var_s6 == 0x20) {
                        func_800BF240(saved_reg_gp->unk11C8 + var_s5 + 6, 2);
                    }
                    if (sp30 == 0) {
                        temp_v1_6 = var_s5 + saved_reg_gp->unk11C8;
                        temp_v1_6->unkE = (u16) (temp_v1_6->unkE | 0x80);
                    }
                }
            }
        }
        var_s5 += 0x10;
        var_s7 += 0xC;
        sp2C += 1;
        var_s6 += 1;
        var_t0 = sp3C + 2;
        goto loop_3;
    }
}

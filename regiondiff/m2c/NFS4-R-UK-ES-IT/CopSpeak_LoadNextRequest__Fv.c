/* NFS4-R-UK-ES-IT CHANGED @8009B220 | base 8009A634 CopSpeak_LoadNextRequest__Fv */
s32 func_80077300(s8, s32, ?);                      /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
? func_8009A16C(void *);                            /* extern */
? func_8009B034();                                  /* extern */
s32 func_8009B1F0(void *);                          /* extern */
s32 func_800EC764(s32);                             /* extern */
s32 func_800ECE34(s32, s32, s32, s32, s32, s32);    /* extern */

void func_8009B220(void) {
    s32 temp_a1;
    s32 temp_a1_2;
    s32 temp_s0;
    s32 temp_t0;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 var_v1;
    s8 temp_a0;
    void *temp_s0_2;

    temp_s0 = func_8007AA48();
    if (temp_s0 >= func_8007A9C4()) {
loop_1:
        temp_a1 = saved_reg_gp->unkB70;
        if ((temp_a1 != saved_reg_gp->unkB60) && (((temp_a1 - (saved_reg_gp->unkB74 - 0x40)) & 0x3F) < 8)) {
            temp_s0_2 = (temp_a1 << 5) + 0x80113214;
            temp_a0 = temp_s0_2->unk1E;
            if (temp_a0 >= 0) {
                if (temp_a0 == 3) {
                    temp_s0_2->unk4 = -1;
                    var_v1 = 0;
                    if (temp_a1 < 0x3F) {
                        var_v1 = temp_a1 + 1;
                    }
                    goto block_27;
                }
                if (temp_s0_2->unk1D == 0) {
                    temp_a1_2 = temp_s0_2->unk18;
                    if (temp_a1_2 >= 0) {
                        var_v1 = 0;
                        if (func_80077300(temp_a0, temp_a1_2, 1) >= 0) {
                            temp_s0_2->unk4 = -1;
                            goto block_25;
                        }
                        goto block_12;
                    }
block_12:
                    if (temp_s0_2->unk1D == 0) {
                        var_v1 = 0;
                        if (func_80077300(temp_s0_2->unk1E, temp_s0_2->unk8 + 0x4000, 1) >= 0) {
                            temp_s0_2->unk4 = -1;
                            goto block_25;
                        }
                    }
                    goto block_15;
                }
block_15:
                if ((saved_reg_gp->unkB80 == 0) || (func_8009B1F0(temp_s0_2) == 0) || (temp_v0 = temp_s0_2->unkC, (temp_v0 == 0)) || (temp_v0 >= 0x7FFD) || ((*(s32 *)0x8013E704 >= 2) && (*(s32 *)0x80118314 == 3))) {
                    goto block_21;
                }
                func_8009A16C(temp_s0_2);
                temp_v0_2 = temp_s0_2->unk4;
                if (temp_v0_2 >= 0) {
                    temp_t0 = saved_reg_gp->unkB80;
                    *(temp_t0 + temp_v0_2) = 0x4C494146;
                    temp_s0_2->unk14 = func_800ECE34(temp_s0_2->unk10, temp_s0_2->unk8, temp_t0 + temp_s0_2->unk4, temp_s0_2->unkC, 0x64, 0);
                    saved_reg_gp->unkB38 = (u8) (saved_reg_gp->unkB38 + 1);
                    var_v1 = 0;
                    if (func_800EC764(temp_s0_2->unk14) <= 0) {
block_25:
                        if (saved_reg_gp->unkB70 < 0x3F) {
                            var_v1 = saved_reg_gp->unkB70 + 1;
                        }
block_27:
                        saved_reg_gp->unkB70 = var_v1;
                    }
                    goto loop_1;
                }
            } else {
block_21:
                func_8009B034();
                goto loop_1;
            }
        }
    }
}

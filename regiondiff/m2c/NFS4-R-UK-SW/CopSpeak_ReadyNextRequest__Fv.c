/* NFS4-R-UK-SW CHANGED @8009A2A0 | base 800997AC CopSpeak_ReadyNextRequest__Fv */
? func_80077174(s8, s32, s32, s32);                 /* extern */
s32 func_80077300(s8, s32, ?);                      /* extern */
? func_8009A1EC(void *);                            /* extern */
s32 func_800EC70C(s32);                             /* extern */
? func_800EC764(s32);                               /* extern */
s32 func_800ECBF8(s32);                             /* extern */
s32 func_800ECE34(s32, s32, s32, s32, s32, s32);    /* extern */

void func_8009A2A0(void) {
    s32 temp_a0;
    s32 temp_a0_4;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 temp_v0_3;
    s32 var_s1;
    s32 var_v1;
    s8 temp_a0_2;
    s8 temp_a0_3;
    u8 temp_v1;
    void *temp_s0;
    void *temp_s3;

    temp_s0 = (saved_reg_gp->unkB74 << 5) + 0x80113214;
    var_s1 = 1;
    if (temp_s0->unk4 >= 0) {
        temp_a0 = temp_s0->unk14;
        if (temp_a0 != -1) {
            temp_v0 = func_800EC70C(temp_a0);
            if (temp_v0 != 0) {
                var_s1 = (u32) (temp_v0 ^ 1) < 1U;
                temp_v0_2 = func_800ECBF8(temp_s0->unk14);
                temp_s0->unk14 = -1;
                saved_reg_gp->unkB38 = (u8) (saved_reg_gp->unkB38 - 1);
                if (temp_v0_2 != temp_s0->unkC) {
                    var_s1 = 0;
                }
                goto block_5;
            }
        } else {
block_5:
            temp_s3 = saved_reg_gp->unkB80 + temp_s0->unk4;
            if (temp_s3->unk0 != 0x6C4B4E42) {
                var_s1 = 0;
            }
            temp_v1 = temp_s3->unk4;
            if ((temp_v1 != 4) && (temp_v1 != 2)) {
                var_s1 = 0;
            }
            if (var_s1 == 0) {
                if (temp_s0->unk1D != 0) {
                    temp_a0_2 = temp_s0->unk1E;
                    if (temp_a0_2 >= 0) {
                        func_80077174(temp_a0_2, temp_s0->unk18, 0, 0);
                    }
                }
                temp_s3->unk0 = 0x4C494146;
                temp_s0->unk14 = func_800ECE34(temp_s0->unk10, temp_s0->unk8, saved_reg_gp->unkB80 + temp_s0->unk4, temp_s0->unkC, 0, 0);
                saved_reg_gp->unkB38 = (u8) (saved_reg_gp->unkB38 + 1);
                func_800EC764(temp_s0->unk14);
                goto block_29;
            }
            temp_a0_3 = temp_s0->unk1E;
            if (temp_a0_3 >= 0) {
                if ((temp_s0->unk1D != 0) || (temp_s0->unk18 >= 0)) {
                    if (func_80077300(temp_a0_3, temp_s0->unk18, 0) == -1) {
                        func_80077174(temp_s0->unk1E, temp_s0->unk18, saved_reg_gp->unkB80 + temp_s0->unk4, temp_s0->unkC);
                    }
                } else {
                    temp_v0_3 = func_80077300(temp_a0_3, temp_s0->unk8 + 0x4000, 0);
                    if (temp_v0_3 == -1) {
                        func_80077174(temp_s0->unk1E, temp_s0->unk8 + 0x4000, saved_reg_gp->unkB80 + temp_s0->unk4, temp_s0->unkC);
                        if (func_80077300(temp_s0->unk1E, temp_s0->unk8 + 0x4000, 1) == temp_v0_3) {
                            saved_reg_gp->unkB7C = 1;
                            var_s1 = 0;
                        }
                    }
                }
            }
            if (var_s1 != 0) {
                temp_s3->unk0 = 0x4C494146;
                func_8009A1EC(temp_s0);
                saved_reg_gp->unkB7C = 0;
                goto block_29;
            }
        }
    } else {
        if ((temp_s0->unk1D != 0) || ((temp_s0->unk18 >= 0) && (temp_s0->unk1E >= 0))) {
            func_80077174(temp_s0->unk1E, temp_s0->unk18, 0, 0);
        }
block_29:
        if (var_s1 != 0) {
            temp_a0_4 = saved_reg_gp->unkB74;
            var_v1 = 0;
            if (temp_a0_4 < 0x3F) {
                var_v1 = temp_a0_4 + 1;
            }
            saved_reg_gp->unkB74 = var_v1;
        }
    }
}

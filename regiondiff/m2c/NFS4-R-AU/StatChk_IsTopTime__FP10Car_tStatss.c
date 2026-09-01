/* NFS4-R-AU CHANGED @8004A19C | base 80049D0C StatChk_IsTopTime__FP10Car_tStatss */
/* callers: RunPostGame__14tFEApplication, MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand, MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand */
void *func_8001640C(?, s16);                        /* extern */
s16 func_80028080();                                /* extern */
s16 func_8002BA5C(s16);                             /* extern */
? func_8004B2FC(s16, s32);                          /* extern */
? func_800E4EF0(s32 *, ?, ?);                       /* extern */
s32 func_800E5F14(?, s32, ?);                       /* extern */
? func_800E6118(s32, s32);                          /* extern */

s32 func_8004A19C(void *arg0, s16 arg1) {
    s32 sp10;
    s32 sp18;
    s32 sp1C;
    s32 sp20;
    s32 sp24;
    s16 sp28;
    s32 sp30;
    s16 *temp_v1_3;
    s16 *temp_v1_4;
    s16 temp_s3;
    s16 temp_v0;
    s16 temp_v0_2;
    s16 var_a0;
    s16 var_s1;
    s32 temp_a0_2;
    s32 temp_a1;
    s32 temp_s2;
    s32 temp_s8;
    s32 temp_v1_2;
    s32 var_a0_2;
    s32 var_s0;
    s32 var_s7;
    s32 var_v1;
    void *temp_a0;
    void *temp_s4;
    void *temp_s5;
    void *temp_v1;

    var_s7 = 0;
    temp_s3 = func_80028080();
    func_800E4EF0(&sp10, 0, 8);
    func_800E4EF0(&sp18, 0, 8);
    func_800E4EF0(&sp20, 0, 8);
    temp_s8 = func_800E5F14(0x80012490, 0x168, 0x10);
    sp30 = func_800E5F14(0x8001249C, arg1 * 4, 0x10);
    var_a0 = 0;
    temp_s2 = func_800E5F14(0x800124A8, arg1 * 2, 0x10);
    sp28 = arg1;
    if (arg1 > 0) {
        var_v1 = 0 << 0x10;
        do {
            (((((var_v1 >> 0x10) * 0xA0) + arg0)->unk3C * 2) + temp_s2)->unk-2 = var_a0;
            temp_v0 = var_a0 + 1;
            var_a0 = temp_v0;
            var_v1 = var_a0 << 0x10;
        } while (temp_v0 < arg1);
    }
    func_8004B2FC(func_8002BA5C(var_a0), temp_s8);
    var_a0_2 = 9;
    if (temp_s3 == 2) {
        var_a0_2 = 1;
    }
    var_s1 = 0;
    temp_s5 = (((var_a0_2 * 4) | var_a0_2) * 4) + temp_s8;
    temp_s4 = temp_s5 + 0x8C;
loop_6:
    if ((var_s1 << 0x10) < ((u16) sp28 << 0x10)) {
        temp_v1 = (*((var_s1 * 2) + temp_s2) * 0xA0) + arg0;
        temp_a1 = temp_v1->unk6C;
        temp_a0 = func_8001640C(0x80115558, ((var_s1 * 0xA0) + arg0)->unk60);
        if (!(temp_a1 & 0x200)) {
            if ((u32) (temp_a0->unk2 - 7) >= 2U) {
                if (((u8) *(u8 *)0x801158E7 < 3U) && (temp_a1 & 4) && (temp_v1->unk80 == 2)) {
                    var_s7 = 1;
                }
                if (var_s7 == 1) {
                    temp_v0_2 = *(((s32) (var_s1 << 0x10) >> 0xF) + temp_s2);
                    temp_a0_2 = ((temp_v0_2 * 0xA0) + arg0)->unk88;
                    var_s7 = 0;
                    if ((temp_s5->unk84 >= temp_a0_2) || ((temp_s4->unkC == 0) && (temp_a0_2 > 0))) {
                        (sp + (temp_v0_2 * 4))->unk18 = 1;
                    } else {
                        temp_v1_2 = temp_s4->unkC;
                        if ((temp_v1_2 >= temp_a0_2) || ((temp_v1_2 == 0) && (temp_a0_2 > 0))) {
                            temp_v1_3 = ((s32) (var_s1 << 0x10) >> 0xF) + temp_s2;
                            (sp + (*temp_v1_3 * 4))->unk18 = 1;
                            (sp + (*temp_v1_3 * 4))->unk10 = 1;
                        }
                    }
                    if ((temp_s5->unkC >= temp_a0_2) || ((temp_s4->unkC == 0) && (temp_a0_2 > 0))) {
                        temp_v1_4 = ((s32) (var_s1 << 0x10) >> 0xF) + temp_s2;
                        (sp + (*temp_v1_4 * 4))->unk18 = 1;
                        (sp + (*temp_v1_4 * 4))->unk20 = 1;
                    }
                }
            }
            var_s1 += 1;
            goto loop_6;
        }
        func_800E6118(temp_s8, temp_a1);
        func_800E6118(sp30);
        func_800E6118(temp_s2);
        return 0;
    }
    if (sp10 != 0) {
        if (sp14 != 0) {
            if (arg0->unk128 < arg0->unk88) {
                sp18 = 0;
            } else {
                goto block_35;
            }
        } else if (sp1C != 0) {
            sp18 = 0;
        } else {
            goto block_33;
        }
    } else {
block_33:
        if ((sp14 != 0) && (sp18 != 0)) {
block_35:
            sp1C = 0;
        }
    }
    if ((sp20 != 0) && (sp24 != 0)) {
        if (arg0->unk128 >= arg0->unk88) {
            sp24 = 0;
        } else {
            sp20 = 0;
        }
    }
    var_s0 = sp18 != 0;
    if (sp20 != 0) {
        var_s0 |= 2;
    }
    if (sp1C != 0) {
        var_s0 |= 4;
    }
    if (sp24 != 0) {
        var_s0 |= 8;
    }
    func_800E6118(temp_s8);
    func_800E6118(sp30);
    func_800E6118(temp_s2);
    return var_s0;
}

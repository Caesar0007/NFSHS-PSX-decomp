/* NFS4-R-UK-SW CHANGED @8004A6B8 | base 8004A1B8 StatChk_SaveTopTime__FP10Car_tStatss */
/* callers: MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand, MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand */
void *func_80016464(?, s16);                        /* extern */
s32 func_800280D8();                                /* extern */
s16 func_8002BAB4();                                /* extern */
s32 func_8002BB50(s16);                             /* extern */
? func_8004ADB8(?, s32 *, s16 (*)[], s32 (*)[]);    /* extern */
? func_8004B36C(s16, s32);                          /* extern */
s32 func_800E5F14(?, s32, ?);                       /* extern */
? func_800E6118(s32);                               /* extern */
? func_800E6700(s32 *, s32);                        /* extern */
s32 func_800E6954(s32, s32);                        /* extern */
? func_800E6EB4(s32, s32, ?);                       /* extern */
? func_800EB40C(s32, void *, s32);                  /* extern */

void func_8004A6B8(s32 arg0, u16 arg1) {
    s32 sp40;
    s32 sp48;
    s32 sp4C;
    s32 sp50;
    ? sp58;
    u16 sp60;
    s32 sp68;
    u16 sp70;
    u16 sp78;
    s32 sp80;
    s32 sp84;
    s32 sp88;
    s16 *temp_a1;
    s16 *temp_s0;
    s16 temp_v0;
    s16 temp_v0_2;
    s16 temp_v0_6;
    s16 temp_v0_7;
    s16 temp_v0_8;
    s16 temp_v0_9;
    s16 temp_v1;
    s16 var_s1;
    s16 var_s1_2;
    s16 var_s1_4;
    s16 var_s1_5;
    s16 var_s1_6;
    s16 var_s1_7;
    s32 *temp_a1_2;
    s32 temp_a0;
    s32 temp_a0_2;
    s32 temp_s0_2;
    s32 temp_s7;
    s32 temp_v0_5;
    s32 temp_v1_2;
    s32 temp_v1_3;
    s32 temp_v1_4;
    s32 var_s3;
    s32 var_s3_2;
    s32 var_s6;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v0_3;
    s32 var_v0_4;
    s32 var_v0_5;
    s32 var_v0_6;
    s32 var_v1;
    s32 var_v1_3;
    u16 temp_v0_4;
    u16 var_s1_3;
    void *temp_s2;
    void *temp_s5;
    void *temp_v0_3;
    void *var_s4;
    void *var_v1_2;

    var_s6 = 0;
    var_s1 = 0;
    sp60 = arg1;
    sp68 = 0;
    sp78 = 0;
    var_v0 = 0 << 0x10;
    do {
        *(&sp58 + (var_v0 >> 0xE)) = 0;
        temp_v0 = var_s1 + 1;
        var_s1 = temp_v0;
        var_v0 = var_s1 << 0x10;
    } while (temp_v0 < 2);
    temp_s7 = func_800E5F14(0x80012490, 0x14 * 0x12, 0x10);
    sp84 = func_800E5F14(0x8001249C, (s16) sp60 * 4, 0x10);
    sp88 = func_800E5F14(0x800124A8, (s16) sp60 * 2, 0x10);
    var_s1_2 = 0;
    sp80 = func_800E5F14(0x800124B4, 0x14 * 8, 0x10);
    if ((s16) sp60 > 0) {
        var_v1 = 0 << 0x10;
        do {
            (((((var_v1 >> 0x10) * 0xA0) + arg0)->unk3C * 2) + sp88)->unk-2 = var_s1_2;
            temp_v0_2 = var_s1_2 + 1;
            var_s1_2 = temp_v0_2;
            var_v1 = var_s1_2 << 0x10;
        } while (temp_v0_2 < (s16) sp60);
    }
    func_8004B36C(func_8002BAB4(), temp_s7);
    sp70 = 9;
    if (func_800280D8() == 2) {
        sp70 = 1;
    }
    var_s3 = 0;
    if ((sp60 << 0x10) > 0) {
        temp_s5 = (sp70 * 0x14) + temp_s7;
        var_v0_2 = 0 << 0x10;
        do {
            temp_s0 = (var_v0_2 >> 0xF) + sp88;
            temp_v0_3 = func_80016464(0x80115558, ((*temp_s0 * 0xA0) + arg0)->unk60);
            var_v0_3 = var_s3 + 1;
            if ((u32) (temp_v0_3->unk2 - 7) >= 2U) {
                if ((u8) *(u8 *)0x801158E7 < 3U) {
                    var_v1_2 = (*temp_s0 * 0xA0) + arg0;
                    goto block_15;
                }
                temp_v1 = *temp_s0;
                if (temp_v1 == *(s32 *)0x801144EC) {
                    var_v1_2 = (temp_v1 * 0xA0) + arg0;
block_15:
                    if (var_v1_2->unk6C & 4) {
                        if (var_v1_2->unk80 == 2) {
                            var_s6 = 1;
                        }
                    }
                }
                var_v0_3 = var_s3 + 1;
                if ((var_s6 == 1) && ((temp_a1 = ((s32) (var_s3 << 0x10) >> 0xF) + sp88, temp_a0 = temp_s5->unk98, temp_v1_2 = ((*temp_a1 * 0xA0) + arg0)->unk88, var_s6 = 0, ((temp_a0 < temp_v1_2) == 0)) || ((var_v0_3 = var_s3 + 1, (temp_a0 == 0)) && (temp_v1_2 > 0)))) {
                    sp4C = temp_v1_2;
                    var_s1_3 = sp70;
                    sp48 = (s32) temp_v0_3->unk0;
                    sp68 = 1;
                    temp_v1_3 = sp70 + 8;
                    sp50 = ((*temp_a1 * 0xA0) + arg0)->unk9C;
                    temp_s5->unk8C = sp40;
                    temp_s5->unk90 = sp44;
                    temp_s5->unk94 = sp48;
                    temp_s5->unk98 = sp4C;
                    temp_s5->unk9C = sp50;
                    if ((s32) sp70 < temp_v1_3) {
                        var_v0_4 = var_s1_3 << 0x10;
                        do {
                            temp_a0_2 = var_v0_4 >> 0x10;
                            temp_v0_5 = ((temp_a0_2 * 0x14) + temp_s7)->unkC;
                            temp_a1_2 = &(&sp10[0])[temp_a0_2 - sp70];
                            *temp_a1_2 = temp_v0_5;
                            if (temp_v0_5 == 0) {
                                *temp_a1_2 = (temp_a0_2 + 1) * 0x23280;
                            }
                            temp_v0_4 = var_s1_3 + 1;
                            var_s1_3 = temp_v0_4;
                            var_v0_4 = var_s1_3 << 0x10;
                        } while ((s16) temp_v0_4 < temp_v1_3);
                    }
                    func_8004ADB8(8, &sp10[0], (s16 (*)[]) &sp30[0], (s32 (*)[]) &sp10[0]);
                    var_s1_4 = 0;
                    var_v0_5 = 0 << 0x10;
                    do {
                        temp_v0_6 = var_s1_4 + 1;
                        if (*(&sp30[0] + (var_v0_5 >> 0xF)) == 7) {
                            sp78 = var_s1_4 + 1;
                        }
                        var_s1_4 = temp_v0_6;
                        var_v0_5 = var_s1_4 << 0x10;
                    } while (temp_v0_6 < 8);
                    var_s1_5 = 0;
                    var_v0_6 = 0 << 0x10;
loop_33:
                    temp_v0_7 = *(&sp30[0] + (var_v0_6 >> 0xF));
                    if (temp_v0_7 != *(((s32) (var_s3 << 0x10) >> 0xF) + sp88)) {
                        temp_v0_8 = var_s1_5 + 1;
                        var_s1_5 = temp_v0_8;
                        var_v0_6 = var_s1_5 << 0x10;
                        if (temp_v0_8 < 8) {
                            goto loop_33;
                        }
                    } else {
                        (sp + (temp_v0_7 * 4))->unk58 = (s32) (s16) sp78;
                    }
                    var_s1_6 = 0;
                    func_800E6700(&sp40, func_8002BB50(*(((s32) (var_s3 << 0x10) >> 0xF) + sp88)));
                    temp_s5->unk8C = sp40;
                    temp_s5->unk90 = sp44;
                    temp_s5->unk94 = sp48;
                    temp_s5->unk98 = sp4C;
                    temp_s5->unk9C = sp50;
                    func_800EB40C(sp80, temp_s5, 0x14 * 8);
                    var_v1_3 = 0 << 0x10;
                    do {
                        temp_v1_4 = var_v1_3 >> 0x10;
                        func_800EB40C(((sp70 + temp_v1_4) * 0x14) + temp_s7, sp80 + ((&sp30[0])[temp_v1_4] * 0x14), 0x14);
                        temp_v0_9 = var_s1_6 + 1;
                        var_s1_6 = temp_v0_9;
                        var_v1_3 = var_s1_6 << 0x10;
                    } while (temp_v0_9 < 8);
                    var_v0_3 = var_s3 + 1;
                }
            }
            var_s3 = var_v0_3;
            var_v0_2 = var_s3 << 0x10;
        } while ((var_v0_3 << 0x10) < (sp60 << 0x10));
    }
    if (sp68 == 1) {
        func_800E6EB4(temp_s7, (func_8002BAB4() * 0x154) + 0x80116078, 0x154);
    }
    var_s1_7 = 0;
loop_42:
    if (var_s1_7 < 2) {
        if ((sp + (var_s1_7 * 4))->unk58 != 0) {
            var_s3_2 = 1;
            var_s4 = NULL;
            do {
                temp_s0_2 = (sp70 + var_s3_2) * 0x14;
                temp_s2 = (temp_s0_2 + temp_s7) - 0x14;
                if ((temp_s2->unkC == ((var_s1_7 * 0xA0) + arg0)->unk88) && (func_800E6954(temp_s7 + (temp_s0_2 - 0x14), func_8002BB50(var_s1_7)) == 0)) {
                    *(0x800531C8 + (s32) var_s4) = 1;
                    temp_s2->unkC = 0;
                }
                var_s3_2 += 1;
                var_s4 += 4;
            } while (var_s3_2 < 9);
        }
        var_s1_7 += 1;
        goto loop_42;
    }
    func_800E6118(sp80);
    func_800E6118(temp_s7);
    func_800E6118(sp84);
    func_800E6118(sp88);
}

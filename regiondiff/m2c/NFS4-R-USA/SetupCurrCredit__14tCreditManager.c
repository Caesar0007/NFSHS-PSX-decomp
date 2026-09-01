/* NFS4-R-USA CHANGED @80035F20 | base 80035D68 SetupCurrCredit__14tCreditManager */
/* callers: Draw__14tCreditManagerb */
s32 func_80023918(?, ?);                            /* extern */
? func_80037118(s32, s16, s32);                     /* extern */
s32 func_800372D4(s32);                             /* extern */
? func_8007A08C(?);                                 /* extern */

void func_80035F20(void *arg0) {
    s32 temp_a0;
    s32 temp_a0_2;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 var_a0;
    s32 var_a1;
    s32 var_s1;

    if (((*(s32 *)0x8013EF8C - *(s32 *)0x80051F2C) >= 0xD) && (arg0->unk8 == 0)) {
        var_s1 = 0;
        if (arg0->unk20 == arg0->unk1C) {
            if ((func_80023918(0x20, 0) != 0) || (func_80023918(0x20, 1) != 0)) {
                var_s1 = 1;
            }
            if (var_s1 != 0) {
                func_8007A08C(6);
                arg0->unk34 = 0;
                arg0->unk20 = (s32) (arg0->unk1C + 1);
                *(void *)0x80051F2C = (s32) *(void *)0x8013EF8C;
            }
            if (arg0->unk20 >= arg0->unk18) {
                arg0->unk20 = 0;
            }
            if (arg0->unk20 < 0) {
                arg0->unk20 = (s32) (arg0->unk18 - 1);
            }
        }
    }
    temp_a0 = arg0->unk34;
    if ((temp_a0 != 0) && (*(s32 *)0x80051F28 < (*(void *)0x8013EF8C - temp_a0))) {
        temp_v0 = arg0->unk20 + 1;
        arg0->unk20 = temp_v0;
        if (temp_v0 >= arg0->unk18) {
            arg0->unk20 = 0;
        }
        if (arg0->unk20 < 0) {
            arg0->unk20 = (s32) (arg0->unk18 - 1);
        }
        arg0->unk34 = 0;
    }
    if (arg0->unk1C != arg0->unk20) {
        arg0->unkC = 8;
        arg0->unk24 = 0;
        arg0->unk28 = 0;
        arg0->unk2C = 0;
    }
    temp_v0_2 = arg0->unk8 + arg0->unkC;
    arg0->unk8 = temp_v0_2;
    if (temp_v0_2 <= 0) {
        arg0->unk8 = 0;
    }
    if (arg0->unk8 >= 0x80) {
        arg0->unk8 = 0x80;
    }
    if ((arg0->unk8 == 0x80) && (arg0->unk24 == 0)) {
        temp_a0_2 = arg0->unk20;
        arg0->unk24 = 1;
        var_a1 = temp_a0_2 + 1;
        arg0->unk1C = temp_a0_2;
        if (var_a1 >= arg0->unk18) {
            var_a1 = 0;
        }
        if ((temp_a0_2 == ((arg0->unk20 / 3) * 3)) || (((var_a1 * 0x144) + arg0->unk0)->unk1C != -1)) {
            func_80037118(*(s32 *)0x800522E8, ((var_a1 * 0x144) + arg0->unk0)->unk1C, arg0->unk20 / 3);
            *(void *)0x80051F30 = (s32) *(void *)0x8013EF8C;
        } else {
            *(s32 *)0x80051F30 = 0;
        }
    }
    var_a0 = 0;
    if ((arg0->unk28 == 0) && (arg0->unk24 != 0) && ((*(void *)0x8013EF8C - *(void *)0x80051F30) >= 0x81)) {
        var_a0 = func_800372D4(*(void *)0x800522E8) != 0;
    }
    if (var_a0 != 0) {
        arg0->unk28 = 1;
        arg0->unk30 = (s32) *(void *)0x8013EF8C;
    }
    if ((arg0->unk2C == 0) && (arg0->unk28 != 0) && ((*(void *)0x8013EF8C - arg0->unk30) >= 0x1F)) {
        arg0->unk2C = 1;
        arg0->unkC = -8;
        arg0->unk34 = (s32) *(void *)0x8013EF8C;
    }
}

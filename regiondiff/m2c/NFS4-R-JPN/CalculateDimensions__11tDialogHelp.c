/* NFS4-R-JPN CHANGED @80018B18 | base 80018B90 CalculateDimensions__11tDialogHelp */
? func_80018A94(void *, s16, s16);                  /* extern */
? func_80020B98(?);                                 /* extern */
s16 func_8002557C(void *);                          /* extern */
s16 func_800E4818(s32);                             /* extern */
? func_800E4BF4();                                  /* extern */

void func_80018B18(void *arg0) {
    ? sp10;
    ? sp14;
    ? sp18;
    ? sp1C;
    s16 sp20;
    s16 temp_a0;
    s16 temp_a0_2;
    s16 temp_a1_2;
    s16 temp_a2_2;
    s16 temp_v0_2;
    s16 temp_v0_3;
    s16 temp_v1;
    s16 temp_v1_6;
    s16 var_a1;
    s16 var_a1_2;
    s16 var_s1_3;
    s16 var_s5;
    s16 var_v0;
    s16 var_v0_2;
    s32 *temp_v0;
    s32 temp_t0;
    s32 temp_v1_2;
    s32 temp_v1_3;
    s32 temp_v1_4;
    s32 temp_v1_5;
    s32 var_a0;
    s32 var_a0_2;
    s32 var_s1;
    s32 var_s1_2;
    s32 var_s2;
    s32 var_s4;
    s32 var_v0_3;
    u32 temp_a1;
    u32 temp_v0_4;
    void *temp_a0_3;
    void *temp_a0_4;
    void *temp_a2;
    void *temp_s0;

    sp10 = (unaligned s32) (void *)0x8001023C->unk0;
    sp14 = (unaligned s32) (void *)0x8001023C->unk4;
    sp18 = (unaligned s32) (void *)0x8001023C->unk8;
    sp1C = (unaligned s32) (void *)0x8001023C->unkC;
    sp20 = (void *)0x8001023C->unk10;
    func_80020B98(0);
    arg0->unkCC = 0;
    func_80018A94(arg0, 0x5A, 0);
    var_s5 = 0;
    temp_v1 = arg0->unk64;
    if (temp_v1 != -1) {
        var_s5 = temp_v1;
    }
    var_s2 = 0;
    if (*(&sp10 + (arg0->unk90 * 0x12)) != 0) {
        var_s4 = 0;
        temp_s0 = (*(s32 *)0x80051470 + (var_s5 * 4))->unk4;
        var_s1 = 0;
loop_4:
        temp_v0 = (temp_s0 + ((s32) (var_s1 << 0x10) >> 0xE))->unk10;
        if (temp_v0 != NULL) {
            temp_v1_2 = *temp_v0;
            if ((temp_v1_2 ^ 1) & 1) {
                if (temp_v1_2 & 0x400) {
                    var_s2 = 1;
                } else {
                    var_s4 = 1;
                }
            }
            var_s1 += 1;
            goto loop_4;
        }
        if (func_8002557C(temp_s0) >= 2) {
            func_80018A94(arg0, 0x53, 0x50);
        }
        if (var_s2 != 0) {
            func_80018A94(arg0, 0x54, 0xA0);
        }
        if (var_s4 != 0) {
            temp_v1_3 = temp_s0->unk0;
            var_a0 = 0;
            if ((temp_v1_3 & 0x10000) || (temp_v1_3 & 0x20000)) {
                var_a0 = 1;
            }
            if (var_a0 != 0) {
                var_a1 = 0x57;
            } else {
                var_a1 = 0x56;
            }
            func_80018A94(arg0, var_a1, 0x4000);
        }
        if ((*(void *)0x80051470 + (var_s5 * 4))->unk144 > 0) {
            func_80018A94(arg0, 0x55, 0x1000);
        }
        if (temp_s0->unk5C != 0) {
            func_80018A94(arg0, 0x58, -0x8000);
        }
        temp_v1_4 = temp_s0->unk0;
        if (temp_v1_4 & 0x800) {
            var_a1_2 = 0x59;
            goto block_35;
        }
        var_a0_2 = 0;
        if ((temp_s0->unk54 != 0) || (temp_v1_4 & 0x400) || (temp_s0->unk60 != 0)) {
            var_a0_2 = 1;
        }
        if ((var_a0_2 != 0) || (temp_s0->unk0 & 4)) {
            var_a1_2 = 0x57;
block_35:
            func_80018A94(arg0, var_a1_2, 8);
        }
    }
    var_s1_2 = 0;
    if ((&sp10 + (arg0->unk90 * 0x12))->unk2 != 0) {
        do {
            temp_a2 = &sp10 + (((s32) (var_s1_2 << 0x10) >> 0xE) + ((s16) (u16) arg0->unk90 * 0x12));
            func_80018A94(arg0, temp_a2->unk2, temp_a2->unk4);
            temp_v1_5 = var_s1_2 + 1;
            var_s1_2 = temp_v1_5;
        } while ((&sp10 + (((s32) (temp_v1_5 << 0x10) >> 0xE) + (arg0->unk90 * 0x12)))->unk2 != 0);
    }
    arg0->unkCE = 0;
    func_800E4BF4();
    if ((void *)0x8013F990->unk4 == 0) {
        temp_a0 = arg0->unkCE;
        var_v0 = temp_a0 | 1;
        if ((void *)0x8013F990->unk5 == 0x23) {
            var_v0 = temp_a0 | 2;
        }
        arg0->unkCE = var_v0;
    }
    if ((void *)0x8013F990->unk24 == 0) {
        temp_a0_2 = arg0->unkCE;
        var_v0_2 = temp_a0_2 | 1;
        if ((void *)0x8013F990->unk25 == 0x23) {
            var_v0_2 = temp_a0_2 | 2;
        }
        arg0->unkCE = var_v0_2;
    }
    var_s1_3 = 0;
    arg0->unk6A = 0;
    if (arg0->unkCC > 0) {
        var_v0_3 = 0 << 0x10;
        do {
            temp_v0_3 = func_800E4818((arg0 + (var_v0_3 >> 0xE))->unk94);
            if (arg0->unk6A < temp_v0_3) {
                arg0->unk6A = temp_v0_3;
            }
            temp_v0_2 = var_s1_3 + 1;
            var_s1_3 = temp_v0_2;
            var_v0_3 = var_s1_3 << 0x10;
        } while (temp_v0_2 < arg0->unkCC);
    }
    arg0->unkD0 = 0x28;
    temp_v1_6 = arg0->unkCC;
    arg0->unk6A = (s16) ((u16) arg0->unk6A + 0x28);
    if (temp_v1_6 < 2) {
        arg0->unk6C = 0;
    } else {
        arg0->unk6C = (s16) (temp_v1_6 * 0xF);
    }
    temp_a0_3 = *(void **)0x800529BC;
    temp_v0_4 = *(s32 *)0x8013ED54 - arg0->unk6A;
    arg0->unk66 = (s16) ((s32) (temp_v0_4 + (temp_v0_4 >> 0x1F)) >> 1);
    arg0->unk68 = (s16) ((s32) (0xF0 - arg0->unk6C) / 2);
    if (arg0->unk6A < (temp_a0_3->unk70 + 0x14)) {
        arg0->unk6A = (s16) ((u16) temp_a0_3->unk70 + 0x14);
    }
    temp_t0 = *(s32 *)0x8013ED78;
    arg0->unk6A = (s16) ((u16) arg0->unk6A + 0x14);
    temp_a1 = temp_t0 - arg0->unk74;
    arg0->unk6C = (s16) ((u16) arg0->unk6C + 0xA);
    if (temp_a1 < 0x32U) {
        temp_a0_4 = *(void **)0x800529BC;
        temp_a2_2 = temp_a0_4->unk550;
        temp_a1_2 = temp_a0_4->unk552;
        arg0->unk6A = (s16) ((temp_a2_2 * 2) + (((arg0->unk6A - (s16) (temp_a2_2 * 2)) * temp_a1) / 50));
        arg0->unk6C = (s16) ((temp_a1_2 * 2) + (((arg0->unk6C - (s16) (temp_a1_2 * 2)) * (temp_t0 - arg0->unk74)) / 50));
    }
    arg0->unk68 = 0x14;
    arg0->unk66 = (s16) (0x1F9 - (u16) arg0->unk6A);
}

/* NFS4-R-AU CHANGED @80049CD0 | base 80049840 StatChk_IsRecordLapTime__FP10Car_tStatssPs */
/* callers: RunPostGame__14tFEApplication, MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand, MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand */
void *func_8001640C(?, s16);                        /* extern */
s16 func_8002BA5C(s16);                             /* extern */
? func_8004AD48(s16, s16 *, s16 *, u16);            /* extern */
? func_8004B2FC(s16, s16 *);                        /* extern */
s16 func_8004B3A8();                                /* extern */
s16 *func_800E5F14(?, s32, ?);                      /* extern */
? func_800E6118(s16 *);                             /* extern */
? func_800EB40C(? *, s16 *, ?);                     /* extern */

u16 func_80049CD0(s32 arg0, s16 arg1, u16 *arg2) {
    ? sp10;
    s16 sp28;
    u16 sp30;
    s32 sp38;
    s16 *temp_s4;
    s16 *temp_s5;
    s16 *temp_s8;
    s16 temp_v0_2;
    s16 temp_v0_3;
    s16 temp_v1;
    s16 var_a0;
    s16 var_s3;
    s16 var_s6;
    s32 temp_a0;
    s32 temp_s1;
    s32 temp_s2;
    s32 var_v0;
    u16 temp_s0_2;
    void *temp_s0;
    void *temp_v0;

    sp30 = 0;
    var_s6 = func_8004B3A8();
    sp28 = arg1;
    if (var_s6 != 1) {
        return 0U;
    }
    temp_s5 = func_800E5F14(0x80012474, arg1 * 4, 0x10);
    temp_s4 = func_800E5F14(0x8001247C, arg1 * 2, 0x10);
    var_s3 = 0;
    temp_s8 = func_800E5F14(0x80012484, 0x168, 0x10);
    if (arg1 > 0) {
        sp38 = (s32) arg1;
        var_v0 = 0 << 0x10;
loop_4:
        temp_s1 = var_v0 >> 0x10;
        temp_s2 = temp_s1 * 4;
        temp_s0 = (temp_s1 * 0xA0) + arg0;
        temp_v0 = func_8001640C(0x80115558, temp_s0->unk60);
        if (!(temp_s0->unk6C & 0x200)) {
            if ((u32) (temp_v0->unk2 - 7) >= 2U) {
                *(temp_s2 + temp_s5) = temp_s0->unk9C;
            } else {
                *(temp_s2 + temp_s5) = (temp_s1 + 1) * 0x23280;
            }
            temp_v0_2 = var_s3 + 1;
            var_s3 = temp_v0_2;
            var_v0 = var_s3 << 0x10;
            if (temp_v0_2 >= sp38) {
                goto block_9;
            }
            goto loop_4;
        }
        func_800E6118(temp_s5);
        func_800E6118(temp_s4);
        func_800E6118(temp_s8);
        return 0U;
    }
block_9:
    if ((s16) (u16) sp28 >= 2) {
        func_8004AD48((s16) (u16) sp28, temp_s5, temp_s4, (u16) sp28);
    } else {
        *temp_s4 = 0;
    }
    var_a0 = 0;
    if ((s16) (u16) sp28 > 0) {
loop_14:
        temp_v1 = *(((s32) (var_a0 << 0x10) >> 0xF) + temp_s4);
        if (!(((temp_v1 * 0xA0) + arg0)->unk6C & 4) || (var_s6 = 1, (((temp_s4[temp_v1] * 0xA0) + arg0)->unk9C <= 0))) {
            temp_v0_3 = var_a0 + 1;
            var_a0 = temp_v0_3;
            var_s6 = 0;
            if (temp_v0_3 < (s16) (u16) sp28) {
                goto loop_14;
            }
        }
    }
    if ((var_s6 << 0x10) == 0) {

    } else {
        temp_s0_2 = *(((s32) (var_a0 << 0x10) >> 0xF) + temp_s4);
        func_8004B2FC(func_8002BA5C(var_a0), temp_s8);
        func_800EB40C(&sp10, temp_s8, 0x14);
        temp_a0 = (((s16) temp_s0_2 * 0xA0) + arg0)->unk9C;
        if (((sp20 >= temp_a0) || (sp20 == 0)) && (temp_a0 > 0)) {
            sp30 = 1;
        }
        *arg2 = temp_s0_2;
    }
    func_800E6118(temp_s5);
    func_800E6118(temp_s4);
    func_800E6118(temp_s8);
    return sp30;
}

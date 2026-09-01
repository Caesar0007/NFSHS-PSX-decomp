/* NFS4-R-FR-DE CHANGED @80017C64 | base 80017A9C AdjustPosition__16tListIteratorCar7tPlayers */
/* callers: Increment__16tListIteratorCar7tPlayer, Decrement__16tListIteratorCar7tPlayer */
s32 func_800174FC(void *, ?);                       /* extern */
s32 func_80018294(void *, s32, u8);                 /* extern */

void func_80017C64(void *arg0, u16 arg1, s32 arg2) {
    u8 sp10;
    u8 sp18;
    s32 temp_s3;
    s32 temp_v1;
    s32 var_s4;
    s32 var_s4_2;
    s32 var_s5;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v0_3;
    s32 var_v1_3;
    s32 var_v1_4;
    s8 *temp_s1;
    s8 *temp_v1_14;
    s8 *temp_v1_16;
    s8 *temp_v1_18;
    s8 *temp_v1_20;
    s8 *var_s0;
    s8 *var_s1;
    s8 *var_v1;
    s8 *var_v1_2;
    s8 temp_a0_4;
    u16 var_s3;
    u8 *temp_a0_3;
    u8 *temp_a1_2;
    u8 *temp_v0;
    u8 *temp_v1_11;
    u8 *temp_v1_3;
    u8 *temp_v1_4;
    u8 *temp_v1_5;
    u8 *temp_v1_9;
    u8 temp_a0_2;
    u8 temp_v1_10;
    u8 temp_v1_12;
    u8 temp_v1_15;
    u8 temp_v1_17;
    u8 temp_v1_19;
    u8 temp_v1_21;
    u8 temp_v1_22;
    u8 temp_v1_6;
    void *temp_a0;
    void *temp_a0_5;
    void *temp_a0_6;
    void *temp_a1;
    void *temp_a2;
    void *temp_v1_13;
    void *temp_v1_2;
    void *temp_v1_7;
    void *temp_v1_8;

    var_s3 = 0;
    if (arg1 != -1U) {
        var_s3 = arg1;
    }
    temp_v1 = arg0->unk10;
    var_s0 = NULL;
    if (temp_v1 & 0x89) {
        var_s4 = arg0->unk14->unk0;
        var_s5 = 0;
    } else if (temp_v1 & 0x42) {
        temp_a0 = arg0->unk14;
        var_s1 = temp_a0 + (((s16) var_s3 << 7) + 8);
        var_s5 = temp_a0->unk0;
        if (((s16) var_s3 == 1) && ((func_800174FC(temp_a0, 1) << 0x10) <= 0)) {
            var_s1 = arg0->unk14 + 8;
        }
        var_s4_2 = 0;
        if (*var_s1 >= 0) {
            var_v1 = var_s1;
            do {
                var_v1 += 4;
                var_s4_2 += 1;
            } while (*var_v1 >= 0);
            var_s4 = var_s4_2 + var_s5;
        } else {
            goto block_15;
        }
    } else {
        temp_v1_2 = arg0->unk14;
        temp_s1 = temp_v1_2 + (((s32) (var_s3 << 0x10) >> 9) + 0x108);
        var_s5 = temp_v1_2->unk0;
        var_s4_2 = 0;
        if (*temp_s1 >= 0) {
            var_v1_2 = temp_s1;
            do {
                var_v1_2 += 4;
                var_s4_2 += 1;
            } while (*var_v1_2 >= 0);
        }
block_15:
        var_s4 = var_s4_2 + var_s5;
    }
    temp_v1_3 = arg0->unk4 + (s16) var_s3;
    if ((s32) *temp_v1_3 >= var_s4) {
        *temp_v1_3 = var_s4 - 1;
    }
    temp_v1_4 = arg0->unk4 + (s16) var_s3;
    if ((s32) *temp_v1_4 < var_s5) {
        *temp_v1_4 = (u8) var_s5;
    }
    if (var_s5 < var_s4) {
        temp_a2 = arg0->unk14;
        temp_v1_5 = arg0->unk4 + (s16) var_s3;
        temp_a0_2 = *temp_v1_5;
        sp10 = *temp_v1_5;
        if (temp_a0_2 < (u32) temp_a2->unk0) {
            var_s0 = temp_a2->unk4 + (temp_a0_2 * 0xCC);
            sp18 = (*var_s0 + ((s16) var_s3 * 0x30) + 0x801158E4)->unkC0;
        } else {
            sp18 = 0;
        }
        temp_s3 = (s16) var_s3 * 0x30;
loop_25:
        temp_a1 = arg0->unk14;
        temp_a0_3 = arg0->unk4 + (s16) var_s3;
        temp_v1_6 = *temp_a0_3;
        if (temp_v1_6 < (u32) temp_a1->unk0) {
            var_s0 = temp_a1->unk4 + (temp_v1_6 * 0xCC);
            if (var_s0->unk2 == 7) {
                temp_v1_7 = var_s0->unk0 + temp_s3 + 0x801158E4;
                temp_v1_7->unkC0 = (u8) (arg2 + temp_v1_7->unkC0);
                temp_v1_8 = var_s0->unk0 + temp_s3 + 0x801158E4;
                temp_a0_4 = temp_v1_8->unkC0;
                if (temp_a0_4 >= 5) {
                    temp_v1_8->unkC0 = 0;
                    temp_v1_9 = arg0->unk4 + (s16) var_s3;
                    *temp_v1_9 += 1;
                    temp_v1_10 = *(arg0->unk4 + (s16) var_s3);
                    if ((s32) temp_v1_10 < var_s4) {
                        var_v0 = temp_v1_10 * 3;
                        var_v1_3 = temp_v1_10 * 0x30;
                        goto block_39;
                    }
                } else if (temp_a0_4 < 0) {
                    temp_v1_8->unkC0 = 4;
                    temp_v1_11 = arg0->unk4 + (s16) var_s3;
                    *temp_v1_11 -= 1;
                    temp_v1_12 = *(arg0->unk4 + (s16) var_s3);
                    if ((s32) temp_v1_12 >= var_s5) {
                        var_v0_2 = temp_v1_12 * 3;
                        var_v1_4 = temp_v1_12 * 0x30;
                        goto block_43;
                    }
                }
            } else {
                temp_v1_13 = var_s0->unk0 + temp_s3 + 0x801158E4;
                if ((arg2 << 0x10) <= 0) {
                    temp_v1_13->unkC0 = 4;
                } else {
                    temp_v1_13->unkC0 = 0;
                }
                temp_v0 = arg0->unk4 + (s16) var_s3;
                *temp_v0 += arg2;
                var_v0_3 = arg2 << 0x10;
                if ((var_v0_3 > 0) && (temp_v1_14 = arg0->unk4 + (s16) var_s3, var_v0_3 = arg2 << 0x10, ((*temp_v1_14 < var_s4) != 0))) {
                    temp_v1_15 = (u8) *temp_v1_14;
                    var_v0 = temp_v1_15 * 3;
                    var_v1_3 = temp_v1_15 * 0x30;
block_39:
                    var_s0 = arg0->unk14->unk4 + ((var_v0 + var_v1_3) * 4);
                    (*var_s0 + temp_s3 + 0x801158E4)->unkC0 = 0;
                } else if (var_v0_3 < 0) {
                    temp_v1_16 = arg0->unk4 + (s16) var_s3;
                    if (*temp_v1_16 >= var_s5) {
                        temp_v1_17 = (u8) *temp_v1_16;
                        var_v0_2 = temp_v1_17 * 3;
                        var_v1_4 = temp_v1_17 * 0x30;
block_43:
                        var_s0 = arg0->unk14->unk4 + ((var_v0_2 + var_v1_4) * 4);
                        (*var_s0 + temp_s3 + 0x801158E4)->unkC0 = 4;
                    }
                }
            }
        } else {
            *temp_a0_3 = arg2 + temp_v1_6;
        }
        temp_v1_18 = arg0->unk4 + (s16) var_s3;
        if (*temp_v1_18 >= var_s4) {
            *temp_v1_18 = (s8) var_s5;
            temp_a0_5 = arg0->unk14;
            temp_v1_19 = *(arg0->unk4 + (s16) var_s3);
            if (temp_v1_19 < (u32) temp_a0_5->unk0) {
                var_s0 = temp_a0_5->unk4 + (temp_v1_19 * 0xCC);
                (*var_s0 + temp_s3 + 0x801158E4)->unkC0 = 0;
            }
        }
        temp_v1_20 = arg0->unk4 + (s16) var_s3;
        if (*temp_v1_20 < var_s5) {
            *temp_v1_20 = var_s4 - 1;
            temp_a0_6 = arg0->unk14;
            temp_v1_21 = *(arg0->unk4 + (s16) var_s3);
            if (temp_v1_21 < (u32) temp_a0_6->unk0) {
                var_s0 = temp_a0_6->unk4 + (temp_v1_21 * 0xCC);
                (*var_s0 + temp_s3 + 0x801158E4)->unkC0 = 4;
            }
        }
        temp_a1_2 = arg0->unk4 + (s16) var_s3;
        temp_v1_22 = *temp_a1_2;
        if (((sp10 != temp_v1_22) || (((s8) temp_v1_22 < arg0->unk14->unk0) && ((*var_s0 + temp_s3 + 0x801158E4)->unkC0 != sp18))) && ((func_80018294(arg0, (s32) arg1, *temp_a1_2) ^ 1) != 0)) {
            goto loop_25;
        }
    }
}

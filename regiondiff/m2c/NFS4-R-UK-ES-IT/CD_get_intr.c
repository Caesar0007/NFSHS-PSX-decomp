/* NFS4-R-UK-ES-IT CHANGED @80107A58 | base 80107080 CD_get_intr */
/* callers: CD_sync, CD_ready, CD_cw, _cd_intr_dispatch */
? func_800E8CA4(?);                                 /* extern */
? func_801053D4(?, s32, s32, s32);                  /* extern */

s32 func_80107A58(void) {
    u8 sp10;
    u8 sp18;
    s32 temp_v0_2;
    s32 var_a0;
    s32 var_a0_2;
    s32 var_a0_3;
    s32 var_a0_4;
    s32 var_a0_5;
    s32 var_a0_7;
    s32 var_a0_9;
    s32 var_s0;
    s32 var_s1;
    s32 var_v1;
    s32 var_v1_10;
    s32 var_v1_8;
    u8 *temp_a0;
    u8 *temp_v1;
    u8 *var_a0_6;
    u8 *var_a0_8;
    u8 *var_a1;
    u8 *var_a1_2;
    u8 *var_a1_3;
    u8 *var_a1_4;
    u8 *var_a1_5;
    u8 *var_a1_6;
    u8 *var_a1_7;
    u8 *var_a1_8;
    u8 *var_a1_9;
    u8 *var_v0;
    u8 *var_v1_11;
    u8 *var_v1_2;
    u8 *var_v1_3;
    u8 *var_v1_4;
    u8 *var_v1_5;
    u8 *var_v1_7;
    u8 *var_v1_9;
    u8 temp_v0;
    u8 temp_v0_10;
    u8 temp_v0_11;
    u8 temp_v0_3;
    u8 temp_v0_4;
    u8 temp_v0_5;
    u8 temp_v0_6;
    u8 temp_v0_7;
    u8 temp_v0_8;
    u8 temp_v0_9;
    u8 var_v0_2;
    u8 var_v1_6;

    **(u8 **)0x8013D528 = 1;
    temp_a0 = *(u8 **)0x8013D534;
    temp_v0 = *temp_a0 & 7;
    sp10 = temp_v0;
    var_s1 = 0;
    if (temp_v0 != 0) {
loop_3:
        var_s0 = 0;
        if (sp10 != (*temp_a0 & 7)) {
            sp10 = *temp_a0 & 7;
            goto loop_3;
        }
loop_5:
        temp_v1 = &(&sp18)[var_s0];
        if (**(void *)0x8013D528 & 0x20) {
            var_s0 += 1;
            *temp_v1 = **(u8 **)0x8013D52C;
            if (var_s0 < 8) {
                goto loop_5;
            }
        }
        var_v1 = var_s0;
        if (var_s0 < 8) {
            var_v0 = &(&sp18)[var_v1];
            do {
                *var_v0 = 0;
                var_v1 += 1;
                var_v0 = &(&sp18)[var_v1];
            } while (var_v1 < 8);
        }
        **(void *)0x8013D528 = 1;
        **(void *)0x8013D534 = 7;
        **(s8 **)0x8013D530 = 7;
        if ((sp10 != 3) || (((*(u8 *)0x8013D281 * 4) + 0x80140000)->unk-2BD8 != 0)) {
            if (!(*(s32 *)0x8013D270 & 0x10) && (sp18 & 0x10)) {
                *(void *)0x8013D278 = (s32) (*(s32 *)0x8013D278 + 1);
            }
            temp_v0_2 = sp18 & 0xFF;
            var_s1 = temp_v0_2 & 0x1D;
            *(void *)0x8013D270 = temp_v0_2;
            *(s32 *)0x8013D274 = (s32) sp19;
        }
        if ((sp10 == 5) && (*(s32 *)0x8013D26C > 0)) {
            func_801053D4(0x80057F70);
            if (*(void *)0x8013D26C > 0) {
                func_801053D4(0x80057F7C, ((*(void *)0x8013D281 * 4) + 0x80140000)->unk-2D78, *(void *)0x8013D270, *(void *)0x8013D274);
            }
        }
        switch (sp10) {
        case 3:
            if (var_s1 != 0) {
                (void *)0x8013D540->unk0 = 5U;
                var_v1_2 = (u8 *)0x80149D04;
                var_a1 = &sp18;
                if (0x80149D04 != 0) {
                    var_a0 = 7;
                    do {
                        temp_v0_3 = *var_a1;
                        var_a1 += 1;
                        var_a0 -= 1;
                        *var_v1_2 = temp_v0_3;
                        var_v1_2 += 1;
                    } while (var_a0 != -1);
                    return 2;
                }
                goto block_41;
            }
            if (((*(void *)0x8013D281 * 4) + 0x80140000)->unk-2CD8 != 0) {
                (void *)0x8013D540->unk0 = 3U;
                var_v1_3 = (u8 *)0x80149D04;
                var_a1_2 = &sp18;
                if (0x80149D04 != 0) {
                    var_a0_2 = 7;
                    do {
                        temp_v0_4 = *var_a1_2;
                        var_a1_2 += 1;
                        var_a0_2 -= 1;
                        *var_v1_3 = temp_v0_4;
                        var_v1_3 += 1;
                    } while (var_a0_2 != -1);
                }
                return 1;
            }
            (void *)0x8013D540->unk0 = 2U;
            var_v1_4 = (u8 *)0x80149D04;
            var_a1_3 = &sp18;
            if (0x80149D04 != 0) {
                var_a0_3 = 7;
                do {
                    temp_v0_5 = *var_a1_3;
                    var_a1_3 += 1;
                    var_a0_3 -= 1;
                    *var_v1_4 = temp_v0_5;
                    var_v1_4 += 1;
                } while (var_a0_3 != -1);
                return 2;
            }
block_41:
            return 2;
        case 2:
            var_v0_2 = 2;
            if (var_s1 != 0) {
                var_v0_2 = 5;
            }
            (void *)0x8013D540->unk0 = var_v0_2;
            var_v1_5 = (u8 *)0x80149D04;
            var_a1_4 = &sp18;
            if (0x80149D04 != 0) {
                var_a0_4 = 7;
                do {
                    temp_v0_6 = *var_a1_4;
                    var_a1_4 += 1;
                    var_a0_4 -= 1;
                    *var_v1_5 = temp_v0_6;
                    var_v1_5 += 1;
                } while (var_a0_4 != -1);
            }
            goto block_41;
        case 1:
            if ((var_s1 != 0) && (var_s0 == 1)) {
                var_s1 = 0;
            }
            var_v1_6 = 1;
            if (var_s1 != 0) {
                var_v1_6 = 5;
            }
            (void *)0x8013D540->unk1 = var_v1_6;
            var_v1_7 = (u8 *)0x80149D0C;
            var_a1_5 = &sp18;
            if (0x80149D0C != 0) {
                var_a0_5 = 7;
                do {
                    temp_v0_7 = *var_a1_5;
                    var_a1_5 += 1;
                    var_a0_5 -= 1;
                    *var_v1_7 = temp_v0_7;
                    var_v1_7 += 1;
                } while (var_a0_5 != -1);
            }
            **(void *)0x8013D528 = 0;
            **(void *)0x8013D534 = 0;
            return 4;
        case 4:
            var_a0_6 = (u8 *)0x80149D14;
            (void *)0x8013D540->unk2 = 4U;
            var_a1_6 = &sp18;
            (void *)0x8013D540->unk1 = (u8) (void *)0x8013D540->unk2;
            var_v1_8 = 7;
            if (0x80149D14 != 0) {
                do {
                    temp_v0_8 = *var_a1_6;
                    var_a1_6 += 1;
                    var_v1_8 -= 1;
                    *var_a0_6 = temp_v0_8;
                    var_a0_6 += 1;
                } while (var_v1_8 != -1);
            }
            var_v1_9 = (u8 *)0x80149D0C;
            var_a1_7 = &sp18;
            if (0x80149D0C != 0) {
                var_a0_7 = 7;
                do {
                    temp_v0_9 = *var_a1_7;
                    var_a1_7 += 1;
                    var_a0_7 -= 1;
                    *var_v1_9 = temp_v0_9;
                    var_v1_9 += 1;
                } while (var_a0_7 != -1);
            }
            return 4;
        case 5:
            var_a0_8 = (u8 *)0x80149D04;
            (void *)0x8013D540->unk1 = 5U;
            var_a1_8 = &sp18;
            (void *)0x8013D540->unk0 = (u8) (void *)0x8013D540->unk1;
            var_v1_10 = 7;
            if (0x80149D04 != 0) {
                do {
                    temp_v0_10 = *var_a1_8;
                    var_a1_8 += 1;
                    var_v1_10 -= 1;
                    *var_a0_8 = temp_v0_10;
                    var_a0_8 += 1;
                } while (var_v1_10 != -1);
            }
            var_v1_11 = (u8 *)0x80149D0C;
            var_a1_9 = &sp18;
            if (0x80149D0C != 0) {
                var_a0_9 = 7;
                do {
                    temp_v0_11 = *var_a1_9;
                    var_a1_9 += 1;
                    var_a0_9 -= 1;
                    *var_v1_11 = temp_v0_11;
                    var_v1_11 += 1;
                } while (var_a0_9 != -1);
            }
            return 6;
        default:
            func_800E8CA4(0x80057F98);
            func_801053D4(0x80057FAC, (s32) sp10);
            goto block_66;
        }
    } else {
block_66:
        return 0;
    }
}

/* NFS4-R-JPN CHANGED @80043684 | base 80043778 SetCurrentController__23tScreenControllerConfigb */
/* callers: DrawBackground__23tScreenControllerConfig, DrawForeground__23tScreenControllerConfig, Initialize__23tScreenControllerConfig */
? func_8001DBE8(s32, ?, s32);                       /* extern */
s32 func_800B9CCC(?);                               /* extern */
u8 func_800F05E8(s32, ?, ?);                        /* extern */

void func_80043684(void *arg0, ? arg1) {
    s32 temp_a0;
    s32 var_s0;
    s32 var_s2;
    s32 var_s3;
    u8 temp_v0;
    u8 temp_v1_2;
    void *temp_s0;
    void *temp_v1;

    var_s2 = 0;
    temp_s0 = arg0 + 0xB8;
    temp_s0->unk90 = func_800B9CCC(0x20C);
    temp_s0->unkA0 = 0x20D;
    temp_s0->unkA4 = 0x20E;
    temp_s0->unk88 = 1;
    temp_a0 = -((u32) arg0->unk178 > 0U);
    temp_v1 = (temp_a0 & 0x20) + 0x8013F990;
    var_s3 = 0;
    if ((temp_v1->unk4 != 0) || (temp_v1->unk5 == 0x23)) {
        arg0->unk174 = 0U;
        if (arg0->unkA8 >= 0x80) {
            arg0->unk96 = 0;
        }
        var_s3 = 1;
    } else {
        temp_v1_2 = temp_v1->unk5;
        if (temp_v1_2 != 0x53) {
            if ((s32) temp_v1_2 < 0x54) {
                if (temp_v1_2 != 0x23) {
                    if (temp_v1_2 != 0x41) {
                        var_s3 = 1;
                        goto block_29;
                    }
                    var_s0 = 0;
                    if (func_800F05E8(temp_a0 & 0x10, 0x23, 1) == 6) {
                        arg0->unk174 = 4U;
                        arg0->unk160 = 0;
                        var_s2 = *(void **)0x800519A8 + 0x2E84;
                    } else {
                        if ((func_800F05E8(((u32) arg0->unk178 > 0U) * 0x10) == 2) || ((arg0->unk160 != 0) && (func_800F05E8(((u32) arg0->unk178 > 0U) * 0x10) == 1) && ((*(s32 *)0x8013ED78 - arg0->unk160) >= 0x61))) {
                            var_s0 = 1;
                        }
                        if ((var_s0 == 0) && (arg0->unk174 != 3)) {
                            if (arg0->unk160 == 0) {
                                arg0->unk160 = (s32) *(void *)0x8013ED78;
                            }
                        } else {
                            var_s3 = 1;
                            goto block_29;
                        }
                    }
                } else {
                    arg0->unk160 = 0;
                    arg0->unk174 = 1U;
                    arg0->unk98 = -1;
                    var_s2 = *(void *)0x800519A8 + 0x2FE0;
                }
            } else if (temp_v1_2 != 0x73) {
                var_s3 = 1;
block_29:
                arg0->unk160 = 0;
                arg0->unk174 = 3U;
            } else {
                goto block_24;
            }
        } else {
block_24:
            arg0->unk160 = 0;
            temp_v0 = func_800F05E8((arg0->unk178 != 0) * 0x10, 0x23, 1);
            if (temp_v0 == 6) {
                arg0->unk174 = temp_v0;
                var_s2 = *(void *)0x800519A8 + 0x2F6C;
            } else if (func_800F05E8((arg0->unk178 != 0) * 0x10) == 2) {
                arg0->unk174 = 5U;
                var_s2 = 0;
            }
        }
    }
    if ((var_s2 != 0) || (var_s3 != 0)) {
        func_8001DBE8(*(void *)0x800519A8 + 0x2B28, arg1, var_s2);
    }
    if (((u32) (arg0->unk174 - 5) < 2U) && ((u8) arg0->unk6D < 2U)) {
        (*(void *)0x800519A8)->unk2BD0 = 1;
        return;
    }
    (*(void *)0x800519A8)->unk2BD0 = 0;
}

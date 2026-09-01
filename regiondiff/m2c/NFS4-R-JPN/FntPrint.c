/* NFS4-R-JPN CHANGED @800F777C | base 800F7034 FntPrint */
s32 func_800EA6BC(s32, s32, s32);                   /* extern */

s32 func_800F777C(s32 arg0, s32 arg1, s32 arg2, s32 arg3) {
    s32 *sp210;
    s32 **var_s0;
    s32 temp_a2;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 temp_v0_3;
    s32 temp_v0_4;
    s32 temp_v0_5;
    s32 temp_v0_6;
    s32 temp_v1;
    s32 temp_v1_2;
    s32 var_a0_2;
    s32 var_a0_3;
    s32 var_a1;
    s32 var_s2;
    s32 var_s3;
    s32 var_v0;
    s8 var_a0;
    s8 var_a2;
    u8 temp_a0;
    void *temp_s1;

    var_a1 = arg1;
    sp210 = &arg1;
    if ((arg0 < 0) || (arg0 >= *(s32 *)0x801370B4)) {
        temp_v0 = *(s32 *)0x801370B8;
        var_s3 = arg0;
        arg0 = temp_v0;
        if (((temp_v0 * 0x30) + 0x80130000)->unk6F58 == 0) {
            goto block_3;
        }
        goto block_5;
    }
    var_s3 = arg1;
    sp210 = &arg2;
block_5:
    temp_s1 = (arg0 * 0x30) + 0x80136F34;
    if (temp_s1->unk1C >= temp_s1->unk28) {
        var_a0 = *var_s3;
        if (var_a0 != 0) {
loop_8:
            if ((var_a0 != 0x25) || (var_s3 += 1, var_a0 = *var_s3, var_s2 = 0, (var_a0 == 0x25))) {
                temp_v0_2 = temp_s1->unk28;
                *(temp_s1->unk24 + temp_v0_2) = var_a0;
                temp_v0_3 = temp_v0_2 + 1;
                temp_s1->unk28 = temp_v0_3;
                if (temp_s1->unk1C < temp_v0_3) {
                    return -1;
                }
                goto block_45;
            }
            temp_a2 = var_a0 == 0x30;
loop_14:
            if ((u32) (var_a0 - 0x30) < 0xAU) {
                var_s2 = (var_s2 * 0xA) - 0x30 + var_a0;
                var_s3 += 1;
                var_a0 = *var_s3;
                goto loop_14;
            }
            if (var_s2 <= 0) {
                var_s2 = 1;
            }
            var_s0 = &sp210;
            switch (var_a0) {
            case 0x64:
                var_a0_2 = *sp210;
                sp210 += 4;
                if (var_a0_2 < 0) {
                    var_a0_2 = -var_a0_2;
                    var_a2 = 0x2D;
                } else {
                    var_a2 = 0;
                }
                var_a1 = 0;
                do {
loop_23:
                    var_s0 -= 1;
                    var_a1 += 1;
                    *var_s0 = (s8) ((var_a0_2 % 10) + 0x30);
                    var_a0_2 /= 0xA;
                    if (var_a1 == 0) {
                        goto loop_23;
                    }
                } while (var_a0_2 != 0);
                var_v0 = var_a1 < var_s2;
                if (var_a2 != 0) {
                    var_s0 -= 1;
                    *var_s0 = var_a2;
                    var_a1 += 1;
                default:
block_37:
                    var_v0 = var_a1 < var_s2;
                }
block_38:
                if (var_v0 != 0) {
loop_39:
                    temp_v0_4 = temp_s1->unk28;
                    *(temp_s1->unk24 + temp_v0_4) = 0x20;
                    temp_v0_5 = temp_v0_4 + 1;
                    temp_s1->unk28 = temp_v0_5;
                    if (temp_s1->unk1C >= temp_v0_5) {
                        var_s2 -= 1;
                        if (var_a1 >= var_s2) {
                            goto block_41;
                        }
                        goto loop_39;
                    }
                    goto block_3;
                }
block_41:
                var_a1 -= 1;
                if (var_a1 != -1) {
loop_43:
                    temp_v1 = temp_s1->unk28;
                    temp_a0 = *var_s0;
                    var_s0 += 1;
                    *(temp_s1->unk24 + temp_v1) = temp_a0;
                    temp_v1_2 = temp_v1 + 1;
                    temp_s1->unk28 = temp_v1_2;
                    if (temp_s1->unk1C >= temp_v1_2) {
                        var_a1 -= 1;
                        if (var_a1 == -1) {
                            goto block_45;
                        }
                        goto loop_43;
                    }
                    goto block_3;
                }
block_45:
                var_s3 += 1;
                var_a0 = *var_s3;
                if (var_a0 == 0) {
                    goto block_46;
                }
                goto loop_8;
            case 0x58:
            case 0x78:
                var_a1 = 0;
                var_a0_3 = *sp210;
                sp210 += 4;
loop_28:
                var_s0 -= 1;
                do {
                    temp_v0_6 = var_a0_3 & 0xF;
                    var_a0_3 = (s32) ((u32) var_a0_3 >> 4);
                    var_a1 += 1;
                    *var_s0 = (u8) *(*(s32 *)0x80137AC0 + temp_v0_6);
                    if (var_a1 == 0) {
                        goto loop_28;
                    }
                    var_s0 -= 1;
                } while (var_a0_3 != 0);
                var_s0 += 1;
                if (temp_a2 != 0) {
                    if (var_a1 < var_s2) {
                        do {
                            var_s0 -= 1;
                            var_a1 += 1;
                            var_v0 = var_a1 < var_s2;
                            *var_s0 = 0x30;
                        } while (var_v0 != 0);
                        goto block_38;
                    }
                    goto block_41;
                }
                goto block_37;
            case 0x63:
                var_s0 -= 1;
                var_a1 = 1;
                *var_s0 = (u8) *sp210;
                sp210 += 4;
                goto block_37;
            case 0x73:
                var_s0 = (s32 **) *sp210;
                sp210 += 4;
                var_a1 = func_800EA6BC((s32) var_s0, var_a1, temp_a2);
                goto block_37;
            }
        } else {
block_46:
            *(temp_s1->unk24 + temp_s1->unk28) = 0;
            return temp_s1->unk28;
        }
    } else {
block_3:
        return -1;
    }
}

/* NFS4-R-AU CHANGED @800792E4 | base 800788BC AudioCmn_SoundCar__FP8Car_tObjiiiiiii */
? func_80077A74();                                  /* extern */
? func_80078A88(?, ?);                              /* extern */
? func_80078D5C(s32, ?, ?, s32, s32);               /* extern */
? func_80078D88(?, ?, s32, s32, s32, s32);          /* extern */
? func_8007BF3C(s32, s32, s32, s32, s32, s32, s32, s32); /* extern */
s32 func_800809F8(void *);                          /* extern */
s32 func_800E29F8(s32, s32, s32);                   /* extern */
s32 func_800E4F00(s32, s32);                        /* extern */
s32 func_800E4FDC(?, s32);                          /* extern */
? func_800E79A8(?, s32);                            /* extern */

void func_800792E4(void *arg0, s32 arg1, s32 arg2, s32 arg3, s32 arg4, s32 arg6, s32 arg7) {
    s32 sp20;
    s32 sp24;
    s32 sp28;
    ? var_a0;
    ? var_a0_5;
    ? var_a0_6;
    ? var_a1_2;
    ? var_a2;
    ? var_s2;
    s16 temp_v1_5;
    s32 temp_a0;
    s32 temp_a0_2;
    s32 temp_hi;
    s32 temp_lo;
    s32 temp_s0;
    s32 temp_s1;
    s32 temp_s1_2;
    s32 temp_v0;
    s32 temp_v0_3;
    s32 temp_v0_4;
    s32 temp_v0_5;
    s32 temp_v0_6;
    s32 temp_v1;
    s32 temp_v1_2;
    s32 temp_v1_4;
    s32 temp_v1_7;
    s32 var_a0_2;
    s32 var_a0_3;
    s32 var_a0_4;
    s32 var_a1;
    s32 var_a3;
    s32 var_s0;
    s32 var_s0_2;
    s32 var_s0_3;
    s32 var_s1;
    s32 var_s2_2;
    s32 var_s3;
    s32 var_s3_2;
    s32 var_s5;
    s32 var_s5_2;
    s32 var_s6;
    s32 var_s7;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v0_3;
    s32 var_v0_4;
    s32 var_v0_5;
    s32 var_v0_6;
    s32 var_v0_7;
    s32 var_v1;
    s32 var_v1_2;
    s32 var_v1_3;
    u8 temp_v0_2;
    u8 temp_v1_3;
    u8 temp_v1_6;
    u8 temp_v1_8;
    u8 temp_v1_9;

    func_80077A74();
    if (saved_reg_gp->unkFC != 0) {
        var_a0 = 0x08000000;
        if (((arg0->unk254 * 0x110) + 0x8011059C)->unk70 == 0xC) {
            var_a0 = 0x10000000;
            var_a1 = 0x10000;
        } else {
            var_a1 = 0x20000;
        }
        var_v1 = func_800E4FDC(var_a0, arg1 + var_a1);
        if (var_v1 < 0) {
            var_v1 += 0xFFFF;
        }
        sp24 = var_v1 >> 0x10;
        var_v0 = arg0->unk420;
        if (var_v0 < 0) {
            var_v0 = -var_v0;
        }
        temp_v1 = var_v0 + 0xFFF28000;
        var_s1 = 0;
        if (temp_v1 >= 0) {
            var_s1 = temp_v1 >> 0x10;
        }
        var_s0 = var_v0 >> 0xF;
        if (var_s0 >= 0x80) {
            var_s0 = 0x7F;
        }
        var_v0_2 = var_s0;
        if (var_s0 < 0) {
            var_v0_2 = var_s0 + 0xF;
        }
        var_s3 = 8 - (var_v0_2 >> 4);
        if (var_s3 < 3) {
            var_s3 = 3;
        }
        var_s6 = arg2;
        sp20 = 0x40;
        if (var_s6 >= 0x97) {
            var_s6 = 0x96;
        }
        if (var_s6 < 0) {
            var_s6 = 0;
        }
        var_s5 = arg0->unk1C0;
        temp_v0 = func_800809F8(arg0 + 8);
        sp28 = temp_v0;
        if (temp_v0 != 0) {
            if ((*(s32 *)0x801144DC != 1) && ((u8) saved_reg_gp->unk131 < 0x64U)) {
                temp_v1_2 = saved_reg_gp->unk131 + 0xA;
                var_a0_2 = 0x64;
                if (temp_v1_2 < 0x65) {
                    var_a0_2 = temp_v1_2;
                }
                saved_reg_gp->unk131 = (u8) var_a0_2;
                func_800E79A8(0, var_a0_2 & 0xFF);
                saved_reg_gp->unk130 = 1;
            }
            var_s1 += 0x14;
            sp20 = 0x5E;
        } else {
            temp_v1_3 = saved_reg_gp->unk131;
            if (temp_v1_3 < 0x20U) {
                saved_reg_gp->unk131 = 0x20U;
                func_800E79A8(0, 0x20);
                saved_reg_gp->unk130 = 1;
            } else if (temp_v1_3 >= 0x21U) {
                temp_v1_4 = saved_reg_gp->unk131 - 5;
                var_a0_3 = 0x20;
                if (temp_v1_4 >= 0x20) {
                    var_a0_3 = temp_v1_4;
                }
                saved_reg_gp->unk131 = (u8) var_a0_3;
                func_800E79A8(0, var_a0_3 & 0xFF);
            }
        }
        var_s7 = 0;
        if (*(void *)0x801144DC == 1) {
            var_s7 = 1;
            var_s2 = 0xC002;
            if (arg0->unk254 != 0) {
                var_s2 = 0x3FFE;
            }
        } else {
            var_s2 = 0;
        }
        if (arg0->unk274 != 0) {
            var_s5 = 4;
            var_s0 *= 2;
        }
        if (arg1 <= 0x45FFFF) {
            temp_lo = ((0x13240000 - func_800E4F00(arg1, arg1)) / 4900) * var_s0;
            var_s0_2 = temp_lo >> 0x10;
            if (temp_lo < 0) {
                var_s0_2 = (s32) (temp_lo + 0xFFFF) >> 0x10;
            }
        } else {
            var_s0_2 = 0;
        }
        switch (var_s5) {                           /* switch 1 */
        case 2:                                     /* switch 1 */
        case 10:                                    /* switch 1 */
        case 11:                                    /* switch 1 */
        case 13:                                    /* switch 1 */
            var_v0_3 = var_s1;
            if (var_s1 < 0) {
                var_v0_3 = var_s1 + 3;
            }
            var_s1 += var_v0_3 >> 2;
            sp20 = 0x18;
            break;
        case 4:                                     /* switch 1 */
        case 7:                                     /* switch 1 */
        case 12:                                    /* switch 1 */
            temp_v0_2 = saved_reg_gp->unk168 + 1;
            saved_reg_gp->unk168 = temp_v0_2;
            temp_hi = (s32) (temp_v0_2 & 0xFF) % var_s3;
            saved_reg_gp->unk168 = (u8) temp_hi;
            if (!(temp_hi & 0xFF) && (arg0->unk188 < 0x3333) && (saved_reg_gp->unk10C > 0)) {
                var_a2 = 0;
                if (var_s7 & 0xFF) {
                    var_a2 = var_s2;
                }
                var_v0_4 = 0x40;
                if (var_s5 == 7) {
                    var_v0_4 = 0x28;
                }
                func_80078D5C((void *)0x8010FB98->unk24, 0x1D, var_a2, var_s0_2 / 2, var_v0_4);
            }
            break;
        }
        if (saved_reg_gp->unk110 != 0) {
            temp_v1_5 = ((arg0->unk254 * 0x110) + 0x8011059C)->unk70;
            if (temp_v1_5 >= 0) {
                var_s5_2 = 0;
                if (temp_v1_5 >= 2) {
                    var_s5_2 = 1;
                    if (temp_v1_5 < 5) {
                        var_s1 = var_s1 >> 1;
                    } else {
                        goto block_62;
                    }
                }
            } else {
block_62:
                var_s5_2 = 2;
                var_s1 = var_s1 >> 1;
            }
            temp_v0_3 = arg0->unk254 * 4;
            temp_v1_6 = arg0->unk43F;
            temp_a0 = *(0x8013F0B4 + temp_v0_3);
            if (temp_a0 < (s32) temp_v1_6) {
                temp_v0_4 = (s32) (temp_v1_6 - temp_a0) / 2;
                var_v0_5 = temp_a0 + temp_v0_4;
                if (temp_v0_4 <= 0) {
                    var_v0_5 = temp_a0 + 1;
                }
                goto block_71;
            }
            temp_v0_5 = temp_v1_6 - temp_a0;
            if ((s32) temp_v1_6 < temp_a0) {
                var_v1_2 = temp_v0_5;
                if (temp_v0_5 < 0) {
                    var_v1_2 = temp_v0_5 + 7;
                }
                temp_v1_7 = var_v1_2 >> 3;
                var_v0_5 = temp_a0 - 1;
                if (temp_v1_7 < 0) {
                    var_v0_5 = temp_a0 + temp_v1_7;
                }
block_71:
                *(0x8013F0B4 + temp_v0_3) = var_v0_5;
            }
            temp_a0_2 = arg0->unk254;
            var_s2_2 = *(0x8013F0B4 + (temp_a0_2 * 4));
            if (var_s2_2 >= 0x100) {
                var_s2_2 = 0xFF;
            }
            var_v0_6 = sp24 * (var_s6 + 0x28);
            if (var_v0_6 < 0) {
                var_v0_6 += 0x7F;
            }
            var_v1_3 = var_v0_6 >> 7;
            if (var_v1_3 < sp24) {
                var_v1_3 = sp24;
            }
            var_s3_2 = (s32) (var_v1_3 * 0x7F) >> 7;
            temp_s1 = (s32) (var_s1 * var_v1_3) >> 7;
            if (sp28 != 0) {
                var_s0_3 = 0;
            } else {
                var_s0_3 = func_800E29F8(temp_a0_2, temp_v0_3 + 0x8013F0B4, var_v1_3);
            }
            var_v0_7 = var_s0_3 >> 3;
            if (var_s0_3 >= 0x80) {
                var_s0_3 = 0x7F;
                var_v0_7 = 0x7F >> 3;
            }
            var_a0_4 = 0x7F;
            if (temp_s1 < 0x80) {
                var_a0_4 = temp_s1;
            }
            if ((arg6 != 0) || (((arg0->unk254 * 0x110) + 0x8011059C)->unk70 == 0xB)) {
                var_s3_2 = (s32) (var_s3_2 << 0x10) / arg3;
            }
            var_a1_2 = 0xE;
            if (var_s5_2 == 0) {
                var_a1_2 = 0;
                if (*(void *)0x801144DC == 1) {
                    var_a1_2 = 0xE;
                }
            }
            temp_v0_6 = *(s32 *)0x8013D924;
            temp_s1_2 = (s32) (var_a0_4 * temp_v0_6) >> 7;
            temp_s0 = (s32) (var_s0_3 * temp_v0_6) >> 7;
            if (temp_s1_2 != 0) {
                var_a0_5 = 0x19;
                if (arg0->unk254 == 0) {
                    var_a0_5 = 0x18;
                }
                func_80078D88(var_a0_5, var_a1_2, sp20, arg3, temp_s1_2, arg4);
            } else {
                var_a0_6 = 0x19;
                if (arg0->unk254 == 0) {
                    var_a0_6 = 0x18;
                }
                func_80078A88(var_a0_6, var_a1_2);
            }
            if (arg0->unk254 == 0) {
                if ((*(s32 *)0x80114518 == 1) && (temp_s0 != 0)) {
                    func_80078D88(0x1A, 0, 0x48 - var_v0_7, arg3, temp_s0, 0);
                } else {
                    func_80078A88(0x1A);
                }
            }
            if (arg0->unk444 != 0) {
                temp_v1_8 = arg0->unk441;
                if ((temp_v1_8 < (u8) arg0->unk442) && (temp_v1_8 != 1) && (var_s2_2 != 0)) {
                    temp_v1_9 = arg0->unk444;
                    var_s3_2 = (s32) (var_s3_2 + ((s32) (var_s3_2 * temp_v1_9) / (s32) arg0->unk464->unk8)) >> 1;
                    switch (temp_v1_9) {            /* switch 2; irregular */
                    case 5:                         /* switch 2 */
                        var_s2_2 -= var_s2_2 >> 2;
                        break;
                    case 4:                         /* switch 2 */
                        var_s2_2 = var_s2_2 >> 1;
                        break;
                    case 3:                         /* switch 2 */
                        var_s2_2 = var_s2_2 >> 2;
                        break;
                    default:                        /* switch 2 */
                        var_s2_2 = 0;
                        break;
                    }
                    *(0x8013F0B4 + (arg0->unk254 * 4)) = var_s2_2;
                }
            }
            var_a3 = 0x7F;
            if (arg0->unk27C == 0) {
                var_a3 = var_s2_2 >> 1;
            }
            func_8007BF3C(arg0->unk254, (s32) (saved_reg_gp->unk110 * (var_s3_2 * 0xE)) >> 0xE, (s32) (arg0->unk468 << 0x10) / (s32) arg0->unk464->unkF0, var_a3, var_s5_2, arg3, arg4, arg7);
        }
    }
}

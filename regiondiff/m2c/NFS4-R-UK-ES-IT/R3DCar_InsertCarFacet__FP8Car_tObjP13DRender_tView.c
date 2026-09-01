/* NFS4-R-UK-ES-IT CHANGED @800B086C | base 800AFBD0 R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView */
/* callers: R3DCar_InsertCarFacetZ__FP8Car_tObjP13DRender_tView */
? func_8009E854(s32 *, s32 *, s32 *);               /* extern */
? func_800A319C(void *, s32);                       /* extern */
? func_800B0790(void *, ?);                         /* extern */
? func_800B07F0(void *, s32);                       /* extern */
? func_800B0844(s32 *, s32 *);                      /* extern */
? func_800E2918(void *, void *, ?, void *, s32);    /* extern */
s32 func_800E4F00(s32, ?);                          /* extern */
s32 func_800E4FDC(s32, s32);                        /* extern */
? func_800EB4F4(s32 *, s32);                        /* extern */
? func_800EB558(s32 *, s32);                        /* extern */
? func_800EB5BC(s32 *, s32);                        /* extern */
? func_800EB820(s32 *, s32 *, s32 *, s32);          /* extern */
s32 func_800EDE70(s32, s32, s32, s32);              /* extern */

void func_800B086C(void *arg0, void *arg1) {
    s32 sp18;
    s32 sp1C;
    s32 sp20;
    s32 sp28;
    s32 sp50;
    s32 sp78;
    s32 sp7C;
    s32 sp80;
    s32 spA0;
    s32 spC8;
    s32 spF0;
    s32 spF4;
    s32 spF8;
    s32 sp100;
    s32 sp108;
    s32 sp110;
    s32 sp118;
    s32 sp128;
    s32 sp12C;
    s32 sp130;
    s32 sp138;
    s32 sp160;
    s32 sp188;
    s32 sp1B0;
    u32 sp1B4;
    s32 sp1B8;
    s32 *sp1BC;
    s16 *var_v1_4;
    s16 *var_v1_5;
    s16 temp_s7;
    s16 temp_v0_3;
    s16 var_s4_3;
    s16 var_s4_4;
    s16 var_v0_17;
    s32 *temp_s0;
    s32 *temp_s0_2;
    s32 *var_a0_2;
    s32 *var_a0_7;
    s32 *var_a0_8;
    s32 *var_a1_10;
    s32 *var_a1_2;
    s32 *var_a1_7;
    s32 *var_a1_8;
    s32 *var_a2_2;
    s32 temp_a0_2;
    s32 temp_a0_3;
    s32 temp_a0_4;
    s32 temp_a0_5;
    s32 temp_a0_6;
    s32 temp_a1_2;
    s32 temp_a2;
    s32 temp_a2_2;
    s32 temp_a3;
    s32 temp_a3_2;
    s32 temp_a3_3;
    s32 temp_lo;
    s32 temp_s1;
    s32 temp_s6;
    s32 temp_t0;
    s32 temp_t1;
    s32 temp_v0_2;
    s32 temp_v1_4;
    s32 var_a0;
    s32 var_a0_3;
    s32 var_a0_6;
    s32 var_a1;
    s32 var_a1_3;
    s32 var_a1_6;
    s32 var_a1_9;
    s32 var_a2;
    s32 var_lo;
    s32 var_s0;
    s32 var_s0_2;
    s32 var_s1;
    s32 var_s3;
    s32 var_s4;
    s32 var_s4_2;
    s32 var_s6;
    s32 var_v0;
    s32 var_v0_10;
    s32 var_v0_11;
    s32 var_v0_13;
    s32 var_v0_14;
    s32 var_v0_15;
    s32 var_v0_16;
    s32 var_v0_19;
    s32 var_v0_4;
    s32 var_v0_5;
    s32 var_v0_6;
    s32 var_v0_7;
    s32 var_v0_8;
    s32 var_v0_9;
    s32 var_v1;
    s32 var_v1_3;
    s8 *var_v0_18;
    s8 temp_v0;
    s8 var_a1_4;
    s8 var_a1_5;
    u16 temp_a0;
    u16 temp_v1;
    u16 temp_v1_2;
    u16 var_v0_12;
    u16 var_v0_2;
    u16 var_v0_3;
    u32 var_v1_2;
    u8 temp_a1;
    u8 temp_v0_4;
    u8 temp_v1_3;
    void *temp_a2_3;
    void *temp_a2_4;
    void *temp_s0_3;
    void *temp_s1_2;
    void *temp_s8;
    void *var_a0_4;
    void *var_a0_5;
    void *var_a2_3;

    sp1B8 = 0;
    sp1B0 = arg0->unk8D0;
    temp_s7 = arg0->unk8BC;
    sp1B4 = (u8) arg0->unk842 >> 7;
    if (temp_s7 < 0x1C) {
        temp_v0 = *(0x80117B28 + temp_s7);
        sp1B8 = (s32) temp_v0;
        if (temp_v0 < 0) {
            sp1B8 = ((s32) (((*(s32 *)0x8011450C * 0xC) + 0x8010F164)->unk4 + 1) >> 1) ^ 1;
        }
    }
    if (*(s32 *)0x801144FC != 0) {
        sp1B8 ^= 1;
    }
    saved_reg_gp->unkE64 = sp1B8;
    temp_s6 = (u32) (temp_s7 - 0x16) < 6U;
    if (arg0->unk8C2 >= 0) {
        temp_a0 = arg0->unk8B4;
        var_v0 = temp_a0 & 0x80;
        if (!(temp_a0 & 8)) {
            if (arg0->unk218 > 0x1E0000) {
                if (!(temp_a0 & 0x44)) {
                    var_v0_2 = temp_a0 | 0xC;
                    goto block_11;
                }
                var_v0_2 = temp_a0 | 8;
                if (temp_a0 & 2) {
block_11:
                    arg0->unk8B4 = var_v0_2;
                }
            }
            var_v0 = arg0->unk8B4 & 0x80;
        }
        if ((var_v0 == 0) && (arg0->unk220 > 0x1E0000)) {
            if (!(arg0->unk8B4 & 0x44)) {
                var_v0_3 = arg0->unk8B4 | 0xC0;
                goto block_19;
            }
            var_v0_3 = arg0->unk8B4 | 0x80;
            if (arg0->unk8B4 & 0x20) {
block_19:
                arg0->unk8B4 = var_v0_3;
            }
        }
        if (temp_s6 != 0) {
            if (arg0->unk570 & 2) {
                if (!(arg0->unk8B8 & 0x80)) {
                    arg0->unk8B8 = 0x80U;
                    arg0->unk8BA = 0x88U;
                    if (!(arg0->unk447 & 2)) {
                        func_800B0790(arg0, 1);
                    }
                }
            } else if (arg0->unk8B8 & 0x80) {
                temp_a1 = arg0->unk447;
                arg0->unk8B8 = 0U;
                arg0->unk8BA = 0U;
                if (!(temp_a1 & 2)) {
                    func_800B07F0(arg0, (temp_a1 & 4) == 0);
                }
            }
        }
        var_v0_4 = temp_s7 < 0x1C;
        if (saved_reg_gp->unkE50 != 0) {
            temp_v1 = arg0->unk8B8;
            if (temp_v1 & 0x80) {
                arg0->unk8B8 = (u16) ((temp_v1 + 1) & 0x8F);
            }
            temp_v1_2 = arg0->unk8BA;
            if (temp_v1_2 & 0x80) {
                arg0->unk8BA = (u16) ((temp_v1_2 + 1) & 0x8F);
            }
            var_v0_4 = temp_s7 < 0x1C;
        }
        if (var_v0_4 == 0) {
            sp1B0 = 0;
        } else if (arg0->unk8B3 & 2) {
            sp1B0 = arg0->unk8D4;
        }
        if ((arg0->unk8C2 == 0) && ((temp_s7 >= 0x1C) || (arg0->unk8B2 != 0))) {
            arg0->unk8C2 = 1;
        }
        if ((arg0->unk8C2 == 2) && (temp_s7 == 0x1C)) {
            arg0->unk8C2 = 1;
        }
        temp_a2 = arg0->unkA0 - arg1->unk8;
        spF0 = temp_a2;
        temp_s8 = arg0->unk8C2 + 2;
        temp_a3 = arg0->unkA4 - arg1->unkC;
        spF4 = temp_a3;
        var_a1 = temp_a2;
        var_v1 = arg0->unkA8 - arg1->unk10;
        spF8 = var_v1;
        if (temp_a2 < 0) {
            var_a1 = temp_a2 + 0xFF;
        }
        var_v0_5 = arg0->unkF0;
        temp_t1 = var_a1 >> 8;
        if (var_v0_5 < 0) {
            var_v0_5 += 0xFF;
        }
        var_a0 = temp_a3;
        if (temp_a3 < 0) {
            var_a0 = temp_a3 + 0xFF;
        }
        var_v0_6 = arg0->unkF4;
        temp_t0 = var_a0 >> 8;
        if (var_v0_6 < 0) {
            var_v0_6 += 0xFF;
        }
        if (var_v1 < 0) {
            var_v1 += 0xFF;
        }
        var_v0_7 = arg0->unkF8;
        if (var_v0_7 < 0) {
            var_v0_7 += 0xFF;
        }
        temp_a0_2 = (temp_t1 * (var_v0_5 >> 8)) + (temp_t0 * (var_v0_6 >> 8)) + ((var_v1 >> 8) * (var_v0_7 >> 8));
        sp100 = temp_a0_2;
        var_a2 = spF8;
        if (var_a2 < 0) {
            var_a2 += 0xFF;
        }
        var_v0_8 = arg0->unk110;
        temp_a2_2 = var_a2 >> 8;
        if (var_v0_8 < 0) {
            var_v0_8 += 0xFF;
        }
        temp_a1_2 = (temp_t1 * ((s32) arg0->unk108 / 256)) + (temp_t0 * ((s32) arg0->unk10C / 256)) + (temp_a2_2 * (var_v0_8 >> 8));
        sp108 = temp_a1_2;
        saved_reg_gp->unkE4C = (s16) (0x1000 - (func_800EDE70(temp_a0_2, temp_a1_2, temp_a2_2, temp_a3) >> 4));
        temp_s0 = arg0 + 0xF0;
        if (temp_s7 < 0x1C) {
            func_800B0844(temp_s0, &sp78);
            if (sp1B8 != 0) {
                sp78 = -sp78;
                sp80 = -sp80;
                sp7C = -sp7C;
            }
            var_s3 = arg0->unk84C;
            if (sp1B8 != 0) {
                var_s3 = -var_s3;
            }
            func_800EB5BC(&sp28, arg0->unk84C);
            func_800EB4F4(&sp138, arg0->unk848 + 0x64);
            func_8009E854(&sp28, &sp138, &sp28);
            func_8009E854(&sp28, temp_s0, &sp28);
            func_800EB5BC(&sp110, var_s3);
            func_8009E854(&sp110, &sp138, &sp110);
            func_8009E854(&sp110, &sp78, &sp78);
            temp_s0_2 = arg1 + 0x44;
            func_8009E854(&sp28, temp_s0_2, &sp50);
            var_a0_2 = &sp78;
            var_a1_2 = temp_s0_2;
            var_a2_2 = &spA0;
        } else {
            func_800EB5BC(&sp28, arg0->unk84C);
            func_800EB4F4(&spF0, arg0->unk848);
            func_8009E854(&sp28, &spF0, &sp28);
            func_8009E854(&sp28, arg0 + 0xF0, &sp28);
            var_a0_2 = &sp28;
            var_a2_2 = &sp50;
            var_a1_2 = arg1 + 0x44;
        }
        func_8009E854(var_a0_2, var_a1_2, var_a2_2);
        if (((void *)0x8011F3A8->unk8 == 0) && ((void *)0x8011F3A8->unk10 == 0)) {
            var_a1_3 = 0;
            if (temp_s7 == 0x1C) {
                arg0->unkD0 = (s32) ((arg0->unkD0 + 0x1800) & 0xFFFF);
                arg0->unkD4 = (s32) ((arg0->unkD4 + 0x1800) & 0xFFFF);
            } else {
                var_a2_3 = arg0;
                var_v0_9 = arg0->unk46C;
                temp_a3_2 = *(s32 *)0x8013E704;
                if (var_v0_9 < 0) {
                    var_v0_9 = -var_v0_9;
                }
loop_75:
                if (var_a1_3 < 2) {
                    if (temp_a3_2 != 2) {
                        var_a0_3 = (s32) arg0->unk420 >> 6;
                    } else {
                        var_a0_3 = (s32) arg0->unk420 >> (8 - (void *)0x80118310->unk4);
                    }
                    if (var_a1_3 != 0) {
                        if ((u32) (var_v0_9 - 1) < 2U) {
                            goto block_83;
                        }
                    } else if (arg0->unk470 != 0) {
block_83:
                        temp_v1_3 = arg0->unk442;
                        if (temp_v1_3 != 1) {
                            temp_lo = (s32) (arg0->unk468 << 0x10) / (s32) (arg0->unk464 + (temp_v1_3 * 4))->unkC;
                            if (temp_a3_2 != 2) {
                                var_a0_3 = temp_lo << 9;
                            } else {
                                var_a0_3 = temp_lo << ((void *)0x80118310->unk4 + 7);
                            }
                        }
                    }
                    temp_v1_4 = arg0->unk474;
                    if (temp_v1_4 != 0) {
                        var_v0_10 = var_a0_3 < -0x1800;
                        if (temp_v1_4 & (var_a1_3 + 1)) {
                            var_a0_3 = 0;
                            goto block_90;
                        }
                    } else {
block_90:
                        var_v0_10 = var_a0_3 < -0x1800;
                    }
                    var_v0_11 = var_a0_3 < 0x1801;
                    if (var_v0_10 != 0) {
                        var_a0_3 = -0x1800;
                        var_v0_11 = -0x1800 < 0x1801;
                    }
                    if (var_v0_11 == 0) {
                        var_a0_3 = 0x1800;
                    }
                    var_a1_3 += 1;
                    var_a2_3->unkD0 = (s32) ((var_a2_3->unkD0 + var_a0_3) & 0xFFFF);
                    var_a2_3 += 4;
                    goto loop_75;
                }
            }
        }
        temp_a0_3 = arg0->unk420;
        var_s0 = arg0->unk450;
        if (temp_a0_3 > 0x1E0000) {
            temp_v0_2 = func_800E4FDC(var_s0 << 0x10, func_800E4F00(temp_a0_3, 0x888));
            temp_a0_4 = temp_v0_2;
            var_s0 = temp_a0_4 >> 0x10;
            if (temp_a0_4 < 0) {
                var_s0 = (s32) (temp_a0_4 + 0xFFFF) >> 0x10;
            }
        }
        func_800EB558(&spC8, var_s0 << 5);
        if ((arg0->unk43D != 0) && (arg0->unk454 == 0)) {
            var_v0_12 = arg0->unk8B6 | 1;
        } else {
            var_v0_12 = arg0->unk8B6 & 0xFE;
        }
        arg0->unk8B6 = var_v0_12;
        var_s4 = 0;
        if (temp_s7 < 0x1C) {
            var_a0_4 = temp_s8;
loop_106:
            if (var_s4 < 0x39) {
                var_a1_4 = (s8) *(0x801178C4 + (s32) var_a0_4);
                temp_v0_3 = var_a1_4 - 2;
                switch (temp_v0_3) {                /* switch 1 */
                case 0:                             /* switch 1 */
                case 7:                             /* switch 1 */
                    var_v0_13 = arg0->unk8C0 & 1;
block_146:
                    var_v1_2 = var_s4 - 6;
                    if (var_v0_13 != 0) {
                    case 15:                        /* switch 1 */
block_147:
                        var_a1_4 = 0;
                    default:                        /* switch 1 */
                        var_v1_2 = var_s4 - 6;
                    }
block_149:
                    var_v0_14 = var_v1_2 < 6U;
                    break;
                case 1:                             /* switch 1 */
                case 2:                             /* switch 1 */
                    var_v1_2 = var_s4 - 6;
                    if ((s16) arg0->unk8C0 == 0) {
                        var_a1_4 = 0;
                    }
                    goto block_149;
                case 9:                             /* switch 1 */
                    var_v0_13 = arg0->unk8B3 & 4;
                    goto block_146;
                case 10:                            /* switch 1 */
                    var_v1_2 = var_s4 - 6;
                    if (!(arg0->unk8B3 & 4)) {
                        var_a1_4 = 0;
                    }
                    goto block_149;
                case 5:                             /* switch 1 */
                    var_v0_15 = arg0->unk8B4 & 2;
block_130:
                    var_v1_2 = var_s4 - 6;
                    if (var_v0_15 == 0) {
                        var_a1_4 = 0;
                    }
                    goto block_149;
                case 6:                             /* switch 1 */
                    var_v1_2 = var_s4 - 6;
                    if (!(arg0->unk8B4 & 0x20)) {
                        var_a1_4 = 0;
                    }
                    goto block_149;
                case 20:                            /* switch 1 */
                    var_v1_2 = var_s4 - 6;
                    if (!(arg0->unk8B4 & 0x11)) {
                        var_a1_4 = 0;
                    }
                    goto block_149;
                case 12:                            /* switch 1 */
                    var_v1_2 = var_s4 - 6;
                    if (!(arg0->unk8B3 & 1)) {
                        var_a1_4 = 0;
                    }
                    goto block_149;
                case 11:                            /* switch 1 */
                    var_v0_13 = arg0->unk8B3 & 1;
                    goto block_146;
                case 3:                             /* switch 1 */
                    var_v0_13 = arg0->unk87E & 1;
                    goto block_146;
                case 4:                             /* switch 1 */
                    var_v0_13 = arg0->unk87E & 2;
                    goto block_146;
                case 16:                            /* switch 1 */
                    var_v1_2 = var_s4 - 6;
                    if ((s16) arg0->unk8B6 == 0) {
block_128:
                        if (temp_s6 != 0) {
                            var_v0_15 = arg0->unk570 & 2;
                            goto block_130;
                        }
                        goto block_147;
                    }
                    goto block_149;
                case 17:                            /* switch 1 */
                    var_v1_2 = var_s4 - 6;
                    if (arg0->unk442 != 0) {
                        goto block_128;
                    }
                    goto block_149;
                case 18:                            /* switch 1 */
                    if ((s32) arg0->unk8B8 & 0x800080) {
                        var_v1_2 = var_s4 - 6;
                        if (temp_s6 != 0) {
block_145:
                            var_v0_13 = arg0->unk87E & 4;
                            goto block_146;
                        }
                    } else {
                        goto block_147;
                    }
                    goto block_149;
                case 19:                            /* switch 1 */
                    if (temp_s6 == 0) {
                        var_v1_2 = var_s4 - 6;
                        if (!((s32) arg0->unk8B8 & 0x800080)) {
                            if (*(0x80117AF0 + temp_s7) != 0) {
                                var_v0_14 = var_v1_2 < 6U;
                                if ((s16) arg0->unk8B6 == 0) {
                                    var_a1_4 = 0;
                                }
                            } else {
                                goto block_147;
                            }
                        } else {
                            goto block_149;
                        }
                    } else {
                        if ((s32) arg0->unk8B8 & 0x800080) {
                            goto block_145;
                        }
                        goto block_147;
                        goto block_149;
                    }
                    break;
                case 13:                            /* switch 1 */
                    var_v1_2 = var_s4 - 6;
                    if (temp_s6 != 0) {
                        goto block_145;
                    }
                    goto block_149;
                case 14:                            /* switch 1 */
                    if (temp_s6 != 0) {
                        goto block_145;
                    }
                    goto block_147;
                    goto block_149;
                }
                if (var_v0_14 != 0) {
                    switch (var_v1_2) {             /* switch 2 */
                    case 0:                         /* switch 2 */
                    case 1:                         /* switch 2 */
                        var_v0_16 = arg0->unk87E & 0x18;
block_159:
                        if (var_v0_16 != 0) {
                            var_a1_4 = 0;
                        }
                        break;
                    case 2:                         /* switch 2 */
                    case 3:                         /* switch 2 */
                        if (arg0->unk87E & 4) {
                            temp_v0_4 = *(0x80117B44 + temp_s7);
                            var_a1_4 = temp_v0_4 & 1;
                            if (!(arg0->unk8B3 & 4)) {
                                var_a1_4 = temp_v0_4 & 0x80;
                            }
                            if ((var_a1_4 << 0x10) != 0) {
                                var_a1_4 = 0xB;
                            }
                        }
                        break;
                    case 4:                         /* switch 2 */
                    case 5:                         /* switch 2 */
                        var_v0_16 = arg0->unk87E & 4;
                        goto block_159;
                    }
                }
                *(0x80117B90 + var_s4) = var_a1_4;
                var_a0_4 += 6;
                var_s4 += 1;
                goto loop_106;
            }
        } else {
            var_a0_5 = temp_s8;
loop_164:
            if (var_s4 < 0x39) {
                var_a1_5 = (s8) *(0x801178C4 + (s32) var_a0_5);
                if (var_a1_5 != 0x12) {
                    switch (var_a1_5) {             /* switch 3; irregular */
                    case 1:                         /* switch 3 */
                        break;
                    default:                        /* switch 3 */
                        var_a1_5 = 0;
                        break;
                    case 22:                        /* switch 3 */
                        var_v0_17 = arg0->unk8B4 & 0x11;
                        goto block_172;
                    }
                } else {
                    var_v0_17 = (s16) arg0->unk8B6;
block_172:
                    if (var_v0_17 == 0) {
                        var_a1_5 = 0;
                    }
                }
                var_v0_18 = var_s4 + 0x80117B90;
                if (temp_s7 == 0x1C) {
                    var_v0_18 = var_s4 + 0x80117B90;
                    if (var_s4 == 0x20) {
                        var_a1_5 = 1;
                    }
                }
                *var_v0_18 = var_a1_5;
                var_a0_5 += 6;
                var_s4 += 1;
                goto loop_164;
            }
        }
        var_s4_2 = 0;
        temp_a2_3 = **(0x80117BEC + (s32) ((temp_s7 * 4) + (sp1B4 * 0xC8)));
        sp1BC = arg1 + 0x44;
        sp18 = temp_a2_3->unk4;
        sp1C = temp_a2_3->unk8;
        var_s6 = 0;
        sp20 = temp_a2_3->unkC;
loop_179:
        if (var_s4_2 < 0x39) {
            temp_a2_4 = *(*(0x80117BEC + (s32) ((temp_s7 * 4) + (sp1B4 * 0xC8))) + (var_s4_2 * 4));
            if ((temp_a2_4->unk2 != 0) && (*(0x80117B90 + var_s4_2) != 0)) {
                if (var_s4_2 >= 0x2F) {
                    var_a1_6 = (arg0 + (*(0x80117A1C + ((var_s4_2 - 0x2F) * 2)) * 0x30))->unk2B4;
                    if (var_a1_6 > 0) {
                        if (var_a1_6 >= 0x1EB9) {
                            var_a1_6 = 0x1EB8;
                        }
                    } else {
                        var_v1_3 = -0x1EB8;
                        if (var_a1_6 >= -0x1EB8) {
                            var_v1_3 = var_a1_6;
                        }
                        var_a1_6 = var_v1_3;
                    }
                } else {
                    var_a1_6 = sp1B0 - arg0->unk858;
                }
                var_a0_6 = temp_a2_4->unk4;
                if (arg0->unk8C2 == 3) {
                    if (var_s4_2 == 0x27) {
                        var_a0_6 += 0xCCC;
                    }
                    if (var_s4_2 == 0x28) {
                        var_a0_6 -= 0xCCC;
                    }
                }
                sp128 = var_a0_6 - sp18;
                sp12C = (temp_a2_4->unk8 - sp1C) - var_a1_6;
                sp130 = temp_a2_4->unkC - sp20;
                if (var_s4_2 < 0x2F) {
                    if (temp_s7 < 0x1C) {
                        if ((var_s4_2 >= 0x23) && (var_a1_7 = &sp78, ((var_s4_2 < 0x29) != 0))) {

                        } else {
                            goto block_202;
                        }
                    } else {
block_202:
                        var_a1_7 = &sp28;
                    }
                } else {
                    var_a1_7 = arg0 + 0xF0;
                }
                func_800EB820(&sp128, var_a1_7, &sp118);
                sp128 = (arg0->unkA0 + sp118) - arg1->unk8;
                sp12C = (arg0->unkA4 + sp11C) - arg1->unkC;
                temp_a3_3 = arg1->unk10;
                sp130 = (arg0->unkA8 + sp120) - temp_a3_3;
                func_800EB820(&sp128, sp1BC, saved_reg_gp->unkE34 + (var_s4_2 * 0xC), temp_a3_3);
                if (temp_s7 == 0x1C) {
                    switch (var_s4_2) {             /* switch 4; irregular */
                    case 31:                        /* switch 4 */
                        func_800EB558(&spF0, arg0->unkD0);
                        func_8009E854(&spF0, &sp28, &spF0);
                        func_8009E854(&spF0, sp1BC, saved_reg_gp->unkE30 + 0x45C);
                        var_s6 += 0x24;
                        break;
                    case 35:                        /* switch 4 */
                        func_800EB4F4(&spF0, arg0->unkD4);
                        func_8009E854(&spF0, &sp28, &spF0);
                        func_8009E854(&spF0, sp1BC, saved_reg_gp->unkE30 + 0x4EC);
                        var_s6 += 0x24;
                        break;
                    }
                } else {
                    switch (var_s4_2) {             /* switch 5 */
                    case 0x2F:                      /* switch 5 */
                        func_800EB4F4(&spF0, arg0->unkD0);
                        func_8009E854(&spF0, &spC8, &spF0);
                        var_a1_8 = arg0 + 0xF0;
block_234:
                        func_8009E854(&spF0, var_a1_8, &spF0);
                        func_8009E854(&spF0, arg1 + 0x44, saved_reg_gp->unkE30 + var_s6);
                        var_s6 += 0x24;
                        break;
                    case 0x30:                      /* switch 5 */
                    case 0x31:                      /* switch 5 */
                    case 0x32:                      /* switch 5 */
                    case 0x33:                      /* switch 5 */
                    case 0x34:                      /* switch 5 */
                        var_a0_7 = saved_reg_gp->unkE30 + 0x69C;
block_236:
                        func_800B0844(var_a0_7, saved_reg_gp->unkE30 + var_s6);
                        goto block_237;
                    case 0x35:                      /* switch 5 */
                        func_800EB4F4(&spF0, arg0->unkD4);
                        var_a1_8 = arg0 + 0xF0;
                        goto block_234;
                    case 0x36:                      /* switch 5 */
                        var_a0_7 = saved_reg_gp->unkE30 + 0x774;
                        goto block_236;
                    case 0x37:                      /* switch 5 */
                        func_800EB4F4(&spF0, arg0->unkD4);
                        var_a1_8 = arg0 + 0xF0;
                        goto block_234;
                    case 0x38:                      /* switch 5 */
                        var_a0_7 = saved_reg_gp->unkE30 + 0x7BC;
                        goto block_236;
                    case 0x23:                      /* switch 5 */
                    case 0x24:                      /* switch 5 */
                        var_a0_7 = &spA0;
                        goto block_236;
                    case 0x25:                      /* switch 5 */
                        var_v0_19 = arg0->unk450;
                        if (sp1B8 != 0) {
                            var_v0_19 = -var_v0_19;
                        }
                        func_800EB5BC(&spF0, -(var_v0_19 * 0x38));
block_233:
                        var_a1_8 = &sp78;
                        goto block_234;
                    case 0x26:                      /* switch 5 */
                        var_a1_9 = (s32) (arg0->unk84C * 3) >> 1;
                        temp_s1 = arg0->unk848 * 8;
                        if (sp1B8 != 0) {
                            var_a1_9 = -var_a1_9;
                        }
                        func_800EB5BC(&sp160, var_a1_9);
                        func_800EB4F4(&sp188, temp_s1);
                        var_a0_8 = &sp160;
                        var_a1_10 = &sp188;
block_232:
                        func_8009E854(var_a0_8, var_a1_10, &spF0);
                        goto block_233;
                    case 0x27:                      /* switch 5 */
                    case 0x28:                      /* switch 5 */
                        var_s0_2 = arg0->unk450;
                        var_s1 = -0xC;
                        if (sp1B8 != 0) {
                            var_s0_2 = -var_s0_2;
                        }
                        var_lo = var_s0_2 * -0xC;
                        if (var_s4_2 == 0x27) {
                            var_s1 = 0xC;
                            var_lo = var_s0_2 * 0xC;
                        }
                        func_800EB4F4(&sp138, var_lo);
                        if (var_s0_2 > 0) {
                            var_s0_2 = -var_s0_2;
                        }
                        func_800EB558(&sp160, var_s0_2 * (var_s1 >> 1));
                        var_a0_8 = &sp138;
                        var_a1_10 = &sp160;
                        goto block_232;
                    default:                        /* switch 5 */
                        var_a0_7 = &sp50;
                        goto block_236;
                    }
                }
            } else {
block_237:
                var_s6 += 0x24;
            }
            var_s4_2 += 1;
            goto loop_179;
        }
        temp_s1_2 = arg1 + 0x44;
        temp_s0_3 = arg1 + 0x38;
        func_800E2918(temp_s1_2, temp_s0_3, 1, arg0 + 0xA0, 0x8013E6A0);
        if ((saved_reg_gp->unkE44 != 0) && (arg0->unk90 == 0)) {
            func_800A319C(arg0, *(s32 *)0x8011F394);
            func_800E2918(temp_s1_2, temp_s0_3, 4, arg0 + 0x1E8, 0x80117BCC);
            saved_reg_gp->unkE40 = 1;
        } else {
            saved_reg_gp->unkE40 = 0;
        }
        if (((void *)0x8011F3A8->unk8 == 0) && ((void *)0x8011F3A8->unk10 == 0)) {
            if (*(void *)0x8013E704 != 2) {
                arg0->unkC8 = (u16) (arg0->unkC8 + arg0->unk422);
            } else {
                arg0->unkC8 = (u16) (arg0->unkC8 + ((s32) arg0->unk420 >> (0x12 - *(s32 *)0x80118314)));
            }
        }
        temp_a0_5 = *(s32 *)0x8013EB0C;
        var_s4_3 = 0;
        if (temp_a0_5 > 0) {
            var_v1_4 = *(s16 **)0x8013EB04;
loop_250:
            if (arg0->unk8 >= *var_v1_4) {
                var_s4_3 += 1;
                var_v1_4 += 6;
                if (var_s4_3 < temp_a0_5) {
                    goto loop_250;
                }
            }
        }
        temp_a0_6 = *(s32 *)0x8013EB10;
        arg0->unkCA = var_s4_3;
        var_s4_4 = 0;
        if (temp_a0_6 > 0) {
            var_v1_5 = *(s16 **)0x8013EB08;
loop_254:
            if (arg0->unk8 >= *var_v1_5) {
                var_s4_4 += 1;
                var_v1_5 += 6;
                if (var_s4_4 < temp_a0_6) {
                    goto loop_254;
                }
            }
        }
        arg0->unkCC = var_s4_4;
    }
}

/* NFS4-R-USA CHANGED @800ACDF8 | base 800AC164 Physics_Real__FP8Car_tObj */
/* callers: Physics_SimCar__FP8Car_tObj */
s32 func_800809F8(void *);                          /* extern */
? func_800867A8(void *, ?);                         /* extern */
? func_8009E4E0(s32 *, s32, s32, s32);              /* extern */
? func_800AA9A0(void *, s32, s32);                  /* extern */
? func_800AB49C(void *);                            /* extern */
s32 func_800AB618(void *);                          /* extern */
? func_800AC6D0(void *, s32 *);                     /* extern */
s32 func_800ACC38(void *, s32, s32);                /* extern */
s32 func_800E4F14(s32, s32, s32);                   /* extern */
? func_800E4F44(void *, s32 *);                     /* extern */
s32 func_800E4FF0(s32, s32);                        /* extern */

void func_800ACDF8(void *arg0) {
    s32 sp10;
    s32 sp14;
    s32 sp1C;
    s32 sp20;
    s32 sp24;
    s32 sp28;
    s32 sp2C;
    s32 sp34;
    s32 sp38;
    s32 sp40;
    s32 sp44;
    s32 sp4C;
    s32 sp50;
    s32 sp54;
    s32 sp58;
    s32 sp5C;
    s32 sp64;
    s32 sp68;
    s32 sp70;
    s32 sp74;
    s32 sp78;
    s32 sp80;
    s32 sp84;
    s32 sp88;
    s32 sp90;
    s32 sp94;
    s32 sp98;
    s32 spA0;
    s32 spC8;
    s32 spCC;
    s32 spD0;
    s32 spD8;
    s32 spDC;
    s32 spE0;
    s32 spE8;
    s32 spEC;
    s32 spF0;
    s32 temp_a0;
    s32 temp_a0_3;
    s32 temp_a1;
    s32 temp_a1_2;
    s32 temp_a1_3;
    s32 temp_a2;
    s32 temp_a2_2;
    s32 temp_a2_3;
    s32 temp_lo;
    s32 temp_lo_2;
    s32 temp_lo_3;
    s32 temp_lo_4;
    s32 temp_lo_5;
    s32 temp_s0;
    s32 temp_s0_10;
    s32 temp_s0_11;
    s32 temp_s0_12;
    s32 temp_s0_13;
    s32 temp_s0_14;
    s32 temp_s0_15;
    s32 temp_s0_16;
    s32 temp_s0_17;
    s32 temp_s0_18;
    s32 temp_s0_19;
    s32 temp_s0_20;
    s32 temp_s0_21;
    s32 temp_s0_22;
    s32 temp_s0_2;
    s32 temp_s0_3;
    s32 temp_s0_4;
    s32 temp_s0_5;
    s32 temp_s0_6;
    s32 temp_s0_7;
    s32 temp_s0_8;
    s32 temp_s0_9;
    s32 temp_s1;
    s32 temp_s1_10;
    s32 temp_s1_11;
    s32 temp_s1_12;
    s32 temp_s1_13;
    s32 temp_s1_14;
    s32 temp_s1_15;
    s32 temp_s1_16;
    s32 temp_s1_17;
    s32 temp_s1_2;
    s32 temp_s1_3;
    s32 temp_s1_4;
    s32 temp_s1_5;
    s32 temp_s1_6;
    s32 temp_s1_7;
    s32 temp_s1_8;
    s32 temp_s1_9;
    s32 temp_s2;
    s32 temp_s2_2;
    s32 temp_s2_3;
    s32 temp_s2_4;
    s32 temp_v0;
    s32 temp_v0_10;
    s32 temp_v0_2;
    s32 temp_v0_3;
    s32 temp_v0_4;
    s32 temp_v0_5;
    s32 temp_v0_6;
    s32 temp_v0_8;
    s32 temp_v0_9;
    s32 temp_v1;
    s32 temp_v1_2;
    s32 temp_v1_3;
    s32 temp_v1_4;
    s32 temp_v1_5;
    s32 temp_v1_6;
    s32 temp_v1_7;
    s32 temp_v1_8;
    s32 var_a0;
    s32 var_a0_10;
    s32 var_a0_2;
    s32 var_a0_3;
    s32 var_a0_4;
    s32 var_a0_5;
    s32 var_a0_6;
    s32 var_a0_7;
    s32 var_a0_8;
    s32 var_a0_9;
    s32 var_a1;
    s32 var_a1_10;
    s32 var_a1_2;
    s32 var_a1_3;
    s32 var_a1_4;
    s32 var_a1_5;
    s32 var_a1_6;
    s32 var_a1_7;
    s32 var_a1_8;
    s32 var_a1_9;
    s32 var_a2;
    s32 var_s0;
    s32 var_s0_2;
    s32 var_s0_3;
    s32 var_v0;
    s32 var_v0_10;
    s32 var_v0_11;
    s32 var_v0_12;
    s32 var_v0_13;
    s32 var_v0_14;
    s32 var_v0_15;
    s32 var_v0_16;
    s32 var_v0_18;
    s32 var_v0_19;
    s32 var_v0_20;
    s32 var_v0_21;
    s32 var_v0_22;
    s32 var_v0_23;
    s32 var_v0_2;
    s32 var_v0_3;
    s32 var_v0_4;
    s32 var_v0_5;
    s32 var_v0_6;
    s32 var_v0_7;
    s32 var_v0_8;
    s32 var_v0_9;
    s32 var_v1;
    s32 var_v1_10;
    s32 var_v1_12;
    s32 var_v1_13;
    s32 var_v1_14;
    s32 var_v1_2;
    s32 var_v1_3;
    s32 var_v1_4;
    s32 var_v1_5;
    s32 var_v1_6;
    s32 var_v1_7;
    s32 var_v1_8;
    s32 var_v1_9;
    s8 temp_a0_2;
    s8 var_v1_11;
    u32 var_v0_17;
    void *temp_s4;
    void *temp_s6;
    void *temp_v0_7;

    arg0->unk40C = 0;
    arg0->unk410 = 0;
    arg0->unk414 = 0;
    temp_s6 = arg0->unk464;
    saved_reg_gp->unkDC4 = 1;
    saved_reg_gp->unkDC8 = 1;
    if ((*(s32 *)0x801144EC != 0) && ((func_800809F8(arg0 + 8) ^ 1) != 0)) {
        saved_reg_gp->unkDC0 = 1;
    } else {
        saved_reg_gp->unkDC0 = 0;
    }
    if ((arg0->unk2AC != 0) && (arg0->unk2DC != 0) && (arg0->unk188 >= 0xCCD)) {
        saved_reg_gp->unkDC4 = 0;
    }
    if ((arg0->unk30C != 0) && (arg0->unk33C != 0) && (arg0->unk188 >= 0xCCD)) {
        saved_reg_gp->unkDC8 = 0;
    }
    temp_s0 = func_800E4F14(arg0->unkAC, arg0->unk1C4);
    temp_s1 = func_800E4F14(arg0->unkB0, arg0->unk1C8);
    arg0->unk418 = (s32) (temp_s0 + temp_s1 + func_800E4F14(arg0->unkB4, arg0->unk1CC));
    temp_s0_2 = func_800E4F14(arg0->unkAC, arg0->unk1D0);
    temp_s1_2 = func_800E4F14(arg0->unkB0, arg0->unk1D4);
    arg0->unk41C = (s32) (temp_s0_2 + temp_s1_2 + func_800E4F14(arg0->unkB4, arg0->unk1D8));
    temp_s0_3 = func_800E4F14(arg0->unkAC, arg0->unk1DC);
    temp_s1_3 = func_800E4F14(arg0->unkB0, arg0->unk1E0);
    arg0->unk420 = (s32) (temp_s0_3 + temp_s1_3 + func_800E4F14(arg0->unkB4, arg0->unk1E4));
    temp_s0_4 = func_800E4F14(arg0->unk114, arg0->unk1C4);
    temp_s1_4 = func_800E4F14(arg0->unk118, arg0->unk1C8);
    arg0->unk424 = (s32) (temp_s0_4 + temp_s1_4 + func_800E4F14(arg0->unk11C, arg0->unk1CC));
    temp_s0_5 = func_800E4F14(arg0->unk114, arg0->unk1D0);
    temp_s1_5 = func_800E4F14(arg0->unk118, arg0->unk1D4);
    arg0->unk428 = (s32) (temp_s0_5 + temp_s1_5 + func_800E4F14(arg0->unk11C, arg0->unk1D8));
    temp_s0_6 = func_800E4F14(arg0->unk114, arg0->unk1DC);
    temp_s1_6 = func_800E4F14(arg0->unk118, arg0->unk1E0);
    temp_a1 = arg0->unk420;
    arg0->unk42C = (s32) (temp_s0_6 + temp_s1_6 + func_800E4F14(arg0->unk11C, arg0->unk1E4));
    if (temp_a1 > 0x50000) {
        arg0->unk478 = func_800E4FF0(arg0->unk418, temp_a1);
    } else {
        arg0->unk478 = 0;
    }
    sp90 = (s32) -(arg0->unk418 << 5) / 2;
    sp94 = (s32) -(arg0->unk41C << 5) / 2;
    sp98 = (s32) -(arg0->unk420 << 5) / 2;
    temp_s2 = -func_800E4F14(arg0->unk118 << 5, temp_s6->unk1C4);
    temp_s2_2 = temp_s2 + ((u32) temp_s2 >> 0x1F);
    sp70 = 0;
    sp74 = -0xA0000;
    sp78 = 0;
    temp_s2_3 = temp_s2_2 >> 1;
    temp_s0_7 = func_800E4F14(0, arg0->unk1C4);
    temp_s1_7 = func_800E4F14(sp74, arg0->unk1C8);
    *(s32 *)0x8011788C = temp_s0_7 + temp_s1_7 + func_800E4F14(sp78, arg0->unk1CC);
    temp_s4 = (s32 *)0x80110000 + 0x788C;
    temp_s0_8 = func_800E4F14(sp70, arg0->unk1D0);
    temp_s1_8 = func_800E4F14(sp74, arg0->unk1D4);
    temp_s4->unk4 = (s32) (temp_s0_8 + temp_s1_8 + func_800E4F14(sp78, arg0->unk1D8));
    temp_s0_9 = func_800E4F14(sp70, arg0->unk1DC);
    temp_s1_9 = func_800E4F14(sp74, arg0->unk1E0);
    temp_s4->unk8 = (s32) (temp_s0_9 + temp_s1_9 + func_800E4F14(sp78, arg0->unk1E4));
    sp20 = sp90 + temp_s2_3;
    sp24 = sp94;
    sp28 = sp98;
    sp50 = sp90 - temp_s2_3;
    sp54 = sp94;
    sp58 = sp98;
    func_800AA9A0(arg0, sp94, sp98);
    var_v1 = ((s32) *(s32 *)0x8011788C / 256) * 0x300;
    if (var_v1 < 0) {
        var_v1 += 0xFFFF;
    }
    var_v1_2 = arg0->unk450 + (var_v1 >> 0x10);
    if (var_v1_2 >= 0x80) {
        var_v1_2 = 0x7F;
    } else if (var_v1_2 < -0x7F) {
        var_v1_2 = -0x7F;
    }
    temp_lo = var_v1_2 * temp_s6->unk10C;
    var_a1 = temp_lo >> 7;
    if (temp_lo < 0) {
        var_a1 = (s32) (temp_lo + 0x7F) >> 7;
    }
    sp1C = var_a1;
    temp_v1 = arg0->unk218 + arg0->unk21C + arg0->unk220 + arg0->unk23C;
    var_v0 = temp_v1;
    if (temp_v1 < 0) {
        var_v0 = temp_v1 + 0x1FF;
    }
    var_a0 = var_a1;
    var_v0_2 = 0x10000 - (var_v0 >> 9);
    if (var_a0 < 0) {
        var_a0 += 0xFF;
    }
    if (var_v0_2 < 0) {
        var_v0_2 += 0xFF;
    }
    sp1C = (var_a0 >> 8) * (var_v0_2 >> 8);
    temp_a0 = arg0->unk420;
    if (temp_a0 > 0x3C0000) {
        sp1C = func_800E4FF0(sp1C, func_800E4F14(temp_a0, 0x444));
    }
    temp_v1_2 = arg0->unk420;
    if (temp_v1_2 > 0x1AB333) {
        temp_v1_3 = arg0->unk478;
        var_v0_3 = temp_v1_3 < -0xCCC;
        if (temp_v1_3 >= 0xCCD) {
            var_v0_3 = temp_v1_3 < -0xCCC;
            if (sp1C <= 0) {
                goto block_38;
            }
            goto block_40;
        }
        goto block_38;
    }
    if (temp_v1_2 > 0xD6666) {
        temp_v1_4 = arg0->unk478;
        var_v0_3 = temp_v1_4 < -0x2666;
        if ((temp_v1_4 < 0x2667) || (var_v0_3 = temp_v1_4 < -0x2666, (sp1C <= 0))) {
block_38:
            if (var_v0_3 != 0) {
                if (sp1C < 0) {
                    goto block_40;
                }
            }
        } else {
block_40:
            var_v0_4 = arg0->unk478;
            var_a1_2 = 0x10000;
            if (var_v0_4 < 0) {
                var_v0_4 = -var_v0_4;
            }
            temp_v1_5 = var_v0_4 * 2;
            if (temp_v1_5 <= 0x10000) {
                var_a1_2 = temp_v1_5;
            }
            sp1C = func_800E4F14(sp1C, var_a1_2);
        }
    }
    sp4C = 0;
    sp38 = 1;
    sp68 = 0;
    temp_v0 = func_800AB618(arg0);
    var_v1_3 = temp_v0;
    if (temp_v0 < 0) {
        var_v1_3 = temp_v0 + 0xFF;
    }
    var_v0_5 = temp_s6->unkF8;
    if (var_v0_5 < 0) {
        var_v0_5 += 0xFF;
    }
    temp_lo_2 = (var_v1_3 >> 8) * (var_v0_5 >> 8);
    sp10 = temp_lo_2;
    sp40 = temp_v0 - temp_lo_2;
    if ((saved_reg_gp->unkDC4 == 0) && (saved_reg_gp->unkDC8 == 0)) {
        arg0->unk484 = 0;
        arg0->unk488 = 0;
        return;
    }
    var_v1_4 = saved_reg_gp->unkD98;
    arg0->unk3EC = 0;
    if (var_v1_4 < 0) {
        var_v1_4 += 0xFF;
    }
    var_v0_6 = temp_s6->unkFC;
    if (var_v0_6 < 0) {
        var_v0_6 += 0xFF;
    }
    temp_lo_3 = (var_v1_4 >> 8) * (var_v0_6 >> 8);
    var_v0_7 = arg0->unk420;
    if (var_v0_7 < 0) {
        var_v0_7 = -var_v0_7;
    }
    var_a0_2 = var_v0_7 << 5;
    if (var_a0_2 >= temp_lo_3) {
        var_a0_2 = temp_lo_3;
    }
    var_v1_5 = arg0->unk23C;
    var_s0 = var_a0_2;
    if (var_v1_5 != 0) {
        var_a0_3 = var_s0;
        if (var_v1_5 < 0) {
            var_v1_5 += 0x7F;
        }
        var_v0_8 = 0x10000 - (var_v1_5 >> 7);
        if (var_s0 < 0) {
            var_a0_3 = var_s0 + 0xFF;
        }
        if (var_v0_8 < 0) {
            var_v0_8 += 0xFF;
        }
        var_s0 = (var_a0_3 >> 8) * (var_v0_8 >> 8);
    }
    if (arg0->unk420 > 0) {
        var_s0 = -var_s0;
    }
    temp_v0_2 = func_800E4F14(var_s0, temp_s6->unk100);
    sp10 += temp_v0_2;
    sp40 += var_s0 - temp_v0_2;
    temp_s1_10 = func_800E4F14(-*(s32 *)0x80117890, temp_s6->unk114);
    func_800AB49C(arg0);
    var_v1_6 = temp_s1_10;
    if (temp_s1_10 < 0) {
        var_v1_6 = temp_s1_10 + 0xFF;
    }
    var_v0_9 = saved_reg_gp->unkDAC;
    if (var_v0_9 < 0) {
        var_v0_9 += 0xFF;
    }
    temp_lo_4 = (var_v1_6 >> 8) * (var_v0_9 >> 8);
    if (temp_lo_4 >= 0) {
        if (saved_reg_gp->unkDC0 != 0) {
            var_a1_3 = temp_s6->unk108 + 0x28F;
        } else {
            var_a1_3 = temp_s6->unk108;
        }
        temp_s2_4 = func_800E4F14(temp_lo_4, var_a1_3);
        temp_v0_3 = arg0->unk228 + arg0->unk22C + arg0->unk230 + arg0->unk23C;
        var_v1_7 = temp_v0_3 >> 9;
        if (temp_v0_3 < 0) {
            var_v1_7 = (s32) (temp_v0_3 + 0x1FF) >> 9;
        }
        temp_s0_10 = var_v1_7 + 0xC000;
        temp_v0_4 = func_800E4F14(arg0->unk47C, temp_s0_10);
        arg0->unk47C = temp_v0_4;
        if (temp_v0_4 < 0) {
            var_a1_4 = temp_s0_10;
            if (var_a1_4 < 0) {
                var_a1_4 += 0xFF;
            }
            arg0->unk47C = (s32) (((s32) (temp_v0_4 + 0xFF) >> 8) * (var_a1_4 >> 8));
        } else if (temp_v0_4 > 0) {
            arg0->unk47C = (s32) ((s32) (temp_v0_4 * 3) / 4);
        }
        var_v1_8 = saved_reg_gp->unkDB0;
        var_v0_10 = temp_s2_4 - arg0->unk47C;
        sp14 = var_v0_10;
        if (var_v1_8 < 0) {
            var_v1_8 += 0xFF;
        }
        if (var_v0_10 < 0) {
            var_v0_10 += 0xFF;
        }
        sp14 = (var_v1_8 >> 8) * (var_v0_10 >> 8);
        var_a0_4 = saved_reg_gp->unkDB4;
        var_v0_11 = (temp_lo_4 - temp_s2_4) + arg0->unk47C;
        sp44 = var_v0_11;
        if (var_a0_4 < 0) {
            var_a0_4 += 0xFF;
        }
        if (var_v0_11 < 0) {
            var_v0_11 += 0xFF;
        }
        sp44 = (var_a0_4 >> 8) * (var_v0_11 >> 8);
        arg0->unk474 = 0;
        sp2C = 0;
        sp34 = 0;
        sp5C = 0;
        sp64 = 0;
        if (saved_reg_gp->unkDC4 != 0) {
            func_800AC6D0(arg0, &sp10);
        }
        if (saved_reg_gp->unkDC8 != 0) {
            func_800AC6D0(arg0, &sp40);
        }
        arg0->unk414 = (s32) (sp34 + sp64);
        arg0->unk40C = (s32) (sp2C + sp5C);
        temp_v0_5 = func_800E4F14(arg0->unk414, temp_s6->unk1CC);
        arg0->unk414 = temp_v0_5;
        if ((*(s32 *)0x801144DC & 0x80) && (temp_v0_5 > 0) && (arg0->unk446 != 0)) {
            arg0->unk414 = (s32) (temp_v0_5 * 4);
        }
        if (saved_reg_gp->unkDC0 == 0) {
            if ((arg0->unk288->unk38 == 2) && ((u8) arg0->unk442 < 4U)) {
                var_a1_5 = 0x12666;
            } else {
                var_a1_5 = 0x11999;
            }
            arg0->unk414 = func_800E4F14(arg0->unk414, var_a1_5);
        }
        arg0->unk410 = 0;
        var_a0_5 = arg0->unk40C;
        temp_s0_11 = -func_800E4F14(*(s32 *)0x80117894, 0x1999);
        if (var_a0_5 < 0) {
            var_a0_5 += 7;
        }
        arg0->unk480 = (s32) -func_800E4F14(var_a0_5 >> 3, temp_s6->unk124);
        arg0->unk47C = (s32) (func_800E4F14(arg0->unk414, temp_s6->unk124) + temp_s0_11);
        temp_s0_12 = func_800E4F14(sp2C - sp5C, temp_s6->unk1C8);
        temp_s0_13 = temp_s0_12 + (func_800E4F14(func_800E4F14(sp34 + sp64, saved_reg_gp->unkDB8 - saved_reg_gp->unkDBC, sp34), temp_s6->unk1C8) * 2);
        sp84 = temp_s0_13;
        temp_v0_6 = arg0->unk118;
        if (((temp_v0_6 > 0) && (temp_s0_13 > 0)) || ((temp_v0_6 < 0) && (temp_s0_13 < 0))) {
            if ((arg0->unk445 != 0) && !(*(void *)0x801144DC & 8)) {
                var_v0_12 = (s32) (sp84 + ((u32) sp84 >> 0x1F)) >> 1;
            } else {
                temp_v1_6 = arg0->unk44C;
                if ((((temp_v1_6 < 0) && (arg0->unk118 >= 0x3334)) || ((temp_v1_6 > 0) && (arg0->unk118 < -0x3333))) && (arg0->unk46C == 1)) {
                    var_v0_12 = -arg0->unk118;
                } else {
                    var_v0_12 = func_800E4F14(sp84, arg0->unk464->unk12C);
                }
            }
            sp84 = var_v0_12;
        }
        sp80 = 0;
        sp88 = 0;
        func_800E4F44(arg0 + 0x1C4, &spA0);
        func_800867A8(arg0, 0);
        temp_s0_14 = func_800E4F14(arg0->unk40C, spA0);
        temp_s1_11 = func_800E4F14(arg0->unk410, spA4);
        arg0->unk400 = (s32) (temp_s0_14 + temp_s1_11 + func_800E4F14(arg0->unk414, spA8));
        temp_s0_15 = func_800E4F14(arg0->unk40C, spAC);
        temp_s1_12 = func_800E4F14(arg0->unk410, spB0);
        arg0->unk404 = (s32) (temp_s0_15 + temp_s1_12 + func_800E4F14(arg0->unk414, spB4));
        temp_s0_16 = func_800E4F14(arg0->unk40C, spB8);
        temp_s1_13 = func_800E4F14(arg0->unk410, spBC);
        arg0->unk408 = (s32) (temp_s0_16 + temp_s1_13 + func_800E4F14(arg0->unk414, spC0));
        temp_s0_17 = func_800E4F14(sp80, spA0);
        temp_s1_14 = func_800E4F14(sp84, spA4);
        arg0->unk3F4 = (s32) (temp_s0_17 + temp_s1_14 + func_800E4F14(sp88, spA8));
        temp_s0_18 = func_800E4F14(sp80, spAC);
        temp_s1_15 = func_800E4F14(sp84, spB0);
        arg0->unk3F8 = (s32) (temp_s0_18 + temp_s1_15 + func_800E4F14(sp88, spB4));
        temp_s0_19 = func_800E4F14(sp80, spB8);
        temp_s1_16 = func_800E4F14(sp84, spBC);
        var_v1_9 = arg0->unk400;
        arg0->unk3FC = (s32) (temp_s0_19 + temp_s1_16 + func_800E4F14(sp88, spC0));
        if (var_v1_9 < 0) {
            var_v1_9 += 0x1F;
        }
        var_a0_6 = arg0->unk404;
        arg0->unkAC = (s32) (arg0->unkAC + (var_v1_9 >> 5));
        if (var_a0_6 < 0) {
            var_a0_6 += 0x1F;
        }
        var_a1_6 = arg0->unk408;
        arg0->unkB0 = (s32) (arg0->unkB0 + (var_a0_6 >> 5));
        if (var_a1_6 < 0) {
            var_a1_6 += 0x1F;
        }
        var_a0_7 = arg0->unk3F4;
        arg0->unkB4 = (s32) (arg0->unkB4 + (var_a1_6 >> 5));
        if (var_a0_7 < 0) {
            var_a0_7 += 0x1F;
        }
        var_a1_7 = arg0->unk3F8;
        arg0->unk114 = (s32) (arg0->unk114 + (var_a0_7 >> 5));
        if (var_a1_7 < 0) {
            var_a1_7 += 0x3F;
        }
        var_a0_8 = arg0->unk3FC;
        arg0->unk118 = (s32) (arg0->unk118 + (var_a1_7 >> 6));
        if (var_a0_8 < 0) {
            var_a0_8 += 0x1F;
        }
        arg0->unk11C = (s32) (arg0->unk11C + (var_a0_8 >> 5));
        if (arg0->unk460 != 0) {
            if (arg0->unk55C <= 0x471C6) {
                if ((u8) arg0->unk442 >= 2U) {
                    var_v0_13 = arg0->unk442 * 4;
                } else {
                    var_v0_13 = 8;
                }
                var_a1_8 = (temp_s6 + var_v0_13)->unkC;
                var_a0_9 = 0x188000;
            } else {
                if ((u8) arg0->unk442 >= 2U) {
                    var_v0_14 = arg0->unk442 * 4;
                } else {
                    var_v0_14 = 8;
                }
                var_a0_9 = arg0->unk55C;
                var_a1_8 = (temp_s6 + var_v0_14)->unkC;
            }
            var_v1_10 = func_800E4F14(var_a0_9, var_a1_8);
            if (var_v1_10 < 0) {
                var_v1_10 += 0xFFFF;
            }
            temp_s0_20 = var_v1_10 >> 0x10;
            if ((u8) arg0->unk442 >= 2U) {
                var_v0_15 = arg0->unk442 * 4;
            } else {
                var_v0_15 = 8;
            }
            var_a1_9 = func_800E4F14(arg0->unk420, (temp_s6 + var_v0_15)->unkC);
            if (var_a1_9 < 0) {
                var_a1_9 += 0xFFFF;
            }
            temp_lo_5 = (s32) (temp_s0_20 << 8) / (s32) temp_s6->unkF0;
            temp_a1_2 = temp_s0_20 - (var_a1_9 >> 0x10);
            if (temp_a1_2 >= 0xC9) {
                var_v1_11 = temp_lo_5 + ((s32) (temp_a1_2 << 7) / temp_s0_20);
                if (var_v1_11 >= 0xE1) {
                    var_v1_11 = -0x20;
                }
                arg0->unk458 = var_v1_11;
            } else if (temp_a1_2 < 0xC8) {
                temp_a0_2 = temp_lo_5 + ((s32) (temp_a1_2 << 7) / temp_s0_20);
                if (temp_a0_2 >= 0) {
                    arg0->unk458 = temp_a0_2;
                } else {
                    arg0->unk458 = 0;
                }
                if (temp_a1_2 < 0) {
                    var_v0_16 = temp_a1_2 << 9;
                    if (temp_a1_2 & 0x400000) {
                        var_v0_16 = -var_v0_16;
                    }
                    var_v1_12 = var_v0_16 / (s32) temp_s6->unkF0;
                    var_v0_17 = var_v1_12 & 0xFF;
                    if (var_v1_12 >= 0x100) {
                        var_v1_12 = 0xFF;
                        var_v0_17 = 0xFF & 0xFF;
                    }
                    arg0->unk459 = (s8) var_v1_12;
                    if (var_v0_17 >= 0x81U) {
                        arg0->unk458 = 0;
                    }
                }
            }
            var_v0_18 = arg0->unk564;
            if (var_v0_18 < 0) {
                var_v0_18 = -var_v0_18;
            }
            temp_a2 = var_v0_18 / 393216;
            temp_v1_7 = arg0->unk460;
            if (temp_a2 >= 3) {
                var_v1_13 = temp_v1_7 * temp_a2;
            } else {
                var_v1_13 = temp_v1_7 * 3;
            }
            if (var_v1_13 >= 0) {
                temp_a0_3 = *(s32 *)0x8013DABC;
                var_a1_10 = arg0->unk8 + var_v1_13;
                if (var_a1_10 >= temp_a0_3) {
                    var_a1_10 -= temp_a0_3;
                }
            } else {
                var_a1_10 = arg0->unk8 + var_v1_13;
                if (var_a1_10 < 0) {
                    var_a1_10 += *(void *)0x8013DABC;
                }
            }
            temp_s0_21 = var_a1_10 << 5;
            var_a2 = var_v1_13 * 3;
            if (var_a2 < 0) {
                var_a2 = -var_a2;
            }
            spC8 = arg0->unkA0;
            spCC = arg0->unkA4;
            spD0 = arg0->unkA8;
            temp_v0_7 = temp_s0_21 + *(s32 *)0x8013DAB4;
            spD8 = temp_v0_7->unk0;
            spDC = temp_v0_7->unk4;
            spE0 = temp_v0_7->unk8;
            temp_v0_8 = func_800ACC38(arg0, var_a1_10, var_a2);
            spE8 = func_800E4F14((temp_s0_21 + *(void *)0x8013DAB4)->unk12 << 9, temp_v0_8);
            spEC = func_800E4F14((temp_s0_21 + *(void *)0x8013DAB4)->unk13 << 9, temp_v0_8);
            temp_v0_9 = func_800E4F14((temp_s0_21 + *(void *)0x8013DAB4)->unk14 << 9, temp_v0_8);
            temp_a1_3 = spD8 + spE8;
            temp_a2_2 = spDC + spEC;
            spF0 = temp_v0_9;
            spD8 = temp_a1_3;
            temp_v1_8 = spE0 + temp_v0_9;
            spD8 = temp_a1_3 - spC8;
            spDC = temp_a2_2;
            spE0 = temp_v1_8;
            temp_a2_3 = temp_a2_2 - spCC;
            spDC = temp_a2_3;
            spE0 = temp_v1_8 - spD0;
            func_8009E4E0(&spD8, spD0, temp_a2_3, spC8);
            temp_s0_22 = func_800E4F14(spD8, arg0->unkF0);
            temp_s1_17 = func_800E4F14(spDC, arg0->unkF4);
            temp_v0_10 = temp_s0_22 + temp_s1_17 + func_800E4F14(spE0, arg0->unkF8);
            var_s0_2 = temp_v0_10 >> 8;
            if (temp_v0_10 < 0) {
                var_s0_2 = (s32) (temp_v0_10 + 0xFF) >> 8;
            }
            arg0->unk45C = var_s0_2;
            if (var_s0_2 >= 0x80) {
                var_v0_19 = 0x7F;
                goto block_188;
            }
            var_v0_19 = -0x7F;
            if (var_s0_2 < -0x7F) {
block_188:
                arg0->unk45C = var_v0_19;
            }
        }
        if (!(*(void *)0x801144DC & 8)) {
            if (arg0->unk43F != 0) {
                var_v0_20 = arg0->unk478;
                if (var_v0_20 < 0) {
                    var_v0_20 = -var_v0_20;
                }
                if (var_v0_20 >= 0x199A) {
                    goto block_194;
                }
            } else {
block_194:
                arg0->unkAC = func_800E4F14(arg0->unk464->unk158, arg0->unkAC);
                arg0->unkB0 = func_800E4F14(arg0->unk464->unk158, arg0->unkB0);
                arg0->unkB4 = func_800E4F14(arg0->unk464->unk158, arg0->unkB4);
            }
        }
        if ((arg0->unk1C0 == 3) && (arg0->unkC0 > 0x2CA3D7)) {
            arg0->unkAC = func_800E4F14(0xFEB8, arg0->unkAC);
            var_v0_21 = func_800E4F14(0xFEB8, arg0->unkB0);
            var_a0_10 = 0xFEB8;
            goto block_213;
        }
        if (arg0->unk442 == 1) {
            var_v1_14 = *(void *)0x80117894;
            if (var_v1_14 < 0) {
                var_v1_14 = -var_v1_14;
            }
            if (var_v1_14 <= 0x7FFF) {
                var_v0_22 = arg0->unk420;
                if (var_v0_22 < 0) {
                    var_v0_22 = -var_v0_22;
                }
                var_s0_3 = 0xFD70;
                if (var_v0_22 > 0x13FFFF) {
                    var_v0_23 = arg0->unk450;
                    if (var_v0_23 < 0) {
                        var_v0_23 = -var_v0_23;
                    }
                    var_s0_3 = 0xFF7C;
                    if (var_v0_23 >= 0x21) {
                        var_s0_3 = 0xFD70;
                    }
                }
                arg0->unkAC = func_800E4F14(var_s0_3, arg0->unkAC);
                arg0->unkB0 = func_800E4F14(var_s0_3, arg0->unkB0);
                arg0->unkB4 = func_800E4F14(var_s0_3, arg0->unkB4);
                arg0->unk114 = func_800E4F14(var_s0_3, arg0->unk114);
                arg0->unk118 = func_800E4F14(var_s0_3, arg0->unk118);
                arg0->unk11C = func_800E4F14(var_s0_3, arg0->unk11C);
                return;
            }
            goto block_210;
        }
block_210:
        if ((arg0->unk445 != 0) && (arg0->unkC0 <= 0xFFFF)) {
            arg0->unkAC = func_800E4F14(0x8000, arg0->unkAC);
            var_v0_21 = func_800E4F14(0x8000, arg0->unkB0);
            var_a0_10 = 0x8000;
block_213:
            arg0->unkB0 = var_v0_21;
            arg0->unkB4 = func_800E4F14(var_a0_10, arg0->unkB4);
        }
    }
}

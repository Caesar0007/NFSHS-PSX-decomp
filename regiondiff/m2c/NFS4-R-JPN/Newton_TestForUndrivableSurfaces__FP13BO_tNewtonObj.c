/* NFS4-R-JPN CHANGED @800A3990 | base 800A2E84 Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj */
/* callers: Collide_CheckMeForCollisions__FP13BO_tNewtonObj */
? func_8006D120(void *);                            /* extern */
? func_800804E8(s32 *, ?, ?, s32);                  /* extern */
s32 func_8008074C(s32 *, void *, ?, s32 *);         /* extern */
? func_8009E698(s32 *);                             /* extern */
? func_8009FA38(void *, s32, s32, ?);               /* extern */
? func_800A35FC(void *, s32, s32, s32);             /* extern */
? func_800A37A4(s8, s32 *, void *);                 /* extern */
s32 func_800A3930(void *, ?, s32);                  /* extern */
? func_800AAF2C(void *);                            /* extern */
? func_800E4CF0(s32 *, ?, ?);                       /* extern */

void func_800A3990(void *arg0) {
    s32 sp10;
    s32 sp14;
    s32 sp18;
    s32 sp20;
    s32 sp24;
    s32 sp28;
    s32 sp30;
    s32 sp34;
    s32 sp38;
    s32 sp40;
    s32 sp44;
    s32 sp48;
    s32 sp50;
    s32 sp54;
    s32 sp58;
    s32 sp60;
    s32 sp64;
    s32 sp68;
    s32 sp70;
    s32 sp74;
    s32 sp78;
    s32 sp80;
    s32 sp84;
    s32 *var_v0;
    s32 *var_v0_5;
    s32 *var_v1;
    s32 *var_v1_2;
    s32 *var_v1_3;
    s32 temp_a0_2;
    s32 temp_a1;
    s32 temp_a1_2;
    s32 temp_v0;
    s32 temp_v0_3;
    s32 temp_v0_5;
    s32 var_a2_4;
    s32 var_a3;
    s32 var_a3_2;
    s32 var_s2;
    s32 var_s6;
    s32 var_v0_4;
    s32 var_v0_6;
    s32 var_v0_7;
    s32 var_v1_4;
    s32 var_v1_5;
    s32 var_v1_6;
    s32 var_v1_7;
    s8 temp_a0;
    s8 var_a0;
    s8 var_a0_2;
    s8 var_a0_3;
    s8 var_v0_3;
    void *temp_s4;
    void *temp_v0_2;
    void *temp_v0_4;
    void *var_a2;
    void *var_a2_2;
    void *var_a2_3;
    void *var_s5;
    void *var_v0_2;

    var_s6 = 0;
    sp80 = 0;
    func_800E4CF0(&sp10, 0, 0xC);
    sp20 = arg0->unk168;
    sp24 = arg0->unk16C;
    sp28 = arg0->unk170;
    func_800E4CF0(&sp40, 0, 0xC);
    var_v0 = (s32 *)0x801151D8;
    var_v1 = arg0 + 8;
    do {
        var_v0->unk0 = var_v1->unk0;
        var_v0->unk4 = (s32) var_v1->unk4;
        var_v0->unk8 = (s32) var_v1->unk8;
        var_v0->unkC = (s32) var_v1->unkC;
        var_v1 += 0x10;
        var_v0 += 0x10;
    } while (var_v1 != (arg0 + 0x88));
    *var_v0 = *var_v1;
    var_s2 = 0;
    if (arg0->unkC0 > 0x280000) {
        sp40 = (s32) (arg0->unkAC * 5) / 256;
        sp44 = (s32) (arg0->unkB0 * 5) / 256;
        sp48 = (s32) (arg0->unkB4 * 5) / 256;
        var_s2 = 0;
    }
    temp_s4 = arg0 + 8;
    var_s5 = arg0;
    sp84 = 0;
loop_5:
    if (var_s2 < 4) {
        sp50 = var_s5->unk28C;
        sp54 = var_s5->unk290;
        sp58 = var_s5->unk294;
        sp50 += sp40;
        sp54 += sp44;
        sp58 += sp48;
        func_800804E8(&sp50, 0x801151D8, 1, sp44);
        temp_a0 = (void *)0x801151D8->unk5A;
        if (temp_a0 != 0) {
            func_800A37A4(temp_a0, &sp10, arg0 + 8);
            sp14 = 0;
            func_8009E698(&sp10);
            var_s6 = 1;
        } else if (func_800A3930(arg0, 0x801151D8, var_s2) != 0) {
            var_v1_2 = (s32 *)0x8011525C;
            var_v0_2 = (void *)0x801151D8;
            do {
                var_v1_2->unk0 = var_v0_2->unk0;
                var_v1_2->unk4 = (s32) var_v0_2->unk4;
                var_v1_2->unk8 = (s32) var_v0_2->unk8;
                var_v1_2->unkC = (s32) var_v0_2->unkC;
                var_v0_2 += 0x10;
                var_v1_2 += 0x10;
            } while (var_v0_2 != (void *)0x80115258);
            *var_v1_2 = *(s32 *)0x80115258;
            sp60 = sp50;
            sp64 = sp54;
            sp68 = sp58;
            temp_v0 = func_8008074C(&sp50, temp_s4, 0x801151D8, &sp80);
            var_v0_3 = 1;
            var_s6 = 2;
            if (temp_v0 != 1) {
                if (temp_v0 == 2) {
                    var_a0 = 2;
                    goto block_17;
                }
                var_a0 = 4;
                if (temp_v0 != 4) {
                    var_v0_3 = 8;
                    if (temp_v0 == 8) {
                        goto block_16;
                    }
                    if ((temp_v0 == 0) || (var_v0_4 = temp_v0 & 3, (temp_v0 == 0xC))) {
                        sp10 = -arg0->unkAC;
                        sp14 = -arg0->unkB0;
                        sp18 = -arg0->unkB4;
                        var_v0_4 = temp_v0 & 3;
                    }
                } else {
                    goto block_17;
                }
            } else {
block_16:
                var_a0 = var_v0_3;
block_17:
                func_800A37A4(var_a0, &sp10, temp_s4);
                var_v0_4 = temp_v0 & 3;
            }
            if (var_v0_4 != 0) {
                var_a0_2 = 1;
                if ((temp_v0 & 1) || (var_a0_2 = 2, ((temp_v0 & 2) != 0))) {
                    func_800A37A4(var_a0_2, &sp10, arg0 + 8);
                }
                sp60 += sp10;
                sp64 += sp14;
                sp68 += sp18;
                func_800804E8(&sp60, 0x8011525C, 1, sp14);
                if (func_800A3930(arg0, 0x8011525C, var_s2) != 0) {
                    if (temp_v0 & 0xC) {
                        var_a0_3 = 4;
                        if (temp_v0 & 4) {
                            var_a2 = arg0 + 8;
                            goto block_31;
                        }
                        var_a0_3 = 8;
                        if (temp_v0 & 8) {
                            var_a2 = arg0 + 8;
block_31:
                            func_800A37A4(var_a0_3, &sp10, var_a2);
                        }
                        var_v1_3 = (s32 *)0x8011525C;
                        var_v0_5 = (s32 *)0x801151D8;
                        do {
                            var_v1_3->unk0 = var_v0_5->unk0;
                            var_v1_3->unk4 = (s32) var_v0_5->unk4;
                            var_v1_3->unk8 = (s32) var_v0_5->unk8;
                            var_v1_3->unkC = (s32) var_v0_5->unkC;
                            var_v0_5 += 0x10;
                            var_v1_3 += 0x10;
                        } while (var_v0_5 != (s32 *)0x80115258);
                        *var_v1_3 = *var_v0_5;
                        sp60 = sp50;
                        sp64 = sp54;
                        sp68 = sp58;
                        sp60 += sp10;
                        sp64 += sp14;
                        sp68 += sp18;
                        func_800804E8(&sp60, 0x8011525C, 1, sp14);
                        var_a3 = 0;
                        if (func_800A3930(arg0, 0x8011525C, var_s2) != 0) {
                            var_a2_2 = (void *)0x801151E0;
                            sp38 = 0;
                            sp34 = 0;
                            sp30 = 0;
loop_36:
                            if (var_a3 < 4) {
                                if ((void *)0x801151D8->unk78 != 0) {
                                    sp70 = var_a2_2->unk0;
                                    sp74 = var_a2_2->unk4;
                                    sp78 = var_a2_2->unk8;
                                    var_a2_2 += 0xC;
                                } else {
                                    temp_v0_2 = ((void *)0x801151D8->unk0 << 5) + *(s32 *)0x8013D8A0;
                                    sp70 = temp_v0_2->unk0;
                                    sp74 = temp_v0_2->unk4;
                                    sp78 = temp_v0_2->unk8;
                                    var_a2_2 += 0xC;
                                }
                                var_a3 += 1;
                                sp30 += sp70;
                                sp34 += sp74;
                                sp38 += sp78;
                                goto loop_36;
                            }
                            var_v1_4 = sp30;
                            if (var_v1_4 < 0) {
                                var_v1_4 += 3;
                            }
                            var_v0_6 = sp34;
                            temp_a1 = var_v1_4 >> 2;
                            sp30 = temp_a1;
                            if (var_v0_6 < 0) {
                                var_v0_6 += 3;
                            }
                            var_v1_5 = sp38;
                            sp34 = var_v0_6 >> 2;
                            if (var_v1_5 < 0) {
                                var_v1_5 += 3;
                            }
                            temp_v0_3 = var_v1_5 >> 2;
                            sp38 = temp_v0_3;
                            sp14 = 0;
                            sp10 = sp20 - temp_a1;
                            sp18 = sp28 - temp_v0_3;
                        }
                    } else {
                        var_a3_2 = 0;
                        var_a2_3 = (void *)0x801151E0;
                        sp38 = 0;
                        sp34 = 0;
                        sp30 = 0;
loop_49:
                        if (var_a3_2 < 4) {
                            if ((void *)0x801151D8->unk78 != 0) {
                                sp70 = var_a2_3->unk0;
                                sp74 = var_a2_3->unk4;
                                sp78 = var_a2_3->unk8;
                                var_a2_3 += 0xC;
                            } else {
                                temp_v0_4 = ((void *)0x801151D8->unk0 << 5) + *(void *)0x8013D8A0;
                                sp70 = temp_v0_4->unk0;
                                sp74 = temp_v0_4->unk4;
                                sp78 = temp_v0_4->unk8;
                                var_a2_3 += 0xC;
                            }
                            var_a3_2 += 1;
                            sp30 += sp70;
                            sp34 += sp74;
                            sp38 += sp78;
                            goto loop_49;
                        }
                        var_v1_6 = sp30;
                        if (var_v1_6 < 0) {
                            var_v1_6 += 3;
                        }
                        var_v0_7 = sp34;
                        temp_a0_2 = var_v1_6 >> 2;
                        sp30 = temp_a0_2;
                        if (var_v0_7 < 0) {
                            var_v0_7 += 3;
                        }
                        var_v1_7 = sp38;
                        sp34 = var_v0_7 >> 2;
                        if (var_v1_7 < 0) {
                            var_v1_7 += 3;
                        }
                        temp_v0_5 = var_v1_7 >> 2;
                        sp38 = temp_v0_5;
                        sp10 = arg0->unkA0 - temp_a0_2;
                        sp14 = 0;
                        sp18 = arg0->unkA8 - temp_v0_5;
                    }
                }
            }
            sp14 = 0;
            func_8009E698(&sp10);
        }
        if (var_s6 != 0) {
            if (0 == 0) {
                func_800A35FC(arg0, sp10, sp14, sp18);
                arg0->unk1A0 = (s32) var_s5->unk28C;
                arg0->unk1A4 = (s32) var_s5->unk290;
                arg0->unk1A8 = (s32) var_s5->unk294;
                func_8006D120(arg0);
                if (arg0->unk260 & 4) {
                    func_800AAF2C(arg0);
                }
                temp_a1_2 = arg0->unk190;
                if (temp_a1_2 > 0xA0000) {
                    var_a2_4 = 6;
                    if (var_s2 != 2) {
                        var_a2_4 = sp84;
                        if (var_s2 == 3) {
                            var_a2_4 = 4;
                        }
                    }
                    func_8009FA38(arg0, temp_a1_2, var_a2_4, 1);
                }
            }
        } else {
            var_s5 += 0x30;
            var_s2 += 1;
            sp84 += 2;
            goto loop_5;
        }
    }
}

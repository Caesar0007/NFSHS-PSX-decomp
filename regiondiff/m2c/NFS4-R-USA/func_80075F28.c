/* NFS4-R-USA REGION-ONLY @80075F28 */
/* callers: AudioClc_SoundCars__Fv, AudioClc_SoundCars__Fv, AudioClc_SoundCars__Fv */
s32 func_80075274(void *, void *);                  /* extern */
s32 func_80075440(?, void *);                       /* extern */
s32 func_800754C8(?, void *);                       /* extern */
s32 func_80075648(?, void *);                       /* extern */
s32 func_8007571C(?, void *, s32);                  /* extern */
? func_80078708(s32, s32, s32, s32);                /* extern */
? func_80078A88(s32);                               /* extern */
? func_800792E4(void *, s32, s32, s32, s32, s32, s32, s32); /* extern */
? func_80079ECC(s32, s32, ?, s32, s32);             /* extern */
s32 func_80079FD0(s32, s32);                        /* extern */
? func_8007A134(void *);                            /* extern */
? func_8007A280(s32, s32);                          /* extern */
? func_8007A328(s32);                               /* extern */
? func_8007A3E4(s32, s32, s32, s32, s32);           /* extern */
? func_8007D76C(void *, s32);                       /* extern */
s32 func_800E4F14(s32, s8);                         /* extern */
s32 func_800E4FF0(s32, s32);                        /* extern */

void func_80075F28(s32 arg0) {
    s32 sp20;
    s32 temp_a0;
    s32 temp_a0_2;
    s32 temp_a0_3;
    s32 temp_lo;
    s32 temp_s0;
    s32 temp_s1;
    s32 temp_s1_2;
    s32 temp_s4;
    s32 temp_s6;
    s32 temp_v0;
    s32 temp_v1;
    s32 temp_v1_2;
    s32 temp_v1_3;
    s32 temp_v1_4;
    s32 temp_v1_5;
    s32 var_a1;
    s32 var_a2;
    s32 var_s0_2;
    s32 var_s1;
    s32 var_s3;
    s32 var_s3_2;
    s32 var_s5;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v0_3;
    void *temp_s2;
    void *temp_s7;
    void *var_a0;
    void *var_s0;
    void *var_s1_2;

    temp_v1 = arg0 * 0x50;
    temp_s7 = temp_v1 + 0x8010F584;
    temp_s2 = *(0x8010F584 + temp_v1);
    if (temp_s2 != NULL) {
        var_s1 = 0;
        if (temp_s2->unk260 & 0x200) {
            if (temp_s2->unk550 != temp_s2->unk554) {
                var_s1 = -1;
            }
        } else {
            temp_s1 = func_800E4F14(temp_s2->unk108, ((temp_s2->unk8 << 5) + *(s32 *)0x8013DAB4)->unkF);
            temp_s0 = func_800E4F14(temp_s2->unk10C, ((temp_s2->unk8 << 5) + *(void *)0x8013DAB4)->unk10);
            var_s1 = temp_s1 + temp_s0 + func_800E4F14(temp_s2->unk110, ((temp_s2->unk8 << 5) + *(void *)0x8013DAB4)->unk11);
            if (*(s32 *)0x801144D4 != 0) {
                var_s1 = -var_s1;
            }
        }
        if ((temp_s2->unk390 != 2) && (((temp_v1_2 = (void *)0x801144A4->unk0, (temp_v1_2 != 1)) && (temp_v1_2 != 5)) || (!((*(void **)0x80110D0C)->unk260 & 0x200) && ((*(s32 *)0x8013DAF4 != 2) || !(((void **)0x80110000 + 0xD0C)->unk4->unk260 & 0x200))) || ((temp_s2->unk260 & 0x204) != 4)) && (temp_s2->unk460 == 0) && (temp_s2->unk278 == 0) && (var_s1 < 0)) {
            var_s0 = temp_s2 + 0xA0;
            if (temp_s2->unk17C == 0) {
                var_a0 = var_s0;
                if (temp_s2->unk78C == 0) {
                    temp_v1_3 = temp_s2->unk3F0 + 1;
                    temp_s2->unk3F0 = temp_v1_3;
                    if ((temp_v1_3 >= 0x40) && !(temp_v1_3 & 0x1F) && ((temp_v1_3 < 0x94) || (*(s32 *)0x8013EC1C != 0))) {
                        var_s0 = temp_s2 + 0xA0;
                        func_8007A134(var_a0);
                        var_a0 = var_s0;
                    }
                }
            } else {
                goto block_24;
            }
        } else {
            temp_s2->unk3F0 = 0;
            var_s0 = temp_s2 + 0xA0;
block_24:
            var_a0 = var_s0;
        }
        sp20 = func_80075274(var_a0, temp_s2 + 0xAC);
        if (*(s32 *)0x8013D968 != 0) {
            if (*(s32 *)0x801144B0 == 1) {
                var_s5 = 0xC000;
                if (arg0 != 0) {
                    var_s5 = 0x3FFF;
                }
            } else {
                if (((arg0 * 0x110) + 0x80110570)->unk70 == 0) {
                    goto block_30;
                }
                var_s5 = func_800754C8(0x8010F6EC, var_s0);
            }
        } else {
block_30:
            var_s5 = 0;
        }
        temp_s1_2 = func_80075440(0x8010F6EC, temp_s2 + 0xA0);
        if (func_800E4FF0(func_80075648(0x8010F6EC, temp_s2), temp_s1_2) <= 0x10000) {
            var_s3 = -0x10000;
            if (func_800E4FF0(func_80075648(0x8010F6EC, temp_s2), temp_s1_2) >= 0xFFFF0000) {
                goto block_35;
            }
        } else {
block_35:
            var_s3 = 0x10000;
            if (func_800E4FF0(func_80075648(0x8010F6EC, temp_s2), temp_s1_2) <= 0x10000) {
                var_s3 = func_800E4FF0(func_80075648(0x8010F6EC, temp_s2), temp_s1_2);
            }
        }
        var_v0 = temp_s1_2;
        if (temp_s1_2 < 0) {
            var_v0 = temp_s1_2 + 0xFFFF;
        }
        temp_s4 = var_v0 >> 0x10;
        temp_lo = temp_s4 * temp_s4;
        if (temp_s2->unk288->unk8 == 1) {
            var_a2 = temp_s2->unk464->unkF0 + 0x3E8;
        } else {
            var_a2 = temp_s2->unk464->unkF0 + 0x7D0;
        }
        if ((u16) temp_s2->unk17C >= 6U) {
            var_a2 -= 0x1F4;
        }
        temp_s6 = (s32) (temp_s2->unk468 * 0x7F) / var_a2;
        if (saved_reg_gp->unkC0 != 0) {
            temp_s7->unkC = 0;
        } else {
            var_v0_2 = temp_s2->unk564;
            if (var_v0_2 < 0) {
                var_v0_2 = -var_v0_2;
            }
            temp_s7->unkC = var_v0_2;
        }
        temp_v0 = func_8007571C(0x8010F6EC, temp_s2, var_a2);
        func_8007D76C(temp_s2, temp_v0);
        func_800792E4(temp_s2, temp_s1_2, temp_s6, sp20, var_s5, temp_v0, temp_s7->unkC, var_s3);
        if (*(s32 *)0x8013D948 != 0) {
            var_s3_2 = temp_s2->unk794 - 1;
            if (var_s3_2 >= 0) {
                var_s1_2 = (var_s3_2 * 0x18) + temp_s2;
                do {
                    temp_a0 = var_s1_2->unk79C;
                    if (temp_a0 == 0x12) {
                        var_s0_2 = 0x12;
                        if (arg0 != 0) {
                            var_s0_2 = 0x13;
                        }
                    } else {
                        var_s0_2 = temp_a0;
                        if (temp_a0 == 0x14) {
                            var_s0_2 = 0x14;
                            if (arg0 != 0) {
                                var_s0_2 = 0x15;
                            }
                        }
                    }
                    temp_v1_4 = var_s1_2->unk798;
                    if (((temp_v1_4 == 5) || (temp_v1_4 == 3)) && (var_s0_2 >= 0)) {
                        func_80078A88(var_s0_2);
                        if ((u32) (var_s0_2 - 0x12) < 2U) {
                            func_80078A88(var_s0_2 + 4);
                            var_s1_2 -= 0x18;
                        } else {
                            goto block_70;
                        }
                    } else {
                        if ((var_s0_2 < 0) && ((void *)0x801144A4->unkC != 1) && (temp_v1_5 = var_s1_2->unk7A0, (temp_v1_5 != 0xA)) && (temp_v1_5 != 8)) {
                            func_800754C8(0x8010F6EC, temp_s2 + 0x1A0);
                        }
                        func_80078708(var_s0_2, var_s1_2->unk7A0, var_s1_2->unk7A4, var_s1_2->unk7A8);
block_70:
                        var_s1_2 -= 0x18;
                    }
                    var_s3_2 -= 1;
                } while (var_s3_2 >= 0);
            }
            if (temp_s2->unk446 != 0) {
                func_80079ECC(temp_s2->unk254, temp_lo, 0x40, var_s5, sp20);
                var_v0_3 = 1;
                goto block_76;
            }
            if (temp_s7->unk20 != 0) {
                var_v0_3 = func_80079FD0(temp_s2->unk254, temp_lo);
block_76:
                temp_s7->unk20 = var_v0_3;
            }
            if ((u32) (temp_s2->unk288->unk0 - 0x16) < 6U) {
                if (temp_s2->unk570 & 2) {
                    if (temp_lo < 0x1324) {
                        var_a1 = ((0x1324 - temp_lo) * 0x7F) / 4900;
                    } else {
                        var_a1 = 0;
                    }
                    temp_a0_2 = temp_s2->unk254 + 4;
                    if (*(0x8010FA54 + (temp_a0_2 * 4)) == 0) {
                        func_8007A280(temp_a0_2, temp_s2->unk260 & 0x40);
                        return;
                    }
                    func_8007A3E4(temp_a0_2, var_a1, sp20, var_s5, temp_s2->unk260 & 0x40);
                    return;
                }
                temp_a0_3 = temp_s2->unk254 + 4;
                if (*(0x8010FA54 + (temp_a0_3 * 4)) != 0) {
                    func_8007A328(temp_a0_3);
                    func_80078A88(temp_s2->unk254 + 0x2F);
                }
            }
        }
    }
}

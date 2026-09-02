/* NFS4-R-UK-SW CHANGED @80075A30 | base 80075508 AudioClc_SoundPlayersCar__Fi */
/* callers: AudioClc_SoundCars__Fv, AudioClc_SoundCars__Fv, AudioClc_SoundCars__Fv, AudioClc_SoundCars__Fv, AudioClc_SoundCars__Fv */
s32 func_80075274(s32, s32);                        /* extern */
s32 func_80075440(?, s32);                          /* extern */
s32 func_800754C8(?, void *);                       /* extern */
s32 func_80075648(?, void *);                       /* extern */
? func_80075870(s32, s32, s32, s32);                /* extern */
? func_8007591C(s32);                               /* extern */
? func_80078A88(s32);                               /* extern */
? func_80079B54(s32, s32, s32, s32, s32);           /* extern */
? func_80079E18(s32, s32, s32, s32);                /* extern */
? func_8007A280(s32, s32);                          /* extern */
? func_8007A328(s32);                               /* extern */
? func_8007A3E4(s32, s32, s32, s32, s32);           /* extern */
s32 func_800E4FDC(s32, s32);                        /* extern */

void func_80075A30(s32 arg0, s32 arg1) {
    s32 temp_a0;
    s32 temp_lo;
    s32 temp_s0;
    s32 temp_s0_2;
    s32 temp_s4;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 temp_v0_3;
    s32 temp_v1;
    s32 temp_v1_2;
    s32 temp_v1_3;
    s32 var_a0;
    s32 var_s1;
    s32 var_s5;
    s32 var_s6;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v0_3;
    s32 var_v0_4;
    void *temp_s2;
    void *temp_s3;
    void *var_s0;

    temp_v1 = arg1 * 0x38;
    temp_s3 = temp_v1 + 0x8010F638;
    temp_s2 = *(0x8010F638 + temp_v1);
    temp_s0 = temp_s2 + 0xA0;
    if ((temp_s2 != NULL) && (temp_v0 = func_80075274(temp_s0, temp_s2 + 0xAC), (temp_v0 >= 0))) {
        temp_s0_2 = func_80075440(0x8010F718, temp_s0);
        if ((func_800E4FDC(func_80075648(0x8010F718, temp_s2), temp_s0_2) > 0x10000) || (func_800E4FDC(func_80075648(0x8010F718, temp_s2), temp_s0_2) >= 0xFFFF0000)) {
            if (func_800E4FDC(func_80075648(0x8010F718, temp_s2), temp_s0_2) <= 0x10000) {
                func_800E4FDC(func_80075648(0x8010F718, temp_s2), temp_s0_2);
            }
        }
        if (*(s32 *)0x8013D994 == 0) {
            var_s5 = 0;
        } else if (*(s32 *)0x801144DC == 1) {
            var_s5 = 0x3FFF;
            if (arg0 == 0) {
                var_s5 = 0xC000;
            }
        } else {
            var_s5 = func_800754C8(0x8010F718, temp_s2 + 0xA0);
        }
        var_v0 = temp_s0_2;
        if (temp_s0_2 < 0) {
            var_v0 = temp_s0_2 + 0xFFFF;
        }
        temp_s4 = var_v0 >> 0x10;
        temp_lo = temp_s4 * temp_s4;
        var_s6 = 0x1324;
        if (temp_lo < 0x1324) {
            var_s6 = temp_lo;
        }
        if (saved_reg_gp->unkC0 != 0) {
            temp_a0 = temp_s2->unk564;
            temp_v1_2 = ((arg0 * 0x50) + 0x8010F598)->unk18->unk564;
            var_v0_2 = temp_a0 - temp_v1_2;
            if (var_v0_2 <= 0) {
                var_v0_2 = temp_v1_2 - temp_a0;
            }
        } else {
            var_v0_2 = temp_s2->unk564;
            if (var_v0_2 < 0) {
                var_v0_2 = -var_v0_2;
            }
        }
        temp_s3->unkC = var_v0_2;
        temp_s3->unk14 = var_s6;
        var_v0_3 = temp_s2->unk420;
        if (var_v0_3 < 0) {
            var_v0_3 = -var_v0_3;
        }
        func_80079B54(arg1 + 6, *temp_s2->unk288, (s32) (temp_s2->unk468 << 0x10) / (s32) temp_s2->unk464->unkF0, temp_v0, var_v0_3);
        var_s1 = temp_s2->unk794 - 1;
        if (var_s1 >= 0) {
            var_s0 = (var_s1 * 0x18) + temp_s2;
            do {
                var_a0 = arg1 + 0x20;
                if (var_s0->unk79C >= 0) {

                } else {
                    var_a0 = -1;
                }
                var_s0 -= 0x18;
                func_80079E18(var_a0, var_s0->unk7A0, var_s0->unk7A4, var_s0->unk7A8);
                var_s1 -= 1;
            } while (var_s1 >= 0);
        }
        if (temp_s2->unk260 & 4) {
            if (temp_s2->unk446 != 0) {
                func_80075870(arg1, var_s5, temp_v0, var_s6);
                var_v0_4 = 1;
                goto block_46;
            }
            if (temp_s3->unk20 != 0) {
                func_8007591C(arg1);
                temp_s3->unk20 = 0;
            }
        } else {
            temp_v1_3 = temp_s3->unk20;
            if (temp_v1_3 > 0) {
                if (temp_s3->unk24 > 0) {
                    temp_s3->unk20 = (s32) (temp_v1_3 - 1);
                }
                if (temp_s3->unk20 == 0) {
                    temp_s2->unk446 = 0U;
                    func_8007591C(arg1);
                    temp_v0_2 = temp_s3->unk2C - 1;
                    temp_s3->unk2C = temp_v0_2;
                    if (temp_v0_2 != 0) {
                        temp_s3->unk20 = (s32) temp_s3->unk28;
                    }
                } else {
                    temp_s2->unk446 = 1U;
                    func_80075870(arg1, var_s5, temp_v0, var_s6);
                }
            } else {
                temp_v0_3 = temp_v1_3 + 1;
                if (temp_v1_3 < 0) {
                    temp_s3->unk20 = temp_v0_3;
                    if (temp_v0_3 == 0) {
                        var_v0_4 = temp_s3->unk24;
block_46:
                        temp_s3->unk20 = var_v0_4;
                    }
                }
            }
        }
        if ((u32) (*temp_s2->unk288 - 0x16) < 6U) {
            if (temp_s2->unk570 & 2) {
                if (*(0x8010FA80 + (arg1 * 4)) == 0) {
                    func_8007A280(arg1, temp_s2->unk260 & 0x40);
                    return;
                }
                func_8007A3E4(arg1, ((0x1324 - var_s6) * 0x7F) / 4900, temp_v0, var_s5, temp_s2->unk260 & 0x40);
                return;
            }
            if (*(0x8010FA80 + (arg1 * 4)) != 0) {
                func_8007A328(arg1);
                func_80078A88(arg1 + 0x2B);
            }
        }
    }
}

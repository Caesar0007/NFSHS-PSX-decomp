/* NFS4-R-AU CHANGED @80078D88 | base 800783CC AudioCmn_PlaySFX__Fiiiiii */
/* callers: AudioClc_SoundOpponentHorn__Fiiii, AudioCmn_SFX__Fi6s_typeT1iii, AudioCmn_SFX__Fi6s_typeT1iii, AudioCmn_SFX__Fi6s_typeT1iii, AudioCmn_SoundCar__FP8Car_tObjiiiiiii */
s32 func_80077300(s32, s32, ?);                     /* extern */
s32 func_80078AF8(s32, s32, s32, s32, s32, s32);    /* extern */
? func_800E745C(s32, s32);                          /* extern */
? func_800E766C(s32, s32);                          /* extern */
? func_800E85A8(s32, s32);                          /* extern */
s32 func_800E86EC(s32);                             /* extern */
? func_800E8A58(s32);                               /* extern */
? func_800E8AE0(s32, s32);                          /* extern */
? func_800E8CBC(s32, s32, ?);                       /* extern */

s32 func_80078D88(s32 arg0, s32 arg1, s32 arg2, s32 arg3, s32 arg4, s32 arg5) {
    s32 temp_a0;
    s32 temp_s0;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 temp_v1;
    s32 temp_v1_2;
    s32 temp_v1_4;
    s32 temp_v1_5;
    s32 var_a0;
    s32 var_a0_2;
    s32 var_a1;
    s32 var_lo;
    s32 var_s0;
    s32 var_s2;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v0_3;
    s32 var_v0_4;
    s32 var_v0_5;
    s32 var_v1;
    s32 var_v1_2;
    s32 var_v1_3;
    void *temp_s1;
    void *temp_s1_2;
    void *temp_v1_3;

    var_v1 = arg4;
    var_v0 = arg2;
    if (arg2 < 0) {
        var_v0 = 0;
    }
    var_a0 = 0x7F;
    if (var_v0 < 0x80) {
        var_a0 = var_v0;
    }
    if (*(s32 *)0x8013E810 != 0) {
        var_s0 = var_v1;
        if ((arg5 <= 0xBFFF) && (arg5 >= 0x4000)) {
            if (arg5 > 0xA000) {
                var_v0_2 = 0xC000 - arg5;
                goto block_10;
            }
            var_v0_2 = arg5 - 0x3FFF;
            if (arg5 < 0x5FFF) {
block_10:
                var_v1 += (s32) (var_v1 * var_v0_2) >> 0xD;
            } else {
                var_v1 *= 2;
            }
            goto block_12;
        }
    } else {
block_12:
        var_s0 = var_v1;
    }
    var_v0_3 = var_s0 < 0x80;
    if (var_s0 < 0) {
        var_s0 = 0;
        var_v0_3 = 0 < 0x80;
    }
    var_v1_2 = 0x7F;
    if (var_v0_3 != 0) {
        var_v1_2 = var_s0;
    }
    if ((u32) (arg0 - 0x1C) >= 4U) {
        if ((u32) (arg0 - 0x32) >= 4U) {
            if ((arg0 != 0x24) && (arg0 != 0x36)) {
                if ((u32) (arg0 - 0x37) >= 0x10U) {
                    if (((u32) (arg0 - 0xA) < 8U) || ((u32) (arg0 - 0x1A) < 2U)) {
                        var_s2 = *(s32 *)0x8010FBB0;
                    } else if (arg1 != 0x7D) {
                        if (arg1 < 0x7E) {
                            if (arg1 != 8) {
                                if (arg1 >= 8) {
                                    if (arg1 < 0xC) {
                                        if (arg1 >= 0xA) {
                                            goto block_31;
                                        }
                                        goto block_35;
                                    }
                                    goto block_34;
                                }
                                goto block_35;
                            }
block_31:
                            var_s2 = *(s32 *)0x8010FBBC;
                        } else {
block_34:
block_35:
                            var_s2 = *(0x8010FB98 + (*(0x8010F7C0 + (arg0 * 4)) * 0xC));
                        }
                    } else {
                        goto block_32;
                    }
                } else {
                    goto block_33;
                }
            } else {
                goto block_32;
            }
        } else {
            goto block_33;
        }
    } else {
block_32:
block_33:
        var_s2 = *(s32 *)0x8010FBD4;
    }
    if (arg0 == 0x31) {
        (void *)0x8010FBEC->unk188 = func_80078AF8(var_s2, arg1, arg5, var_v1_2, var_a0, arg3);
        (void *)0x8010FBEC->unk18C = arg1;
        saved_reg_gp->unk128 = (s32) (saved_reg_gp->unk128 - 1);
    } else {
        temp_v1 = arg0 * 8;
        temp_s1 = temp_v1 + 0x8010FBEC;
        if (temp_s1->unk4 == arg1) {
            if (func_800E86EC(*(0x8010FBEC + temp_v1)) != 0) {
                *(0x8010FBEC + temp_v1) = -1;
                temp_s1->unk4 = -1;
            }
            if (var_s2 < -1) {
                temp_v0 = func_80077300(var_s2 == -3, arg1, 0);
                if (temp_v0 == -1) {
                    *(0x8010FBEC + temp_v1) = temp_v0;
                    temp_s1->unk4 = temp_v0;
                }
            }
            temp_v1_2 = arg0 * 8;
            temp_v1_3 = temp_v1_2 + 0x8010FBEC;
            if (temp_v1_3->unk4 != arg1) {
                goto block_46;
            }
            var_a0_2 = *(0x8010FBEC + temp_v1_2);
            if (var_a0_2 != -1) {
                if (arg1 == 0x7D) {
                    var_a1 = (s32) (saved_reg_gp->unk10C * var_v1_2) >> 7;
                } else {
                    temp_v1_4 = (void *)0x8010FB98->unk18;
                    if (var_s2 == temp_v1_4) {
                        var_lo = saved_reg_gp->unk118 * (var_v1_2 * 0x27);
                    } else if (var_s2 == (void *)0x8010FB98->unk3C) {
                        var_lo = saved_reg_gp->unk118 * (var_v1_2 * 0x82);
                    } else {
                        switch (arg1) {             /* irregular */
                        case 0x63:
                            var_lo = saved_reg_gp->unk118 * (var_v1_2 * 0x27);
                            break;
                        case 0x3:
                            if ((var_s2 == (void *)0x8010FB98->unk0) || (var_s2 == temp_v1_4)) {
                                var_lo = saved_reg_gp->unk10C * (var_v1_2 * 0x7F);
                            } else {
                                if (arg1 == 0) {
                                case 0x0:
                                    var_v1_3 = saved_reg_gp->unk110;
                                    var_v0_4 = var_v1_2 * 0x19;
                                } else {
                                default:
                                    var_v1_3 = saved_reg_gp->unk10C;
                                    var_v0_4 = var_v1_2 * 0x27;
                                }
                                var_lo = var_v1_3 * var_v0_4;
                                var_a0_2 = *(0x8010FBEC + (arg0 * 8));
                            }
                            break;
                        }
                    }
                    var_a1 = var_lo >> 0xE;
                }
                func_800E766C(var_a0_2, var_a1);
                if (*(void *)0x8013E810 != 0) {
                    func_800E8CBC(*(0x8010FBEC + (arg0 * 8)), arg5, 0);
                } else if (saved_reg_gp->unk12C != 0) {
                    if ((u32) (arg5 - 0x4000) <= 0x7FFFU) {
                        var_v0_5 = 0xBFFF - arg5;
                    } else {
                        var_v0_5 = (arg5 + 0x4000) & 0xFFFF;
                    }
                    func_800E745C(*(0x8010FBEC + (arg0 * 8)), var_v0_5 >> 8);
                }
                temp_s0 = arg0 * 8;
                func_800E85A8(*(0x8010FBEC + temp_s0), var_a0);
                func_800E8AE0(*(0x8010FBEC + temp_s0), arg3 >> 4);
            } else {
                temp_v1_3->unk4 = var_a0_2;
            }
        } else {
block_46:
            temp_v1_5 = arg0 * 8;
            temp_s1_2 = temp_v1_5 + 0x8010FBEC;
            temp_a0 = *(0x8010FBEC + temp_v1_5);
            if (temp_a0 != -1) {
                func_800E8A58(temp_a0);
                saved_reg_gp->unk128 = (s32) (saved_reg_gp->unk128 - 1);
            }
            temp_v0_2 = func_80078AF8(var_s2, arg1, arg5, var_v1_2, var_a0, arg3);
            if (temp_v0_2 != -1) {
                *(0x8010FBEC + temp_v1_5) = temp_v0_2;
                temp_s1_2->unk4 = arg1;
            } else {
                *(0x8010FBEC + temp_v1_5) = temp_v0_2;
                temp_s1_2->unk4 = temp_v0_2;
            }
        }
    }
    return *(0x8010FBEC + (arg0 * 8));
}

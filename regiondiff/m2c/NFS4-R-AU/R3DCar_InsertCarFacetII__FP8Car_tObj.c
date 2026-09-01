/* NFS4-R-AU CHANGED @800B2E34 | base 800B2174 R3DCar_InsertCarFacetII__FP8Car_tObj */
/* callers: R3DCar_InsertAllListFacet__FP13DRender_tView */
s32 func_80080868(void *);                          /* extern */
? func_800BF728(void *);                            /* extern */
s32 func_800BFAF4(?, void *, s32, ?);               /* extern */
? func_800C0A34(void *, ?);                         /* extern */
? func_800C0AF4(s32, s32, void *, s32, s32, ?);     /* extern */
? func_800C230C(s32, s32, void *, s32, s32, ?);     /* extern */
? func_800C47E0(s32, s32, void *, s16, s32, s32, ?); /* extern */
? func_800C4C94(?, ?, s32);                         /* extern */
? func_800C5080(?, ?, s32);                         /* extern */

void func_800B2E34(void *arg0) {
    s32 sp20;
    s32 sp24;
    s32 sp28;
    s32 sp2C;
    s32 sp30;
    s32 sp34;
    s16 temp_s1;
    s16 temp_t1_2;
    s16 temp_v0_3;
    s16 var_a3;
    s16 var_v1;
    s32 temp_a2_2;
    s32 temp_v0_2;
    s32 temp_v1;
    s32 var_a1;
    s32 var_s0;
    s32 var_s4;
    s32 var_s5;
    s32 var_s6;
    s32 var_s8;
    s32 var_t2;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v1_2;
    s8 var_a0;
    s8 var_t0;
    u32 temp_s7;
    u32 temp_v0;
    u8 temp_t1;
    void *temp_a2;

    sp2C = 0;
    temp_s1 = arg0->unk8BC;
    temp_s7 = (u8) arg0->unk842 >> 7;
    sp28 = *(0x80117BEC + (s32) ((temp_s1 * 4) + (temp_s7 * 0xC8))) + 0xE4;
    sp24 = saved_reg_gp->unkE64;
    if ((arg0->unk2AC | arg0->unk2DC | arg0->unk30C | arg0->unk33C) == 0) {
        if ((void *)0x801144D0->unk54 == 0) {
            sp2C = *(s32 *)0x8013EB24 != 0;
        } else if ((void *)0x801144D0->unkC == 1) {
            sp2C = -1;
            if (*(void *)0x8013EB24 != 0) {
                var_t2 = 1;
                goto block_7;
            }
        } else {
            var_t2 = -2;
            if (*(void *)0x8013EB24 != 0) {
block_7:
                sp2C = var_t2;
            }
        }
    }
    arg0->unk880 = (u32) (func_80080868(arg0 + 8) & 0xFFFFFF);
    if (arg0->unk8C2 >= 0) {
        if (*(s32 *)0x8013ED34 != 0) {
            func_800BF728(arg0);
        }
        temp_v0 = arg0->unk880;
        var_s6 = ((temp_v0 & 0xFF) + ((s32) (temp_v0 & 0xFF00) >> 8) + ((temp_v0 >> 0x10) & 0xFF)) / 3;
        var_v0 = var_s6 << 0x10;
        if (var_s6 < 0x18) {
            var_s6 = 0x18;
            var_v0 = 0x18 << 0x10;
        }
        *(s32 *)0x1F80008C = var_v0 + (var_s6 << 8) + var_s6;
        temp_v0_2 = func_800BFAF4(0x8013E6A0, arg0, var_s6, 0x1F800000);
        sp20 = temp_v0_2;
        if (temp_v0_2 >= 0) {
            var_s0 = 0;
            var_s5 = 0;
            var_s4 = 0;
            sp30 = temp_s1 * 4;
            sp34 = 0;
loop_15:
            if (var_s0 < 0x39) {
                temp_a2 = *(*(0x80117BEC + (s32) (sp30 + (temp_s7 * 0xC8))) + (var_s0 * 4));
                temp_t1 = *(0x80117B90 + var_s0);
                if ((temp_a2->unk2 != 0) && (temp_t1 != 0)) {
                    temp_v1 = sp34 * 2;
                    var_a0 = (temp_v1 + 0x801178C4)->unk1;
                    var_t0 = *(0x801178C4 + temp_v1);
                    var_s8 = 0;
                    if ((temp_s1 < 0x1C) && ((u32) (var_s0 - 0x1C) < 2U) && (*(0x80117B0C + temp_s1) != 0)) {
                        var_t0 = -var_t0;
                    }
                    if ((sp24 != 0) && (var_s0 >= 0x23) && (var_s0 < 0x29)) {
                        var_s8 = 1;
                        *(s32 *)0x1F80000C ^= 1;
                    }
                    temp_t1_2 = temp_t1 - 0x11;
                    var_a3 = temp_t1_2;
                    if (temp_t1_2 >= 0) {
                        var_v1 = -1;
                        if (temp_s1 < 0x1C) {
                            if (temp_s1 >= 0x16) {
                                temp_v0_3 = *(0x80117A3C + (s32) ((var_a3 * 2) + (*(0x80117B60 + (s32) ((arg0->unk842 & 0x7F) + ((temp_s1 - 0x16) * 5))) * 0xC)));
                                if (temp_v0_3 != 0) {
                                    var_a3 = temp_v0_3;
                                }
                            } else if ((var_a3 == 4) && (*(0x80117AF0 + temp_s1) != 0)) {
                                var_a3 = 0x41;
                            }
                            var_v1_2 = var_a3 & 0xBF;
                            if (!(arg0->unk8B6 & 2)) {
                                if (temp_s1 >= 0x16) {
                                    var_v1_2 = var_a3 & 0xBF;
                                    if (arg0->unk570 & 2) {
                                        goto block_37;
                                    }
                                }
                            } else {
block_37:
                                if (var_v1_2 == 1) {
                                    var_a3 |= 0x600;
                                }
                            }
                            var_v1 = *(0x80117A30 + (temp_t1_2 * 2));
                        }
                        *(s32 *)0x1F800040 = arg0->unk868 + var_t0;
                        func_800C47E0(saved_reg_gp->unkE30 + var_s4, saved_reg_gp->unkE34 + var_s5, temp_a2, var_a3, (s32) var_v1, sp2C, 0x1F800000);
                    } else {
                        var_a1 = 0x20;
                        if (temp_s1 >= 0x1C) {
                            var_a1 = 0x40;
                            var_a0 = 0x22;
                            if ((temp_s1 == 0x1C) && (var_s0 == 0x23)) {
                                var_t0 = 4;
                            }
                        } else {
                            var_v0_2 = var_a0 & 0x10;
                            if (saved_reg_gp->unkE48 == 0) {
                                var_a0 &= 0xFE;
                                var_v0_2 = var_a0 & 0x10;
                            }
                            if ((var_v0_2 != 0) && (temp_s1 >= 0x16)) {
                                var_t0 += 0xC;
                            }
                        }
                        if (arg0->unk8C2 == 3) {
                            var_a0 |= 4;
                            var_t0 = -var_t0;
                            if (var_s0 == 0x24) {
                                var_t0 += 0x14;
                            }
                            if (var_s0 == 0x25) {
                                var_t0 += 8;
                            }
                        }
                        *(s32 *)0x1F800040 = arg0->unk868 + var_t0;
                        if (sp20 < var_a1) {
                            func_800C230C(saved_reg_gp->unkE30 + var_s4, saved_reg_gp->unkE34 + var_s5, temp_a2, sp28, (s32) var_a0, 0x1F800000);
                        } else {
                            func_800C0AF4(saved_reg_gp->unkE30 + var_s4, saved_reg_gp->unkE34 + var_s5, temp_a2, sp28, (s32) var_a0, 0x1F800000);
                        }
                    }
                    if (var_s8 != 0) {
                        *(s32 *)0x1F80000C ^= 1;
                    }
                }
                var_s5 += 0xC;
                var_s4 += 0x24;
                var_s0 += 1;
                sp34 += 3;
                goto loop_15;
            }
            func_800C0A34(arg0, 0x1F800000);
            if (saved_reg_gp->unkE40 != 0) {
                temp_a2_2 = (s32) (var_s6 * saved_reg_gp->unkE44) >> 8;
                *(s32 *)0x1F80008C = (((s32) (var_s6 * saved_reg_gp->unkE46) >> 8) << 0x10) + (((s32) (var_s6 * saved_reg_gp->unkE45) >> 8) << 8) + temp_a2_2;
                if (sp20 < 0x20) {
                    func_800C5080(0x80117BCC, 0x1F800000, temp_a2_2);
                    return;
                }
                func_800C4C94(0x80117BCC, 0x1F800000, temp_a2_2);
            }
        }
    }
}

/* NFS4-R-AU CHANGED @800E5094 | base 800E44BC sprintf */
/* callers: DrawHelpIcons__14tFEApplication, MainLoop__14tFEApplicationP5tMenu, FeAudio_AsyncPlaySpeech__Fii, FeAudio_InitCommentary__Fii, LoadDescription__11tCarManager */
s32 func_800EA8BC(s32, s8, s8 *);                   /* extern */
s32 func_800FED60(s32, ?, s32);                     /* extern */
? func_800FED70(s32, s32, s32);                     /* extern */

s16 func_800E5094(s32 arg0, s8 *arg1, s32 arg2, s32 arg3) {
    u32 sp210;
    s32 sp214;
    s32 sp218;
    s32 *sp220;
    s16 var_s2;
    s32 temp_a0;
    s32 temp_s1_2;
    s32 temp_v0_2;
    s32 temp_v0_3;
    s32 temp_v0_5;
    s32 temp_v1_2;
    s32 var_a0;
    s32 var_a0_2;
    s32 var_a0_3;
    s32 var_a0_4;
    s32 var_a3;
    s32 var_s0;
    s8 *temp_a0_2;
    s8 *temp_a2;
    s8 *temp_s1;
    s8 *temp_v1;
    s8 *temp_v1_3;
    s8 *temp_v1_4;
    s8 *temp_v1_5;
    s8 *var_s1_2;
    s8 *var_s1_3;
    s8 *var_s1_4;
    s8 *var_v0;
    s8 temp_v0;
    s8 var_a1;
    u32 *var_s1;
    u32 temp_v0_4;
    u32 var_v0_2;
    u32 var_v0_3;
    u32 var_v0_4;
    u32 var_v1;

    sp220 = &arg2;
    var_a1 = arg1->unk0;
    var_s2 = 0;
    if (var_a1 != 0) {
loop_2:
        var_v0 = arg0 + var_s2;
        if (var_a1 == 0x25) {
            sp210 = (void *)0x801247A8->unk0;
            sp214 = (void *)0x801247A8->unk4;
            sp218 = (void *)0x801247A8->unk8;
loop_4:
            temp_a2 = arg1;
            arg1 = temp_a2 + 1;
            var_a1 = temp_a2->unk1;
            if (var_a1 == 0x2D) {
                sp210 |= 1;
                goto loop_4;
            }
            if (var_a1 == 0x2B) {
                sp210 |= 2;
                goto loop_4;
            }
            if (var_a1 == 0x20) {
                unksp211 = var_a1;
                goto loop_4;
            }
            if (var_a1 == 0x23) {
                sp210 |= 4;
                goto loop_4;
            }
            if (var_a1 == 0x30) {
                sp210 |= 8;
                goto loop_4;
            }
            var_v0_2 = var_a1 - 0x30;
            if (var_a1 == 0x2A) {
                temp_a0 = *sp220;
                sp220 += 4;
                sp214 = temp_a0;
                if (temp_a0 < 0) {
                    sp214 = -temp_a0;
                    sp210 |= 1;
                }
                arg1 = temp_a2 + 2;
                var_a1 = temp_a2->unk2;
            } else {
loop_19:
                if (var_v0_2 < 0xAU) {
                    sp214 = (sp214 * 0xA) - 0x30 + var_a1;
                    temp_v1 = arg1;
                    arg1 = temp_v1 + 1;
                    var_a1 = temp_v1->unk1;
                    var_v0_2 = var_a1 - 0x30;
                    goto loop_19;
                }
            }
            if (var_a1 == 0x2E) {
                temp_a0_2 = arg1;
                arg1 = temp_a0_2 + 1;
                var_a1 = temp_a0_2->unk1;
                var_v0_3 = var_a1 - 0x30;
                if (var_a1 == 0x2A) {
                    temp_v1_2 = *sp220;
                    sp220 += 4;
                    sp218 = temp_v1_2;
                    arg1 = temp_a0_2 + 2;
                    var_a1 = temp_a0_2->unk2;
                } else {
loop_24:
                    if (var_v0_3 < 0xAU) {
                        sp218 = (sp218 * 0xA) - 0x30 + var_a1;
                        temp_v1_3 = arg1;
                        arg1 = temp_v1_3 + 1;
                        var_a1 = temp_v1_3->unk1;
                        var_v0_3 = var_a1 - 0x30;
                        goto loop_24;
                    }
                }
                if (sp218 >= 0) {
                    sp210 |= 0x10;
                }
            }
            var_s1 = &sp210;
            if (sp210 & 1) {
                sp210 &= ~8;
            }
            var_v1 = var_a1 - 0x4C;
loop_30:
            switch (var_v1) {
            case 28:
                var_v0_4 = sp210 | 0x20;
block_35:
                sp210 = var_v0_4;
                temp_v1_4 = arg1;
                arg1 = temp_v1_4 + 1;
                var_a1 = temp_v1_4->unk1;
                var_v1 = var_a1 - 0x4C;
                goto loop_30;
            case 32:
                var_v0_4 = sp210 | 0x40;
                goto block_35;
            case 0:
                var_v0_4 = sp210 | 0x80;
                goto block_35;
            case 24:
            case 29:
                var_a0 = *sp220;
                sp220 += 4;
                if ((sp210 >> 5) & 1) {
                    var_a0 = (s32) (s16) var_a0;
                }
                if (var_a0 < 0) {
                    var_a0 = -var_a0;
                    unksp211 = 0x2D;
                } else if ((sp210 >> 1) & 1) {
                    unksp211 = 0x2B;
                }
block_45:
                if (!((sp210 >> 4) & 1)) {
                    if ((sp210 >> 3) & 1) {
                        sp218 = sp214;
                        if (unksp211 != 0) {
                            sp218 = sp214 - 1;
                        }
                    }
                    if (sp218 <= 0) {
                        sp218 = 1;
                    }
                }
                var_s0 = 0;
                if (var_a0 != 0) {
                    do {
                        var_s1 -= 1;
                        var_s0 += 1;
                        temp_v0 = (var_a0 % 10) + 0x30;
                        var_a0 /= 0xA;
                        *var_s1 = temp_v0;
                    } while (var_a0 != 0);
                }
                if (var_s0 < sp218) {
                    var_s1_2 = var_s1 - 1;
                    do {
                        *var_s1_2 = 0x30;
                        var_s0 += 1;
                        var_s1_2 -= 1;
                    } while (var_s0 < sp218);
                    var_s1 = var_s1_2 + 1;
                }
                if (unksp211 != 0) {
                    var_s1 -= 1;
                    *var_s1 = (u8) unksp211;
                    var_s0 += 1;
                }
block_110:
                var_a0_2 = arg0 + var_s2;
                if (var_s0 < sp214) {
                    if (!(sp210 & 1)) {
                        do {
                            *(arg0 + var_s2) = 0x20;
                            temp_v0_2 = sp214 - 1;
                            sp214 = temp_v0_2;
                            var_s2 += 1;
                        } while (var_s0 < temp_v0_2);
                        var_a0_2 = arg0 + var_s2;
                    }
                }
                func_800FED70(var_a0_2, (s32) var_s1, var_s0);
                var_s2 += var_s0;
                if (var_s0 < sp214) {
                    do {
                        *(arg0 + var_s2) = 0x20;
                        var_s0 += 1;
                        var_s2 += 1;
                    } while (var_s0 < sp214);
                }
                goto block_117;
            case 41:
                var_a0 = *sp220;
                sp220 += 4;
                if ((sp210 >> 5) & 1) {
                    var_a0 &= 0xFFFF;
                }
                unksp211 = 0;
                goto block_45;
            case 35:
                var_a0_3 = *sp220;
                sp220 += 4;
                if ((sp210 >> 5) & 1) {
                    var_a0_3 &= 0xFFFF;
                }
                if (!((sp210 >> 4) & 1)) {
                    if ((sp210 >> 3) & 1) {
                        sp218 = sp214;
                    }
                    if (sp218 <= 0) {
                        sp218 = 1;
                    }
                }
                var_s0 = 0;
                if (var_a0_3 != 0) {
                    do {
                        var_s1 -= 1;
                        *var_s1 = (s8) ((var_a0_3 & 7) + 0x30);
                        var_a0_3 = (s32) ((u32) var_a0_3 >> 3);
                        var_s0 += 1;
                    } while (var_a0_3 != 0);
                }
                if (((sp210 >> 2) & 1) && (var_s0 != 0) && (*var_s1 != 0x30)) {
                    var_s1 -= 1;
                    *var_s1 = 0x30;
                    var_s0 += 1;
                }
                if (var_s0 < sp218) {
                    var_s1_3 = var_s1 - 1;
                    do {
                        *var_s1_3 = 0x30;
                        var_s0 += 1;
                        var_s1_3 -= 1;
                    } while (var_s0 < sp218);
                    var_s1 = var_s1_3 + 1;
                }
                goto block_110;
            case 36:
                sp218 = 8;
                sp210 |= 0x50;
                /* fallthrough */
            case 12:
                var_a3 = 0x800572DC;
block_80:
                var_a0_4 = *sp220;
                sp220 += 4;
                if ((sp210 >> 5) & 1) {
                    var_a0_4 &= 0xFFFF;
                }
                if (!((sp210 >> 4) & 1)) {
                    if ((sp210 >> 3) & 1) {
                        sp218 = sp214;
                        if ((sp210 >> 2) & 1) {
                            sp218 = sp214 - 2;
                        }
                    }
                    if (sp218 <= 0) {
                        sp218 = 1;
                    }
                }
                var_s0 = 0;
                if (var_a0_4 != 0) {
                    do {
                        var_s1 -= 1;
                        temp_v0_3 = var_a0_4 & 0xF;
                        var_a0_4 = (s32) ((u32) var_a0_4 >> 4);
                        var_s0 += 1;
                        *var_s1 = (u8) *(var_a3 + temp_v0_3);
                    } while (var_a0_4 != 0);
                }
                if (var_s0 < sp218) {
                    var_s1_4 = var_s1 - 1;
                    do {
                        *var_s1_4 = 0x30;
                        var_s0 += 1;
                        var_s1_4 -= 1;
                    } while (var_s0 < sp218);
                    var_s1 = var_s1_4 + 1;
                }
                if ((sp210 >> 2) & 1) {
                    temp_s1 = var_s1 - 1;
                    *temp_s1 = var_a1;
                    var_s1 = temp_s1 - 1;
                    var_s0 += 2;
                    *var_s1 = 0x30;
                }
                goto block_110;
            case 44:
                var_a3 = 0x800572F0;
                goto block_80;
            case 23:
                var_s1 -= 1;
                var_s0 = 1;
                *var_s1 = (u8) *sp220;
                sp220 += 4;
                goto block_110;
            case 39:
                var_s1 = (u32 *) *sp220;
                sp220 += 4;
                temp_v0_4 = sp210 >> 4;
                if ((sp210 >> 2) & 1) {
                    var_s0 = (s32) *var_s1;
                    var_s1 += 1;
                    if ((temp_v0_4 & 1) && (sp218 < var_s0)) {
                        var_s0 = sp218;
                    }
                } else if (!(temp_v0_4 & 1)) {
                    var_s0 = func_800EA8BC((s32) var_s1, var_a1, temp_a2);
                } else {
                    temp_v0_5 = func_800FED60((s32) var_s1, 0, sp218);
                    var_s0 = temp_v0_5 - var_s1;
                    if (temp_v0_5 == 0) {
                        var_s0 = sp218;
                    }
                }
                goto block_110;
            case 34:
                temp_s1_2 = *sp220;
                sp220 += 4;
                if ((sp210 >> 5) & 1) {
                    *temp_s1_2 = var_s2;
                } else {
                    *temp_s1_2 = (s32) var_s2;
                }
                goto block_117;
            default:
                var_v0 = arg0 + var_s2;
                if (var_a1 == 0x25) {
                    goto block_109;
                }
                break;
            }
        } else {
block_109:
            *var_v0 = var_a1;
            var_s2 += 1;
block_117:
            temp_v1_5 = arg1;
            arg1 = temp_v1_5 + 1;
            var_a1 = temp_v1_5->unk1;
            if (var_a1 != 0) {
                goto loop_2;
            }
        }
    }
    *(arg0 + var_s2) = 0;
    return var_s2;
}

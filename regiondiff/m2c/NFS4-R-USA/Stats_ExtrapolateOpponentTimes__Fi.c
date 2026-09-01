/* NFS4-R-USA CHANGED @800B92D8 | base 800B8604 Stats_ExtrapolateOpponentTimes__Fi */
/* callers: HandlePullOver__13AIHigh_Player, Sim_ProcessPause__Fv, Stats_TrackEndGame__Fv */
s32 func_800B8E28(void *, void *, s32);             /* extern */
s32 func_800EB430(s32, void *, s32);                /* extern */

void func_800B92D8(s32 arg0, s32 arg2) {
    s32 temp_a0;
    s32 temp_a0_3;
    s32 temp_a0_4;
    s32 temp_a0_5;
    s32 temp_a0_6;
    s32 temp_lo;
    s32 temp_s0;
    s32 temp_t4;
    s32 temp_v0_2;
    s32 temp_v0_4;
    s32 temp_v1_11;
    s32 temp_v1_15;
    s32 temp_v1_16;
    s32 var_a0;
    s32 var_a0_2;
    s32 var_a1_2;
    s32 var_a1_3;
    s32 var_a1_4;
    s32 var_a1_5;
    s32 var_a1_6;
    s32 var_a2;
    s32 var_a2_2;
    s32 var_a2_3;
    s32 var_s2;
    s32 var_s2_2;
    s32 var_t0;
    void **var_a3;
    void **var_s1;
    void **var_s1_2;
    void **var_t1;
    void *temp_a0_2;
    void *temp_a1;
    void *temp_a1_2;
    void *temp_a2;
    void *temp_v0;
    void *temp_v0_3;
    void *temp_v0_5;
    void *temp_v1;
    void *temp_v1_10;
    void *temp_v1_12;
    void *temp_v1_13;
    void *temp_v1_14;
    void *temp_v1_2;
    void *temp_v1_3;
    void *temp_v1_4;
    void *temp_v1_5;
    void *temp_v1_6;
    void *temp_v1_7;
    void *temp_v1_8;
    void *temp_v1_9;
    void *var_a0_3;
    void *var_a1;

    var_a2 = arg2;
    var_s2 = 0;
    var_s1 = (void **)0x80110D0C;
loop_1:
    if (var_s2 < *(s32 *)0x8013DAF4) {
        var_a1 = *var_s1;
        if (var_a1->unk390 != 2) {
            var_a0 = var_a1->unk350;
            if (var_a0 <= 0) {
                var_a0 = 1;
            }
            var_a2 = var_a1->unk354 - 0x200;
            if (var_a0 < 0x64) {
                var_a2 = var_a0 * 0xD;
            }
            temp_lo = (s32) (var_a2 * ((*(s32 *)0x8013DABC * (void *)0x801144A4->unk4) + var_a1->unk34C)) / var_a0;
            if (0 != 0) {
                var_a1->unk364 = temp_lo;
            } else {
                var_a1->unk364 = (s32) (temp_lo * 2);
            }
            if ((void *)0x801144A4->unk0 != 2) {
                if (0 != 0) {
                    goto block_15;
                }
                goto block_16;
            }
            if ((void *)0x801144A4->unk1C == var_s2) {
                if (0 != 0) {
block_15:
                    (*var_s1)->unk390 = 2;
                } else {
block_16:
                    (*var_s1)->unk390 = 1;
                }
            }
        }
        if (arg0 == 1) {
            temp_a0 = (void *)0x801144A4->unk0;
            if (temp_a0 != 2) {
                if (0 != 0) {
                    (*var_s1)->unk390 = 2;
                } else {
                    temp_v1 = *var_s1;
                    if (temp_v1->unk390 != 2) {
                        temp_v1->unk390 = arg0;
                    }
                }
            } else {
                temp_v1_2 = *var_s1;
                if ((temp_v1_2->unk390 != temp_a0) && ((void *)0x801144A4->unk1C == var_s2)) {
                    if (0 != 0) {
                        temp_v1_2->unk390 = temp_a0;
                    } else {
                        temp_v1_2->unk390 = arg0;
                    }
                }
            }
            (*var_s1)->unk3D0 = func_800B8E28(*var_s1, var_a1, var_a2);
            temp_v1_3 = *var_s1;
            temp_v1_3->unk3D4 = (s32) temp_v1_3->unk364;
            var_a1 = NULL;
            if ((void *)0x801144A4->unk4 > 0) {
                do {
                    temp_v1_4 = *var_s1 + ((s32) var_a1 * 4);
                    temp_v1_4->unk3D8 = (s32) temp_v1_4->unk368;
                    var_a1 += 1;
                } while ((s32) var_a1 < (void *)0x801144A4->unk4);
            }
        }
        (*var_s1)->unk3D0 = func_800B8E28(*var_s1, var_a1);
        (*var_s1)->unk3D0 = func_800B8E28(*var_s1);
        temp_v1_5 = *var_s1;
        temp_v1_5->unk3D4 = (s32) temp_v1_5->unk364;
        temp_v1_6 = *var_s1;
        temp_v1_6->unk3CC = (s32) temp_v1_6->unk390;
        temp_v1_7 = *var_s1;
        temp_v1_7->unk3E8 = (s32) temp_v1_7->unk368;
        temp_v1_8 = *var_s1;
        temp_v1_8->unk3C0 = (s32) temp_v1_8->unk3A0;
        temp_v1_9 = *var_s1;
        temp_v1_9->unk3C4 = (s32) temp_v1_9->unk3A4;
        temp_v0 = *var_s1;
        var_a1_2 = 0;
        temp_v0->unk3C8 = (s32) temp_v0->unk3A8;
        var_a2 = (s32) var_s1;
        (*var_s1)->unk3BC = 0;
        do {
            temp_a0_2 = *var_a2;
            temp_v0_2 = (temp_a0_2 + (var_a1_2 * 4))->unk218;
            var_a1_2 += 1;
            temp_a0_2->unk3BC = (s32) (temp_a0_2->unk3BC + temp_v0_2);
        } while (var_a1_2 < 0xA);
        var_a1_3 = 0;
        if ((void *)0x801144A4->unk4 > 0) {
            do {
                temp_a0_3 = var_a1_3 * 4;
                temp_v1_10 = *var_s1 + temp_a0_3;
                temp_v1_10->unk3D8 = (s32) temp_v1_10->unk368;
                var_a2 = (s32) *var_s1;
                temp_v1_11 = (var_a2 + temp_a0_3)->unk3D8;
                if ((temp_v1_11 < var_a2->unk3E8) && (temp_v1_11 != 0)) {
                    var_a2->unk3E8 = temp_v1_11;
                }
                var_a1_3 += 1;
            } while (var_a1_3 < (void *)0x801144A4->unk4);
        }
        var_s1 += 4;
        var_s2 += 1;
        goto loop_1;
    }
    var_s2_2 = 0;
    var_s1_2 = (void **)0x80110D30;
loop_42:
    if (var_s2_2 < *(s32 *)0x8013DAF8) {
        temp_a1 = *var_s1_2;
        if (temp_a1->unk390 != 2) {
            var_a0_2 = temp_a1->unk350;
            if (var_a0_2 <= 0) {
                var_a0_2 = 1;
            }
            var_a2_2 = temp_a1->unk354 - 0x200;
            if (var_a0_2 < 0x64) {
                var_a2_2 = var_a0_2 * 0xD;
            }
            temp_s0 = (s32) (var_a2_2 * ((*(void *)0x8013DABC * (void *)0x801144A4->unk4) + temp_a1->unk34C)) / var_a0_2;
            if ((0 == 0) && ((*(void **)0x80110D0C)->unk390 != 2)) {
                (*var_s1_2)->unk364 = (s32) (temp_s0 + ((s32) ((void *)0x801144A4->unk4 * func_800EB430(var_a0_2, temp_a1, var_a2_2)) / 128));
            } else {
                (*var_s1_2)->unk364 = temp_s0;
            }
            (*var_s1_2)->unk390 = 2;
        }
        (*var_s1_2)->unk3D0 = func_800B8E28(*var_s1_2);
        temp_v1_12 = *var_s1_2;
        temp_v1_12->unk3D4 = (s32) temp_v1_12->unk364;
        temp_v1_13 = *var_s1_2;
        temp_v1_13->unk3CC = (s32) temp_v1_13->unk390;
        temp_v0_3 = *var_s1_2;
        temp_v0_3->unk3C8 = (s32) temp_v0_3->unk3A8;
        var_a0_3 = (void *)0x1869F;
        (*var_s1_2)->unk3E8 = 0x1869F;
        var_a1_4 = 0;
        if ((void *)0x801144A4->unk4 > 0) {
            do {
                var_a0_3 = *var_s1_2;
                temp_v0_4 = (var_a0_3 + (var_a1_4 * 4))->unk368;
                if ((temp_v0_4 < var_a0_3->unk3E8) && (temp_v0_4 > 0)) {
                    var_a0_3->unk3E8 = temp_v0_4;
                }
                var_a1_4 += 1;
            } while (var_a1_4 < (void *)0x801144A4->unk4);
        }
        temp_a1_2 = *var_s1_2;
        temp_a0_4 = ((s32) temp_a1_2->unk3D4 / (s32) (void *)0x801144A4->unk4) - (func_800EB430((s32) var_a0_3, (void *) var_a1_4) / 48);
        if (temp_a0_4 < temp_a1_2->unk3E8) {
            temp_a1_2->unk3E8 = temp_a0_4;
        }
        var_a1_5 = 0;
        if ((void *)0x801144A4->unk4 > 0) {
            do {
                temp_a0_5 = var_a1_5 * 4;
                temp_v1_14 = *var_s1_2 + temp_a0_5;
                temp_v1_14->unk3D8 = (s32) temp_v1_14->unk368;
                temp_a2 = *var_s1_2;
                temp_v1_15 = (temp_a2 + temp_a0_5)->unk3D8;
                if ((temp_v1_15 < temp_a2->unk3E8) && (temp_v1_15 != 0)) {
                    temp_a2->unk3E8 = temp_v1_15;
                }
                var_a1_5 += 1;
            } while (var_a1_5 < (void *)0x801144A4->unk4);
        }
        var_s1_2 += 4;
        var_s2_2 += 1;
        goto loop_42;
    }
    var_t0 = 0;
    if (0 == 0) {
        temp_t4 = *(s32 *)0x8013DAEC;
        var_t1 = (void **)0x80110CC4;
loop_70:
        var_a2_3 = 1;
        if (var_t0 < temp_t4) {
            var_a1_6 = 0;
            if (temp_t4 > 0) {
                var_a3 = (void **)0x80110CC4;
                do {
                    if ((var_t0 != var_a1_6) && ((temp_a0_6 = (*var_t1)->unk3D4, temp_v1_16 = (*var_a3)->unk3D4, ((temp_v1_16 < temp_a0_6) != 0)) || ((temp_a0_6 == temp_v1_16) && (var_a1_6 < var_t0)))) {
                        var_a2_3 += 1;
                    }
                    var_a1_6 += 1;
                    var_a3 += 4;
                } while (var_a1_6 < *(void *)0x8013DAEC);
            }
            temp_v0_5 = *var_t1;
            var_t1 += 4;
            var_t0 += 1;
            temp_v0_5->unk3D0 = var_a2_3;
            goto loop_70;
        }
    }
}

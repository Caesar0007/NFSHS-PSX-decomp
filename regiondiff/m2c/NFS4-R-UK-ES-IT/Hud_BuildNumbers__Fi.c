/* NFS4-R-UK-ES-IT CHANGED @800D5A70 | base 800D4E70 Hud_BuildNumbers__Fi */
/* callers: Hud_RenderHudView__Fv */
? func_800D2AF8(?, s32 *, ?, ?);                    /* extern */
? func_800D2E88(void *, void *, s32, s32, s32);     /* extern */
? func_800D4944(void *, s32, s32, s32 *);           /* extern */
s32 func_800E4F00(s32, s32);                        /* extern */

void func_800D5A70(s32 arg0, s32 arg2, s32 *arg3) {
    s32 sp18;
    s32 sp1C;
    s32 sp20;
    s32 sp24;
    s32 *temp_a1;
    s32 *temp_a1_2;
    s32 *temp_a1_4;
    s32 *temp_a1_5;
    s32 *temp_a1_6;
    s32 *temp_a1_7;
    s32 *temp_a2;
    s32 *temp_a3;
    s32 *temp_a3_2;
    s32 *temp_t0;
    s32 *temp_t0_2;
    s32 *temp_t2;
    s32 *var_a0_2;
    s32 *var_a0_3;
    s32 *var_a0_4;
    s32 *var_a0_5;
    s32 *var_a0_6;
    s32 *var_a3;
    s32 temp_a1_3;
    s32 temp_s0;
    s32 temp_s2;
    s32 temp_s3;
    s32 temp_s4;
    s32 temp_s6;
    s32 temp_s7;
    s32 temp_v1;
    s32 temp_v1_2;
    s32 temp_v1_3;
    s32 temp_v1_5;
    s32 var_a0;
    s32 var_a1;
    s32 var_a1_2;
    s32 var_a2;
    s32 var_a2_2;
    s32 var_s2;
    s32 var_s4;
    s32 var_s6;
    s32 var_t0;
    void *temp_a3_3;
    void *temp_s1;
    void *temp_s1_2;
    void *temp_s1_3;
    void *temp_v0;
    void *temp_v1_4;
    void *var_s0;
    void *var_s1;
    void *var_s5;
    void *var_v0;
    void *var_v0_2;

    var_a2 = arg2;
    var_a3 = arg3;
    if (arg0 != 0) {
        var_s5 = saved_reg_gp->unk18D8;
    } else {
        var_s5 = saved_reg_gp->unk18D4;
    }
    var_s1 = (void *)0x8013F784;
    if (arg0 != 0) {
        var_s1 = (void *)0x8013F82C;
    }
    var_s0 = (void *)0x8013FA64;
    if (arg0 != 0) {
        var_s0 = (void *)0x8013FAF4;
    }
    var_s6 = 0;
    if (arg0 != 0) {
        var_s6 = -0xF;
    }
    if (((arg0 * 0xB4) + 0x801144D0)->unk45C != 0) {
        var_a0 = 0x801144D0;
        if (saved_reg_gp->unk13E0 == 0) {
            var_a2 = 0x14;
            if ((void *)0x80113A14->unk3C != 1) {
                var_s5->unk19C = (s32) *(0x80111F60 + ((void *)0x80113A14->unk38 * 4));
                var_a0_2 = var_s5 + 0x190;
                var_s5->unk1C4 = (s32) *(0x80111F60 + ((void *)0x80113A14->unk3C * 4));
                temp_a1 = *(s32 **)0x1F800000;
                do {
                    var_a2 += 1;
                    *var_a0_2 = (*var_a0_2 & 0xFF000000) | (*temp_a1 & 0xFFFFFF);
                    *temp_a1 = (*temp_a1 & 0xFF000000) | ((s32) var_a0_2 & 0xFFFFFF);
                    var_a0_2 += 0x14;
                } while (var_a2 < 0x17);
                var_a2_2 = 6;
                var_a3 = *(void *)0x1F800000;
                var_a0_3 = var_s5 + 0x78;
                do {
                    var_a2_2 += 1;
                    *var_a0_3 = (*var_a0_3 & 0xFF000000) | (*var_a3 & 0xFFFFFF);
                    *var_a3 = (*var_a3 & 0xFF000000) | ((s32) var_a0_3 & 0xFFFFFF);
                    var_a0_3 += 0x14;
                } while (var_a2_2 < 8);
                var_a2 = 0xFF000000;
                temp_a1_2 = *(void *)0x1F800000;
                var_s0->unk24 = (s32) ((var_s0->unk24 & 0xFF000000) | (*temp_a1_2 & 0xFFFFFF));
                temp_v1 = (*temp_a1_2 & 0xFF000000) | ((s32) (var_s0 + 0x24) & 0xFFFFFF);
                *temp_a1_2 = temp_v1;
                var_s1->unk18 = (s32) ((var_s1->unk18 & 0xFF000000) | (temp_v1 & 0xFFFFFF));
                *temp_a1_2 = (*temp_a1_2 & 0xFF000000) | ((s32) (var_s1 + 0x18) & 0xFFFFFF);
            }
            goto block_18;
        }
    } else {
block_18:
        var_a0 = 0x801144D0;
    }
    if (((arg0 * 0xB4) + var_a0)->unk458 != 0) {
        temp_a1_3 = (void *)0x80113A14->unk5C;
        if ((temp_a1_3 != 0) && (temp_a1_3 <= 0x95FF) && (saved_reg_gp->unk13E0 == 0) && (saved_reg_gp->unk1914 == 0) && ((void *)0x80113A14->unk3C != 1)) {
            if (((void *)0x80113A14->unk14 == 0) || !(*(s32 *)0x8011F394 & 0x10)) {
                func_800D4944(var_s5 + 0x1CC, temp_a1_3, var_a2, var_a3);
            }
            var_a1 = 0x17;
            temp_a3 = *(void *)0x1F800000;
            var_a0_4 = var_s5 + 0x1CC;
            do {
                var_a1 += 1;
                *var_a0_4 = (*var_a0_4 & 0xFF000000) | (*temp_a3 & 0xFFFFFF);
                *temp_a3 = (*temp_a3 & 0xFF000000) | ((s32) var_a0_4 & 0xFFFFFF);
                var_a0_4 += 0x14;
            } while (var_a1 < 0x1E);
            var_a1_2 = 8;
            temp_a3_2 = *(void *)0x1F800000;
            var_a0_5 = var_s5 + 0xA0;
            do {
                var_a1_2 += 1;
                *var_a0_5 = (*var_a0_5 & 0xFF000000) | (*temp_a3_2 & 0xFFFFFF);
                *temp_a3_2 = (*temp_a3_2 & 0xFF000000) | ((s32) var_a0_5 & 0xFFFFFF);
                var_a0_5 += 0x14;
            } while (var_a1_2 < 0xA);
            temp_a1_4 = *(void *)0x1F800000;
            var_s0->unk6C = (s32) ((var_s0->unk6C & 0xFF000000) | (*temp_a1_4 & 0xFFFFFF));
            temp_v1_2 = (*temp_a1_4 & 0xFF000000) | ((s32) (var_s0 + 0x6C) & 0xFFFFFF);
            *temp_a1_4 = temp_v1_2;
            var_s1->unk30 = (s32) ((var_s1->unk30 & 0xFF000000) | (temp_v1_2 & 0xFFFFFF));
            *temp_a1_4 = (*temp_a1_4 & 0xFF000000) | ((s32) (var_s1 + 0x30) & 0xFFFFFF);
        }
    }
    if ((((arg0 * 0xB4) + 0x801144D0)->unk460 != 0) && (saved_reg_gp->unk13E0 == 0) && ((void *)0x80113A14->unk58 >= 2)) {
        temp_v0 = saved_reg_gp->unk18D0;
        var_s5->unk2EC = (s16) ((temp_v0->unk38 + temp_v0->unk28 + ((void *)0x80111F88->unk380 - 2)) - ((((void *)0x80113A14->unk54 + 0x2C) * 0x14) + 0x80111F88)->unk10);
        var_s5->unk2F0 = (s32) (((void *)0x80113A14->unk54 * 0x14) + 0x80111F88)->unk370;
        var_t0 = 0x25;
        var_s5->unk2F4 = (u16) ((((void *)0x80113A14->unk54 + 0x2C) * 0x14) + 0x80111F88)->unk10;
        var_s5->unk318 = (s32) (((void *)0x80113A14->unk58 * 0x14) + 0x80111F88)->unk424;
        temp_a1_5 = *(void *)0x1F800000;
        var_a0_6 = var_s5 + 0x2E4;
        var_s5->unk31C = (u16) ((((void *)0x80113A14->unk58 + 0x35) * 0x14) + 0x80111F88)->unk10;
        do {
            var_t0 += 1;
            *var_a0_6 = (*var_a0_6 & 0xFF000000) | (*temp_a1_5 & 0xFFFFFF);
            *temp_a1_5 = (*temp_a1_5 & 0xFF000000) | ((s32) var_a0_6 & 0xFFFFFF);
            var_a0_6 += 0x14;
        } while (var_t0 < 0x28);
        if (((arg0 * 0xB4) + 0x801144D0)->unk450 != 0) {
            func_800D2AF8(0, temp_a1_5, 0x80111F88, 0xFFFFFF);
            temp_a1_6 = *(void *)0x1F800000;
            var_s5->unk320 = (s32) ((var_s5->unk320 & 0xFF000000) | (*temp_a1_6 & 0xFFFFFF));
            *temp_a1_6 = (*temp_a1_6 & 0xFF000000) | ((s32) (var_s5 + 0x320) & 0xFFFFFF);
            func_800D2AF8(1, temp_a1_6, 0xFFFFFF, 0xFF000000);
        }
    }
    func_800D2AF8(0);
    if (((arg0 * 0xB4) + 0x801144D0)->unk44C != 0) {
        temp_v1_3 = *(s32 *)0x80113A5C;
        switch (temp_v1_3) {                        /* irregular */
        case 0:
            var_v0 = var_s5 + 0x3C0;
            var_s5->unk3C0 = (s32) ((var_s5->unk3C0 & 0xFF000000) | (**(void *)0x1F800000 & 0xFFFFFF));
block_46:
            **(void *)0x1F800000 = (**(void *)0x1F800000 & 0xFF000000) | ((s32) var_v0 & 0xFFFFFF);
            break;
        case 1:
            var_v0 = var_s5 + 0x3AC;
            var_s5->unk3AC = (s32) ((var_s5->unk3AC & 0xFF000000) | (**(void *)0x1F800000 & 0xFFFFFF));
            goto block_46;
        default:
            temp_a2 = *(void *)0x1F800000;
            temp_v1_4 = ((void *)0x80113A14->unk48 * 0x14) + var_s5;
            temp_v1_4->unk30C = (s32) ((temp_v1_4->unk30C & 0xFF000000) | (*temp_a2 & 0xFFFFFF));
            *temp_a2 = (*temp_a2 & 0xFF000000) | ((s32) (((void *)0x80113A14->unk48 * 0x14) + var_s5 + 0x30C) & 0xFFFFFF);
            break;
        }
        if (((arg0 * 0xB4) + 0x801144D0)->unk444 == 0) {
            var_v0_2 = var_s5 + 0x3E8;
            var_s5->unk3E8 = (s32) ((var_s5->unk3E8 & 0xFF000000) | (**(void *)0x1F800000 & 0xFFFFFF));
        } else {
            var_v0_2 = var_s5 + 0x3D4;
            var_s5->unk3D4 = (s32) ((var_s5->unk3D4 & 0xFF000000) | (**(void *)0x1F800000 & 0xFFFFFF));
        }
        **(void *)0x1F800000 = (**(void *)0x1F800000 & 0xFF000000) | ((s32) var_v0_2 & 0xFFFFFF);
    }
    func_800D2AF8(1);
    if (((arg0 * 0xB4) + 0x801144D0)->unk44C != 0) {
        var_s4 = func_800E4F00(((arg0 * 0xB4) + 0x801144D0)->unk448, *(s32 *)0x80113A60);
        if (var_s4 < 0) {
            var_s4 += 0xFFFF;
        }
        sp24 = 0xC8C8C8;
        sp20 = 0x505050;
        temp_s1 = *(void **)0x1F800004;
        *(void **)0x1F800004 = temp_s1 + 0x34;
        temp_a3_3 = saved_reg_gp->unk18D0;
        temp_t2 = *(void *)0x1F800000;
        temp_s3 = (s16) (void *)0x80111F88->unk380 + 1;
        temp_s7 = (s32) (temp_s3 + (void *)0x80111F88->unk40C) >> 1;
        temp_s2 = (temp_s3 * 2) + (temp_a3_3->unk4 + temp_a3_3->unk30 + 4);
        temp_s1->unk0 = (s32) ((temp_s1->unk0 & 0xFF000000) | (*temp_t2 & 0xFFFFFF));
        sp18 = temp_a3_3->unk6 + temp_a3_3->unk32 + var_s6;
        *temp_t2 = (*temp_t2 & 0xFF000000) | ((s32) temp_s1 & 0xFFFFFF);
        temp_s4 = (s32) (temp_s3 + (void *)0x80111F88->unk394) >> 1;
        temp_v1_5 = var_s4 / 655360;
        temp_s0 = var_s4 / 6553600;
        temp_s6 = temp_v1_5 - (temp_s0 * 0xA);
        func_800D2E88(temp_s1, (((var_s4 >> 0x10) - (temp_v1_5 * 0xA)) * 0x14) + ((void *)0x80111F88 + 0x370), temp_s2, sp18, 0xC8C8C8);
        temp_s1->unk28 = 0x505050;
        temp_s1->unk1C = 0x505050;
        sp1C = temp_s3 - temp_s4;
        if (temp_s6 == 1) {
            var_s2 = temp_s2 - temp_s4;
        } else if (temp_s6 == 7) {
            var_s2 = temp_s2 - temp_s7;
        } else {
            var_s2 = temp_s2 - temp_s3;
        }
        if ((temp_s0 != 0) || (temp_s6 != 0)) {
            temp_s1_2 = *(void *)0x1F800004;
            temp_t0 = *(void *)0x1F800000;
            temp_s1_2->unk0 = (s32) ((temp_s1_2->unk0 & 0xFF000000) | (*temp_t0 & 0xFFFFFF));
            *(void *)0x1F800004 = (void *) (temp_s1_2 + 0x34);
            *temp_t0 = (*temp_t0 & 0xFF000000) | ((s32) temp_s1_2 & 0xFFFFFF);
            func_800D2E88(temp_s1_2, (temp_s6 * 0x14) + 0x801122F8, var_s2, sp18, sp24);
            temp_s1_2->unk28 = sp20;
            temp_s1_2->unk1C = sp20;
        }
        if (temp_s6 == 1) {
            var_s2 -= sp1C;
        }
        if (temp_s0 != 0) {
            temp_s1_3 = *(void *)0x1F800004;
            temp_t0_2 = *(void *)0x1F800000;
            temp_s1_3->unk0 = (s32) ((temp_s1_3->unk0 & 0xFF000000) | (*temp_t0_2 & 0xFFFFFF));
            *(void *)0x1F800004 = (void *) (temp_s1_3 + 0x34);
            *temp_t0_2 = (*temp_t0_2 & 0xFF000000) | ((s32) temp_s1_3 & 0xFFFFFF);
            func_800D2E88(temp_s1_3, (temp_s0 * 0x14) + 0x801122F8, (var_s2 - 1) - (((temp_s0 + 0x2C) * 0x14) + 0x80111F88)->unk10, sp18, sp24);
            temp_s1_3->unk28 = sp20;
            temp_s1_3->unk1C = sp20;
        }
    }
    if ((((arg0 * 4) + 0x80113A14)->unk2C != 0) && (((s32) *(void *)0x8011F394 >> 5) & 1)) {
        temp_a1_7 = *(void *)0x1F800000;
        var_s5->unk0 = (s32) ((var_s5->unk0 & 0xFF000000) | (*temp_a1_7 & 0xFFFFFF));
        *temp_a1_7 = (*temp_a1_7 & 0xFF000000) | ((s32) var_s5 & 0xFFFFFF);
    }
}

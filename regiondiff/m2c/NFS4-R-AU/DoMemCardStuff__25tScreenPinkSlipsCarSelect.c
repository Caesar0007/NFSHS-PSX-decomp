/* NFS4-R-AU CHANGED @8003F2BC | base 8003EF14 DoMemCardStuff__25tScreenPinkSlipsCarSelect */
/* callers: DrawBackground__25tScreenPinkSlipsCarSelect */
? func_800138B4(void *);                            /* extern */
s32 func_8001645C(?);                               /* extern */
s16 func_80017590(?, u8);                           /* extern */
? func_800181FC(s32, u8);                           /* extern */
? func_8001821C(s32, u8);                           /* extern */
? func_8002B8C8();                                  /* extern */
? func_800349B4();                                  /* extern */
s16 func_80034F84(u8, ?, ?);                        /* extern */
? func_80050420(?);                                 /* extern */
s32 *func_800507E4(?);                              /* extern */

void func_8003F2BC(void *arg0) {
    ? var_s1;
    s16 temp_v0_2;
    s32 *temp_s0;
    s32 *temp_v0;
    s32 *var_v1;
    s32 temp_a0;
    s32 temp_s7;
    s32 temp_v1_2;
    s32 temp_v1_3;
    s32 temp_v1_4;
    s32 var_s4;
    s32 var_v0;
    u8 temp_s2;
    void *temp_v1;

    temp_s2 = (*(void **)0x80051A60)->unk22C;
    var_s1 = 1;
    if (temp_s2 != 0) {
        var_s1 = 5;
    }
    if ((arg0->unk448 == 0) && ((temp_s2 != 1) || ((void *)0x80052584->unk0 == 6)) && (temp_v1 = (void *)0x80050000 + 0x2584, ((void *)0x80052584->unk0 != 8)) && (temp_s7 = temp_s2 * 4, (temp_v1->unk4 != 8)) && (temp_s0 = temp_s7 + temp_v1, temp_a0 = *temp_s0, (temp_a0 != 6))) {
        if ((arg0->unk424 ^ 1) != 0) {
            arg0->unk438 = 0;
            return;
        }
        temp_v1_2 = arg0->unk438;
        if (temp_v1_2 < 5) {
            arg0->unk438 = (s32) (temp_v1_2 + 1);
            return;
        }
        if (temp_a0 != 8) {
            func_80050420(var_s1);
            temp_v0 = func_800507E4(var_s1);
            arg0->unk43C = temp_v0;
            if (*temp_v0 == -1) {
                *temp_s0 = 0;
            } else if ((*(s32 *)0x80051FBC == 0) && (*temp_s0 == 0)) {
                *temp_s0 = 8;
                func_800138B4(*(void **)0x80051A60);
                func_800138B4(*(void **)0x80051A60);
                temp_v0_2 = func_80034F84(temp_s2, 1, 0);
                switch (temp_v0_2) {                /* irregular */
                case 0:
                    var_s4 = 0;
                    if (func_80017590(0x80115558, temp_s2) == 0x20) {
                        *temp_s0 = 5;
                    } else {
                        if ((func_80017590(0x80115558, temp_s2) >= 2) || ((func_80017590(0x80115558, temp_s2) == 1) && ((temp_s7 + 0x801158E4)->unk4C >= func_8001645C(0x80115558)))) {
                            var_s4 = 1;
                        }
                        temp_v1_3 = temp_s2 * 4;
                        if (var_s4 != 0) {
                            var_v1 = temp_v1_3 + 0x80052584;
                            var_v0 = 6;
                        } else {
                            var_v1 = temp_v1_3 + 0x80052584;
                            var_v0 = 4;
                        }
block_33:
                        *var_v1 = var_v0;
                    }
                    break;
                case 1:
                    *temp_s0 = (s32) temp_v0_2;
                    break;
                case 2:
                    *temp_s0 = 3;
                    break;
                default:
                    var_v1 = (temp_s2 * 4) + 0x80052584;
                    var_v0 = 2;
                    goto block_33;
                }
            }
        }
        if (*(0x80052584 + (temp_s2 * 4)) == 6) {
            func_8001821C(*(s32 *)0x80051F98 + 0x19D4, temp_s2);
            func_800181FC(*(s32 *)0x80051F98 + 0x19D4, temp_s2);
        }
        temp_v1_4 = (void *)0x80052584->unk0;
        if ((temp_v1_4 == 6) && ((void *)0x80052584->unk4 == temp_v1_4)) {
            func_800349B4();
            func_8002B8C8();
        }
    }
}

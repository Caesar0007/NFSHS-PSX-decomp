/* NFS4-R-JPN CHANGED @8009C7C8 | base 8009BD9C GameSetup_StartUp__FPi */
/* callers: Nfs2_GameModuleStartUp__FPi */
? func_8009CE08();                                  /* extern */
? func_800BE1B4(s32, s32, s32);                     /* extern */
s32 func_800E4B90(?);                               /* extern */
? func_800E4BF4();                                  /* extern */
? func_800E5F18(s32 *);                             /* extern */
? func_800E8C5C(?);                                 /* extern */

void func_8009C7C8(s32 *arg0) {
    ? (*temp_v0)(s32, s32);
    s32 *var_a0_2;
    s32 *var_s0;
    s32 *var_v1;
    s32 *var_v1_2;
    s32 *var_v1_3;
    s32 temp_a0;
    s32 temp_a0_2;
    s32 temp_a1;
    s32 temp_a1_2;
    s32 temp_a2;
    s32 temp_v0_2;
    s32 var_a0;
    s32 var_a1;
    s32 var_s0_2;
    s32 var_v0;
    s32 var_v0_2;

    func_8009CE08();
    var_s0 = arg0;
    if (*arg0 != 0) {
        do {
            temp_a1 = var_s0->unk0;
            if (temp_a1 >= 0x103) {
                var_v1 = (s32 *)0x80113840;
                var_a0 = 0;
                if (*(s32 *)0x80113840 != 0) {
                    var_v0 = *(s32 *)0x80113840;
                    do {
                        if (var_v0 == temp_a1) {
                            var_a0 = var_v1->unk4;
                        }
                        var_v1 += 8;
                        var_v0 = *var_v1;
                    } while (var_v0 != 0);
                }
                if (var_a0 != 0) {
                    *(var_a0 + (var_s0->unk4 * 0xB4)) = var_s0->unk8;
                }
                var_s0 += 0xC;
            } else {
                var_v1_2 = (s32 *)0x80110000 + 0x3840;
                if (temp_a1 >= 0x4D) {
                    ((temp_a1 * 4) + 0x80114CB8)->unk-134 = (s32) var_s0->unk4;
                    temp_a0 = var_s0->unk4;
                    temp_v0 = (((temp_a0 & 0xFF) * 0xC) + 0x8011FCF4)->unk8;
                    if (temp_v0 != NULL) {
                        temp_v0(temp_a0 >> 8, temp_a1);
                        var_s0 += 8;
                    } else {
                        goto block_28;
                    }
                } else {
                    var_a0_2 = NULL;
                    if (*(s32 *)0x80113840 != 0) {
                        var_v0_2 = (s32 *)0x80110000->unk3840;
                        do {
                            if (var_v0_2 == temp_a1) {
                                var_a0_2 = var_v1_2->unk4;
                            }
                            var_v1_2 += 8;
                            var_v0_2 = *var_v1_2;
                        } while (var_v0_2 != 0);
                    }
                    if (var_a0_2 != NULL) {
                        if (var_s0->unk0 >= 0x4B) {
                            var_a1 = 0;
                            if (var_s0->unk4 > 0) {
                                var_v1_3 = var_s0;
                                do {
                                    temp_v0_2 = var_v1_3->unk8;
                                    var_v1_3 += 4;
                                    var_a1 += 1;
                                    *var_a0_2 = temp_v0_2;
                                    var_a0_2 += 4;
                                } while (var_a1 < var_s0->unk4);
                            }
                        } else {
                            *var_a0_2 = var_s0->unk4;
                        }
                    }
                    if (var_s0->unk0 >= 0x4B) {
                        var_s0 += var_s0->unk4 * 4;
                    }
block_28:
                    var_s0 += 8;
                }
            }
        } while (*var_s0 != 0);
    }
    func_800E5F18(arg0);
    func_800E8C5C(0x64);
    func_800E4BF4();
    if ((func_800E4B90(0) & 0xFFFF) == 0xF00) {
        *(s32 *)0x801142C8 = 0;
    }
    if ((func_800E4B90(0) & 0xFFFF) == 0xA080) {
        (void *)0x80114290->unk38 = (s32) ((void *)0x80114290->unk38 + 2);
    }
    if ((func_800E4B90(0) & 0xFFFF) == 0xC001) {
        (void *)0x80114290->unk38 = (s32) ((void *)0x80114290->unk38 + 4);
    }
    if ((func_800E4B90(0) & 0xFFFF) == 0x909) {
        (void *)0x80114290->unk38 = (s32) ((void *)0x80114290->unk38 + 8);
    }
    if ((func_800E4B90(0) & 0xFFFF) == 0x640) {
        (void *)0x80114290->unk38 = (s32) ((void *)0x80114290->unk38 + 0x10);
    }
    if ((func_800E4B90(0) & 0xFFFF) == 0x610) {
        (void *)0x80114290->unk38 = (s32) ((void *)0x80114290->unk38 + 0x20);
    }
    if ((func_800E4B90(0) & 0xFFFF) == 0x910) {
        (void *)0x80114290->unk38 = (s32) ((void *)0x80114290->unk38 + 0x40);
    }
    var_s0_2 = 0;
    if ((func_800E4B90(0) & 0xFFFF) == 0x5010) {
        (void *)0x80114290->unk38 = (s32) ((void *)0x80114290->unk38 + 0x80);
    }
    if ((func_800E4B90(0) & 0xFFFF) == 0x620) {
        var_s0_2 = (func_800E4B90(4) & 0xFFFF) == 0x620;
    }
    if (var_s0_2 != 0) {
        (void *)0x80114290->unk38 = (s32) ((void *)0x80114290->unk38 + 0x100);
    }
    temp_a0_2 = (void *)0x80114290->unkF4;
    temp_a1_2 = (void *)0x80114290->unkFC;
    temp_a2 = (void *)0x80114290->unkF8;
    *(s32 *)0x8013D730 = (void *)0x80114290->unkF0;
    *(s32 *)0x8013D734 = temp_a0_2;
    *(s32 *)0x8013D73C = temp_a1_2;
    *(s32 *)0x8013D738 = temp_a2;
    *(s32 *)0x8013D740 = (void *)0x80114290->unk100;
    func_800BE1B4(temp_a0_2, temp_a1_2, temp_a2);
}

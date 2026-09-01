/* NFS4-R-USA CHANGED @8009C7C8 | base 8009BD9C GameSetup_StartUp__FPi */
/* callers: Nfs2_GameModuleStartUp__FPi */
? func_8009CE08();                                  /* extern */
? func_800BE3C8(s32, s32, s32);                     /* extern */
s32 func_800E4DA4(?);                               /* extern */
? func_800E4E08();                                  /* extern */
? func_800E612C(s32 *);                             /* extern */
? func_800E8E70(?);                                 /* extern */

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
                var_v1 = (s32 *)0x80113A54;
                var_a0 = 0;
                if (*(s32 *)0x80113A54 != 0) {
                    var_v0 = *(s32 *)0x80113A54;
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
                var_v1_2 = (s32 *)0x80110000 + 0x3A54;
                if (temp_a1 >= 0x4D) {
                    ((temp_a1 * 4) + 0x80114ECC)->unk-134 = (s32) var_s0->unk4;
                    temp_a0 = var_s0->unk4;
                    temp_v0 = (((temp_a0 & 0xFF) * 0xC) + 0x8011FF08)->unk8;
                    if (temp_v0 != NULL) {
                        temp_v0(temp_a0 >> 8, temp_a1);
                        var_s0 += 8;
                    } else {
                        goto block_28;
                    }
                } else {
                    var_a0_2 = NULL;
                    if (*(s32 *)0x80113A54 != 0) {
                        var_v0_2 = (s32 *)0x80110000->unk3A54;
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
    func_800E612C(arg0);
    func_800E8E70(0x64);
    func_800E4E08();
    if ((func_800E4DA4(0) & 0xFFFF) == 0xF00) {
        *(s32 *)0x801144DC = 0;
    }
    if ((func_800E4DA4(0) & 0xFFFF) == 0xA080) {
        (void *)0x801144A4->unk38 = (s32) ((void *)0x801144A4->unk38 + 2);
    }
    if ((func_800E4DA4(0) & 0xFFFF) == 0xC001) {
        (void *)0x801144A4->unk38 = (s32) ((void *)0x801144A4->unk38 + 4);
    }
    if ((func_800E4DA4(0) & 0xFFFF) == 0x909) {
        (void *)0x801144A4->unk38 = (s32) ((void *)0x801144A4->unk38 + 8);
    }
    if ((func_800E4DA4(0) & 0xFFFF) == 0x640) {
        (void *)0x801144A4->unk38 = (s32) ((void *)0x801144A4->unk38 + 0x10);
    }
    if ((func_800E4DA4(0) & 0xFFFF) == 0x610) {
        (void *)0x801144A4->unk38 = (s32) ((void *)0x801144A4->unk38 + 0x20);
    }
    if ((func_800E4DA4(0) & 0xFFFF) == 0x910) {
        (void *)0x801144A4->unk38 = (s32) ((void *)0x801144A4->unk38 + 0x40);
    }
    var_s0_2 = 0;
    if ((func_800E4DA4(0) & 0xFFFF) == 0x5010) {
        (void *)0x801144A4->unk38 = (s32) ((void *)0x801144A4->unk38 + 0x80);
    }
    if ((func_800E4DA4(0) & 0xFFFF) == 0x620) {
        var_s0_2 = (func_800E4DA4(4) & 0xFFFF) == 0x620;
    }
    if (var_s0_2 != 0) {
        (void *)0x801144A4->unk38 = (s32) ((void *)0x801144A4->unk38 + 0x100);
    }
    temp_a0_2 = (void *)0x801144A4->unkF4;
    temp_a1_2 = (void *)0x801144A4->unkFC;
    temp_a2 = (void *)0x801144A4->unkF8;
    *(s32 *)0x8013D944 = (void *)0x801144A4->unkF0;
    *(s32 *)0x8013D948 = temp_a0_2;
    *(s32 *)0x8013D950 = temp_a1_2;
    *(s32 *)0x8013D94C = temp_a2;
    *(s32 *)0x8013D954 = (void *)0x801144A4->unk100;
    func_800BE3C8(temp_a0_2, temp_a1_2, temp_a2);
}

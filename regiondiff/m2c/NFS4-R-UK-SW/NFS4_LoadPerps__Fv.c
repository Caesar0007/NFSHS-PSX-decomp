/* NFS4-R-UK-SW CHANGED @800A4A70 | base 800A3F08 NFS4_LoadPerps__Fv */
/* callers: Nfs2_GameModuleStartUp__FPi */
? func_800E5094(? *, ?, s32, s32);                  /* extern */
? func_800E6118(u32 *, s32);                        /* extern */
u32 *func_800E63C0(? *, ?);                         /* extern */

void func_800A4A70(void) {
    ? sp10;
    s16 temp_a1;
    s16 var_t4;
    s32 *var_t3;
    s32 temp_v0_2;
    s32 var_a3;
    s32 var_v0;
    s32 var_v0_2;
    u32 *temp_s0;
    u32 *temp_s1;
    u32 *temp_t2;
    u32 *var_v1;
    u32 temp_t1;
    u32 var_a0;
    u8 *var_t0;
    u8 temp_v0;
    void *temp_v1;
    void *temp_v1_2;
    void *var_a1;
    void *var_a2;
    void *var_a3_2;

    if ((void *)0x801144D0->unk1AC > 0) {
        if (((void *)0x801144D0->unkC != 1) && ((void *)0x801144D0->unk18 <= 0)) {
            var_a3 = 0x800567AC;
        } else {
            var_a3 = 0x800567B8;
        }
        func_800E5094(&sp10, 0x8013E59C, (void *)0x8011774C->unk94, var_a3);
        temp_s0 = func_800E63C0(&sp10, 0x10);
        func_800E5094(&sp10, 0x8013E59C, *(s32 *)0x801177E0, 0x800567C4);
        var_a1 = (void *)0x801144D0;
        var_t3 = (s32 *)0x8011468C;
        var_t4 = 0;
        temp_s1 = func_800E63C0(&sp10, 0x10);
        temp_t1 = *temp_s1;
        var_t0 = &(temp_s0 + 0xC)[temp_s0->unk0] + (temp_s0->unk4 * 0x14) + ((void *)0x801144D0->unk1B0 * 0x2C);
        if ((void *)0x801144D0->unk1AC > 0) {
            temp_t2 = temp_s1 + 4;
            var_a2 = (void *)0x801144D0 + 0x1C8;
            var_a3_2 = var_t0 + 1;
            do {
                var_a0 = 0;
                if (temp_t1 != 0) {
                    var_v1 = temp_t2;
loop_9:
                    var_v0 = var_a0 < temp_t1;
                    if (*var_v1 != *var_t0) {
                        var_a0 += 1;
                        var_v1 += 0xCC;
                        if (var_a0 >= temp_t1) {
                            var_v0 = var_a0 < temp_t1;
                        } else {
                            goto loop_9;
                        }
                    }
                    var_v0_2 = var_a0 * 2;
                    if (var_v0 == 0) {
                        goto block_13;
                    }
                } else {
block_13:
                    var_a0 = 0;
                    var_v0_2 = 0 * 2;
                }
                *var_t3 = (s32) (((var_v0_2 + var_a0) * 0x44) + temp_t2)->unk1;
                var_a2->unk-8 = (s32) var_a3_2->unk0;
                var_a2->unk4 = (s32) var_a3_2->unk1;
                var_a2->unk8 = (s32) var_a3_2->unk3;
                if ((void *)0x801144D0->unkC != 1) {
                    var_a2->unkC = (s32) var_a3_2->unk5;
                    var_a2->unk10 = (s32) var_a3_2->unk7;
                    var_a2->unk14 = (s32) var_a3_2->unk9;
                } else {
                    var_a2->unkC = -1;
                    var_a2->unk10 = -1;
                    var_a2->unk14 = -1;
                }
                var_t0 += 0x2C;
                var_t3 += 0x34;
                var_a2->unk18 = (s32) var_a3_2->unkD;
                temp_a1 = var_t4 + 1;
                var_a2->unk1C = (s32) var_a3_2->unkF;
                var_t4 = temp_a1;
                var_a2->unk20 = (s32) var_a3_2->unk13;
                var_a2->unk24 = (s32) var_a3_2->unk17;
                temp_v1 = (var_a0 * 0xCC) + temp_t2;
                var_a2->unk-4 = (s32) (temp_v1 + var_a3_2->unk0)->unk84;
                temp_v0 = var_a3_2->unk0;
                var_a3_2 += 0x2C;
                temp_v1_2 = temp_v1 + (temp_v0 * 4);
                temp_v0_2 = temp_v1_2->unk44;
                var_a2->unk0 = (s32) (temp_v1_2->unk46 | (temp_v0_2 & 0xFF00) | ((temp_v0_2 & 0xFF) << 0x10));
                var_a1 = (void *) (temp_a1 < (void *)0x801144D0->unk1AC);
                var_a2 += 0x34;
            } while (var_a1 != NULL);
        }
        func_800E6118(temp_s0, (s32) var_a1);
        func_800E6118(temp_s1);
    }
}

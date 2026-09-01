/* NFS4-R-USA CHANGED @800FA654 | base 800F9CA4 CdReadyHandler */
? func_800E6EC8(void *, u8 *, s32);                 /* extern */
? func_800E76E0(?, ?, ?);                           /* extern */
? func_800EB9A4(?);                                 /* extern */
? func_800EB9EC(s32 *);                             /* extern */
? func_800EBA00(s32);                               /* extern */
? func_800F8174(void *);                            /* extern */
? func_800F81A8(?, ?);                              /* extern */
? func_800F81FC(?);                                 /* extern */
? func_800F8210(?, u8 *, u8 *);                     /* extern */
? func_800F85CC(u8 *, ?);                           /* extern */
? func_800F8630(?);                                 /* extern */
? func_800F8650(s32, u8 *);                         /* extern */
s32 func_800F8754(u8 *);                            /* extern */

void func_800FA654(s32 arg0, u8 *arg1) {
    u8 sp10;
    u8 sp1C;
    u8 sp138;
    s32 sp140;
    ? var_a0;
    s32 temp_a0;
    s32 temp_a0_3;
    s32 temp_a0_4;
    s32 temp_a0_5;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 var_s2;
    u8 *var_a1;
    u8 *var_a2;
    u8 *var_s1;
    void *temp_a0_2;
    void *temp_s1;
    void *temp_s1_2;
    void *temp_v1;

    func_800F81FC(0);
    var_s2 = 0;
    if (*arg1 & 0x10) {
        func_800EB9A4(0x800FA5F4);
        func_800E76E0(0x800FA444, 0, 0);
        return;
    }
    temp_a0 = arg0 & 0xFF;
    switch (temp_a0) {                              /* irregular */
    case 2:
        temp_a0_2 = (void *)0x80148020 - 0x20;
        if (temp_a0_2->unk1C == -1) {
            temp_a0_2->unk1C = 0;
block_36:
            (void *)0x80148020->unk-20 = (s32) ((void *)0x80148020->unk-20 | 2);
        }
block_37:
    default:
        (void *)0x80148000->unkC = (s32) ((void *)0x80148000->unkC + 1);
        if ((void *)0x80148000->unk0 & 2) {
            (void *)0x80148000->unk0 = (s32) ((void *)0x80148000->unk0 & ~2);
            (void *)0x80148000->unk0 = (s32) ((void *)0x80148000->unk0 & ~0x10);
            (void *)0x80148000->unk0 = (s32) ((void *)0x80148000->unk0 | 1);
            if ((void *)0x80148000->unkC != (void *)0x80148000->unk14) {
                func_800F8174((void *)0x80150000);
                func_800F81A8(0, 0);
                temp_a0_3 = (void *)0x80148000->unk14;
                (void *)0x80148000->unkC = temp_a0_3;
                func_800F8650(temp_a0_3, &sp138);
                func_800F8210(0x1B, &sp138, arg1);
            }
        }
        temp_v1 = (void *)0x80150000 - 0x8000;
        if (!((void *)0x80148000->unk0 & 1)) {
            temp_a0_4 = temp_v1->unk10;
            if ((temp_v1->unkC - temp_a0_4) >= 0x15) {
                temp_v1->unkC = temp_a0_4;
                func_800F8650(temp_a0_4, &sp138);
                var_a0 = 0x1B;
                var_a1 = &sp138;
                var_a2 = arg1;
block_45:
                func_800F8210(var_a0, var_a1, var_a2);
            }
        }
        break;
    case 1:
        if ((void *)0x80148020->unk-20 & 1) {
            if ((void *)0x80148020->unk-20 & 4) {
                var_s2 = 1;
                (void *)0x80148020->unk-20 = (s32) ((void *)0x80148020->unk-20 & ~4);
                goto block_28;
            }
            var_s1 = (void *)0x80148020 + 0x1C;
            if (!((void *)0x80148020->unk-20 & 8)) {
                var_s1 = (void *)0x80148020->unkC;
            }
            func_800F85CC(&sp10, 3);
            func_800F85CC(var_s1, 0x200);
            func_800F85CC(&sp1C, 0x46);
            func_800F8630(0);
            if (func_800F8754(&sp10) != (void *)0x80148000->unkC) {
                temp_v0 = (void *)0x80148000->unk1C + 1;
                (void *)0x80148000->unk1C = temp_v0;
                (void *)0x80148000->unk14 = (s32) (void *)0x80148000->unkC;
                if (temp_v0 < 4) {
                    (void *)0x80148000->unk0 = (s32) ((void *)0x80148000->unk0 | 2);
                    goto block_29;
                }
                (void *)0x80148000->unk1C = -1;
                var_a0 = 9;
                var_a1 = NULL;
                var_a2 = NULL;
                goto block_45;
            }
            (void *)0x80148000->unk18 = (s32) (*(s32 *)0x8013EFA4 * 0xC);
            if ((void *)0x80148000->unk0 & 8) {
                (void *)0x80148000->unk0 = (s32) ((void *)0x80148000->unk0 & ~8);
                (void *)0x80148000->unk0 = (s32) ((void *)0x80148000->unk0 | 0x10);
                func_800E6EC8((void *)0x80148020->unk8 + ((void *)0x80148000 + 0x3C), (void *)0x80148020->unkC, (void *)0x80148020->unk0);
                (void *)0x80148020->unk8 = 0;
            }
            if ((void *)0x80148020->unk4 > 0) {
                temp_a0_5 = (void *)0x80148020->unk4;
                (void *)0x80148020->unkC = &(void *)0x80148020->unkC[(void *)0x80148020->unk0];
                if (temp_a0_5 < 0x800) {
                    (void *)0x80148020->unk0 = temp_a0_5;
                    (void *)0x80148000->unk0 = (s32) ((void *)0x80148000->unk0 | 8);
                } else {
                    (void *)0x80148020->unk0 = 0x800;
                }
                (void *)0x80148020->unk4 = (s32) ((void *)0x80148020->unk4 - (void *)0x80148020->unk0);
            } else {
                var_s2 = 1;
            }
            goto block_29;
        }
block_28:
        func_800F8174((void *)0x80150000);
        func_800F81A8(0, 0);
block_29:
        if (var_s2 != 0) {
            temp_s1 = (void *)0x80150000 - 0x8000;
            (void *)0x80148000->unk0 = (s32) ((void *)0x80148000->unk0 & ~1);
            temp_s1->unk10 = (s32) temp_s1->unkC;
            func_800EB9A4(0x800FA5F4);
            temp_s1->unk18 = 0;
            if (temp_s1->unk30 != NULL) {
                *(s32 *)0x8013F060 = 2;
                func_800EB9EC(&sp140);
                temp_s1->unk30(1);
                func_800EBA00(sp140);
                *(s32 *)0x8013F060 = 0;
            }
        }
        goto block_37;
    case 5:
        temp_s1_2 = (void *)0x80148020 - 0x20;
        if ((void *)0x80148020->unk-20 & 1) {
            func_800F8210(1, NULL, &sp10);
            temp_v0_2 = temp_s1_2->unk1C + 1;
            temp_s1_2->unk1C = temp_v0_2;
            temp_s1_2->unk14 = (s32) temp_s1_2->unkC;
            if (temp_v0_2 >= 4) {
                temp_s1_2->unk1C = -1;
                var_a0 = 9;
                var_a1 = NULL;
                var_a2 = NULL;
                goto block_45;
            }
            goto block_36;
        }
        goto block_37;
    }
    func_800F81FC(0x800FA654);
}

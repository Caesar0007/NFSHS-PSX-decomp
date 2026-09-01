/* NFS4-R-USA CHANGED @800FB028 | base 800FA678 CD_Read */
/* callers: readfile */
? func_800E6EC8(void *, s32, s32);                  /* extern */
? func_800EB944(?, s32, ?);                         /* extern */
? func_800EB9A4(?);                                 /* extern */
? func_800EB9EC(s32 *);                             /* extern */
? func_800EBA00(s32);                               /* extern */

s32 func_800FB028(s32 arg0, s32 arg1, s32 arg2, s32 arg3) {
    s32 sp10;
    s32 temp_a0_2;
    s32 temp_v0;
    s32 temp_v1;
    s32 temp_v1_2;
    s32 var_a2;
    s32 var_s3;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v0_3;
    void **temp_a0;
    void *temp_s0;

    var_a2 = arg2;
    var_s3 = arg3;
    temp_a0 = (void *)0x80148000->unk34 + ((arg0 * 4) - 4);
    temp_s0 = (void *)0x80148000 + 0x20;
    if ((void *)0x80148000->unk0 & 3) {
        return 0;
    }
    temp_v1 = (*temp_a0)->unk10 - var_a2;
    if (temp_v1 < var_s3) {
        var_s3 = temp_v1;
    }
    var_v0 = var_a2;
    if (var_a2 < 0) {
        var_v0 = var_a2 + 0x7FF;
    }
    temp_v0 = var_a2 - ((var_v0 >> 0xB) << 0xB);
    temp_s0->unk8 = temp_v0;
    temp_s0->unkC = arg1;
    if ((temp_v0 != 0) || (var_s3 < 0x800)) {
        (void *)0x80148000->unk0 = (s32) ((void *)0x80148000->unk0 | 8);
    }
    temp_v1_2 = temp_s0->unk8;
    if ((temp_v1_2 + var_s3) >= 0x801) {
        var_v0_2 = 0x800 - temp_v1_2;
    } else {
        var_v0_2 = var_s3;
    }
    (void *)0x80148000->unk20 = var_v0_2;
    temp_s0->unk4 = (s32) (var_s3 - var_v0_2);
    if (var_a2 < 0) {
        var_a2 += 0x7FF;
    }
    (void *)0x80148000->unk1C = 0;
    (void *)0x80148000->unk14 = (s32) ((*temp_a0)->unkC + (var_a2 >> 0xB));
    (void *)0x80148000->unk0 = (s32) ((void *)0x80148000->unk0 | 2);
    (void *)0x80148000->unk18 = (s32) (*(s32 *)0x8013EFA4 * 0xC);
    func_800EB944(0x800FA5F4, var_a2, 0x80150000);
    if ((void *)0x80148000->unkC == (void *)0x80148000->unk14) {
        if ((void *)0x80148000->unk0 & 0x10) {
            if (*(s32 *)0x8013F060 == 2) {
                func_800E6EC8(temp_s0->unk8 + ((void *)0x80148000 + 0x3C), temp_s0->unkC, (void *)0x80148000->unk20);
                if (temp_s0->unk4 > 0) {
                    temp_a0_2 = temp_s0->unk4;
                    temp_s0->unk8 = 0;
                    temp_s0->unkC = (s32) (temp_s0->unkC + (void *)0x80148000->unk20);
                    if (temp_a0_2 < 0x800) {
                        (void *)0x80148000->unk20 = temp_a0_2;
                        var_v0_3 = (void *)0x80148000->unk0 | 8;
                    } else {
                        (void *)0x80148000->unk20 = 0x800;
                        var_v0_3 = (void *)0x80148000->unk0 & ~8;
                    }
                    (void *)0x80148000->unk0 = var_v0_3;
                    temp_s0->unk4 = (s32) (temp_s0->unk4 - (void *)0x80148000->unk20);
                    (void *)0x80148000->unk14 = (s32) ((void *)0x80148000->unk14 + 1);
                } else {
                    (void *)0x80148000->unk0 = (s32) ((void *)0x80148000->unk0 & ~2);
                    func_800EB9A4(0x800FA5F4);
                    (void *)0x80148000->unk18 = 0;
                    if ((void *)0x80148000->unk30 != NULL) {
                        func_800EB9EC(&sp10);
                        (void *)0x80148000->unk30(1);
                        func_800EBA00(sp10);
                    }
                }
            }
        }
    }
    return var_s3;
}

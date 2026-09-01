/* NFS4-R-AU CHANGED @800FB054 | base 800FA678 CD_Read */
/* callers: readfile */
? func_800E6EB4(void *, s32, s32);                  /* extern */
? func_800EB930(?, s32, ?);                         /* extern */
? func_800EB990(?);                                 /* extern */
? func_800EB9D8(s32 *);                             /* extern */
? func_800EB9EC(s32);                               /* extern */

s32 func_800FB054(s32 arg0, s32 arg1, s32 arg2, s32 arg3) {
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
    temp_a0 = (void *)0x8014802C->unk34 + ((arg0 * 4) - 4);
    temp_s0 = (void *)0x8014802C + 0x20;
    if ((void *)0x8014802C->unk0 & 3) {
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
        (void *)0x8014802C->unk0 = (s32) ((void *)0x8014802C->unk0 | 8);
    }
    temp_v1_2 = temp_s0->unk8;
    if ((temp_v1_2 + var_s3) >= 0x801) {
        var_v0_2 = 0x800 - temp_v1_2;
    } else {
        var_v0_2 = var_s3;
    }
    (void *)0x8014802C->unk20 = var_v0_2;
    temp_s0->unk4 = (s32) (var_s3 - var_v0_2);
    if (var_a2 < 0) {
        var_a2 += 0x7FF;
    }
    (void *)0x8014802C->unk1C = 0;
    (void *)0x8014802C->unk14 = (s32) ((*temp_a0)->unkC + (var_a2 >> 0xB));
    (void *)0x8014802C->unk0 = (s32) ((void *)0x8014802C->unk0 | 2);
    (void *)0x8014802C->unk18 = (s32) (*(s32 *)0x8013EFD0 * 0xC);
    func_800EB930(0x800FA620, var_a2, 0x80150000);
    if ((void *)0x8014802C->unkC == (void *)0x8014802C->unk14) {
        if ((void *)0x8014802C->unk0 & 0x10) {
            if (*(s32 *)0x8013F08C == 2) {
                func_800E6EB4(temp_s0->unk8 + ((void *)0x8014802C + 0x3C), temp_s0->unkC, (void *)0x8014802C->unk20);
                if (temp_s0->unk4 > 0) {
                    temp_a0_2 = temp_s0->unk4;
                    temp_s0->unk8 = 0;
                    temp_s0->unkC = (s32) (temp_s0->unkC + (void *)0x8014802C->unk20);
                    if (temp_a0_2 < 0x800) {
                        (void *)0x8014802C->unk20 = temp_a0_2;
                        var_v0_3 = (void *)0x8014802C->unk0 | 8;
                    } else {
                        (void *)0x8014802C->unk20 = 0x800;
                        var_v0_3 = (void *)0x8014802C->unk0 & ~8;
                    }
                    (void *)0x8014802C->unk0 = var_v0_3;
                    temp_s0->unk4 = (s32) (temp_s0->unk4 - (void *)0x8014802C->unk20);
                    (void *)0x8014802C->unk14 = (s32) ((void *)0x8014802C->unk14 + 1);
                } else {
                    (void *)0x8014802C->unk0 = (s32) ((void *)0x8014802C->unk0 & ~2);
                    func_800EB990(0x800FA620);
                    (void *)0x8014802C->unk18 = 0;
                    if ((void *)0x8014802C->unk30 != NULL) {
                        func_800EB9D8(&sp10);
                        (void *)0x8014802C->unk30(1);
                        func_800EB9EC(sp10);
                    }
                }
            }
        }
    }
    return var_s3;
}

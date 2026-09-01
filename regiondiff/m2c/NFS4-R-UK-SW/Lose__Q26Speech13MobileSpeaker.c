/* NFS4-R-UK-SW CHANGED @80098F28 | base 80098434 Lose__Q26Speech13MobileSpeaker */
? func_80093F54(void *, void *);                    /* extern */
? func_800940D4(void *, void *, s32);               /* extern */
? func_80094360(void *, void *, s32, void *, s32, void *, void *); /* extern */
? func_800946D8(void *);                            /* extern */
? func_80094720(void *, void *);                    /* extern */
? func_80094A58(void *, s32, s32, void *);          /* extern */
? func_80094BA8(void *, void *, s32);               /* extern */
? func_80094D94(void *);                            /* extern */
? func_800950CC(void *, s32);                       /* extern */
? func_800954CC(void *, s32);                       /* extern */
void *func_800969E4();                              /* extern */
? func_800E821C();                                  /* extern */

void func_80098F28(void *arg0) {
    s32 temp_s0_2;
    s32 temp_v1_4;
    s32 var_s0;
    s32 var_v0;
    void *temp_a1;
    void *temp_s0;
    void *temp_v0;
    void *temp_v0_2;
    void *temp_v0_3;
    void *temp_v0_4;
    void *temp_v0_5;
    void *temp_v0_6;
    void *temp_v0_7;
    void *temp_v1;
    void *temp_v1_2;
    void *temp_v1_3;
    void *temp_v1_5;
    void *var_a0;
    void *var_s0_2;
    void *var_s2;

    temp_v0 = arg0->unk4C;
    if (temp_v0->unkDC(arg0 + temp_v0->unkD8) != 0) {
        saved_reg_gp->unk83C->unk38C = (s32) arg0->unk60;
        var_s0 = 0;
        if ((func_800969E4()->unk48 != 0) && (func_800969E4()->unk48->unk48 == arg0) && (arg0->unk14 == 0)) {
            var_s0 = arg0->unk2C == 0;
        }
        if (var_s0 != 0) {
            temp_v1 = arg0->unk4C;
            var_s2 = func_800969E4()->unk48;
            temp_v1_2 = var_s2->unk4C;
            temp_s0 = temp_v1->unkF4(arg0 + temp_v1->unkF0);
            arg0->unk3C = (s32) (temp_s0 + (temp_v1_2->unk8C(var_s2 + temp_v1_2->unk88) * 4))->unk8;
        } else {
            temp_v0_2 = arg0->unk4C;
            var_s2 = NULL;
            arg0->unk3C = (s32) temp_v0_2->unkF4(arg0 + temp_v0_2->unkF0)->unk4;
        }
        if (arg0->unk2C != 0) {
            func_800946D8(arg0 + 0x50);
            var_s0_2 = arg0 + 0x50;
            func_800E821C();
            var_a0 = var_s0_2;
            goto block_14;
        }
        var_v0 = 0;
        if (var_s2 == NULL) {
            temp_v0_3 = func_800969E4();
            temp_v1_3 = temp_v0_3->unk4C;
            var_v0 = temp_v1_3->unkAC(temp_v0_3 + temp_v1_3->unkA8) >= 0x161;
        }
        var_s0_2 = arg0 + 0x50;
        if (var_v0 == 0) {
            var_a0 = var_s0_2;
block_14:
            func_80094A58(var_a0, arg0->unk3C, arg0->unk38, arg0 + 0x18);
            func_800E821C();
            temp_v0_4 = arg0->unk4C;
            func_800950CC(arg0, temp_v0_4->unkDC(arg0 + temp_v0_4->unkD8));
            temp_v0_5 = arg0->unk4C;
            func_800954CC(arg0, temp_v0_5->unkDC(arg0 + temp_v0_5->unkD8));
            if (arg0->unk2C != 0) {
                func_80094720(var_s0_2, arg0 + 0x20);
            } else {
                temp_v0_6 = arg0->unk4C;
                if (temp_v0_6->unkCC(arg0 + temp_v0_6->unkC8)->unk260 & 0x200) {
                    func_80094D94(var_s0_2);
                } else {
                    temp_v1_4 = arg0->unk14;
                    if (temp_v1_4 == 1) {
                        func_80094BA8(var_s0_2, arg0 + 8, arg0->unk30);
                    } else if (temp_v1_4 == 2) {
                        func_800940D4(var_s0_2, arg0 + 8, arg0->unk30);
                    } else {
                        temp_a1 = arg0 + 8;
                        if (var_s2 != NULL) {
                            func_80093F54(var_s0_2, temp_a1);
                        } else {
                            func_80094360(var_s0_2, temp_a1, arg0->unk30, arg0, arg0->unk34, arg0 + 4, arg0 + 0x20);
                        }
                    }
                }
            }
            func_800E821C();
            arg0->unk14 = 0;
            arg0->unk2C = 0;
            arg0->unk28 = 0;
            if (var_s2 == NULL) {
                temp_s0_2 = func_800969E4()->unk48;
                func_800969E4()->unk48 = arg0;
                temp_v0_7 = func_800969E4();
                temp_v1_5 = temp_v0_7->unk4C;
                temp_v1_5->unk74(temp_v0_7 + temp_v1_5->unk70);
                func_800969E4()->unk48 = temp_s0_2;
            }
        }
    }
}

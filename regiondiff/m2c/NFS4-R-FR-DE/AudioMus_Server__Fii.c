/* NFS4-R-FR-DE CHANGED @8007AE4C | base 8007A3D0 AudioMus_Server__Fii */
? func_8007A960();                                  /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
? func_8007AC48(?);                                 /* extern */
? func_8007ACE4(void *);                            /* extern */
? func_8007AE0C();                                  /* extern */
s32 func_800E8FC4(s32);                             /* extern */
? func_800EA5A0(s32);                               /* extern */
? func_800EA6D4(s32, ?);                            /* extern */
? func_800EA730(s32, ?, s32);                       /* extern */
s32 func_800EA854(?);                               /* extern */
? func_800EAA20(s32, ?);                            /* extern */

s32 func_8007AE4C(void) {
    s32 temp_a0_2;
    s32 temp_s0;
    s32 temp_v0;
    s32 temp_v1_2;
    s32 var_a0;
    s32 var_a2;
    s32 var_v0;
    void *temp_a0;
    void *temp_a0_3;
    void *temp_a3;
    void *temp_v0_2;
    void *temp_v1;
    void *temp_v1_3;

    if (saved_reg_gp->unk1D8->unk88 != 0) {
        func_8007A960();
        if ((func_8007A9C4() != 0) && (saved_reg_gp->unk1D8->unk14 != 2)) {
            if (func_8007AA48() < 0x226) {
                func_8007AC48(-5);
            } else if (func_8007AA48() < 0x5DC) {
                temp_v1 = saved_reg_gp->unk1D8;
                if (temp_v1->unk80 == 0) {
                    func_800EA6D4(temp_v1->unk70, 1);
                    saved_reg_gp->unk1D8->unk80 = 1;
                }
            } else {
                temp_a0 = saved_reg_gp->unk1D8;
                if ((func_8007AA48() >= temp_a0->unk84) && (temp_a0->unk80 != 0)) {
                    func_800EA6D4(temp_a0->unk70, 0);
                    saved_reg_gp->unk1D8->unk80 = 0;
                }
            }
        }
        temp_a3 = saved_reg_gp->unk1D8;
        temp_v0 = temp_a3->unk14;
        if (temp_v0 != 0) {
            if (temp_v0 == 2) {
                if (temp_a3->unk6C == 0) {
                    func_8007AC48(-4);
                    return 0;
                }
                if (temp_a3->unk70 < 0) {
                    func_8007AC48(-3);
                    return 0;
                }
                if (temp_a3->unk8C != 0) {
                    if (temp_a3->unk84 < temp_a3->unkA4) {
                        if (temp_a3->unk1C == -5) {
                            var_a0 = temp_a3->unk70;
                            var_a2 = temp_a3->unk0;
                            temp_a3->unk1C = 0;
                        } else {
                            func_8007AE0C();
                            temp_v0_2 = saved_reg_gp->unk1D8;
                            var_a0 = temp_v0_2->unk70;
                            var_a2 = temp_v0_2->unk0;
                        }
                        func_800EA730(var_a0, 0x7D0, var_a2);
                        saved_reg_gp->unk1D8->unk14 = 0;
                    }
                }
                /* Duplicate return node #41. Try simplifying control flow for better match */
                return 0;
            }
            if ((temp_a3->unk8C == 0) || (func_800E8FC4(temp_a3->unk70) == 0)) {
                temp_a0_2 = saved_reg_gp->unk1D8->unk70;
                if (temp_a0_2 >= 0) {
                    func_800EA5A0(temp_a0_2);
                }
                temp_a0_3 = saved_reg_gp->unk1D8;
                temp_a0_3->unk28 = 0;
                if (temp_a0_3->unk14 == 1) {
                    temp_a0_3->unk20 = 0;
                    func_8007ACE4(temp_a0_3);
                    saved_reg_gp->unk1D8->unk14 = 2;
                } else {
                    temp_a0_3->unk14 = 0;
                }
            }
            /* Duplicate return node #41. Try simplifying control flow for better match */
            return 0;
        }
        if (temp_a3->unk8C == 0) {
            temp_v1_2 = temp_a3->unkC;
            if (temp_v1_2 >= 0) {
                temp_s0 = temp_a3->unk8;
                if (temp_s0 >= 2) {
                    if (temp_a3->unk24 != 0) {
                        if (func_800EA854(0) > 0) {
                            var_v0 = func_800EA854(0);
                        } else {
                            var_v0 = -func_800EA854(0);
                        }
                        temp_a3->unkC = (s32) ((s32) (temp_v1_2 + 1 + (var_v0 % (s32) (temp_s0 - 1))) % temp_s0);
                    } else {
                        temp_a3->unkC = (s32) ((s32) (temp_v1_2 + 1) % temp_s0);
                    }
                }
                func_800EAA20(saved_reg_gp->unk1D8->unk70, 0);
                func_8007ACE4();
                temp_v1_3 = saved_reg_gp->unk1D8;
                temp_v1_3->unk18 = 1;
                temp_v1_3->unk10 = 1;
            }
        }
        /* Duplicate return node #41. Try simplifying control flow for better match */
        return 0;
    }
    return 0;
}

/* NFS4-R-FR-DE CHANGED @8007EFEC | base 8007E5C8 BWorld_Init__Fv */
/* callers: Nfs2_GameModuleStartUp__FPi */
? func_800743FC(s32);                               /* extern */
? func_8007BEE8(s32);                               /* extern */
? func_8007E1C0();                                  /* extern */
? func_8007EE24();                                  /* extern */
? func_8007EE7C(?);                                 /* extern */
? func_8007EEA8(?, ?);                              /* extern */
? func_800A5DA8(void *);                            /* extern */
? func_800A6104();                                  /* extern */
? func_800A6A4C();                                  /* extern */
? func_800B6C54(s32);                               /* extern */
? func_800B6D5C(s32, ?);                            /* extern */
? func_800B9FC4(s32);                               /* extern */
s32 func_800B9FD4(?);                               /* extern */
s32 func_800BA01C(?);                               /* extern */
? func_800BB5B8(s32);                               /* extern */
? func_800DBE18(?);                                 /* extern */
s32 func_800EB41C(s32);                             /* extern */

void func_8007EFEC(void *arg0) {
    ? var_a0_2;
    ? var_a0_3;
    s32 *temp_a0_2;
    s32 temp_a0;
    s32 temp_v0;
    s32 temp_v1;
    s32 temp_v1_2;
    s32 temp_v1_3;
    s32 var_a0_4;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v0_3;
    void *var_a0;

    var_a0 = arg0;
    if (*(s32 *)0x8013E704 == 0) {
        var_a0 = (void *)0x80110000;
        if ((void *)0x801144D0->unkC != 1) {
            if ((void *)0x801144D0->unk0 != 2) {
                (void *)0x801144D0->unkD4 = (s32) (func_800EB41C(0x80110000) / 8192);
                temp_a0 = (void *)0x801144D0->unk4;
                temp_v1 = func_800EB41C();
                if (temp_a0 >= 2) {
                    var_v0 = temp_v1 * temp_a0;
                    if (var_v0 < 0) {
                        var_v0 += 0x7FFF;
                    }
                    var_v0_2 = var_v0 >> 0xF;
                } else {
                    var_v0_2 = temp_v1 / 16384;
                }
                (void *)0x801144D0->unkD8 = var_v0_2;
                var_a0 = (void *)0x801144D0;
                var_v0_3 = func_800EB41C(temp_a0) * (void *)0x801144D0->unk4;
                if (var_v0_3 < 0) {
                    var_v0_3 += 0x7FFF;
                }
                temp_v1_2 = (void *)0x801144D0->unkD8;
                temp_v0 = temp_v1_2 + (var_v0_3 >> 0xF);
                (void *)0x801144D0->unkDC = temp_v0;
                if (temp_v1_2 == temp_v0) {
                    (void *)0x801144D0->unkDC = (s32) (temp_v1_2 + 1);
                }
                if ((void *)0x801144D0->unk48 != 0) {
                    (void *)0x801144D0->unkD4 = (s32) ((void *)0x801144D0->unkD4 + 0xA);
                    (void *)0x801144D0->unkDC = (s32) ((void *)0x801144D0->unkDC + 5);
                } else if ((void *)0x801144D0->unk18 != 0) {
                    (void *)0x801144D0->unkD4 = (s32) ((void *)0x801144D0->unkD4 + 0x14);
                }
                saved_reg_gp->unk210 = 0;
            } else {
                goto block_18;
            }
        } else {
block_18:
            (void *)0x801144D0->unkD4 = 0x63;
            (void *)0x801144D0->unkD8 = 0x63;
            (void *)0x801144D0->unkDC = 0x63;
        }
    }
    func_800A5DA8(var_a0);
    func_800B9FC4((void *)0x801144D0->unk3C);
    func_8007EE24();
    if ((void *)0x801144D0->unkC == 1) {
        func_8007EEA8(1, 0);
        var_a0_2 = 1;
    } else {
        var_a0_2 = 0;
    }
    func_8007EEA8(var_a0_2, var_a0_2);
    func_8007EE7C(0);
    if ((void *)0x801144D0->unk54 != 0) {
        if ((void *)0x801144D0->unk48 != 0) {
            var_a0_3 = 0x8013DA8C;
        } else {
            var_a0_3 = 0x8013DA94;
        }
    } else if ((void *)0x801144D0->unk48 != 0) {
        var_a0_3 = 0x8013DA9C;
    } else {
        var_a0_3 = 0x8013DAA4;
    }
    func_800BB5B8(func_800B9FD4(var_a0_3));
    func_800A6104();
    func_800A6A4C();
    temp_a0_2 = *(s32 **)0x8013E7CC;
    if (temp_a0_2 != NULL) {
        func_800B6C54(*temp_a0_2);
    }
    func_800DBE18(5);
    func_800743FC(func_800BA01C(0x8013DAAC));
    if ((void *)0x801144D0->unkC != 1) {
        temp_v1_3 = (void *)0x801144D0->unk0;
        if (temp_v1_3 != 1) {
            if (temp_v1_3 != 5) {
                func_800B6D5C((void *)0x801144D0->unkD4, 0x801144D0);
            }
        }
    }
    var_a0_4 = (void *)0x801144D0->unk54 != 0;
    if ((void *)0x801144D0->unk48 != 0) {
        var_a0_4 += 2;
    }
    func_8007BEE8(var_a0_4);
    func_8007E1C0();
}

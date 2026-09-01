/* NFS4-R-JPN CHANGED @8007EFEC | base 8007E5C8 BWorld_Init__Fv */
/* callers: Nfs2_GameModuleStartUp__FPi */
? func_800743FC(s32);                               /* extern */
? func_8007BEE8(s32);                               /* extern */
? func_8007E1C0();                                  /* extern */
? func_8007EE24();                                  /* extern */
? func_8007EE7C(?);                                 /* extern */
? func_8007EEA8(?, ?);                              /* extern */
? func_800A5DA4(void *);                            /* extern */
? func_800A6100();                                  /* extern */
? func_800A6A48();                                  /* extern */
? func_800B6A04(s32);                               /* extern */
? func_800B6B0C(s32, ?);                            /* extern */
? func_800B9D74(s32);                               /* extern */
s32 func_800B9D84(?);                               /* extern */
s32 func_800B9DCC(?);                               /* extern */
? func_800BB368(s32);                               /* extern */
? func_800DBBD8(?);                                 /* extern */
s32 func_800EB21C(s32);                             /* extern */

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
    if (*(s32 *)0x8013E4C4 == 0) {
        var_a0 = (void *)0x80110000;
        if ((void *)0x80114290->unkC != 1) {
            if ((void *)0x80114290->unk0 != 2) {
                (void *)0x80114290->unkD4 = (s32) (func_800EB21C(0x80110000) / 8192);
                temp_a0 = (void *)0x80114290->unk4;
                temp_v1 = func_800EB21C();
                if (temp_a0 >= 2) {
                    var_v0 = temp_v1 * temp_a0;
                    if (var_v0 < 0) {
                        var_v0 += 0x7FFF;
                    }
                    var_v0_2 = var_v0 >> 0xF;
                } else {
                    var_v0_2 = temp_v1 / 16384;
                }
                (void *)0x80114290->unkD8 = var_v0_2;
                var_a0 = (void *)0x80114290;
                var_v0_3 = func_800EB21C(temp_a0) * (void *)0x80114290->unk4;
                if (var_v0_3 < 0) {
                    var_v0_3 += 0x7FFF;
                }
                temp_v1_2 = (void *)0x80114290->unkD8;
                temp_v0 = temp_v1_2 + (var_v0_3 >> 0xF);
                (void *)0x80114290->unkDC = temp_v0;
                if (temp_v1_2 == temp_v0) {
                    (void *)0x80114290->unkDC = (s32) (temp_v1_2 + 1);
                }
                if ((void *)0x80114290->unk48 != 0) {
                    (void *)0x80114290->unkD4 = (s32) ((void *)0x80114290->unkD4 + 0xA);
                    (void *)0x80114290->unkDC = (s32) ((void *)0x80114290->unkDC + 5);
                } else if ((void *)0x80114290->unk18 != 0) {
                    (void *)0x80114290->unkD4 = (s32) ((void *)0x80114290->unkD4 + 0x14);
                }
                saved_reg_gp->unk210 = 0;
            } else {
                goto block_18;
            }
        } else {
block_18:
            (void *)0x80114290->unkD4 = 0x63;
            (void *)0x80114290->unkD8 = 0x63;
            (void *)0x80114290->unkDC = 0x63;
        }
    }
    func_800A5DA4(var_a0);
    func_800B9D74((void *)0x80114290->unk3C);
    func_8007EE24();
    if ((void *)0x80114290->unkC == 1) {
        func_8007EEA8(1, 0);
        var_a0_2 = 1;
    } else {
        var_a0_2 = 0;
    }
    func_8007EEA8(var_a0_2, var_a0_2);
    func_8007EE7C(0);
    if ((void *)0x80114290->unk54 != 0) {
        if ((void *)0x80114290->unk48 != 0) {
            var_a0_3 = 0x8013D84C;
        } else {
            var_a0_3 = 0x8013D854;
        }
    } else if ((void *)0x80114290->unk48 != 0) {
        var_a0_3 = 0x8013D85C;
    } else {
        var_a0_3 = 0x8013D864;
    }
    func_800BB368(func_800B9D84(var_a0_3));
    func_800A6100();
    func_800A6A48();
    temp_a0_2 = *(s32 **)0x8013E58C;
    if (temp_a0_2 != NULL) {
        func_800B6A04(*temp_a0_2);
    }
    func_800DBBD8(5);
    func_800743FC(func_800B9DCC(0x8013D86C));
    if ((void *)0x80114290->unkC != 1) {
        temp_v1_3 = (void *)0x80114290->unk0;
        if (temp_v1_3 != 1) {
            if (temp_v1_3 != 5) {
                func_800B6B0C((void *)0x80114290->unkD4, 0x80114290);
            }
        }
    }
    var_a0_4 = (void *)0x80114290->unk54 != 0;
    if ((void *)0x80114290->unk48 != 0) {
        var_a0_4 += 2;
    }
    func_8007BEE8(var_a0_4);
    func_8007E1C0();
}

/* NFS4-R-USA CHANGED @8007EFEC | base 8007E5C8 BWorld_Init__Fv */
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
? func_800B6C50(s32);                               /* extern */
? func_800B6D58(s32, ?);                            /* extern */
? func_800B9FC0(s32);                               /* extern */
s32 func_800B9FD0(?);                               /* extern */
s32 func_800BA018(?);                               /* extern */
? func_800BB5B4(s32);                               /* extern */
? func_800DBDEC(?);                                 /* extern */
s32 func_800EB430(s32);                             /* extern */

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
    if (*(s32 *)0x8013E6D8 == 0) {
        var_a0 = (void *)0x80110000;
        if ((void *)0x801144A4->unkC != 1) {
            if ((void *)0x801144A4->unk0 != 2) {
                (void *)0x801144A4->unkD4 = (s32) (func_800EB430(0x80110000) / 8192);
                temp_a0 = (void *)0x801144A4->unk4;
                temp_v1 = func_800EB430();
                if (temp_a0 >= 2) {
                    var_v0 = temp_v1 * temp_a0;
                    if (var_v0 < 0) {
                        var_v0 += 0x7FFF;
                    }
                    var_v0_2 = var_v0 >> 0xF;
                } else {
                    var_v0_2 = temp_v1 / 16384;
                }
                (void *)0x801144A4->unkD8 = var_v0_2;
                var_a0 = (void *)0x801144A4;
                var_v0_3 = func_800EB430(temp_a0) * (void *)0x801144A4->unk4;
                if (var_v0_3 < 0) {
                    var_v0_3 += 0x7FFF;
                }
                temp_v1_2 = (void *)0x801144A4->unkD8;
                temp_v0 = temp_v1_2 + (var_v0_3 >> 0xF);
                (void *)0x801144A4->unkDC = temp_v0;
                if (temp_v1_2 == temp_v0) {
                    (void *)0x801144A4->unkDC = (s32) (temp_v1_2 + 1);
                }
                if ((void *)0x801144A4->unk48 != 0) {
                    (void *)0x801144A4->unkD4 = (s32) ((void *)0x801144A4->unkD4 + 0xA);
                    (void *)0x801144A4->unkDC = (s32) ((void *)0x801144A4->unkDC + 5);
                } else if ((void *)0x801144A4->unk18 != 0) {
                    (void *)0x801144A4->unkD4 = (s32) ((void *)0x801144A4->unkD4 + 0x14);
                }
                saved_reg_gp->unk210 = 0;
            } else {
                goto block_18;
            }
        } else {
block_18:
            (void *)0x801144A4->unkD4 = 0x63;
            (void *)0x801144A4->unkD8 = 0x63;
            (void *)0x801144A4->unkDC = 0x63;
        }
    }
    func_800A5DA4(var_a0);
    func_800B9FC0((void *)0x801144A4->unk3C);
    func_8007EE24();
    if ((void *)0x801144A4->unkC == 1) {
        func_8007EEA8(1, 0);
        var_a0_2 = 1;
    } else {
        var_a0_2 = 0;
    }
    func_8007EEA8(var_a0_2, var_a0_2);
    func_8007EE7C(0);
    if ((void *)0x801144A4->unk54 != 0) {
        if ((void *)0x801144A4->unk48 != 0) {
            var_a0_3 = 0x8013DA60;
        } else {
            var_a0_3 = 0x8013DA68;
        }
    } else if ((void *)0x801144A4->unk48 != 0) {
        var_a0_3 = 0x8013DA70;
    } else {
        var_a0_3 = 0x8013DA78;
    }
    func_800BB5B4(func_800B9FD0(var_a0_3));
    func_800A6100();
    func_800A6A48();
    temp_a0_2 = *(s32 **)0x8013E7A0;
    if (temp_a0_2 != NULL) {
        func_800B6C50(*temp_a0_2);
    }
    func_800DBDEC(5);
    func_800743FC(func_800BA018(0x8013DA80));
    if ((void *)0x801144A4->unkC != 1) {
        temp_v1_3 = (void *)0x801144A4->unk0;
        if (temp_v1_3 != 1) {
            if (temp_v1_3 != 5) {
                func_800B6D58((void *)0x801144A4->unkD4, 0x801144A4);
            }
        }
    }
    var_a0_4 = (void *)0x801144A4->unk54 != 0;
    if ((void *)0x801144A4->unk48 != 0) {
        var_a0_4 += 2;
    }
    func_8007BEE8(var_a0_4);
    func_8007E1C0();
}

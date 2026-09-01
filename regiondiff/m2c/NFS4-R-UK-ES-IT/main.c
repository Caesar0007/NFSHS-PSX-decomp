/* NFS4-R-UK-ES-IT CHANGED @800A52A8 | base 800A4730 main */
/* callers: __SN_ENTRY_POINT */
s32 func_80012928();                                /* extern */
? func_80016370(?);                                 /* extern */
? func_80016FE8(?, ?, ?);                           /* extern */
? func_80017314(?);                                 /* extern */
? func_800174D4(?);                                 /* extern */
? func_80021C18(?);                                 /* extern */
? func_80021D1C(?);                                 /* extern */
? func_80021E54(?);                                 /* extern */
? func_800236A0(?);                                 /* extern */
? func_80027B8C();                                  /* extern */
? func_80027C04();                                  /* extern */
? func_80027C24(?);                                 /* extern */
s32 func_8002A89C(s32);                             /* extern */
? func_8002B83C();                                  /* extern */
? func_80032460(?);                                 /* extern */
? func_80032534(?);                                 /* extern */
? func_80032780(?);                                 /* extern */
? func_80034280(?);                                 /* extern */
? func_800343D0(?);                                 /* extern */
? func_8007B9C4(?);                                 /* extern */
? func_800A4954();                                  /* extern */
? func_800A4A10();                                  /* extern */
? func_800A4D20(s32);                               /* extern */
? func_800A4ECC();                                  /* extern */
? func_800A5070();                                  /* extern */
? func_800A50C4();                                  /* extern */
? func_800A5130();                                  /* extern */
? func_800A5254();                                  /* extern */
? func_800B7A24();                                  /* extern */
s32 func_800B8E80();                                /* extern */
? func_800BC95C(?, ?);                              /* extern */
? func_800BCA50();                                  /* extern */
? func_800DD088();                                  /* extern */
? func_800E4C1C();                                  /* extern */
? func_800F1354(?, ?, ?);                           /* extern */
? func_800F24D0(?);                                 /* extern */

void func_800A52A8(void) {
    ? var_a0;
    ? var_a0_2;
    s16 var_s5;
    s32 temp_v1;
    s32 var_s0;

    func_800E4C1C();
    var_s5 = 0;
    func_800DD088();
    func_800A4954();
    func_800BC95C(0, 0);
    func_800BCA50();
    func_800F24D0(1);
    *(s8 *)0x80115C24 = 0xFF;
    func_800A5070();
    *(s32 *)0x8005207C = 1;
    func_80016370(0x80115558);
    func_80017314(0x80115558);
    func_800236A0(0);
    func_80016FE8(0x80115558, 0, 1);
    func_80016FE8(0x80115558, 1, 1);
    func_80016FE8(0x80115558, 2, 1);
    func_80016FE8(0x80115558, 3, 1);
    func_80016FE8(0x80115558, 4, 1);
    func_80016FE8(0x80115558, 5, 1);
    func_80032460(0x80115DBC);
    func_80034280(0x8013E5C0);
    func_80021C18(0x80115D34);
    func_80032534(0x80115DBC);
    func_80021D1C(0x80115D34);
    func_80027B8C();
    func_80027C24(0);
loop_1:
    func_800A5254();
    var_s0 = func_80012928();
    if (saved_reg_gp->unkD10 != 0) {
        var_s0 = func_8002A89C(var_s0);
    }
    func_80021E54(0x80115D34);
    func_800343D0(0x8013E5C0);
    func_80032780(0x80115DBC);
    func_800174D4(0x80115558);
    func_800F1354(0, 1, 1);
    func_800A5254();
    func_800A4D20(var_s0);
    func_800A5254();
    if (*(s32 *)0x8011F3A8 != 0) {
        do {
            *(s32 *)0x8011F3A8 = 0;
            func_800A4A10();
            func_800B7A24();
            if (((void *)0x801144D0->unk24 < 2) || ((void *)0x801144D0->unk28 != 0)) {
                if ((*(s32 *)0x8011F3A8 == 0) || ((void *)0x801144D0->unk28 != 0)) {
                    (void *)0x801144D0->unk24 = 2;
                    if ((void *)0x801144D0->unk28 != 0) {
                        (void *)0x80118310->unk1C = 0;
                    } else {
                        (void *)0x80118310->unk1C = 1;
                        if ((func_800B8E80() >= 2) && (((temp_v1 = (void *)0x801144D0->unk0, (temp_v1 != 1)) && (temp_v1 != 5)) || (!((*(void **)0x80110D38)->unk260 & 0x200) && ((*(s32 *)0x8013DB20 != 2) || !(((void **)0x80110000 + 0xD38)->unk4->unk260 & 0x200))))) {
                            if ((*(void *)0x80110D38)->unk3D0 == 1) {
                                var_a0 = 0x8013E5AC;
                            } else {
                                var_a0 = 0x8013E5B4;
                            }
                            func_8007B9C4(var_a0);
                        }
                    }
                    *(s32 *)0x8013E704 = 2;
                    *(s32 *)0x8011F3A8 = 1;
                    (void *)0x801144D0->unk28 = 0;
                }
            } else {
                (void *)0x80118310->unk1C = 0;
            }
        } while (*(void *)0x8011F3A8 != 0);
    }
    func_800A4ECC();
    func_800A5130();
    func_800A50C4();
    func_800A5254();
    func_80027C04();
    (void *)0x801144D0->unk24 = (s32) var_s5;
    func_8002B83C();
    func_80017314(0x80115558);
    func_80032534(0x80115DBC);
    func_80021D1C(0x80115D34);
    var_a0_2 = 1;
    if (*(s32 *)0x8013E740 == 1) {
        var_a0_2 = 2;
    }
    func_80027C24(var_a0_2);
    var_s5 = (s16) (u16) (void *)0x801144D0->unk24;
    func_800A5254();
    goto loop_1;
}

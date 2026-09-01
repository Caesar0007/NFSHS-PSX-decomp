/* NFS4-R-FR-DE CHANGED @8002E004 | base 8002DE74 MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand */
? func_8001390C(void *);                            /* extern */
? func_80015AF0(?);                                 /* extern */
? func_80016AC8(?, s8, u8, s16);                    /* extern */
? func_80016B44(?, u8, u8, s16);                    /* extern */
? func_80017220(?, u8, s8 *, s16);                  /* extern */
? func_80018A00(void *);                            /* extern */
? func_80018AC4(void *);                            /* extern */
? func_80019C4C(? *);                               /* extern */
? func_80021370(?, ?, ?, ?, s32, s32);              /* extern */
? func_80026124(? *, ?);                            /* extern */
s32 func_8002BB50(s16);                             /* extern */
? func_8002D98C(?);                                 /* extern */
? func_800348A4(?, ?);                              /* extern */
? func_80034A0C();                                  /* extern */
? func_8003599C(s16, ?, ?);                         /* extern */
? func_8004F4F4(?, ?, ?, s32, s32);                 /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
s32 func_800B9F1C(?);                               /* extern */
s32 func_800E4A18(s32);                             /* extern */
? func_800E5094(? *, s32, s32, s32);                /* extern */

void func_8002E004(void *arg0) {
    ? sp18;
    ? sp68;
    s8 sp110;
    s16 temp_a3;
    s16 temp_s3;
    s32 temp_s0;
    s32 temp_s0_3;
    void *temp_a0;
    void *temp_a0_2;
    void *temp_a0_3;
    void *temp_s0_2;

    func_80019C4C(&sp68);
    sp68.unkA0 = 0x292;
    sp68.unkA4 = 0x293;
    sp68.unk88 = 1;
    temp_s3 = (*(void **)0x8005319C)->unk184;
    temp_s0 = func_800B9F1C(0x29B);
    func_800E5094(&sp18, temp_s0, func_8002BB50(temp_s3), temp_s3 + 1);
    temp_a0 = *(void **)0x80051D70 + 0x2D0;
    temp_a0->unk90 = &sp18;
    func_80018A00(temp_a0);
loop_1:
    temp_a0_2 = *(void **)0x80051D70;
    if ((temp_a0_2->unk354 ^ 1) != 0) {
        func_8001390C(temp_a0_2);
        goto loop_1;
    }
    func_8001390C(temp_a0_2);
    func_800348A4(0, 1);
    temp_a3 = 1 - temp_s3;
    func_80017220(0x80115558, (temp_a3 + 0x801158E4)->unk125, &sp110, temp_a3);
    func_80016AC8(0x80115558, sp110, sp1D5, temp_s3);
    func_80016B44(0x80115558, (temp_s3 + 0x801158E4)->unk125, sp1D4, temp_s3);
    func_8003599C(temp_s3, 2, -1);
    func_80018AC4(*(void **)0x80051D70 + 0x2D0);
    arg0->unk0 = 2;
    temp_s0_2 = *(void **)0x80051D70 + 0x2D0;
    arg0->unk4 = (s32) (*(s32 *)0x800522A8 + 0xB0);
    temp_s0_2->unk90 = func_800B9F1C(0x275);
    func_80018A00(*(void **)0x80051D70 + 0x2D0);
loop_4:
    temp_a0_3 = *(void *)0x80051D70;
    if ((temp_a0_3->unk354 ^ 1) != 0) {
        func_8001390C(temp_a0_3);
        goto loop_4;
    }
    func_8001390C(temp_a0_3);
    func_8002D98C(0);
    func_80034A0C();
    func_80018AC4(*(void *)0x80051D70 + 0x2D0);
loop_7:
    temp_s0_3 = func_8007AA48();
    if (temp_s0_3 < func_8007A9C4()) {
        func_80015AF0(0);
        func_8001390C(*(void *)0x80051D70);
        func_80021370(0x27E, 0x1E0, 0xDC, 1, 1, 4);
        func_8004F4F4(0, 0x1E0, 0xDC, -func_800E4A18(func_800B9F1C(0x27E)) - 5, 7);
        goto loop_7;
    }
    arg0->unk0 = 2;
    arg0->unk4 = (s32) (*(void *)0x800522A8 + 0xB0);
    func_80026124(&sp68, 2);
}

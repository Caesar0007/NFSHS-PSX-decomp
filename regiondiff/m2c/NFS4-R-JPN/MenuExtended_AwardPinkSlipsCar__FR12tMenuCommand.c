/* NFS4-R-JPN CHANGED @8002DB7C | base 8002DE74 MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand */
? func_800136AC(void *);                            /* extern */
? func_800158B8(?);                                 /* extern */
? func_80016890(?, s8, u8, s16);                    /* extern */
? func_8001690C(?, u8, u8, s16);                    /* extern */
? func_80016FE8(?, u8, s8 *, s16);                  /* extern */
? func_800187C8(void *);                            /* extern */
? func_8001888C(void *);                            /* extern */
? func_80019930(? *);                               /* extern */
? func_80021040(?, ?, ?, ?, s32, s32);              /* extern */
? func_80025D60(? *, ?);                            /* extern */
s32 func_8002B6C4(s16);                             /* extern */
? func_8002D504(?);                                 /* extern */
? func_800343F4(?, ?);                              /* extern */
? func_8003455C();                                  /* extern */
? func_800354EC(s16, ?, ?);                         /* extern */
? func_8004EBF4(?, ?, ?, s32, s32);                 /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
s32 func_800B9CCC(?);                               /* extern */
s32 func_800E4818(s32);                             /* extern */
? func_800E4E94(? *, s32, s32, s32);                /* extern */

void func_8002DB7C(void *arg0) {
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

    func_80019930(&sp68);
    sp68.unkA0 = 0x292;
    sp68.unkA4 = 0x293;
    sp68.unk88 = 1;
    temp_s3 = (*(void **)0x8005289C)->unk184;
    temp_s0 = func_800B9CCC(0x29B);
    func_800E4E94(&sp18, temp_s0, func_8002B6C4(temp_s3), temp_s3 + 1);
    temp_a0 = *(void **)0x80051470 + 0x2D0;
    temp_a0->unk90 = &sp18;
    func_800187C8(temp_a0);
loop_1:
    temp_a0_2 = *(void **)0x80051470;
    if ((temp_a0_2->unk354 ^ 1) != 0) {
        func_800136AC(temp_a0_2);
        goto loop_1;
    }
    func_800136AC(temp_a0_2);
    func_800343F4(0, 1);
    temp_a3 = 1 - temp_s3;
    func_80016FE8(0x80115318, (temp_a3 + 0x801156A4)->unk125, &sp110, temp_a3);
    func_80016890(0x80115318, sp110, sp1D5, temp_s3);
    func_8001690C(0x80115318, (temp_s3 + 0x801156A4)->unk125, sp1D4, temp_s3);
    func_800354EC(temp_s3, 2, -1);
    func_8001888C(*(void **)0x80051470 + 0x2D0);
    arg0->unk0 = 2;
    temp_s0_2 = *(void **)0x80051470 + 0x2D0;
    arg0->unk4 = (s32) (*(s32 *)0x800519A8 + 0xB0);
    temp_s0_2->unk90 = func_800B9CCC(0x275);
    func_800187C8(*(void **)0x80051470 + 0x2D0);
loop_4:
    temp_a0_3 = *(void *)0x80051470;
    if ((temp_a0_3->unk354 ^ 1) != 0) {
        func_800136AC(temp_a0_3);
        goto loop_4;
    }
    func_800136AC(temp_a0_3);
    func_8002D504(0);
    func_8003455C();
    func_8001888C(*(void *)0x80051470 + 0x2D0);
loop_7:
    temp_s0_3 = func_8007AA48();
    if (temp_s0_3 < func_8007A9C4()) {
        func_800158B8(0);
        func_800136AC(*(void *)0x80051470);
        func_80021040(0x27E, 0x1E0, 0xDC, 1, 1, 4);
        func_8004EBF4(0, 0x1E0, 0xDC, -func_800E4818(func_800B9CCC(0x27E)) - 5, 7);
        goto loop_7;
    }
    arg0->unk0 = 2;
    arg0->unk4 = (s32) (*(void *)0x800519A8 + 0xB0);
    func_80025D60(&sp68, 2);
}

/* NFS4-R-AU CHANGED @8002DFAC | base 8002DE74 MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand */
? func_800138B4(void *);                            /* extern */
? func_80015A98(?);                                 /* extern */
? func_80016A70(?, s8, u8, s16);                    /* extern */
? func_80016AEC(?, u8, u8, s16);                    /* extern */
? func_800171C8(?, u8, s8 *, s16);                  /* extern */
? func_800189A8(void *);                            /* extern */
? func_80018A6C(void *);                            /* extern */
? func_80019BF4(? *);                               /* extern */
? func_80021318(?, ?, ?, ?, s32, s32);              /* extern */
? func_800260CC(? *, ?);                            /* extern */
s32 func_8002BAF8(s16);                             /* extern */
? func_8002D934(?);                                 /* extern */
? func_8003484C(?, ?);                              /* extern */
? func_800349B4();                                  /* extern */
? func_80035944(s16, ?, ?);                         /* extern */
? func_8004F1E4(?, ?, ?, s32, s32);                 /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
s32 func_800B9F1C(?);                               /* extern */
s32 func_800E4A18(s32);                             /* extern */
? func_800E5094(? *, s32, s32, s32);                /* extern */

void func_8002DFAC(void *arg0) {
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

    func_80019BF4(&sp68);
    sp68.unkA0 = 0x292;
    sp68.unkA4 = 0x293;
    sp68.unk88 = 1;
    temp_s3 = (*(void **)0x80052E94)->unk184;
    temp_s0 = func_800B9F1C(0x29B);
    func_800E5094(&sp18, temp_s0, func_8002BAF8(temp_s3), temp_s3 + 1);
    temp_a0 = *(void **)0x80051A60 + 0x2D0;
    temp_a0->unk90 = &sp18;
    func_800189A8(temp_a0);
loop_1:
    temp_a0_2 = *(void **)0x80051A60;
    if ((temp_a0_2->unk354 ^ 1) != 0) {
        func_800138B4(temp_a0_2);
        goto loop_1;
    }
    func_800138B4(temp_a0_2);
    func_8003484C(0, 1);
    temp_a3 = 1 - temp_s3;
    func_800171C8(0x80115558, (temp_a3 + 0x801158E4)->unk125, &sp110, temp_a3);
    func_80016A70(0x80115558, sp110, sp1D5, temp_s3);
    func_80016AEC(0x80115558, (temp_s3 + 0x801158E4)->unk125, sp1D4, temp_s3);
    func_80035944(temp_s3, 2, -1);
    func_80018A6C(*(void **)0x80051A60 + 0x2D0);
    arg0->unk0 = 2;
    temp_s0_2 = *(void **)0x80051A60 + 0x2D0;
    arg0->unk4 = (s32) (*(s32 *)0x80051F98 + 0xB0);
    temp_s0_2->unk90 = func_800B9F1C(0x275);
    func_800189A8(*(void **)0x80051A60 + 0x2D0);
loop_4:
    temp_a0_3 = *(void *)0x80051A60;
    if ((temp_a0_3->unk354 ^ 1) != 0) {
        func_800138B4(temp_a0_3);
        goto loop_4;
    }
    func_800138B4(temp_a0_3);
    func_8002D934(0);
    func_800349B4();
    func_80018A6C(*(void *)0x80051A60 + 0x2D0);
loop_7:
    temp_s0_3 = func_8007AA48();
    if (temp_s0_3 < func_8007A9C4()) {
        func_80015A98(0);
        func_800138B4(*(void *)0x80051A60);
        func_80021318(0x27E, 0x1E0, 0xDC, 1, 1, 4);
        func_8004F1E4(0, 0x1E0, 0xDC, -func_800E4A18(func_800B9F1C(0x27E)) - 5, 7);
        goto loop_7;
    }
    arg0->unk0 = 2;
    arg0->unk4 = (s32) (*(void *)0x80051F98 + 0xB0);
    func_800260CC(&sp68, 2);
}

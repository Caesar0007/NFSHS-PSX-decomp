/* NFS4-R-UK-ES-IT CHANGED @8002E01C | base 8002DE74 MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand */
? func_80013924(void *);                            /* extern */
? func_80015B08(?);                                 /* extern */
? func_80016AE0(?, s8, u8, s16);                    /* extern */
? func_80016B5C(?, u8, u8, s16);                    /* extern */
? func_80017238(?, u8, s8 *, s16);                  /* extern */
? func_80018A18(void *);                            /* extern */
? func_80018ADC(void *);                            /* extern */
? func_80019C64(? *);                               /* extern */
? func_80021388(?, ?, ?, ?, s32, s32);              /* extern */
? func_8002613C(? *, ?);                            /* extern */
s32 func_8002BB68(s16);                             /* extern */
? func_8002D9A4(?);                                 /* extern */
? func_800348BC(?, ?);                              /* extern */
? func_80034A24();                                  /* extern */
? func_800359B4(s16, ?, ?);                         /* extern */
? func_8004F534(?, ?, ?, s32, s32);                 /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
s32 func_800B9F1C(?);                               /* extern */
s32 func_800E4A18(s32);                             /* extern */
? func_800E5094(? *, s32, s32, s32);                /* extern */

void func_8002E01C(void *arg0) {
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

    func_80019C64(&sp68);
    sp68.unkA0 = 0x292;
    sp68.unkA4 = 0x293;
    sp68.unk88 = 1;
    temp_s3 = (*(void **)0x800531DC)->unk184;
    temp_s0 = func_800B9F1C(0x29B);
    func_800E5094(&sp18, temp_s0, func_8002BB68(temp_s3), temp_s3 + 1);
    temp_a0 = *(void **)0x80051DB0 + 0x2D0;
    temp_a0->unk90 = &sp18;
    func_80018A18(temp_a0);
loop_1:
    temp_a0_2 = *(void **)0x80051DB0;
    if ((temp_a0_2->unk354 ^ 1) != 0) {
        func_80013924(temp_a0_2);
        goto loop_1;
    }
    func_80013924(temp_a0_2);
    func_800348BC(0, 1);
    temp_a3 = 1 - temp_s3;
    func_80017238(0x80115558, (temp_a3 + 0x801158E4)->unk125, &sp110, temp_a3);
    func_80016AE0(0x80115558, sp110, sp1D5, temp_s3);
    func_80016B5C(0x80115558, (temp_s3 + 0x801158E4)->unk125, sp1D4, temp_s3);
    func_800359B4(temp_s3, 2, -1);
    func_80018ADC(*(void **)0x80051DB0 + 0x2D0);
    arg0->unk0 = 2;
    temp_s0_2 = *(void **)0x80051DB0 + 0x2D0;
    arg0->unk4 = (s32) (*(s32 *)0x800522E8 + 0xB0);
    temp_s0_2->unk90 = func_800B9F1C(0x275);
    func_80018A18(*(void **)0x80051DB0 + 0x2D0);
loop_4:
    temp_a0_3 = *(void *)0x80051DB0;
    if ((temp_a0_3->unk354 ^ 1) != 0) {
        func_80013924(temp_a0_3);
        goto loop_4;
    }
    func_80013924(temp_a0_3);
    func_8002D9A4(0);
    func_80034A24();
    func_80018ADC(*(void *)0x80051DB0 + 0x2D0);
loop_7:
    temp_s0_3 = func_8007AA48();
    if (temp_s0_3 < func_8007A9C4()) {
        func_80015B08(0);
        func_80013924(*(void *)0x80051DB0);
        func_80021388(0x27E, 0x1E0, 0xDC, 1, 1, 4);
        func_8004F534(0, 0x1E0, 0xDC, -func_800E4A18(func_800B9F1C(0x27E)) - 5, 7);
        goto loop_7;
    }
    arg0->unk0 = 2;
    arg0->unk4 = (s32) (*(void *)0x800522E8 + 0xB0);
    func_8002613C(&sp68, 2);
}

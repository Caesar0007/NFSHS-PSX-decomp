/* NFS4-R-USA CHANGED @8002DF34 | base 8002DE74 MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand */
? func_80013894(void *);                            /* extern */
? func_80015A70(?);                                 /* extern */
? func_80016A48(?, s8, u8, s16);                    /* extern */
? func_80016AC4(?, u8, u8, s16);                    /* extern */
? func_800171A0(?, u8, s8 *, s16);                  /* extern */
? func_80018980(void *);                            /* extern */
? func_80018A44(void *);                            /* extern */
? func_80019BCC(? *);                               /* extern */
? func_800212E0(?, ?, ?, ?, s32, s32);              /* extern */
? func_80026098(? *, ?);                            /* extern */
s32 func_8002BA7C(s16);                             /* extern */
? func_8002D8BC(?);                                 /* extern */
? func_800347D4(?, ?);                              /* extern */
? func_80034938();                                  /* extern */
? func_80035930(s16, ?, ?);                         /* extern */
? func_8004F12C(?, ?, ?, s32, s32);                 /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
s32 func_800B9F18(?);                               /* extern */
s32 func_800E4A2C(s32);                             /* extern */
? func_800E50A8(? *, s32, s32, s32);                /* extern */

void func_8002DF34(void *arg0) {
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

    func_80019BCC(&sp68);
    sp68.unkA0 = 0x292;
    sp68.unkA4 = 0x293;
    sp68.unk88 = 1;
    temp_s3 = (*(void **)0x80052DD4)->unk184;
    temp_s0 = func_800B9F18(0x29B);
    func_800E50A8(&sp18, temp_s0, func_8002BA7C(temp_s3), temp_s3 + 1);
    temp_a0 = *(void **)0x800519A8 + 0x2D0;
    temp_a0->unk90 = &sp18;
    func_80018980(temp_a0);
loop_1:
    temp_a0_2 = *(void **)0x800519A8;
    if ((temp_a0_2->unk354 ^ 1) != 0) {
        func_80013894(temp_a0_2);
        goto loop_1;
    }
    func_80013894(temp_a0_2);
    func_800347D4(0, 1);
    temp_a3 = 1 - temp_s3;
    func_800171A0(0x8011552C, (temp_a3 + 0x801158B8)->unk125, &sp110, temp_a3);
    func_80016A48(0x8011552C, sp110, sp1D5, temp_s3);
    func_80016AC4(0x8011552C, (temp_s3 + 0x801158B8)->unk125, sp1D4, temp_s3);
    func_80035930(temp_s3, 2, -1);
    func_80018A44(*(void **)0x800519A8 + 0x2D0);
    arg0->unk0 = 2;
    temp_s0_2 = *(void **)0x800519A8 + 0x2D0;
    arg0->unk4 = (s32) (*(s32 *)0x80051EE0 + 0xB0);
    temp_s0_2->unk90 = func_800B9F18(0x275);
    func_80018980(*(void **)0x800519A8 + 0x2D0);
loop_4:
    temp_a0_3 = *(void *)0x800519A8;
    if ((temp_a0_3->unk354 ^ 1) != 0) {
        func_80013894(temp_a0_3);
        goto loop_4;
    }
    func_80013894(temp_a0_3);
    func_8002D8BC(0);
    func_80034938();
    func_80018A44(*(void *)0x800519A8 + 0x2D0);
loop_7:
    temp_s0_3 = func_8007AA48();
    if (temp_s0_3 < func_8007A9C4()) {
        func_80015A70(0);
        func_80013894(*(void *)0x800519A8);
        func_800212E0(0x27E, 0x1E0, 0xDC, 1, 1, 4);
        func_8004F12C(0, 0x1E0, 0xDC, -func_800E4A2C(func_800B9F18(0x27E)) - 5, 7);
        goto loop_7;
    }
    arg0->unk0 = 2;
    arg0->unk4 = (s32) (*(void *)0x80051EE0 + 0xB0);
    func_80026098(&sp68, 2);
}

/* NFS4-R-UK-ES-IT CHANGED @8004D254 | base 8004CCE4 Movie_Play__Fc */
/* callers: play_movie__Fc */
? func_8004CB78(s32);                               /* extern */
? func_8004CD48();                                  /* extern */
? func_8004CEF4(s32);                               /* extern */
s32 func_8004D0A0();                                /* extern */
? func_8004D1D4();                                  /* extern */
? func_8004D1E4();                                  /* extern */
s32 func_8004D1F4();                                /* extern */
? func_800DCED0();                                  /* extern */
s32 func_800E4D90(?);                               /* extern */
? func_800E4DF4();                                  /* extern */
? func_800EE12C(?);                                 /* extern */
? func_800EE1C4(?);                                 /* extern */
? func_800EE348(?, ?, ?, ?);                        /* extern */
? func_800EE66C(? *);                               /* extern */
? func_800EE72C(? *);                               /* extern */
? func_800F2BB4(? *, s16, s16, s16, s32);           /* extern */
? func_800F2C68(? *, s16, s16, s16, s32);           /* extern */
? func_800F76A0(?);                                 /* extern */
? func_800FB41C(s32);                               /* extern */

s16 func_8004D254(s32 arg0) {
    ? sp18;
    s16 sp1C;
    s16 sp22;
    s16 sp26;
    s8 sp29;
    ? sp30;
    s32 temp_s0;
    s32 temp_s0_3;
    s32 temp_s0_4;
    void *temp_s0_2;

    func_800FB41C((s32) (*(s32 *)0x8013D970 * 0x7F) >> 7);
    temp_s0 = arg0 & 0xFF;
    func_8004CB78(temp_s0);
    func_8004CEF4(temp_s0);
loop_1:
    if ((func_8004D1F4() ^ 1) != 0) {
        func_800DCED0();
        if (func_8004D0A0() != -1) {
            temp_s0_2 = (((void *)0x800535C0->unk20 == 0) * 8) + 0x800535C0;
            func_800F2C68(&sp18, temp_s0_2->unk10, temp_s0_2->unk12, temp_s0_2->unk14, (s32) temp_s0_2->unk16);
            sp22 = 0x1D;
            sp26 = 0xF0;
            func_800F2BB4(&sp30, temp_s0_2->unk10, temp_s0_2->unk12, temp_s0_2->unk14, (s32) temp_s0_2->unk16);
            if (*(s32 *)0x8005359C != 0) {
                sp29 = 1;
                sp1C = (sp1C * 2) / 3;
            }
            func_800EE72C(&sp18);
            func_800EE66C(&sp30);
            func_800EE12C(1);
            if (*(s32 *)0x8005359C == 0) {
                func_800F76A0(-1);
            }
            func_8004D1D4();
            *(s16 *)0x800532C8 = 1;
            func_800E4DF4();
            temp_s0_3 = func_800E4D90(0);
            temp_s0_4 = (temp_s0_3 | func_800E4D90(4)) & 0xFFFF;
            if ((temp_s0_4 != 0) && ((func_8004D1E4(), (*(u8 *)0x800532C6 != 0)) || (temp_s0_4 == 8))) {
                *(s16 *)0x800532C4 = 1;
            }
            goto loop_1;
        }
    }
    func_8004CD48();
    func_800EE348(0x800535D0, 0, 0, 0);
    func_800EE348(0x800535D8, 0, 0, 0);
    func_800EE1C4(0);
    return *(void *)0x800532C4;
}

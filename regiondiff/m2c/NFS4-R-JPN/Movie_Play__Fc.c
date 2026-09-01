/* NFS4-R-JPN CHANGED @8004CC8C | base 8004CCE4 Movie_Play__Fc */
/* callers: play_movie__Fc */
? func_8004C5B0(s32);                               /* extern */
? func_8004C780();                                  /* extern */
? func_8004C92C(s32);                               /* extern */
s32 func_8004CAD8();                                /* extern */
? func_8004CC0C();                                  /* extern */
? func_8004CC1C();                                  /* extern */
s32 func_8004CC2C();                                /* extern */
? func_800DCC90();                                  /* extern */
s32 func_800E4B90(?);                               /* extern */
? func_800E4BF4();                                  /* extern */
? func_800EDF2C(?);                                 /* extern */
? func_800EDFC4(?);                                 /* extern */
? func_800EE148(?, ?, ?, ?);                        /* extern */
? func_800EE46C(? *);                               /* extern */
? func_800EE52C(? *);                               /* extern */
? func_800F2974(? *, s16, s16, s16, s32);           /* extern */
? func_800F2A28(? *, s16, s16, s16, s32);           /* extern */
? func_800F7460(?);                                 /* extern */
? func_800FB1DC(s32);                               /* extern */

s16 func_8004CC8C(s32 arg0) {
    ? sp18;
    s16 sp1C;
    s16 sp26;
    s8 sp29;
    ? sp30;
    s32 temp_s0;
    s32 temp_s0_3;
    s32 temp_s0_4;
    void *temp_s0_2;

    func_800FB1DC((s32) (*(s32 *)0x8013D730 * 0x7F) >> 7);
    temp_s0 = arg0 & 0xFF;
    func_8004C5B0(temp_s0);
    func_8004C92C(temp_s0);
loop_1:
    if ((func_8004CC2C() ^ 1) != 0) {
        func_800DCC90();
        if (func_8004CAD8() != -1) {
            temp_s0_2 = (((void *)0x80052C80->unk20 == 0) * 8) + 0x80052C80;
            func_800F2A28(&sp18, temp_s0_2->unk10, temp_s0_2->unk12, temp_s0_2->unk14, (s32) temp_s0_2->unk16);
            sp26 = 0xF0;
            func_800F2974(&sp30, temp_s0_2->unk10, temp_s0_2->unk12, temp_s0_2->unk14, (s32) temp_s0_2->unk16);
            if (*(s32 *)0x80052C5C != 0) {
                sp29 = 1;
                sp1C = (sp1C * 2) / 3;
            }
            func_800EE52C(&sp18);
            func_800EE46C(&sp30);
            func_800EDF2C(1);
            if (*(s32 *)0x80052C5C == 0) {
                func_800F7460(-1);
            }
            func_8004CC0C();
            *(s16 *)0x80052988 = 1;
            func_800E4BF4();
            temp_s0_3 = func_800E4B90(0);
            temp_s0_4 = (temp_s0_3 | func_800E4B90(4)) & 0xFFFF;
            if ((temp_s0_4 != 0) && ((func_8004CC1C(), (*(u8 *)0x80052986 != 0)) || (temp_s0_4 == 8))) {
                *(s16 *)0x80052984 = 1;
            }
            goto loop_1;
        }
    }
    func_8004C780();
    func_800EE148(0x80052C90, 0, 0, 0);
    func_800EE148(0x80052C98, 0, 0, 0);
    func_800EDFC4(0);
    return *(void *)0x80052984;
}

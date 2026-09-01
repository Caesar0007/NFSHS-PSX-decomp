/* NFS4-R-USA CHANGED @8004D1C4 | base 8004CCE4 Movie_Play__Fc */
/* callers: play_movie__Fc */
? func_8004CAE8(s32);                               /* extern */
? func_8004CCB8();                                  /* extern */
? func_8004CE64(s32);                               /* extern */
s32 func_8004D010();                                /* extern */
? func_8004D144();                                  /* extern */
? func_8004D154();                                  /* extern */
s32 func_8004D164();                                /* extern */
? func_800DCEA4();                                  /* extern */
s32 func_800E4DA4(?);                               /* extern */
? func_800E4E08();                                  /* extern */
? func_800EE140(?);                                 /* extern */
? func_800EE1D8(?);                                 /* extern */
? func_800EE35C(?, ?, ?, ?);                        /* extern */
? func_800EE680(? *);                               /* extern */
? func_800EE740(? *);                               /* extern */
? func_800F2B88(? *, s16, s16, s16, s32);           /* extern */
? func_800F2C3C(? *, s16, s16, s16, s32);           /* extern */
? func_800F7674(?);                                 /* extern */
? func_800FB3F0(s32);                               /* extern */

s16 func_8004D1C4(s32 arg0) {
    ? sp18;
    s16 sp1C;
    s16 sp26;
    s8 sp29;
    ? sp30;
    s32 temp_s0;
    s32 temp_s0_3;
    s32 temp_s0_4;
    void *temp_s0_2;

    func_800FB3F0((s32) (*(s32 *)0x8013D944 * 0x7F) >> 7);
    temp_s0 = arg0 & 0xFF;
    func_8004CAE8(temp_s0);
    func_8004CE64(temp_s0);
loop_1:
    if ((func_8004D164() ^ 1) != 0) {
        func_800DCEA4();
        if (func_8004D010() != -1) {
            temp_s0_2 = (((void *)0x800531B8->unk20 == 0) * 8) + 0x800531B8;
            func_800F2C3C(&sp18, temp_s0_2->unk10, temp_s0_2->unk12, temp_s0_2->unk14, (s32) temp_s0_2->unk16);
            sp26 = 0xF0;
            func_800F2B88(&sp30, temp_s0_2->unk10, temp_s0_2->unk12, temp_s0_2->unk14, (s32) temp_s0_2->unk16);
            if (*(s32 *)0x80053194 != 0) {
                sp29 = 1;
                sp1C = (sp1C * 2) / 3;
            }
            func_800EE740(&sp18);
            func_800EE680(&sp30);
            func_800EE140(1);
            if (*(s32 *)0x80053194 == 0) {
                func_800F7674(-1);
            }
            func_8004D144();
            *(s16 *)0x80052EC0 = 1;
            func_800E4E08();
            temp_s0_3 = func_800E4DA4(0);
            temp_s0_4 = (temp_s0_3 | func_800E4DA4(4)) & 0xFFFF;
            if ((temp_s0_4 != 0) && ((func_8004D154(), (*(u8 *)0x80052EBE != 0)) || (temp_s0_4 == 8))) {
                *(s16 *)0x80052EBC = 1;
            }
            goto loop_1;
        }
    }
    func_8004CCB8();
    func_800EE35C(0x800531C8, 0, 0, 0);
    func_800EE35C(0x800531D0, 0, 0, 0);
    func_800EE1D8(0);
    return *(void *)0x80052EBC;
}

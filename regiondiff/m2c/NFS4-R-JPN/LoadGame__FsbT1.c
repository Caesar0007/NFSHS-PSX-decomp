/* NFS4-R-JPN CHANGED @80034B2C | base 80034E18 LoadGame__FsbT1 */
/* callers: Front_SecondaryMemCardCheck__Fv, GenericMenuLoadGame__Fi, DoMemCardStuff__25tScreenPinkSlipsCarSelect */
? func_800136AC(void *);                            /* extern */
? func_800169E4(s32, ? *, s32);                     /* extern */
? func_80016AF8(?, ? *, s32);                       /* extern */
? func_800187C8(? *);                               /* extern */
? func_8001888C(? *);                               /* extern */
? func_80021910(?, ? *);                            /* extern */
? func_800234D8(? *);                               /* extern */
? func_80025D08(? *, s16);                          /* extern */
? func_80025D60(? *, ?);                            /* extern */
? func_80026D4C(s16, u8);                           /* extern */
? func_80027174();                                  /* extern */
? func_800332A0(?, s32 *);                          /* extern */
s32 func_80034068(? *);                             /* extern */
? func_80034140();                                  /* extern */
? func_80034164();                                  /* extern */
? func_80034604(? *, s16, ?);                       /* extern */
? func_8004F668(s16, ? *, ?);                       /* extern */
s32 func_8004FE30(s16);                             /* extern */
s32 *func_800501F4(s32);                            /* extern */
s32 func_800B9CCC(s32);                             /* extern */
? func_800DCC90();                                  /* extern */
? func_800E4E94(s32, ? *);                          /* extern */
? func_800E6CB4(? *, ?, ?);                         /* extern */
? func_800E75DC(?);                                 /* extern */
? func_800F2A64(?);                                 /* extern */

s32 func_80034B2C(s16 arg0, s32 arg1, s32 arg2) {
    ? sp10;
    ? sp14;
    ? sp18;
    ? sp37C;
    ? sp468;
    ? sp548;
    s32 sp558;
    ? sp608;
    ? sp15C0;
    s32 sp1620;
    s16 sp1626;
    s16 sp1628;
    s16 sp162A;
    s16 sp162C;
    s16 sp162E;
    s32 sp1630;
    s32 sp1638;
    s16 sp163C;
    s16 sp163E;
    s16 sp1642;
    s32 sp1644;
    s16 sp1648;
    s32 sp1650;
    s32 sp1654;
    ? sp1658;
    s32 sp1668;
    ? *sp166C;
    s16 sp1688;
    s32 sp1690;
    s32 sp1694;
    s32 sp1698;
    s16 temp_s4;
    s32 *temp_s0_2;
    s32 *temp_s0_4;
    s32 temp_s0;
    s32 temp_s0_3;
    s32 temp_s0_5;
    s32 temp_s5;
    s32 temp_s6;
    s32 temp_s8;
    s32 var_s1;
    s32 var_s2;
    s32 var_s3;
    void *temp_a0;
    void *temp_s0_6;
    void *temp_s7;

    temp_s4 = (arg0 * 4) | 1;
    *(s32 *)0x800519B8 = (s32) arg0;
    *(s32 *)0x800519CC = 1;
    sp1688 = arg0;
    sp1690 = (s32) *(u8 *)0x801159E4;
    func_80025D08(&sp15C0, arg0);
    sp1620 = 0x800105A8;
    sp1630 = 0;
    sp162E = 0;
    sp1642 = 0;
    sp163E = 0;
    sp163C = 0;
    sp162C = 0;
    sp162A = 0;
    sp1628 = 0;
    sp1626 = 0;
    sp15C0.unk80 = 0x120;
    sp15C0.unk64 = -1;
    sp1620 = 0x800104E8;
    sp1648 = 0;
    sp1638 = 0;
    sp1654 = 0;
    sp1644 = 0;
    sp1638 = 0;
    sp15C0.unk8C = 0x80;
    sp1620 = 0x80010428;
    if ((arg2 != 0) || (arg1 != 0)) {
        sp1650 = func_800B9CCC(arg0 + 0x277);
        if (arg1 == 0) {
            sp163C = 0;
            sp163E = 0x32;
        }
        func_800187C8(&sp15C0);
loop_5:
        if ((sp1644 ^ 1) != 0) {
            func_800136AC(*(void **)0x80051470);
            goto loop_5;
        }
        func_800136AC(*(void *)0x80051470);
    }
    var_s1 = 0;
    sp1694 = 0x2C;
    var_s3 = 0;
    *(s32 *)0x800519C8 = 0;
    if (arg2 != 0) {
        sp1694 = 0;
    }
    var_s2 = 0x28E;
    sp1698 = (u16) sp1688 << 0x10;
loop_11:
    func_80034140();
    sp1694 += 1;
    func_80034604(&sp1658, temp_s4, 1);
loop_12:
    if (func_8004FE30(temp_s4) == 0x15) {
        func_800DCC90();
        func_800F2A64(0);
        goto loop_12;
    }
    sp166C = &sp10;
    sp1668 = 0;
    temp_s5 = sp1698 >> 0x10;
    temp_s8 = temp_s5 * 8;
    temp_s6 = temp_s5 * 4;
    temp_s7 = temp_s6 + 0x801156A4;
loop_15:
    if (var_s1 == 0) {
        func_800DCC90();
        temp_s0 = func_8004FE30(temp_s4);
        func_800E75DC(0);
        func_800F2A64(0);
        switch (temp_s0) {
        case 22:
            func_8004F668(temp_s4, &sp1658, 0);
            break;
        case 15:
            if (func_80034068(&sp10) != 0) {
                var_s3 = 0;
                if (arg1 == 0) {
                    if (temp_s5 == 0) {
                        func_800E6CB4(&sp18, 0x801156A4, 0x450);
                        func_800332A0(0x80115B7C, &sp558);
                        func_80021910(0x80115AF4, &sp548);
                        func_800E6CB4(&sp608, 0x80115E38, 0xE9C);
                        func_800234D8(&sp14);
                    } else {
                        func_800E4E94(temp_s8 + 0x80115A08, &sp37C);
                    }
                    func_800169E4(0x80115318, &sp468, sp1698 >> 0x10);
                } else {
                    temp_s7->unk43C = sp14A4;
                    func_80016AF8(0x80115318, &sp468, temp_s5);
                    func_800E4E94(temp_s8 + 0x80115A08, &sp37C);
                    temp_s7->unk4C = sp558;
                }
                var_s2 = 0x28E;
                func_80027174();
                var_s1 = 1;
            } else {
                temp_s0_2 = func_800501F4(temp_s6 + 1);
                func_8001888C(*(void *)0x80051470 + 0x2D0);
                temp_s0_3 = *temp_s0_2;
                if (temp_s0_3 != -2) {
                    var_s3 = 1;
                    if (temp_s0_3 != -1) {
                        var_s2 = 0x32A;
                    } else {
block_33:
                        var_s3 = 3;
                        var_s2 = 0x32C;
                    }
                } else {
block_31:
                    var_s2 = 0x2A0;
                    var_s3 = 2;
                }
block_35:
                var_s1 = 1;
            }
            break;
        case 2:
        case 3:
        case 7:
        case 10:
        case 11:
        case 16:
        case 23:
            temp_s0_4 = func_800501F4(temp_s6 + 1);
            func_8001888C(*(void *)0x80051470 + 0x2D0);
            temp_s0_5 = *temp_s0_4;
            if (temp_s0_5 == -2) {
                goto block_31;
            }
            var_s3 = 1;
            if (temp_s0_5 == -1) {
                goto block_33;
            }
            var_s2 = 0x32A;
            goto block_35;
        }
        goto loop_15;
    }
loop_36:
    if (func_8004FE30(temp_s4) != 0x16) {
        func_800DCC90();
        func_800F2A64(0);
        goto loop_36;
    }
    func_80034164();
    if ((var_s2 != 0x28E) && (sp1694 < 3)) {
        goto loop_11;
    }
    if (arg2 != 0) {
        if (*(void *)0x800519C8 == 0) {
            func_8001888C(*(void *)0x80051470 + 0x2D0);
            func_8001888C(*(void *)0x80051470 + 0x238);
            temp_s0_6 = *(void *)0x80051470 + 0x238;
            temp_s0_6->unk90 = func_800B9CCC(var_s2 + (s16) (u16) sp1688);
            func_800187C8(*(void *)0x80051470 + 0x238);
loop_43:
            temp_a0 = *(void *)0x80051470;
            if ((temp_a0->unk2BC ^ 1) != 0) {
                func_800136AC(temp_a0);
                goto loop_43;
            }
            func_800136AC(temp_a0);
        }
    }
    func_80026D4C((s16) (u16) sp1688, ((s16) (u16) sp1688 + 0x801156A4)->unk362);
    if (arg1 == 0) {
        if ((void *)0x801156A4->unk4 == 6) {
            (void *)0x801156A4->unk4 = 0U;
        }
        *(s32 *)0x8013D734 = (s32) (void *)0x801156A4->unk342;
    }
    if ((arg2 != 0) || (arg1 != 0)) {
        func_8001888C(&sp15C0);
    }
    if (arg2 != 0) {
        func_800136AC(*(void *)0x80051470);
    }
    *(void *)0x800519CC = 0;
    (*(void **)0x80052848)->unk5A0 = 1;
    if (*(s32 *)0x8013E34C != 0) {
        *(void *)0x801159E4 = (u8) sp1690;
    }
    func_80025D60(&sp15C0, 2);
    return var_s3;
}

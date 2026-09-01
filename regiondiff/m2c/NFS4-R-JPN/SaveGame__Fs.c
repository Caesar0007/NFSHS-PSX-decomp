/* NFS4-R-JPN CHANGED @80034684 | base 80034988 SaveGame__Fs */
/* callers: GenericMenuSaveGame__Fi */
? func_800136AC(void *);                            /* extern */
? func_80016A80(?, ? *);                            /* extern */
? func_800187C8(? *);                               /* extern */
? func_8001888C(? *);                               /* extern */
? func_8002193C(?, ? *);                            /* extern */
? func_800234C8(? *);                               /* extern */
? func_80025D08(? *, void *, s32, ?);               /* extern */
? func_80025D60(? *, ?);                            /* extern */
? func_80033258(?, ? *);                            /* extern */
? func_80033FF0(? *);                               /* extern */
? func_80034140();                                  /* extern */
? func_80034164();                                  /* extern */
? func_80034604(? *, s16, ?);                       /* extern */
s32 func_8004FE30(s16);                             /* extern */
s32 *func_800501F4(s32);                            /* extern */
s32 func_800B9CCC(s32);                             /* extern */
? func_800DCC90(?);                                 /* extern */
? func_800E4E94(? *, ?, s32);                       /* extern */
? func_800E5F18(s32);                               /* extern */
? func_800E6CB4(?, ? *, ?);                         /* extern */
? func_800E75DC(?);                                 /* extern */
s32 func_800EB21C();                                /* extern */
s32 func_800F15D8(s32, ?);                          /* extern */
s32 func_800F275C(? *, ?);                          /* extern */
? func_800F2A64(?);                                 /* extern */
static ? *jtbl_800116F4[3] = { &.L80034940, &.L80034998, &.L800349C8 }; /* const */

s32 func_80034684(s16 arg0) {
    ? sp10;
    ? sp14;
    ? sp18;
    ? sp468;
    ? sp548;
    ? sp558;
    ? sp608;
    s32 sp14A4;
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
    s32 sp1670;
    s32 sp1674;
    s32 sp1678;
    ? sp1688;
    s16 sp16C8;
    s16 temp_s0;
    s32 temp_a0;
    s32 temp_s0_2;
    s32 temp_s7;
    s32 temp_v1;
    s32 var_a2;
    s32 var_s2;
    s32 var_s3;
    u32 temp_s0_3;
    void *temp_a0_2;
    void *temp_s0_4;
    void *var_a1;

    var_a2 = 0;
    var_a1 = (void *)0x801156A4;
    *(s32 *)0x800519B8 = (s32) arg0;
    *(s32 *)0x800519CC = 1;
    do {
        var_a1->unk448 = 1;
        if ((((var_a2 != 0) << 5) + 0x8013F990)->unk5 != 0x73) {
            var_a1->unk448 = 0;
        }
        var_a2 += 1;
        var_a1 += 4;
    } while (var_a2 < 2);
    func_80025D08(&sp15C0, var_a1, var_a2, 0x73);
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
    sp1650 = func_800B9CCC(arg0 + 0x277);
    sp163C = 0;
    sp163E = 0x32;
    func_800187C8(&sp15C0);
loop_5:
    var_s3 = 0;
    if ((sp1644 ^ 1) != 0) {
        func_800136AC(*(void **)0x80051470);
        goto loop_5;
    }
    var_s2 = 0x28C;
    func_800136AC(*(void *)0x80051470);
    temp_s0 = ((s32) (arg0 << 0x10) >> 0xE) + 1;
    sp16C8 = temp_s0;
    *(s32 *)0x800519C8 = 0;
    func_80034140();
    func_80034604(&sp1658, temp_s0, 0);
    sp166C = &sp10;
loop_8:
    if (func_8004FE30(temp_s0) == 0x15) {
        func_800DCC90(0x80110000);
        func_800F2A64(0);
        goto loop_8;
    }
    func_800E6CB4(0x801156A4, &sp18, 0x450);
    func_80033258(0x80115B7C, &sp558);
    func_8002193C(0x80115AF4, &sp548);
    func_80016A80(0x80115318, &sp468);
    func_800E6CB4(0x80115E38, &sp608, 0xE9C);
    sp14A4 = func_800EB21C();
    func_800234C8(&sp14);
    func_800E4E94(&sp1688, 0x8001169C, *(s32 *)0x8011758C);
    temp_s7 = func_800F275C(&sp1688, 0);
    temp_a0 = temp_s7;
    sp1668 = 0x200;
    sp1670 = func_800F15D8(temp_a0, 0);
    sp1674 = 0;
    sp1678 = 0;
    func_80033FF0(&sp10);
loop_11:
    if (var_s3 == 0) {
        func_800DCC90();
        temp_s0_2 = func_8004FE30((s16) (u16) sp16C8);
        func_800E75DC(0);
        func_800F2A64(0);
        temp_s0_3 = temp_s0_2 - 2;
        if (temp_s0_3 < 0x16U) {
            switch (jtbl_800116F4[temp_s0_3]) {     /* unable to parse jump table */
            case 0:
            case 1:
            case 5:
            case 8:
            case 9:
                temp_v1 = *func_800501F4(((s32) (arg0 << 0x10) >> 0xE) + 1);
                var_s2 = 0x29E;
                if (temp_v1 != -3) {
                    var_s2 = 0x326;
                    if (temp_v1 == -1) {
                        var_s2 = 0x32C;
                    }
                }
                var_s3 = 1;
                break;
            }
        }
        goto loop_11;
    }
loop_22:
    if (func_8004FE30((s16) (u16) sp16C8) != 0x16) {
        func_800DCC90();
        func_800F2A64(0);
        goto loop_22;
    }
    func_800E5F18(temp_s7);
    func_80034164();
    if (*(void *)0x800519C8 == 0) {
        func_8001888C(*(void *)0x80051470 + 0x2D0);
        temp_s0_4 = *(void *)0x80051470 + 0x238;
        temp_s0_4->unk90 = func_800B9CCC(var_s2 + arg0);
        func_800187C8(*(void *)0x80051470 + 0x238);
loop_26:
        temp_a0_2 = *(void *)0x80051470;
        if ((temp_a0_2->unk2BC ^ 1) != 0) {
            func_800136AC(temp_a0_2);
            goto loop_26;
        }
        func_800136AC(temp_a0_2);
    }
    (*(void **)0x80052848)->unk5A0 = 1;
    func_8001888C(&sp15C0);
    func_800136AC(*(void *)0x80051470);
    *(void *)0x800519CC = 0;
    func_80025D60(&sp15C0, 2);
    return 0;
}

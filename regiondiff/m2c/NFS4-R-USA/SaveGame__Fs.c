/* NFS4-R-USA CHANGED @80034AC8 | base 80034988 SaveGame__Fs */
/* callers: GenericMenuSaveGame__Fi */
? func_80013894(void *);                            /* extern */
? func_80016C38(?, ? *);                            /* extern */
? func_80018980(? *);                               /* extern */
? func_80018A44(? *);                               /* extern */
? func_80021BDC(?, ? *);                            /* extern */
? func_80023768(? *);                               /* extern */
? func_80026040(? *, void *, s32, ?);               /* extern */
? func_80026098(? *, ?);                            /* extern */
? func_80033638(?, ? *);                            /* extern */
? func_800343D0(? *);                               /* extern */
? func_80034520();                                  /* extern */
? func_80034544();                                  /* extern */
? func_800349E0(? *, s16, ?);                       /* extern */
s32 func_80050368(s16);                             /* extern */
s32 *func_8005072C(s32);                            /* extern */
s32 func_800B9F18(s32);                             /* extern */
? func_800DCEA4(?);                                 /* extern */
? func_800E50A8(? *, ?, s32);                       /* extern */
? func_800E612C(s32);                               /* extern */
? func_800E6EC8(?, ? *, ?);                         /* extern */
? func_800E77F0(?);                                 /* extern */
s32 func_800EB430();                                /* extern */
s32 func_800F17EC(s32, ?);                          /* extern */
s32 func_800F2970(? *, ?);                          /* extern */
? func_800F2C78(?);                                 /* extern */
static ? *jtbl_800116EC[3] = { &.L80034D84, &.L80034DDC, &.L80034E0C }; /* const */

s32 func_80034AC8(s16 arg0) {
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
    s32 var_s6;
    u32 temp_s0_3;
    void *temp_a0_2;
    void *temp_s0_4;
    void *var_a1;

    var_a2 = 0;
    var_a1 = (void *)0x801158B8;
    *(s32 *)0x80051EF0 = (s32) arg0;
    *(s32 *)0x80051F04 = 1;
    do {
        var_a1->unk448 = 1;
        if ((((var_a2 != 0) << 5) + 0x8013FBA4)->unk5 != 0x73) {
            var_a1->unk448 = 0;
        }
        var_a2 += 1;
        var_a1 += 4;
    } while (var_a2 < 2);
    func_80026040(&sp15C0, var_a1, var_a2, 0x73);
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
    sp1650 = func_800B9F18(arg0 + 0x277);
    sp163C = 0;
    sp163E = 0x32;
    func_80018980(&sp15C0);
loop_5:
    var_s3 = 0;
    if ((sp1644 ^ 1) != 0) {
        func_80013894(*(void **)0x800519A8);
        goto loop_5;
    }
    var_s6 = 0;
    var_s2 = 0x28C;
    func_80013894(*(void *)0x800519A8);
    temp_s0 = ((s32) (arg0 << 0x10) >> 0xE) + 1;
    sp16C8 = temp_s0;
    *(s32 *)0x80051F00 = 0;
    func_80034520();
    func_800349E0(&sp1658, temp_s0, 0);
    sp166C = &sp10;
loop_8:
    if (func_80050368(temp_s0) == 0x15) {
        func_800DCEA4(0x80110000);
        func_800F2C78(0);
        goto loop_8;
    }
    func_800E6EC8(0x801158B8, &sp18, 0x450);
    func_80033638(0x80115D90, &sp558);
    func_80021BDC(0x80115D08, &sp548);
    func_80016C38(0x8011552C, &sp468);
    func_800E6EC8(0x8011604C, &sp608, 0xE9C);
    sp14A4 = func_800EB430();
    func_80023768(&sp14);
    func_800E50A8(&sp1688, 0x80011694, *(s32 *)0x801177A0);
    temp_s7 = func_800F2970(&sp1688, 0);
    temp_a0 = temp_s7;
    sp1668 = 0x200;
    sp1670 = func_800F17EC(temp_a0, 0);
    sp1674 = 0;
    sp1678 = 0;
    func_800343D0(&sp10);
loop_11:
    if (var_s3 == 0) {
        func_800DCEA4();
        temp_s0_2 = func_80050368((s16) (u16) sp16C8);
        func_800E77F0(0);
        func_800F2C78(0);
        temp_s0_3 = temp_s0_2 - 2;
        if (temp_s0_3 < 0x16U) {
            switch (jtbl_800116EC[temp_s0_3]) {     /* unable to parse jump table */
            case 10:
                var_s2 = 0x28C;
                var_s3 = 1;
                var_s6 = 1;
                break;
            case 0:
            case 1:
            case 5:
            case 8:
            case 9:
            case 11:
                temp_v1 = *func_8005072C(((s32) (arg0 << 0x10) >> 0xE) + 1);
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
    if (func_80050368((s16) (u16) sp16C8) != 0x16) {
        func_800DCEA4();
        func_800F2C78(0);
        goto loop_22;
    }
    func_800E612C(temp_s7);
    func_80034544();
    if (*(void *)0x80051F00 == 0) {
        func_80018A44(*(void *)0x800519A8 + 0x2D0);
        temp_s0_4 = *(void *)0x800519A8 + 0x238;
        temp_s0_4->unk90 = func_800B9F18(var_s2 + arg0);
        func_80018980(*(void *)0x800519A8 + 0x238);
loop_26:
        temp_a0_2 = *(void *)0x800519A8;
        if ((temp_a0_2->unk2BC ^ 1) != 0) {
            func_80013894(temp_a0_2);
            goto loop_26;
        }
        func_80013894(temp_a0_2);
    }
    (*(void **)0x80052D80)->unk5A0 = 1;
    func_80018A44(&sp15C0);
    func_80013894(*(void *)0x800519A8);
    *(void *)0x80051F04 = 0;
    func_80026098(&sp15C0, 2);
    return var_s6;
}

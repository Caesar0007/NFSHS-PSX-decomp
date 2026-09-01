/* NFS4-R-JPN CHANGED @8003513C | base 800353F0 SavePinkSlipsCars__Fss */
/* callers: SavePinkSlipsCarsWithErrorDialogs__Fsss */
? func_80016B9C(?, ? *, s16, s16);                  /* extern */
? func_8001888C(s32);                               /* extern */
? func_80033FF0(? *);                               /* extern */
s32 func_80034068(? *);                             /* extern */
? func_80034140();                                  /* extern */
? func_80034164();                                  /* extern */
? func_80034604(? *, s16, ?);                       /* extern */
? func_8004F668(s16, ? *, ?);                       /* extern */
? func_8004F9FC(s16, ? *);                          /* extern */
s32 func_8004FE30(s16);                             /* extern */
s32 *func_800501F4(s32);                            /* extern */
? func_800DCC90(s32);                               /* extern */
? func_800E4E94(? *, ?, s32);                       /* extern */
? func_800E5F18(s32);                               /* extern */
? func_800E75DC(?);                                 /* extern */
s32 func_800F15D8(s32, ?);                          /* extern */
s32 func_800F275C(? *, ?);                          /* extern */
? func_800F2A64(?);                                 /* extern */

s32 func_8003513C(s16 arg0, u16 arg1) {
    ? sp10;
    ? sp468;
    ? sp15C0;
    ? sp1600;
    s32 sp1610;
    ? *sp1614;
    s32 sp1618;
    s32 sp161C;
    s32 sp1620;
    u16 sp1630;
    s16 sp1638;
    void *sp1640;
    s16 temp_v0;
    s32 temp_s0;
    s32 temp_s0_2;
    s32 temp_s4;
    s32 temp_s8;
    s32 temp_v1;
    s32 temp_v1_2;
    s32 var_s2;
    s32 var_s3;
    s32 var_s5;

    sp1630 = arg1;
    func_80034140();
    temp_v0 = (arg0 * 4) + 1;
    var_s3 = 0;
    var_s5 = 0;
    var_s2 = 0;
    sp1638 = temp_v0;
    *(s32 *)0x800519B8 = (s32) arg0;
    *(s32 *)0x800519CC = 1;
    *(s32 *)0x800519C8 = 0;
    func_800E4E94(&sp15C0, 0x8001169C, *(s32 *)0x8011758C);
    temp_s8 = func_800F275C(&sp15C0, 0);
    func_80034604(&sp1600, temp_v0, 1);
loop_1:
    if (func_8004FE30(temp_v0) == 0x15) {
        func_800DCC90();
        func_800F2A64(0);
        goto loop_1;
    }
    temp_s4 = arg0 * 4;
    sp1640 = temp_s4 + 0x801156A4;
    sp1614 = &sp10;
    sp1610 = 0;
loop_4:
    if (var_s3 == 0) {
        func_800DCC90();
        temp_s0 = func_8004FE30((s16) (u16) sp1638);
        func_800E75DC(0);
        func_800F2A64(0);
        switch (temp_s0) {                          /* switch 1 */
        case 22:                                    /* switch 1 */
            func_8004F668((s16) (u16) sp1638, &sp1600, 0);
            break;
        case 15:                                    /* switch 1 */
            if (func_80034068(&sp10) != 0) {
                var_s3 = 1;
                if (sp1640->unk43C != sp14A4) {
                    var_s2 = 1;
                } else {
                    func_80016B9C(0x80115318, &sp468, arg0, (s16) sp1630);
loop_12:
                    if (func_8004FE30((s16) (u16) sp1638) == 0x15) {
                        func_800DCC90(temp_s8);
                        func_800F2A64(0);
                        goto loop_12;
                    }
                    sp1610 = 0x200;
                    sp1618 = func_800F15D8(temp_s8, 0);
                    sp161C = 0;
                    sp1620 = 0;
                    func_80033FF0(&sp10);
loop_15:
                    if (var_s5 == 0) {
                        func_800DCC90();
                        temp_s0_2 = func_8004FE30((s16) (u16) sp1638);
                        func_800E75DC(0);
                        func_800F2A64(0);
                        switch (temp_s0_2) {        /* switch 2 */
                        case 22:                    /* switch 2 */
                            if ((void *)0x80052CC0->unk34 != 0) {
                                func_8004F9FC((s16) (u16) sp1638, &sp1600);
                            }
                            break;
                        case 12:                    /* switch 2 */
                            var_s5 = 1;
                            var_s2 = 0;
                            break;
                        case 2:                     /* switch 2 */
                        case 3:                     /* switch 2 */
                        case 7:                     /* switch 2 */
                        case 10:                    /* switch 2 */
                        case 11:                    /* switch 2 */
                        case 13:                    /* switch 2 */
                        case 23:                    /* switch 2 */
                            func_8001888C(*(s32 *)0x80051470 + 0x2D0);
                            temp_v1 = *func_800501F4(temp_s4 + 1);
                            var_s2 = 6;
                            if (temp_v1 != -3) {
                                var_s2 = 3;
                                if (temp_v1 == -1) {
                                    var_s2 = 4;
                                }
                            }
                            var_s5 = 1;
                            break;
                        }
                        goto loop_15;
                    }
                    goto block_28;
                }
            } else {
            case 2:                                 /* switch 1 */
            case 16:                                /* switch 1 */
                temp_v1_2 = *func_800501F4(temp_s4 + 1);
                var_s2 = 5;
                if (temp_v1_2 != -2) {
                    var_s2 = 2;
                    if (temp_v1_2 == -1) {
                        var_s2 = 4;
                    }
                }
block_28:
                var_s3 = 1;
            }
            break;
        case 3:                                     /* switch 1 */
        case 7:                                     /* switch 1 */
        case 10:                                    /* switch 1 */
        case 11:                                    /* switch 1 */
        case 23:                                    /* switch 1 */
            var_s3 = 1;
            var_s2 = 2;
            break;
        }
        goto loop_4;
    }
loop_31:
    if (func_8004FE30((s16) (u16) sp1638) != 0x16) {
        func_800DCC90();
        func_800F2A64(0);
        goto loop_31;
    }
    func_800E5F18(temp_s8);
    func_80034164();
    *(void *)0x800519CC = 0;
    return var_s2;
}

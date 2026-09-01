/* NFS4-R-JPN CHANGED @800FB5C4 | base 800FAE2C MemCardCmd_cb */
s32 func_800FC8B4(s32);                             /* extern */
? func_8010A2F8(s32);                               /* extern */
s32 func_8010A400();                                /* extern */
? func_8010A4D8();                                  /* extern */
s32 func_8010A5B0();                                /* extern */
s32 func_8010A5EC();                                /* extern */
? func_8010A638(?);                                 /* extern */
? func_8010A748(s32);                               /* extern */
? func_8010A788(s32);                               /* extern */

s32 func_800FB5C4(u32 *arg0) {
    s32 temp_a0;
    s32 temp_a0_2;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 temp_v1_2;
    s32 var_v0;
    s32 var_v1;
    u32 temp_v1;

    temp_v1 = *arg0;
    switch (temp_v1) {
    case 0:
        *(s32 *)0x80148638 = 0;
        *(s32 *)0x80148634 = 0;
        *(s32 *)0x80148630 = 0;
        func_8010A638(0x800FB388);
        *arg0 = 0xA;
    default:
block_24:
        var_v0 = 0;
        return var_v0;
    case 10:
        temp_v1_2 = (void *)0x80148644->unk0;
        if (temp_v1_2 != 0) {
            var_v0 = 1;
            if (temp_v1_2 == 3) {
                temp_a0 = (void *)0x80148644->unk8;
                *(void *)0x80148638 = 1;
                *(void *)0x8014863C = (s32) (*(s32 *)0x8014863C | (1 << temp_a0));
                func_8010A2F8(temp_a0);
                func_8010A748((void *)0x80148644->unk8);
                *arg0 = 0x15;
                goto block_24;
            }
        } else {
block_20:
            *arg0 = 0x1E;
            goto block_24;
        }
        /* Duplicate return node #25. Try simplifying control flow for better match */
        return var_v0;
    case 21:
        var_v0 = 0;
        if (func_8010A5EC() != 0) {
            func_8010A4D8();
            *arg0 = 0x1E;
        case 30:
            func_8010A2F8();
            func_8010A788(*(s32 *)0x8014864C);
            *arg0 += 1;
            goto block_24;
        }
        /* Duplicate return node #25. Try simplifying control flow for better match */
        return var_v0;
    case 31:
        var_v0 = 0;
        if (func_8010A5B0() != 0) {
            temp_v0 = func_8010A400();
            *(void *)0x80148634 = temp_v0;
            if (temp_v0 < 3) {
                if (temp_v0 <= 0) {
                    if (temp_v0 != 0) {
                        goto block_21;
                    }
                    var_v1 = 0;
                    if (*(void *)0x80148638 != 0) {
                        var_v1 = 3;
                    }
                    (void *)0x80148640->unk4 = var_v1;
                    return 1;
                }
                goto block_19;
            }
            if (temp_v0 != 4) {
                goto block_21;
            }
block_19:
            temp_v0_2 = *(void *)0x80148630 + 1;
            *(void *)0x80148630 = temp_v0_2;
            if (temp_v0_2 < 5) {
                goto block_20;
            }
block_21:
            temp_a0_2 = *(void *)0x80148634;
            if (temp_a0_2 == 4) {
                (void *)0x80148640->unk4 = temp_a0_2;
                return 1;
            }
            (void *)0x80148640->unk4 = func_800FC8B4(temp_a0_2);
            return 1;
        }
        /* Duplicate return node #25. Try simplifying control flow for better match */
        return var_v0;
    }
}

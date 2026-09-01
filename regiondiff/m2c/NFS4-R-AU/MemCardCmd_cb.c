/* NFS4-R-AU CHANGED @800FB804 | base 800FAE2C MemCardCmd_cb */
s32 func_800FCAF4(s32);                             /* extern */
? func_8010A538(s32);                               /* extern */
s32 func_8010A640();                                /* extern */
? func_8010A718();                                  /* extern */
s32 func_8010A7F0();                                /* extern */
s32 func_8010A82C();                                /* extern */
? func_8010A878(?);                                 /* extern */
? func_8010A988(s32);                               /* extern */
? func_8010A9C8(s32);                               /* extern */

s32 func_800FB804(u32 *arg0) {
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
        *(s32 *)0x80148878 = 0;
        *(s32 *)0x80148874 = 0;
        *(s32 *)0x80148870 = 0;
        func_8010A878(0x800FB5C8);
        *arg0 = 0xA;
    default:
block_24:
        var_v0 = 0;
        return var_v0;
    case 10:
        temp_v1_2 = (void *)0x80148884->unk0;
        if (temp_v1_2 != 0) {
            var_v0 = 1;
            if (temp_v1_2 == 3) {
                temp_a0 = (void *)0x80148884->unk8;
                *(void *)0x80148878 = 1;
                *(void *)0x8014887C = (s32) (*(s32 *)0x8014887C | (1 << temp_a0));
                func_8010A538(temp_a0);
                func_8010A988((void *)0x80148884->unk8);
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
        if (func_8010A82C() != 0) {
            func_8010A718();
            *arg0 = 0x1E;
        case 30:
            func_8010A538();
            func_8010A9C8(*(s32 *)0x8014888C);
            *arg0 += 1;
            goto block_24;
        }
        /* Duplicate return node #25. Try simplifying control flow for better match */
        return var_v0;
    case 31:
        var_v0 = 0;
        if (func_8010A7F0() != 0) {
            temp_v0 = func_8010A640();
            *(void *)0x80148874 = temp_v0;
            if (temp_v0 < 3) {
                if (temp_v0 <= 0) {
                    if (temp_v0 != 0) {
                        goto block_21;
                    }
                    var_v1 = 0;
                    if (*(void *)0x80148878 != 0) {
                        var_v1 = 3;
                    }
                    (void *)0x80148880->unk4 = var_v1;
                    return 1;
                }
                goto block_19;
            }
            if (temp_v0 != 4) {
                goto block_21;
            }
block_19:
            temp_v0_2 = *(void *)0x80148870 + 1;
            *(void *)0x80148870 = temp_v0_2;
            if (temp_v0_2 < 5) {
                goto block_20;
            }
block_21:
            temp_a0_2 = *(void *)0x80148874;
            if (temp_a0_2 == 4) {
                (void *)0x80148880->unk4 = temp_a0_2;
                return 1;
            }
            (void *)0x80148880->unk4 = func_800FCAF4(temp_a0_2);
            return 1;
        }
        /* Duplicate return node #25. Try simplifying control flow for better match */
        return var_v0;
    }
}

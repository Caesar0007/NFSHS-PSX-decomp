/* NFS4-R-JPN CHANGED @80034188 | base 80034438 Confirm__Fii */
/* callers: OverwriteConfirm__Fv, FormatConfirm__Fv */
? func_800136AC(void *);                            /* extern */
? func_800187C8(void *);                            /* extern */
? func_8001888C(void *);                            /* extern */
s16 func_8001968C(? *);                             /* extern */
? func_80019930(? *);                               /* extern */
? func_80025D60(? *, ?);                            /* extern */
? func_80034140();                                  /* extern */
? func_80034164();                                  /* extern */
s32 func_800B9CCC(s32);                             /* extern */

s16 func_80034188(s32 arg0, s32 arg1) {
    ? sp10;
    s16 var_s0;
    s32 var_s2;
    void *temp_a0;
    void *temp_a0_2;
    void *temp_a0_3;
    void *temp_s0;

    func_80034164();
    func_80019930(&sp10);
    sp10.unk60 = 0x80010308;
    temp_a0 = *(void **)0x80051470 + 0x2D0;
    var_s2 = 0;
    if (temp_a0->unk70 != 0) {
        var_s2 = 1;
        func_8001888C(temp_a0);
    }
    sp10.unk90 = func_800B9CCC(arg0);
    sp10.unkA4 = 0x293;
    sp10.unkA0 = arg1;
    sp10.unk88 = 0;
    if (*(u8 *)0x801159E4 == 3) {
        sp10.unk7C = 0;
        sp10.unk7E = 0xA;
    }
    var_s0 = func_8001968C(&sp10);
    if (var_s0 == -1) {
        temp_s0 = *(void **)0x80051470 + 0x238;
        temp_s0->unk90 = func_800B9CCC(*(s32 *)0x800519B8 + 0x32C);
        func_800187C8(*(void **)0x80051470 + 0x238);
loop_6:
        temp_a0_2 = *(void **)0x80051470;
        if ((temp_a0_2->unk2BC ^ 1) != 0) {
            func_800136AC(temp_a0_2);
            goto loop_6;
        }
        var_s0 = 0;
        func_800136AC(temp_a0_2);
        goto block_10;
    }
    if (var_s0 == 0) {
block_10:
        *(s32 *)0x800519C8 = 1;
    } else if (var_s2 != 0) {
        func_800187C8(*(void **)0x80051470 + 0x2D0);
loop_13:
        temp_a0_3 = *(void **)0x80051470;
        if ((temp_a0_3->unk354 ^ 1) != 0) {
            func_800136AC(temp_a0_3);
            goto loop_13;
        }
    }
    func_800136AC(*(void *)0x80051470);
    func_80034140();
    func_80025D60(&sp10, 2);
    return var_s0;
}

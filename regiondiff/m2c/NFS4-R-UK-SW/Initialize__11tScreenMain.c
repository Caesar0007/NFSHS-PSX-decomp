/* NFS4-R-UK-SW CHANGED @800389C4 | base 800388D4 Initialize__11tScreenMain */
? func_80015AF0(?);                                 /* extern */
? func_800231F8(void *, s32, s32);                  /* extern */
s32 func_80025EB8(void *, void *);                  /* extern */
? func_80026158();                                  /* extern */
? func_800262EC(void *, ? *, void *);               /* extern */
? func_80026498(void *, s32, ?);                    /* extern */
? func_800266A0(void *, void *, ?, ?, s32, s32);    /* extern */
? func_800373B8(void *, ?, s32);                    /* extern */
s32 func_80051570(?, ?, ?, ?, s32);                 /* extern */
? func_800E5094(? *, ?, s32);                       /* extern */
s8 func_800EB41C(s32);                              /* extern */

void func_800389C4(void *arg0) {
    ? sp18;
    s16 temp_v0;
    s16 temp_v0_2;
    s16 temp_v0_3;
    s16 temp_v0_4;
    s16 temp_v0_5;
    s16 var_s2;
    s16 var_s2_2;
    s16 var_s2_3;
    s16 var_s2_4;
    s16 var_s2_5;
    s32 temp_a1;
    s32 temp_a2;
    s32 temp_s4;
    s32 var_a2;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v1;
    s8 temp_ret;
    void *temp_s0;

    func_80026158();
    var_s2 = 0;
    var_v0 = 0 << 0x10;
    do {
        temp_a1 = (var_v0 >> 0x10) * 0x28;
        (arg0 + temp_a1)->unk558 = 0;
        func_80026498(arg0, arg0 + (temp_a1 + 0x558), 0x10);
        temp_v0 = var_s2 + 1;
        var_s2 = temp_v0;
        var_v0 = var_s2 << 0x10;
    } while (temp_v0 < 2);
    temp_ret = func_800EB41C();
    arg0->unk5AC = (s32) (temp_ret % 28);
    var_s2_2 = 0;
    arg0->unk5B0 = (s32) ((arg0->unk5AC + (func_800EB41C(temp_ret / 28) % 27) + 1) % 28);
    do {
        func_800E5094(&sp18, 0x80011830, (arg0 + (var_s2_2 * 4))->unk5AC);
        func_800262EC(arg0, &sp18, arg0 + ((var_s2_2 * 0x28) + 0x558));
        temp_v0_2 = var_s2_2 + 1;
        var_s2_2 = temp_v0_2;
    } while (temp_v0_2 < 2);
    if (0 == 0) {
        temp_s0 = arg0 + 0x558;
        do {
            func_80015AF0(0);
            temp_s4 = func_80025EB8(arg0, temp_s0);
            if (arg0->unk55C != 0) {
                func_800266A0(arg0, temp_s0, 0, 0, 0x10, 0);
            }
            var_v1 = 0;
            if (temp_s4 != 0) {
                var_v1 = func_80025EB8(arg0, arg0 + 0x580) != 0;
            }
            if (arg0->unk584 != 0) {
                func_800266A0(arg0, arg0 + 0x580, 0xA6, 0, 0x10, 0);
            }
        } while (var_v1 == 0);
    }
    arg0->unk54C = -1;
    arg0->unk68 = 0;
    var_s2_3 = 0;
    arg0->unk64 = func_80051570(0x50, 0x50, 0xF0000, 0x20000, 0x10);
    arg0->unk550 = 0;
    arg0->unk540 = 1;
    arg0->unk544 = 0;
    arg0->unk54A = 0;
    arg0->unk5B4 = 0;
    arg0->unk5A8 = 0;
    arg0->unk6C = (s32) *(s32 *)0x8013EFB8;
    arg0->unk70 = (s32) (*(s32 *)0x8013EFB8 - 0x320);
    var_a2 = 0 << 0x10;
    do {
        temp_a2 = var_a2 >> 0x10;
        func_800231F8(arg0 + ((temp_a2 * 0x30) + 0x7C), (arg0 + (arg0->unk5A8 * 0x28))->unk558, temp_a2);
        temp_v0_3 = var_s2_3 + 1;
        var_s2_3 = temp_v0_3;
        var_a2 = var_s2_3 << 0x10;
    } while (temp_v0_3 < 0x10);
    arg0->unk78 = 0;
    func_800373B8(arg0, 1, var_a2);
    var_s2_4 = 0;
    var_v0_2 = 0 << 0x10;
    do {
        (arg0 + (var_v0_2 >> 0xE))->unk37C = 0;
        temp_v0_4 = var_s2_4 + 1;
        var_s2_4 = temp_v0_4;
        var_v0_2 = var_s2_4 << 0x10;
    } while (temp_v0_4 < 0x10);
    var_s2_5 = 0;
    do {
        *(0x800533E0 + var_s2_5) = func_800EB41C();
        temp_v0_5 = var_s2_5 + 1;
        var_s2_5 = temp_v0_5;
    } while (temp_v0_5 < 0x19);
}

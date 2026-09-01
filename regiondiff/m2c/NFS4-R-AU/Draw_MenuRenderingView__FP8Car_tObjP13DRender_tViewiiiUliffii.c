/* NFS4-R-AU CHANGED @80012BC0 | base 80012BF8 Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii */
/* callers: DrawCar__FR8tCarInfossffcbUl7tPlayer */
? func_80012AAC(s32 *, s32 *);                      /* extern */
? func_8009E854(s32 *, ? *, ? *);                   /* extern */
? func_800B1DBC(void *, void *);                    /* extern */
? func_800B342C(void *, s32);                       /* extern */
? func_800B3854(void *);                            /* extern */
? func_800E12D0();                                  /* extern */
? func_800E2570();                                  /* extern */
? func_800E2600(s32, s32, ?, ?);                    /* extern */
? func_800E4F30(? *, ? *);                          /* extern */
s32 func_800E5084(s32);                             /* extern */
? func_800EB558(? *, s32);                          /* extern */
? func_800EB820(s32 *, ? *, void *);                /* extern */
s32 func_800F3E38(s32, ?);                          /* extern */
s32 func_800F42C0(s32);                             /* extern */
u64 func_800F614C(s32);                             /* extern */
s32 func_800F62AC(u64, u32);                        /* extern */
u64 func_800F63DC(u64, u32, u64, u32);              /* extern */
u64 func_800F675C(u64, u32, ?, ?);                  /* extern */

void func_80012BC0(void *arg0, void *arg1, s32 arg2, s32 arg3, s32 arg4, s32 arg5, s32 arg6, s32 arg7, s32 arg8, s32 arg9, s32 arg10) {
    ? sp10;
    s32 sp38;
    ? sp60;
    s32 sp88;
    s32 sp8C;
    s32 sp90;
    s32 sp98;
    s32 sp9C;
    s32 spA0;
    s32 spA8;
    s32 spAC;
    s32 spB0;
    s32 spB4;
    s32 spB8;
    s32 spBC;
    s32 spC0;
    s32 spC4;
    s32 spC8;
    ? *temp_s2;
    ? *temp_s3;
    s32 temp_a0;
    s32 temp_a0_2;
    s32 temp_s5;
    s32 var_s0;
    s32 var_s5;
    s32 var_s6;
    u32 temp_s1;
    u64 temp_ret;
    u64 temp_ret_2;
    u64 temp_ret_3;
    u64 temp_ret_4;
    u64 temp_s0;

    var_s5 = arg7;
    var_s6 = arg8;
    func_800E2570();
    var_s0 = arg3 - 8;
    if (*(s32 *)0x80051800 != 0) {
        var_s0 = 0x8C;
    }
    func_800E2600(arg2 - 0x100, var_s0 - 0x80, 0x200, 0x100);
    temp_a0 = arg4 * 4;
    *(0x80051804 + temp_a0) = (s32) (*(0x80051804 + temp_a0) + arg5);
    if (*(s32 *)0x80051800 != 0) {
        temp_s5 = func_800F3E38(var_s5, 0x3F000000);
        temp_a0_2 = temp_s5;
        sp98 = 0;
        sp9C = func_800F42C0(func_800F3E38(temp_a0_2, 0x47800000));
        spA0 = func_800F42C0(func_800F3E38(var_s6, 0x47800000));
        func_80012AAC(&sp38, &sp98);
        func_800EB558(&sp60, arg6 << 6);
        func_8009E854(&sp38, &sp60, &sp10);
        temp_ret = func_800F614C(var_s6);
        temp_s0 = temp_ret;
        temp_s1 = (u32) temp_ret;
        temp_ret_2 = func_800F614C(temp_s5);
        temp_ret_3 = func_800F675C(temp_ret_2, (u32) temp_ret_2, 0, 0x40040000);
        temp_ret_4 = func_800F63DC(temp_s0, temp_s1, temp_ret_3, (u32) temp_ret_3);
        var_s6 = func_800F62AC(temp_ret_4, (u32) temp_ret_4);
        var_s5 = 0;
    } else {
        func_800EB558(&sp10, arg6 << 6);
    }
    temp_s2 = arg1 + 0x14;
    spA8 = 0x10000;
    spAC = 0;
    spB0 = 0;
    spB4 = 0;
    spB8 = 0x10000;
    spBC = 0;
    spC0 = 0;
    spC4 = 0;
    spC8 = 0x10000;
    spB8 = 0xAD80;
    func_8009E854(&spA8, &sp10, temp_s2);
    temp_s3 = arg1 + 0x44;
    func_800E4F30(temp_s2, temp_s3);
    sp88 = 0;
    sp8C = func_800F42C0(func_800F3E38(var_s5, 0x47800000));
    sp90 = func_800F42C0(func_800F3E38(var_s6, 0x47800000));
    func_800EB820(&sp88, temp_s2, arg1 + 8);
    sp88 = -arg1->unk8;
    sp8C = -arg1->unkC;
    sp90 = -arg1->unk10;
    func_800EB820(&sp88, temp_s3, arg1 + 0x38);
    arg0->unkF0 = 0x10000;
    arg0->unk100 = 0x10000;
    arg0->unk110 = 0x10000;
    arg0->unkF4 = 0;
    arg0->unkF8 = 0;
    arg0->unkFC = 0;
    arg0->unk104 = 0;
    arg0->unk108 = 0;
    arg0->unk10C = 0;
    arg0->unkA0 = 0;
    arg0->unkA4 = 0;
    arg0->unkA8 = 0;
    if (arg4 == 0) {
        if (*(s32 *)0x8013E6BC < *(s32 *)0x8013DB48) {
            *(s32 *)0x8013E6B8 = 1;
            *(s32 *)0x8013E6BC = *(s32 *)0x8013DB48 + 5;
        } else {
            *(s32 *)0x8013E6B8 = 0;
        }
    }
    arg1->unk4 = arg4;
    func_800E12D0();
    func_800B1DBC(arg0, arg1);
    func_800B342C(arg0, arg9);
    func_800B3854(arg1);
    if (arg10 != 0) {
        *(s32 *)0x8013E634 |= 0x80;
        *(s32 *)0x1F80000C ^= 1;
        *(s32 *)0x8013EB44 = func_800E5084(0x1F8003FC);
        *(s32 *)0x8013EB30 = 1;
        func_800B1DBC(arg0, arg1);
        *(s32 *)0x8013EB44 = func_800E5084(*(s32 *)0x8013EB44);
        *(s32 *)0x8013EB30 = 0;
        func_800B342C(arg0, arg9);
        *(s32 *)0x8013E634 &= 0x7F;
        *(s32 *)0x1F80000C ^= 1;
    }
}

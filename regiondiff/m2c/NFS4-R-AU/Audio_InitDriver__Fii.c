/* NFS4-R-AU CHANGED @800BC95C | base 800BBB84 Audio_InitDriver__Fii */
/* callers: RunDemoVideo__14tFEApplication, Init_PSX_FrontEnd__Fv, Nfs2_GameModuleStartUp__FPi, main */
? func_8007A8F4();                                  /* extern */
? func_8007B5AC(s32, ?, ?);                         /* extern */
s32 func_800E5F14(?, ?, ?);                         /* extern */
? func_800F0B84(? *);                               /* extern */
? func_800F0C40(? *);                               /* extern */
? func_800F0D3C(s32, ?);                            /* extern */
? func_800F2AD8();                                  /* extern */

void func_800BC95C(s32 arg0, ? arg1) {
    ? sp10;
    s16 sp1C;
    s8 sp20;
    s32 temp_v0;
    s32 var_a0;
    void *var_v1;

    var_a0 = 0;
    var_v1 = (void *)0x8010FB98;
    do {
        var_v1->unk0 = var_a0;
        var_v1->unk8 = 0;
        var_a0 += 1;
        var_v1 += 0xC;
    } while (var_a0 < 7);
    if ((*(s32 *)0x8013D964 != 0) || (*(s32 *)0x8013D968 != 0)) {
        func_800F0B84(&sp10);
        sp1C = 0x30;
        if (*(s32 *)0x8013D994 == 0) {
            sp20 = 1;
        }
        func_800F0C40(&sp10);
        func_800F2AD8();
        temp_v0 = func_800E5F14(0x80056F08, 0x1000, 0);
        saved_reg_gp->unkFAC = temp_v0;
        func_800F0D3C(temp_v0, 0x1000);
        func_8007A8F4();
    }
    if (arg0 > 0) {
        func_8007B5AC(arg0, arg1, 0x8013E818);
    }
    saved_reg_gp->unkFA8 = 0;
}

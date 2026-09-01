/* NFS4-R-JPN CHANGED @800BC70C | base 800BBB84 Audio_InitDriver__Fii */
/* callers: RunDemoVideo__14tFEApplication, Init_PSX_FrontEnd__Fv, Nfs2_GameModuleStartUp__FPi, main */
? func_8007A8F4();                                  /* extern */
? func_8007B5AC(s32, ?, ?);                         /* extern */
s32 func_800E5D14(?, ?, ?);                         /* extern */
? func_800F0944(? *);                               /* extern */
? func_800F0A00(? *);                               /* extern */
? func_800F0AFC(s32, ?);                            /* extern */
? func_800F2898();                                  /* extern */

void func_800BC70C(s32 arg0, ? arg1) {
    ? sp10;
    s16 sp1C;
    s8 sp20;
    s32 temp_v0;
    s32 var_a0;
    void *var_v1;

    var_a0 = 0;
    var_v1 = (void *)0x8010F958;
    do {
        var_v1->unk0 = var_a0;
        var_v1->unk8 = 0;
        var_a0 += 1;
        var_v1 += 0xC;
    } while (var_a0 < 7);
    if ((*(s32 *)0x8013D724 != 0) || (*(s32 *)0x8013D728 != 0)) {
        func_800F0944(&sp10);
        sp1C = 0x30;
        if (*(s32 *)0x8013D754 == 0) {
            sp20 = 1;
        }
        func_800F0A00(&sp10);
        func_800F2898();
        temp_v0 = func_800E5D14(0x80056F08, 0x1000, 0);
        saved_reg_gp->unkFAC = temp_v0;
        func_800F0AFC(temp_v0, 0x1000);
        func_8007A8F4();
    }
    if (arg0 > 0) {
        func_8007B5AC(arg0, arg1, 0x8013E5D8);
    }
    saved_reg_gp->unkFA8 = 0;
}

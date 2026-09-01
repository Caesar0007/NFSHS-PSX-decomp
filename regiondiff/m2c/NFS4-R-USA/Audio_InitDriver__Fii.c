/* NFS4-R-USA CHANGED @800BC958 | base 800BBB84 Audio_InitDriver__Fii */
/* callers: RunDemoVideo__14tFEApplication, Init_PSX_FrontEnd__Fv, Nfs2_GameModuleStartUp__FPi, main */
? func_8007A8F4();                                  /* extern */
? func_8007B5AC(s32, ?, ?);                         /* extern */
s32 func_800E5F28(?, ?, ?);                         /* extern */
? func_800F0B58(? *);                               /* extern */
? func_800F0C14(? *);                               /* extern */
? func_800F0D10(s32, ?);                            /* extern */
? func_800F2AAC();                                  /* extern */

void func_800BC958(s32 arg0, ? arg1) {
    ? sp10;
    s16 sp1C;
    s8 sp20;
    s32 temp_v0;
    s32 var_a0;
    void *var_v1;

    var_a0 = 0;
    var_v1 = (void *)0x8010FB6C;
    do {
        var_v1->unk0 = var_a0;
        var_v1->unk8 = 0;
        var_a0 += 1;
        var_v1 += 0xC;
    } while (var_a0 < 7);
    if ((*(s32 *)0x8013D938 != 0) || (*(s32 *)0x8013D93C != 0)) {
        func_800F0B58(&sp10);
        sp1C = 0x30;
        if (*(s32 *)0x8013D968 == 0) {
            sp20 = 1;
        }
        func_800F0C14(&sp10);
        func_800F2AAC();
        temp_v0 = func_800E5F28(0x80056F08, 0x1000, 0);
        saved_reg_gp->unkFAC = temp_v0;
        func_800F0D10(temp_v0, 0x1000);
        func_8007A8F4();
    }
    if (arg0 > 0) {
        func_8007B5AC(arg0, arg1, 0x8013E7EC);
    }
    saved_reg_gp->unkFA8 = 0;
}

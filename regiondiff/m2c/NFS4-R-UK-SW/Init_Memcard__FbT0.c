/* NFS4-R-UK-SW CHANGED @800348A4 | base 800346A4 Init_Memcard__FbT0 */
/* callers: MainLoop__14tFEApplicationP5tMenu, Front_InitialMemCardCheck__Fv, Front_SecondaryMemCardCheck__Fv, GenericMenuSaveGame__Fi, MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand */
? func_8004FC88(?);                                 /* extern */
? func_8004FDC4(s32 *);                             /* extern */
? func_8004FE3C(s32 *);                             /* extern */
? func_8007B798(?);                                 /* extern */
? func_800DCED0();                                  /* extern */
? func_800E4CE0();                                  /* extern */
? func_800E4D4C();                                  /* extern */
? func_800E8E5C(?);                                 /* extern */
? func_800EB930(?);                                 /* extern */
? func_800EB990(?);                                 /* extern */

void func_800348A4(s32 arg0, s32 arg1) {
    s32 sp10;
    s32 sp14;
    s32 sp18;
    s16 sp1C;
    s16 sp1E;
    s16 sp20;
    s16 sp22;
    s32 sp24;
    s32 sp28;
    s32 sp2C;
    s32 sp30;
    s32 var_v0;
    s32 var_v0_2;

    if (*(s32 *)0x800522C8 == 0) {
        *(s32 *)0x800522C8 = 1;
        if (*(s32 *)0x8013E588 != 0) {
            func_8007B798(0);
            func_800E8E5C(5);
        }
        func_800E4D4C();
        do {

        } while ((*(s32 *)0x8013EFB8 * 0) < 0x3C);
        func_800EB990(0x8008C42C);
        func_800E8E5C(0x14);
        func_8004FC88(0);
        func_8004FDC4(&sp10);
        sp10 = 2;
        sp14 = 0x800522B4;
        sp1C = 0x200;
        sp1E = 0x100;
        sp20 = 0x20;
        sp22 = 0x60;
        sp18 = 0;
        sp24 = 0x80034820;
        if (arg1 != 0) {
            var_v0 = 0x80034818;
        } else {
            var_v0 = 0x800347EC;
        }
        sp28 = var_v0;
        if (arg0 != 0) {
            var_v0_2 = 0x80034854;
        } else {
            var_v0_2 = 0x8003484C;
        }
        sp2C = var_v0_2;
        sp30 = 0x8003487C;
        func_8004FE3C(&sp10);
        func_800EB930(0x8008C42C);
        func_800E8E5C(0x14);
        func_800E4CE0();
        func_800E8E5C(0x14);
        func_800DCED0();
    }
}

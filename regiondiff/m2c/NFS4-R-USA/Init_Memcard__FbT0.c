/* NFS4-R-USA CHANGED @800347D4 | base 800346A4 Init_Memcard__FbT0 */
/* callers: MainLoop__14tFEApplicationP5tMenu, Front_SecondaryMemCardCheck__Fv, GenericMenuSaveGame__Fi, MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand, MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand */
? func_8004F8C8(?);                                 /* extern */
? func_8004FA04(s32 *);                             /* extern */
? func_8004FA7C(s32 *);                             /* extern */
? func_8007B798(?);                                 /* extern */
? func_800DCEA4();                                  /* extern */
? func_800E4CF4();                                  /* extern */
? func_800E4D60();                                  /* extern */
? func_800E8E70(?);                                 /* extern */
? func_800EB944(?);                                 /* extern */
? func_800EB9A4(?);                                 /* extern */

void func_800347D4(s32 arg0, s32 arg1) {
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

    if (*(s32 *)0x80051F08 == 0) {
        *(s32 *)0x80051F08 = 1;
        if (*(s32 *)0x8013E55C != 0) {
            func_8007B798(0);
            func_800E8E70(5);
        }
        func_800E4D60();
        do {

        } while ((*(s32 *)0x8013EF8C * 0) < 0x3C);
        func_800EB9A4(0x8008C428);
        func_800E8E70(0x14);
        func_8004F8C8(0);
        func_8004FA04(&sp10);
        sp14 = 0x80051EF4;
        sp1C = 0x200;
        sp1E = 0x100;
        sp20 = 0x20;
        sp22 = 0x60;
        sp10 = 0;
        sp18 = 0;
        sp24 = 0x80034750;
        if (arg1 != 0) {
            var_v0 = 0x80034748;
        } else {
            var_v0 = 0x8003471C;
        }
        sp28 = var_v0;
        if (arg0 != 0) {
            var_v0_2 = 0x80034784;
        } else {
            var_v0_2 = 0x8003477C;
        }
        sp2C = var_v0_2;
        sp30 = 0x800347AC;
        func_8004FA7C(&sp10);
        func_800EB944(0x8008C428);
        func_800E8E70(0x14);
        func_800E4CF4();
        func_800E8E70(0x14);
        func_800DCEA4();
    }
}

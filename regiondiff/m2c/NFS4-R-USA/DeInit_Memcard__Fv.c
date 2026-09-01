/* NFS4-R-USA CHANGED @80034938 | base 80034800 DeInit_Memcard__Fv */
/* callers: MainLoop__14tFEApplicationP5tMenu, Front_SecondaryMemCardCheck__Fv, GenericMenuSaveGame__Fi, MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand, MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand */
? func_80013E34(s32);                               /* extern */
? func_8004F9C0();                                  /* extern */
? func_800DCEA4();                                  /* extern */
? func_800E4CF4(s32);                               /* extern */
? func_800E4D60();                                  /* extern */
? func_800EB944(?);                                 /* extern */
? func_800EB9A4(?);                                 /* extern */

void func_80034938(void) {
    if (*(s32 *)0x80051F08 != 0) {
        *(s32 *)0x80051F08 = 0;
        func_800EB9A4(0x8008C428);
        func_8004F9C0();
        func_800EB944(0x8008C428);
        func_800E4D60();
        do {

        } while ((*(s32 *)0x8013EF8C * 0) < 0xC0);
        func_800E4CF4(*(s32 *)0x8013EF8C);
        func_800DCEA4();
        if (*(s32 *)0x8013E55C != 0) {
            func_80013E34(*(s32 *)0x800519A8);
        }
    }
}

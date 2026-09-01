/* NFS4-R-AU CHANGED @800349B4 | base 80034800 DeInit_Memcard__Fv */
/* callers: MainLoop__14tFEApplicationP5tMenu, Front_InitialMemCardCheck__Fv, Front_SecondaryMemCardCheck__Fv, GenericMenuSaveGame__Fi, MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand */
? func_80013E60(s32);                               /* extern */
? func_8004FA78();                                  /* extern */
? func_800DCED0();                                  /* extern */
? func_800E4CE0(s32);                               /* extern */
? func_800E4D4C();                                  /* extern */
? func_800EB930(?);                                 /* extern */
? func_800EB990(?);                                 /* extern */

void func_800349B4(void) {
    if (*(s32 *)0x80051FC0 != 0) {
        *(s32 *)0x80051FC0 = 0;
        func_800EB990(0x8008C42C);
        func_8004FA78();
        func_800EB930(0x8008C42C);
        func_800E4D4C();
        do {

        } while ((*(s32 *)0x8013EFB8 * 0) < 0xC0);
        func_800E4CE0(*(s32 *)0x8013EFB8);
        func_800DCED0();
        if (*(s32 *)0x8013E588 != 0) {
            func_80013E60(*(s32 *)0x80051A60);
        }
    }
}

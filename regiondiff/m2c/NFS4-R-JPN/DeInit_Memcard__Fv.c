/* NFS4-R-JPN CHANGED @8003455C | base 80034800 DeInit_Memcard__Fv */
/* callers: MainLoop__14tFEApplicationP5tMenu, Front_SecondaryMemCardCheck__Fv, GenericMenuSaveGame__Fi, MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand, MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand */
? func_80013C80(s32);                               /* extern */
? func_8004F488();                                  /* extern */
? func_800DCC90();                                  /* extern */
? func_800E4AE0(s32);                               /* extern */
? func_800E4B4C();                                  /* extern */
? func_800EB730(?);                                 /* extern */
? func_800EB790(?);                                 /* extern */

void func_8003455C(void) {
    if (*(s32 *)0x800519D0 != 0) {
        *(s32 *)0x800519D0 = 0;
        func_800EB790(0x8008C428);
        func_8004F488();
        func_800EB730(0x8008C428);
        func_800E4B4C();
        do {

        } while ((*(s32 *)0x8013ED78 * 0) < 0xC0);
        func_800E4AE0(*(s32 *)0x8013ED78);
        func_800DCC90();
        if (*(s32 *)0x8013E348 != 0) {
            func_80013C80(*(s32 *)0x80051470);
        }
    }
}

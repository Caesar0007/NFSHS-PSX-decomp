/* NFS4-R-JPN CHANGED @800343F4 | base 800346A4 Init_Memcard__FbT0 */
/* callers: MainLoop__14tFEApplicationP5tMenu, Front_SecondaryMemCardCheck__Fv, GenericMenuSaveGame__Fi, MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand, MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand */
? func_8004F390(?);                                 /* extern */
? func_8004F4CC(s32 *);                             /* extern */
? func_8004F544(s32 *);                             /* extern */
? func_8007B798(?);                                 /* extern */
? func_800DCC90();                                  /* extern */
? func_800E4AE0();                                  /* extern */
? func_800E4B4C();                                  /* extern */
? func_800E8C5C(?);                                 /* extern */
? func_800EB730(?);                                 /* extern */
? func_800EB790(?);                                 /* extern */

void func_800343F4(s32 arg0, s32 arg1) {
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

    if (*(s32 *)0x800519D0 == 0) {
        *(s32 *)0x800519D0 = 1;
        if (*(s32 *)0x8013E348 != 0) {
            func_8007B798(0);
            func_800E8C5C(5);
        }
        func_800E4B4C();
        do {

        } while ((*(s32 *)0x8013ED78 * 0) < 0x3C);
        func_800EB790(0x8008C428);
        func_800E8C5C(0x14);
        func_8004F390(0);
        func_8004F4CC(&sp10);
        sp10 = 1;
        sp14 = 0x800519BC;
        sp1C = 0x200;
        sp1E = 0x100;
        sp20 = 0x20;
        sp22 = 0x60;
        sp18 = 0;
        sp24 = 0x80034370;
        if (arg1 != 0) {
            var_v0 = 0x80034368;
        } else {
            var_v0 = 0x8003433C;
        }
        sp28 = var_v0;
        if (arg0 != 0) {
            var_v0_2 = 0x800343A4;
        } else {
            var_v0_2 = 0x8003439C;
        }
        sp2C = var_v0_2;
        sp30 = 0x800343CC;
        func_8004F544(&sp10);
        func_800EB730(0x8008C428);
        func_800E8C5C(0x14);
        func_800E4AE0();
        func_800E8C5C(0x14);
        func_800DCC90();
    }
}

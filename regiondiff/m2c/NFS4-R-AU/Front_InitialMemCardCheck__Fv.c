/* NFS4-R-AU CHANGED @800279A0 | base 80027948 Front_InitialMemCardCheck__Fv */
/* callers: DoLanguageScreen__Fv */
? func_800276A0();                                  /* extern */
? func_8003484C(?, ?);                              /* extern */
? func_800349B4();                                  /* extern */
s32 func_80034F84(?, ?, ?);                         /* extern */
? func_8004B17C(?, ?);                              /* extern */
? func_800A5130();                                  /* extern */

void func_800279A0(void) {
    *(s32 *)0x8013E58C = 0;
    *(s32 *)0x8013E588 = 0;
    *(s32 *)0x80051E50 = 0;
    *(s32 *)0x80051E78 = 0;
    func_800A5130();
    *(s32 *)0x80051D08 = 1;
    func_8004B17C(0x80116078, 0);
    func_800276A0();
    func_8003484C(0, 0);
    *(s32 *)0x80051E78 = (func_80034F84(0, 0, 0) << 0x10) == 0;
    func_800349B4();
    if (*(s32 *)0x80051E78 == 0) {
        *(s8 *)0x80115C24 = 0xFF;
    }
}

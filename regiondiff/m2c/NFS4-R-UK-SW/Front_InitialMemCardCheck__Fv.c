/* NFS4-R-UK-SW CHANGED @800279F8 | base 80027948 Front_InitialMemCardCheck__Fv */
/* callers: DoLanguageScreen__Fv */
? func_800276F8();                                  /* extern */
? func_800348A4(?, ?);                              /* extern */
? func_80034A0C();                                  /* extern */
s32 func_80034FDC(?, ?, ?);                         /* extern */
? func_8004B1EC(?, ?);                              /* extern */
? func_800A5130();                                  /* extern */

void func_800279F8(void) {
    *(s32 *)0x8013E58C = 0;
    *(s32 *)0x8013E588 = 0;
    *(s32 *)0x80052158 = 0;
    *(s32 *)0x80052180 = 0;
    func_800A5130();
    *(s32 *)0x80052010 = 1;
    func_8004B1EC(0x80116078, 0);
    func_800276F8();
    func_800348A4(0, 0);
    *(s32 *)0x80052180 = (func_80034FDC(0, 0, 0) << 0x10) == 0;
    func_80034A0C();
    if (*(s32 *)0x80052180 == 0) {
        *(s8 *)0x80115C24 = 0xFF;
    }
}

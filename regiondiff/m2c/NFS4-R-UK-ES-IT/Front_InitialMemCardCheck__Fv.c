/* NFS4-R-UK-ES-IT CHANGED @80027A10 | base 80027948 Front_InitialMemCardCheck__Fv */
/* callers: DoLanguageScreen__Fv */
? func_80027710();                                  /* extern */
? func_800348BC(?, ?);                              /* extern */
? func_80034A24();                                  /* extern */
s32 func_80034FF4(?, ?, ?);                         /* extern */
? func_8004B204(?, ?);                              /* extern */
? func_800A5130();                                  /* extern */

void func_80027A10(void) {
    *(s32 *)0x8013E58C = 0;
    *(s32 *)0x8013E588 = 0;
    *(s32 *)0x800521A0 = 0;
    *(s32 *)0x800521C8 = 0;
    func_800A5130();
    *(s32 *)0x80052058 = 1;
    func_8004B204(0x80116078, 0);
    func_80027710();
    func_800348BC(0, 0);
    *(s32 *)0x800521C8 = (func_80034FF4(0, 0, 0) << 0x10) == 0;
    func_80034A24();
    if (*(s32 *)0x800521C8 == 0) {
        *(s8 *)0x80115C24 = 0xFF;
    }
}

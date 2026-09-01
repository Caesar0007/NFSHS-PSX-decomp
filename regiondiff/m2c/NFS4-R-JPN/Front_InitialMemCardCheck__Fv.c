/* NFS4-R-JPN CHANGED @800275B0 | base 80027948 Front_InitialMemCardCheck__Fv */
/* callers: DoLanguageScreen__Fv */
? func_800272B0();                                  /* extern */
? func_8004AC3C(?, ?);                              /* extern */
? func_800A512C();                                  /* extern */

void func_800275B0(void) {
    *(s32 *)0x8013E34C = 0;
    *(s32 *)0x8013E348 = 0;
    *(s32 *)0x80051860 = 0;
    *(s32 *)0x80051888 = 0;
    func_800A512C();
    *(s32 *)0x80051718 = 1;
    func_8004AC3C(0x80115E38, 0);
    func_800272B0();
    *(s8 *)0x801159E4 = 0;
}

/* NFS4-R-USA CHANGED @80027968 | base 80027948 Front_InitialMemCardCheck__Fv */
/* callers: DoLanguageScreen__Fv */
? func_80027668();                                  /* extern */
? func_8004B174(?, ?);                              /* extern */
? func_800A512C();                                  /* extern */

void func_80027968(void) {
    *(s32 *)0x8013E560 = 0;
    *(s32 *)0x8013E55C = 0;
    *(s32 *)0x80051D98 = 0;
    *(s32 *)0x80051DC0 = 0;
    func_800A512C();
    *(s32 *)0x80051C50 = 1;
    func_8004B174(0x8011604C, 0);
    func_80027668();
    *(s8 *)0x80115BF8 = 0;
}

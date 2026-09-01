/* NFS4-R-USA CHANGED @800E4CF4 | base 800E40E8 padinit */
/* callers: Init_Memcard__FbT0, DeInit_Memcard__Fv, initjoy */
? func_800EB944(?);                                 /* extern */
? func_800F07BC();                                  /* extern */
? func_800F24D4(void *, ?);                         /* extern */
? func_800FE6D4(?, ?);                              /* extern */

void func_800E4CF4(void) {
    if (*(s32 *)0x8013FBA4 == 0) {
        func_800FE6D4(0x8013FBF8, 0x8013FC1A);
        func_800F07BC();
        func_800F24D4((s32 *)0x80140000 - 0x45C, 0x54);
        *(s32 *)0x8013FBA4 = 1;
        func_800EB944(0x800E4E08);
    }
}

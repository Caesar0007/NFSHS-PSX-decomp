/* NFS4-R-USA CHANGED @800E4D60 | base 800E4158 PAD_restore */
/* callers: Init_Memcard__FbT0, DeInit_Memcard__Fv */
? func_800EB9A4(?);                                 /* extern */
? func_800F07DC();                                  /* extern */

void func_800E4D60(void) {
    if (*(s32 *)0x8013FBA4 != 0) {
        func_800EB9A4(0x800E4E08);
        func_800F07DC();
        *(s32 *)0x8013FBA4 = 0;
    }
}

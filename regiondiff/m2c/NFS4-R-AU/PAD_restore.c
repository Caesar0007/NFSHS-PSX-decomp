/* NFS4-R-AU CHANGED @800E4D4C | base 800E4158 PAD_restore */
/* callers: Init_Memcard__FbT0, DeInit_Memcard__Fv */
? func_800EB990(?);                                 /* extern */
? func_800F0808();                                  /* extern */

void func_800E4D4C(void) {
    if (*(s32 *)0x8013FBD0 != 0) {
        func_800EB990(0x800E4DF4);
        func_800F0808();
        *(s32 *)0x8013FBD0 = 0;
    }
}

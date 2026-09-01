/* NFS4-R-JPN CHANGED @800E4B4C | base 800E4158 PAD_restore */
/* callers: Init_Memcard__FbT0, DeInit_Memcard__Fv */
? func_800EB790(?);                                 /* extern */
? func_800F05C8();                                  /* extern */

void func_800E4B4C(void) {
    if (*(s32 *)0x8013F990 != 0) {
        func_800EB790(0x800E4BF4);
        func_800F05C8();
        *(s32 *)0x8013F990 = 0;
    }
}

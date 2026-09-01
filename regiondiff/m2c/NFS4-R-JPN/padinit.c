/* NFS4-R-JPN CHANGED @800E4AE0 | base 800E40E8 padinit */
/* callers: Init_Memcard__FbT0, DeInit_Memcard__Fv, initjoy */
? func_800EB730(?);                                 /* extern */
? func_800F05A8();                                  /* extern */
? func_800F22C0(void *, ?);                         /* extern */
? func_800FE4C0(?, ?);                              /* extern */

void func_800E4AE0(void) {
    if (*(s32 *)0x8013F990 == 0) {
        func_800FE4C0(0x8013F9E4, 0x8013FA06);
        func_800F05A8();
        func_800F22C0((s32 *)0x80140000 - 0x670, 0x54);
        *(s32 *)0x8013F990 = 1;
        func_800EB730(0x800E4BF4);
    }
}

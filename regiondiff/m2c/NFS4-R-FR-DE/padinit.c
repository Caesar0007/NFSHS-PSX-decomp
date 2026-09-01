/* NFS4-R-FR-DE CHANGED @800E4CE0 | base 800E40E8 padinit */
/* callers: Init_Memcard__FbT0, DeInit_Memcard__Fv, initjoy */
? func_800EB930(?);                                 /* extern */
? func_800F07E8();                                  /* extern */
? func_800F2500(void *, ?);                         /* extern */
? func_800FE700(?, ?);                              /* extern */

void func_800E4CE0(void) {
    if (*(s32 *)0x8013FBD0 == 0) {
        func_800FE700(0x8013FC24, 0x8013FC46);
        func_800F07E8();
        func_800F2500((s32 *)0x80140000 - 0x430, 0x54);
        *(s32 *)0x8013FBD0 = 1;
        func_800EB930(0x800E4DF4);
    }
}

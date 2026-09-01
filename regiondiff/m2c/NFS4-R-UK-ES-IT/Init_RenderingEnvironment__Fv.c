/* NFS4-R-UK-ES-IT CHANGED @8004E5F0 | base 8004DD0C Init_RenderingEnvironment__Fv */
/* callers: Init_PSX_FrontEnd__Fv, Init_PSX_FrontEnd__Fv */
? func_80021BF0(?, ?);                              /* extern */
? func_8004DDD0();                                  /* extern */
s32 func_800BE8AC(?, ?, ?, ?, s32, s32, s32, s32, s32); /* extern */
? func_800BE9C0();                                  /* extern */
? func_800F2500(?, ?);                              /* extern */
? func_800F2C68(?, ?, ?, ?, s32);                   /* extern */

void func_8004E5F0(void) {
    func_800F2C68(0x80120740, 0, 0x100, 0x200, 0x100);
    func_800F2C68(0x80120758, 0, 0, 0x200, 0x100);
    (void *)0x80120740->unkA = 0x15;
    (void *)0x80120740->unk22 = 0x15;
    func_800BE9C0();
    *(s32 *)0x8013E6F0 = -1;
    *(s32 *)0x8013E6DC = func_800BE8AC(0, 0, 0, 0x100, 0x200, 0x100, 0, 1, 0xA);
    func_800F2500(0x80118260, 0x8C);
    *(s32 *)0x80118260 = *(s32 *)0x8013E6DC;
    func_8004DDD0();
    *(s32 *)0x8013EABC = 1;
    func_80021BF0(0, 0);
    *(s32 *)0x8013EAC8 = 0;
}

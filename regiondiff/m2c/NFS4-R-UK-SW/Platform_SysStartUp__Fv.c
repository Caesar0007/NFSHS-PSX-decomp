/* NFS4-R-UK-SW CHANGED @800DCFA0 | base 800DC378 Platform_SysStartUp__Fv */
/* callers: Nfs2_SystemNLibStartUp__Fv */
? func_800A7AAC();                                  /* extern */
? func_800BF314(?, ?, ?, ?, s32, s32, s32, s32);    /* extern */
? func_800DD090();                                  /* extern */
? func_800F1354(?, ?, ?);                           /* extern */
? func_800F1F10(?, ?, ?);                           /* extern */
? func_800F4454(?);                                 /* extern */
? func_800F4B08(?, s32);                            /* extern */
? func_800F4B78(?);                                 /* extern */

void func_800DCFA0(void) {
    s32 temp_a1;

    temp_a1 = 0x801FC000 - 0x80149E74;
    *(s32 *)0x8013EF64 = 0;
    *(s32 *)0x8013E5BC = temp_a1;
    func_800F4B08(0x80149E74, temp_a1);
    func_800DD090();
    func_800BF314(0x200, 0x100, 1, 0, 1, 0, 0, 0);
    func_800F1354(0, 1, 1);
    func_800F4454(0x8013EDAC);
    func_800F1354(0, 0x3E8, 1);
    func_800F1354(0, 0x3E8, 1);
    saved_reg_gp->unk1540 = 1;
    func_800F4B78(0x80);
    *(s32 *)0x8013F070 = 0x800DCED8;
    func_800A7AAC();
    func_800F1F10(0x1E, 0x2000, 0);
}

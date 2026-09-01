/* NFS4-R-JPN CHANGED @800DCD60 | base 800DC378 Platform_SysStartUp__Fv */
/* callers: Nfs2_SystemNLibStartUp__Fv */
? func_800A7AA8();                                  /* extern */
? func_800BF0EC(?, ?, ?, ?, s32, s32, s32, s32);    /* extern */
? func_800DCE50();                                  /* extern */
? func_800F1114(?, ?, ?);                           /* extern */
? func_800F1CD0(?, ?, ?);                           /* extern */
? func_800F4214(?);                                 /* extern */
? func_800F48C8(?, s32);                            /* extern */
? func_800F4938(?);                                 /* extern */

void func_800DCD60(void) {
    s32 temp_a1;

    temp_a1 = 0x801FC000 - 0x80149C34;
    *(s32 *)0x8013ED24 = 0;
    *(s32 *)0x8013E37C = temp_a1;
    func_800F48C8(0x80149C34, temp_a1);
    func_800DCE50();
    func_800BF0EC(0x200, 0xF0, 1, 0, 1, 0, 0, 0);
    func_800F1114(0, 1, 1);
    func_800F4214(0x8013EB6C);
    func_800F1114(0, 0x3E8, 1);
    func_800F1114(0, 0x3E8, 1);
    saved_reg_gp->unk1540 = 1;
    func_800F4938(0x80);
    *(s32 *)0x8013EE30 = 0x800DCC98;
    func_800A7AA8();
    func_800F1CD0(0x1E, 0x2000, 0);
}

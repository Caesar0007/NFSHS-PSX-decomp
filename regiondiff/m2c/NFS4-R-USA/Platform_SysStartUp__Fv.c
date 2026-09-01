/* NFS4-R-USA CHANGED @800DCF74 | base 800DC378 Platform_SysStartUp__Fv */
/* callers: Nfs2_SystemNLibStartUp__Fv */
? func_800A7AA8();                                  /* extern */
? func_800BF300(?, ?, ?, ?, s32, s32, s32, s32);    /* extern */
? func_800DD064();                                  /* extern */
? func_800F1328(?, ?, ?);                           /* extern */
? func_800F1EE4(?, ?, ?);                           /* extern */
? func_800F4428(?);                                 /* extern */
? func_800F4ADC(?, s32);                            /* extern */
? func_800F4B4C(?);                                 /* extern */

void func_800DCF74(void) {
    s32 temp_a1;

    temp_a1 = 0x801FC000 - 0x80149E48;
    *(s32 *)0x8013EF38 = 0;
    *(s32 *)0x8013E590 = temp_a1;
    func_800F4ADC(0x80149E48, temp_a1);
    func_800DD064();
    func_800BF300(0x200, 0xF0, 1, 0, 1, 0, 0, 0);
    func_800F1328(0, 1, 1);
    func_800F4428(0x8013ED80);
    func_800F1328(0, 0x3E8, 1);
    func_800F1328(0, 0x3E8, 1);
    saved_reg_gp->unk1540 = 1;
    func_800F4B4C(0x80);
    *(s32 *)0x8013F044 = 0x800DCEAC;
    func_800A7AA8();
    func_800F1EE4(0x1E, 0x2000, 0);
}

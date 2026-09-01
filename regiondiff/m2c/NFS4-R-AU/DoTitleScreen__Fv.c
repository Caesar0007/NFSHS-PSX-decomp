/* NFS4-R-AU CHANGED @8004E0C0 | base 8004DB34 DoTitleScreen__Fv */
/* callers: Init_PSX_FrontEnd__Fv */
? func_8004DC70(?, ?, ?);                           /* extern */
? func_800E5094(? *, s32, u8, ? *);                 /* extern */
? func_800E6118(s32);                               /* extern */
? func_800E77DC(?);                                 /* extern */
? func_800E8E08();                                  /* extern */
s32 func_800EBAB8(s32, ?);                          /* extern */
? func_800F146C(?);                                 /* extern */
? func_800F1498(s32, ?, ?);                         /* extern */
s32 func_800F299C(? *, ?);                          /* extern */

void func_8004E0C0(void) {
    ? sp10;
    ? sp40;
    s32 temp_s0;

    func_800E8E08();
    if ((*(s32 *)0x80052FA8 != 0) || (func_800E5094(&sp40, 0x800127C0, *(u8 *)0x80115C24), func_800E5094(&sp10, *(s32 *)0x80052FA4, (u8) *(s32 *)0x801177CC, &sp40), *(s32 *)0x80052FA8 = func_800F299C(&sp10, 0), func_800E77DC(0), (*(s32 *)0x80052FA8 != 0))) {
        temp_s0 = func_800EBAB8(*(s32 *)0x80052FA8, 0x800127CC);
        func_8004DC70(1, 0, 1);
        func_800F146C(0);
        func_800F1498(temp_s0, 0, 0);
        func_800F146C(1);
        func_8004DC70(0, 1, 0);
        func_800E6118(*(s32 *)0x80052FA8);
        *(s32 *)0x80052FA8 = 0;
        *(s8 *)0x80052FC0 = 1;
    }
}

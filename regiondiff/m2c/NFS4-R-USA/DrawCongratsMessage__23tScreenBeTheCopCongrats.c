/* NFS4-R-USA CHANGED @800499B0 | base 8004952C DrawCongratsMessage__23tScreenBeTheCopCongrats */
? func_80021948(? *, s16 *, ?, ?);                  /* extern */
s32 func_800B9F18(s32);                             /* extern */
s32 func_800E4DA4(?);                               /* extern */
? func_800E50A8(? *, s32, s32);                     /* extern */

void func_800499B0(void *arg0) {
    s16 sp10;
    s16 sp12;
    s16 sp14;
    s16 sp16;
    ? sp18;
    s32 temp_s1;
    s32 var_s0;

    var_s0 = 0x4D;
    sp10 = 0x29;
    sp12 = 0x3C;
    sp14 = 0x1A4;
    sp16 = 0xC8;
    if (*(u8 *)0x801159E5 == 0x1C) {
        var_s0 = 0x4E;
    }
    if (func_800E4DA4(4) & 0xFFFF) {
        func_800B9F18(arg0->unk94 + 0x122);
    }
    temp_s1 = func_800B9F18(var_s0);
    func_800E50A8(&sp18, temp_s1, func_800B9F18(arg0->unk94 + 0x122));
    func_80021948(&sp18, &sp10, 2, 0xA);
}

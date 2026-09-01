/* NFS4-R-UK-SW CHANGED @80027AA0 | base 80027994 Front_SecondaryMemCardCheck__Fv */
/* callers: Init_PSX_FrontEnd__Fv */
? func_800275BC();                                  /* extern */
? func_800348A4(?, ?);                              /* extern */
? func_80034A0C();                                  /* extern */
s32 func_80034FDC(s16, ?, ?);                       /* extern */

void func_80027AA0(void) {
    s16 var_s1;
    s32 temp_v1;
    s32 var_s0;

    *(s32 *)0x8013E588 = 0;
    *(s32 *)0x8013E58C = 1;
    func_800348A4(0, 0);
    var_s1 = 0;
loop_1:
    if (var_s1 < 2) {
        var_s0 = 0;
        if (*(s32 *)0x80052180 == 0) {
loop_4:
            temp_v1 = (func_80034FDC(var_s1, 0, 0) << 0x10) == 0;
            var_s0 += 1;
            *(s32 *)0x80052180 = temp_v1;
            if (var_s0 < 3) {
                if (temp_v1 == 0) {
                    goto loop_4;
                }
            }
        }
        *(s32 *)0x80052180 = 0;
        var_s1 += 1;
        goto loop_1;
    }
    func_80034A0C();
    func_800275BC();
    *(void *)0x8013E588 = 1;
}

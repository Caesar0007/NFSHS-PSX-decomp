/* NFS4-R-AU CHANGED @80027A48 | base 80027994 Front_SecondaryMemCardCheck__Fv */
/* callers: Init_PSX_FrontEnd__Fv */
? func_80027564();                                  /* extern */
? func_8003484C(?, ?);                              /* extern */
? func_800349B4();                                  /* extern */
s32 func_80034F84(s16, ?, ?);                       /* extern */

void func_80027A48(void) {
    s16 var_s1;
    s32 temp_v1;
    s32 var_s0;

    *(s32 *)0x8013E588 = 0;
    *(s32 *)0x8013E58C = 1;
    func_8003484C(0, 0);
    var_s1 = 0;
loop_1:
    if (var_s1 < 2) {
        var_s0 = 0;
        if (*(s32 *)0x80051E78 == 0) {
loop_4:
            temp_v1 = (func_80034F84(var_s1, 0, 0) << 0x10) == 0;
            var_s0 += 1;
            *(s32 *)0x80051E78 = temp_v1;
            if (var_s0 < 3) {
                if (temp_v1 == 0) {
                    goto loop_4;
                }
            }
        }
        *(s32 *)0x80051E78 = 0;
        var_s1 += 1;
        goto loop_1;
    }
    func_800349B4();
    func_80027564();
    *(void *)0x8013E588 = 1;
}

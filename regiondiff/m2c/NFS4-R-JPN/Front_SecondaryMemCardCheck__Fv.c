/* NFS4-R-JPN CHANGED @80027614 | base 80027994 Front_SecondaryMemCardCheck__Fv */
/* callers: Init_PSX_FrontEnd__Fv */
? func_80027174();                                  /* extern */
? func_800343F4(?, ?);                              /* extern */
? func_8003455C();                                  /* extern */
s32 func_80034B2C(s16, ?, ?);                       /* extern */

void func_80027614(void) {
    s16 var_s1;
    s32 temp_v1;
    s32 var_s0;

    *(s32 *)0x8013E348 = 0;
    *(s32 *)0x8013E34C = 1;
    func_800343F4(0, 0);
    var_s1 = 0;
loop_1:
    if (var_s1 < 2) {
        var_s0 = 0;
        if (*(s32 *)0x80051888 == 0) {
loop_4:
            temp_v1 = (func_80034B2C(var_s1, 0, 0) << 0x10) == 0;
            var_s0 += 1;
            *(s32 *)0x80051888 = temp_v1;
            if (var_s0 < 3) {
                if (temp_v1 == 0) {
                    goto loop_4;
                }
            }
        }
        *(s32 *)0x80051888 = 0;
        var_s1 += 1;
        goto loop_1;
    }
    func_8003455C();
    func_80027174();
    *(void *)0x8013E348 = 1;
}

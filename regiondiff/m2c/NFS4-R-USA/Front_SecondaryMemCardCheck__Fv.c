/* NFS4-R-USA CHANGED @800279CC | base 80027994 Front_SecondaryMemCardCheck__Fv */
/* callers: Init_PSX_FrontEnd__Fv */
? func_8002752C();                                  /* extern */
? func_800347D4(?, ?);                              /* extern */
? func_80034938();                                  /* extern */
s32 func_80034F70(s16, ?, ?);                       /* extern */

void func_800279CC(void) {
    s16 var_s1;
    s32 temp_v1;
    s32 var_s0;

    *(s32 *)0x8013E55C = 0;
    *(s32 *)0x8013E560 = 1;
    func_800347D4(0, 0);
    var_s1 = 0;
loop_1:
    if (var_s1 < 2) {
        var_s0 = 0;
        if (*(s32 *)0x80051DC0 == 0) {
loop_4:
            temp_v1 = (func_80034F70(var_s1, 0, 0) << 0x10) == 0;
            var_s0 += 1;
            *(s32 *)0x80051DC0 = temp_v1;
            if (var_s0 < 3) {
                if (temp_v1 == 0) {
                    goto loop_4;
                }
            }
        }
        *(s32 *)0x80051DC0 = 0;
        var_s1 += 1;
        goto loop_1;
    }
    func_80034938();
    func_8002752C();
    *(void *)0x8013E55C = 1;
}

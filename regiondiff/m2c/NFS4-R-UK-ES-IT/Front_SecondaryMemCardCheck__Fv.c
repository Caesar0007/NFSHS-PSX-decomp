/* NFS4-R-UK-ES-IT CHANGED @80027AB8 | base 80027994 Front_SecondaryMemCardCheck__Fv */
/* callers: Init_PSX_FrontEnd__Fv */
? func_800275D4();                                  /* extern */
? func_800348BC(?, ?);                              /* extern */
? func_80034A24();                                  /* extern */
s32 func_80034FF4(s16, ?, ?);                       /* extern */

void func_80027AB8(void) {
    s16 var_s1;
    s32 temp_v1;
    s32 var_s0;

    *(s32 *)0x8013E588 = 0;
    *(s32 *)0x8013E58C = 1;
    func_800348BC(0, 0);
    var_s1 = 0;
loop_1:
    if (var_s1 < 2) {
        var_s0 = 0;
        if (*(s32 *)0x800521C8 == 0) {
loop_4:
            temp_v1 = (func_80034FF4(var_s1, 0, 0) << 0x10) == 0;
            var_s0 += 1;
            *(s32 *)0x800521C8 = temp_v1;
            if (var_s0 < 3) {
                if (temp_v1 == 0) {
                    goto loop_4;
                }
            }
        }
        *(s32 *)0x800521C8 = 0;
        var_s1 += 1;
        goto loop_1;
    }
    func_80034A24();
    func_800275D4();
    *(void *)0x8013E588 = 1;
}

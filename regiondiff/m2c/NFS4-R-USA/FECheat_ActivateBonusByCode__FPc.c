/* NFS4-R-USA CHANGED @80023800 | base 800237E0 FECheat_ActivateBonusByCode__FPc */
/* callers: CheckForCheats__FPc */
? func_800234BC(? *);                               /* extern */
? func_800235F8(s32);                               /* extern */
? func_8007A08C(?, s32, void *, s32);               /* extern */

s32 func_80023800(void) {
    ? sp10;
    s32 var_a1;
    s32 var_a3;
    void *var_a2;
    void *var_s0;
    void *var_v0;

    func_800234BC(&sp10);
    var_a3 = 0;
    var_s0 = (void *)0x80051B34;
    var_a2 = NULL;
loop_1:
    var_a1 = 0;
    var_v0 = var_a2;
loop_2:
    if (*(0x80051B34 + (s32) var_v0) == *(&sp10 + var_a1)) {
        var_a1 += 1;
        var_v0 = var_a1 + var_a2;
        if (var_a1 >= 8) {

        } else {
            goto loop_2;
        }
    }
    var_a3 += 1;
    if (var_a1 == 8) {
        func_8007A08C(0x1A, var_a1, var_a2, var_a3);
        func_800235F8(var_s0->unk8);
        return 1;
    }
    var_s0 += 0xC;
    var_a2 += 0xC;
    if (var_a3 >= 2) {
        return 0;
    }
    goto loop_1;
}

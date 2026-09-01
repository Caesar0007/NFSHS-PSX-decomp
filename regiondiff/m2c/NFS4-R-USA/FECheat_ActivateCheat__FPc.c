/* NFS4-R-USA CHANGED @80023634 | base 80023614 FECheat_ActivateCheat__FPc */
/* callers: CheckForCheats__FPc */
? func_80018980(s32);                               /* extern */
? func_800233A0(s32);                               /* extern */
? func_80023430(? *);                               /* extern */
? func_8007A08C(?, s32, void *, ? *);               /* extern */
s32 func_800B9F18(?);                               /* extern */

s32 func_80023634(void) {
    ? sp10;
    s32 var_a1;
    s32 var_s1;
    s32 var_s2;
    void *temp_s0;
    void *temp_s0_2;
    void *var_a2;
    void *var_v0;

    var_s1 = 0;
    func_80023430(&sp10);
    var_s2 = 0;
    var_a2 = NULL;
loop_1:
    var_a1 = 0;
    if (var_s2 < 3) {
        var_v0 = var_a2;
loop_3:
        if (*(0x80051B10 + (s32) var_v0) == *(&sp10 + var_a1)) {
            var_a1 += 1;
            var_v0 = var_a1 + var_a2;
            if (var_a1 >= 8) {

            } else {
                goto loop_3;
            }
        }
        var_a2 += 0xC;
        if (var_a1 != 8) {
            var_s2 += 1;
            goto loop_1;
        }
        func_8007A08C(0x1A, var_a1, var_a2, &sp10);
        temp_s0 = *(s32 *)0x800519A8 + 0x238;
        temp_s0->unk90 = func_800B9F18(0x27B);
        func_80018980(*(s32 *)0x800519A8 + 0x238);
        temp_s0_2 = (var_s2 * 0xC) + 0x80051B10;
        var_s1 = 1;
        func_800233A0(temp_s0_2->unk8);
        *(s32 *)0x8013E550 |= 1 << temp_s0_2->unk8;
    }
    return var_s1;
}

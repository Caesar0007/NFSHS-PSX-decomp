/* NFS4-R-FR-DE CHANGED @800236C4 | base 80023614 FECheat_ActivateCheat__FPc */
/* callers: CheckForCheats__FPc */
? func_80018A00(s32);                               /* extern */
? func_80023430(s32);                               /* extern */
? func_800234C0(? *);                               /* extern */
? func_8007A08C(?, s32, void *, ? *);               /* extern */
s32 func_800B9F1C(?);                               /* extern */

s32 func_800236C4(void) {
    ? sp10;
    s32 var_a1;
    s32 var_s1;
    s32 var_s2;
    void *temp_s0;
    void *temp_s0_2;
    void *var_a2;
    void *var_v0;

    var_s1 = 0;
    func_800234C0(&sp10);
    var_s2 = 0;
    var_a2 = NULL;
loop_1:
    var_a1 = 0;
    if (var_s2 < 3) {
        var_v0 = var_a2;
loop_3:
        if (*(0x80051ED8 + (s32) var_v0) == *(&sp10 + var_a1)) {
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
        temp_s0 = *(s32 *)0x80051D70 + 0x238;
        temp_s0->unk90 = func_800B9F1C(0x27B);
        func_80018A00(*(s32 *)0x80051D70 + 0x238);
        temp_s0_2 = (var_s2 * 0xC) + 0x80051ED8;
        var_s1 = 1;
        func_80023430(temp_s0_2->unk8);
        *(s32 *)0x8013E57C |= 1 << temp_s0_2->unk8;
    }
    return var_s1;
}

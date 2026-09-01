/* NFS4-R-UK-SW CHANGED @80023808 | base 80023758 FECheat_LoadBonus__FRUl */
/* callers: LoadGame__FsbT1 */
? func_80023430(s32);                               /* extern */

void func_80023808(s32 *arg0) {
    s32 var_s0;

    var_s0 = 0;
    *(s32 *)0x8013E57C = 0;
    *(s32 *)0x8013E580 = *arg0;
    do {
        if (*(s32 *)0x8013E580 & (1 << var_s0)) {
            func_80023430(var_s0);
        }
        var_s0 += 1;
    } while (var_s0 < 0xF);
}

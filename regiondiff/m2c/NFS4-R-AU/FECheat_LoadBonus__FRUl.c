/* NFS4-R-AU CHANGED @800237B0 | base 80023758 FECheat_LoadBonus__FRUl */
/* callers: LoadGame__FsbT1 */
? func_800233D8(s32);                               /* extern */

void func_800237B0(s32 *arg0) {
    s32 var_s0;

    var_s0 = 0;
    *(s32 *)0x8013E57C = 0;
    *(s32 *)0x8013E580 = *arg0;
    do {
        if (*(s32 *)0x8013E580 & (1 << var_s0)) {
            func_800233D8(var_s0);
        }
        var_s0 += 1;
    } while (var_s0 < 0xF);
}

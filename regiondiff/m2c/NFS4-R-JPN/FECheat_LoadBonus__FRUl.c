/* NFS4-R-JPN CHANGED @800234D8 | base 80023758 FECheat_LoadBonus__FRUl */
/* callers: LoadGame__FsbT1 */
? func_80023100(s32);                               /* extern */

void func_800234D8(s32 *arg0) {
    s32 var_s0;

    var_s0 = 0;
    *(s32 *)0x8013E33C = 0;
    *(s32 *)0x8013E340 = *arg0;
    do {
        if (*(s32 *)0x8013E340 & (1 << var_s0)) {
            func_80023100(var_s0);
        }
        var_s0 += 1;
    } while (var_s0 < 0xF);
}

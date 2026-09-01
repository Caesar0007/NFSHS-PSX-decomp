/* NFS4-R-USA CHANGED @80023778 | base 80023758 FECheat_LoadBonus__FRUl */
/* callers: LoadGame__FsbT1 */
? func_800233A0(s32);                               /* extern */

void func_80023778(s32 *arg0) {
    s32 var_s0;

    var_s0 = 0;
    *(s32 *)0x8013E550 = 0;
    *(s32 *)0x8013E554 = *arg0;
    do {
        if (*(s32 *)0x8013E554 & (1 << var_s0)) {
            func_800233A0(var_s0);
        }
        var_s0 += 1;
    } while (var_s0 < 0xF);
}

/* NFS4-R-JPN CHANGED @800701FC | base 8006F9C4 AIState_Restart__Fv */
/* callers: AIHigh_Restart2__Fv */
? func_80072120();                                  /* extern */

void func_800701FC(void) {
    s32 *var_v0;
    s32 var_v1;

    var_v1 = 9;
    var_v0 = (s32 *)0x8010EEC0;
    do {
        *var_v0 = 0;
        var_v1 -= 1;
        var_v0 -= 4;
    } while (var_v1 >= 0);
    func_80072120();
}

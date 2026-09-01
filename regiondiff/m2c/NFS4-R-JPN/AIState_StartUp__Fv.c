/* NFS4-R-JPN CHANGED @800701BC | base 8006F9A4 AIState_StartUp__Fv */
/* callers: AIHigh_StartUp__Fv */
? func_80072120();                                  /* extern */

void func_800701BC(void) {
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

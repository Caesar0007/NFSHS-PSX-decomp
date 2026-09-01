/* NFS4-R-UK-ES-IT REGION-ONLY @800702E4 */
/* callers: __11AIHigh_BaseP8Car_tObj, HighExecute__18AIHigh_BTC_Wingman, HighExecute__18AIHigh_BTC_Wingman, HighExecute__18AIHigh_BTC_Wingman, HighExecute__18AIHigh_BTC_Wingman */
s32 func_800702E4(void) {
    s32 *var_v1;
    s32 var_a0;
    s32 var_a1;

    var_a1 = 0;
    var_a0 = 0x8010EA9C;
    var_v1 = (s32 *)0x8010F0DC;
loop_1:
    var_a1 += 1;
    if (*var_v1 == 0) {
        *var_v1 = 1;
        return var_a0;
    }
    var_a0 += 0xA0;
    var_v1 += 4;
    if (var_a1 >= 0xA) {
        return 0;
    }
    goto loop_1;
}

/* NFS4-R-UK-SW REGION-ONLY @80070330 */
/* callers: ___12AIState_None, ___12AIState_Base, ___17AIState_NonActive, ___12AIState_Base_8005F680, ___17AIState_NonActive_80061378 */
void func_80070330(s32 arg0) {
    s32 *var_a1;
    s32 var_a2;
    s32 var_v1;

    var_a2 = 0;
    var_a1 = (s32 *)0x8010F0DC;
    var_v1 = 0x8010EA9C;
loop_1:
    var_a2 += 1;
    if (arg0 == var_v1) {
        *var_a1 = 0;
        return;
    }
    var_a1 += 4;
    var_v1 += 0xA0;
    if (var_a2 >= 0xA) {
        return;
    }
    goto loop_1;
}

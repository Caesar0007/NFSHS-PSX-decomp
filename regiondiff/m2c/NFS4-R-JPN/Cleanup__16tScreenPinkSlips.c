/* NFS4-R-JPN CHANGED @80039138 | base 80039320 Cleanup__16tScreenPinkSlips */
? func_800158B8(?);                                 /* extern */
? func_80025E88(void *);                            /* extern */
? func_80050DF0(s32);                               /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
? func_800E5F18(s32);                               /* extern */

void func_80039138(void *arg0) {
    s32 temp_s0;

    func_80050DF0(arg0->unk68);
    func_800E5F18(arg0->unk68);
    *(s8 *)0x801156EA = 0;
loop_1:
    temp_s0 = func_8007AA48();
    if (temp_s0 < func_8007A9C4()) {
        func_800158B8(0);
        goto loop_1;
    }
    func_80025E88(arg0);
}

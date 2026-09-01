/* NFS4-R-USA CHANGED @80039580 | base 80039320 Cleanup__16tScreenPinkSlips */
? func_80015A70(?);                                 /* extern */
? func_800261C0(void *);                            /* extern */
? func_80051328(s32);                               /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
? func_800E612C(s32);                               /* extern */

void func_80039580(void *arg0) {
    s32 temp_s0;

    func_80051328(arg0->unk68);
    func_800E612C(arg0->unk68);
    *(s8 *)0x801158FE = 0;
loop_1:
    temp_s0 = func_8007AA48();
    if (temp_s0 < func_8007A9C4()) {
        func_80015A70(0);
        goto loop_1;
    }
    func_800261C0(arg0);
}

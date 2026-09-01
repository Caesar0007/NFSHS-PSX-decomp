/* NFS4-R-AU CHANGED @80039578 | base 80039320 Cleanup__16tScreenPinkSlips */
? func_80015A98(?);                                 /* extern */
? func_800261F4(void *);                            /* extern */
? func_800513E0(s32);                               /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
? func_800E6118(s32);                               /* extern */

void func_80039578(void *arg0) {
    s32 temp_s0;

    func_800513E0(arg0->unk68);
    func_800E6118(arg0->unk68);
    *(s8 *)0x8011592A = 0;
loop_1:
    temp_s0 = func_8007AA48();
    if (temp_s0 < func_8007A9C4()) {
        func_80015A98(0);
        goto loop_1;
    }
    func_800261F4(arg0);
}

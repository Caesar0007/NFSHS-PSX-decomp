/* NFS4-R-UK-SW CHANGED @800395E8 | base 80039320 Cleanup__16tScreenPinkSlips */
? func_80015AF0(?);                                 /* extern */
? func_8002624C(void *);                            /* extern */
? func_800516E8(s32);                               /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
? func_800E6118(s32);                               /* extern */

void func_800395E8(void *arg0) {
    s32 temp_s0;

    func_800516E8(arg0->unk68);
    func_800E6118(arg0->unk68);
    *(s8 *)0x8011592A = 0;
loop_1:
    temp_s0 = func_8007AA48();
    if (temp_s0 < func_8007A9C4()) {
        func_80015AF0(0);
        goto loop_1;
    }
    func_8002624C(arg0);
}

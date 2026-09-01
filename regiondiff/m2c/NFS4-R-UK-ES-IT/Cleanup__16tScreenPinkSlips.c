/* NFS4-R-UK-ES-IT CHANGED @80039600 | base 80039320 Cleanup__16tScreenPinkSlips */
? func_80015B08(?);                                 /* extern */
? func_80026264(void *);                            /* extern */
? func_80051730(s32);                               /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
? func_800E6118(s32);                               /* extern */

void func_80039600(void *arg0) {
    s32 temp_s0;

    func_80051730(arg0->unk68);
    func_800E6118(arg0->unk68);
    *(s8 *)0x8011592A = 0;
loop_1:
    temp_s0 = func_8007AA48();
    if (temp_s0 < func_8007A9C4()) {
        func_80015B08(0);
        goto loop_1;
    }
    func_80026264(arg0);
}

/* NFS4-R-JPN CHANGED @80047CB8 | base 80047DD8 Cleanup__14tScreenMemcard */
? func_800158B8(?);                                 /* extern */
? func_80025E88(s32);                               /* extern */
? func_8003455C();                                  /* extern */
? func_80047A98();                                  /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
? func_800E5F18(s32, void *, ?);                    /* extern */

void func_80047CB8(s32 arg0) {
    s32 temp_s0;
    void *temp_a1;

    func_80047A98();
    func_8003455C();
    temp_a1 = *(void **)0x800519A8;
    temp_a1->unk3054 = (s32) (temp_a1->unk3054 & ~1);
    temp_a1->unk3080 = (s32) (temp_a1->unk3080 & ~1);
    func_800E5F18(*(s32 *)0x80052890, temp_a1, -2);
    func_80025E88(arg0);
loop_1:
    temp_s0 = func_8007AA48();
    if (temp_s0 < func_8007A9C4()) {
        func_800158B8(0);
        goto loop_1;
    }
}

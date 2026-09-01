/* NFS4-R-AU CHANGED @80048234 | base 80047DD8 Cleanup__14tScreenMemcard */
? func_80015A98(?);                                 /* extern */
? func_800261F4(s32);                               /* extern */
? func_800349B4();                                  /* extern */
? func_80048010();                                  /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
? func_800E6118(s32, void *, ?);                    /* extern */

void func_80048234(s32 arg0) {
    s32 temp_s0;
    void *temp_a1;

    func_80048010();
    func_800349B4();
    temp_a1 = *(void **)0x80051F98;
    temp_a1->unk3054 = (s32) (temp_a1->unk3054 & ~1);
    temp_a1->unk3080 = (s32) (temp_a1->unk3080 & ~1);
    func_800E6118(*(s32 *)0x80052E88, temp_a1, -2);
    func_800261F4(arg0);
loop_1:
    temp_s0 = func_8007AA48();
    if (temp_s0 < func_8007A9C4()) {
        func_80015A98(0);
        goto loop_1;
    }
}

/* NFS4-R-USA CHANGED @80048230 | base 80047DD8 Cleanup__14tScreenMemcard */
? func_80015A70(?);                                 /* extern */
? func_800261C0(s32);                               /* extern */
? func_80034938();                                  /* extern */
? func_80048010();                                  /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
? func_800E612C(s32, void *, ?);                    /* extern */

void func_80048230(s32 arg0) {
    s32 temp_s0;
    void *temp_a1;

    func_80048010();
    func_80034938();
    temp_a1 = *(void **)0x80051EE0;
    temp_a1->unk3054 = (s32) (temp_a1->unk3054 & ~1);
    temp_a1->unk3080 = (s32) (temp_a1->unk3080 & ~1);
    func_800E612C(*(s32 *)0x80052DC8, temp_a1, -2);
    func_800261C0(arg0);
loop_1:
    temp_s0 = func_8007AA48();
    if (temp_s0 < func_8007A9C4()) {
        func_80015A70(0);
        goto loop_1;
    }
}

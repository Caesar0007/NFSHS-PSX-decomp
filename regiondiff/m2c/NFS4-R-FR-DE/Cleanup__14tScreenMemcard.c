/* NFS4-R-FR-DE CHANGED @800482A4 | base 80047DD8 Cleanup__14tScreenMemcard */
? func_80015AF0(?);                                 /* extern */
? func_8002624C(s32);                               /* extern */
? func_80034A0C();                                  /* extern */
? func_80048080();                                  /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
? func_800E6118(s32, void *, ?);                    /* extern */

void func_800482A4(s32 arg0) {
    s32 temp_s0;
    void *temp_a1;

    func_80048080();
    func_80034A0C();
    temp_a1 = *(void **)0x800522A8;
    temp_a1->unk3054 = (s32) (temp_a1->unk3054 & ~1);
    temp_a1->unk3080 = (s32) (temp_a1->unk3080 & ~1);
    func_800E6118(*(s32 *)0x80053190, temp_a1, -2);
    func_8002624C(arg0);
loop_1:
    temp_s0 = func_8007AA48();
    if (temp_s0 < func_8007A9C4()) {
        func_80015AF0(0);
        goto loop_1;
    }
}

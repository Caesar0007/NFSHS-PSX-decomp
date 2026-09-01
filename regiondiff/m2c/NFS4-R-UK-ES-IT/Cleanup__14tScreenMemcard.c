/* NFS4-R-UK-ES-IT CHANGED @800482BC | base 80047DD8 Cleanup__14tScreenMemcard */
? func_80015B08(?);                                 /* extern */
? func_80026264(s32);                               /* extern */
? func_80034A24();                                  /* extern */
? func_80048098();                                  /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
? func_800E6118(s32, void *, ?);                    /* extern */

void func_800482BC(s32 arg0) {
    s32 temp_s0;
    void *temp_a1;

    func_80048098();
    func_80034A24();
    temp_a1 = *(void **)0x800522E8;
    temp_a1->unk3054 = (s32) (temp_a1->unk3054 & ~1);
    temp_a1->unk3080 = (s32) (temp_a1->unk3080 & ~1);
    func_800E6118(*(s32 *)0x800531D0, temp_a1, -2);
    func_80026264(arg0);
loop_1:
    temp_s0 = func_8007AA48();
    if (temp_s0 < func_8007A9C4()) {
        func_80015B08(0);
        goto loop_1;
    }
}

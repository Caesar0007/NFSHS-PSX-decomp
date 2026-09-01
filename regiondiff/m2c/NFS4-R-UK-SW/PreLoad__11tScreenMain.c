/* NFS4-R-UK-SW CHANGED @80038928 | base 800386C8 PreLoad__11tScreenMain */
? func_8002682C(void *);                            /* extern */
? func_800E5094(?, ?, u8, s32);                     /* extern */
s32 func_800EB41C();                                /* extern */

void func_80038928(void *arg0) {
    s16 temp_v0;
    s32 temp_ret;

    func_800E5094(0x80053420, 0x80011858, *(u8 *)0x80115C24);
    temp_ret = func_800EB41C();
    temp_v0 = temp_ret % 25;
    arg0->unk548 = temp_v0;
    func_800E5094(0x80053400, 0x8001184C, (u8) temp_v0, MULT_HI(temp_ret, 0x51EB851F));
    func_8002682C(arg0);
}

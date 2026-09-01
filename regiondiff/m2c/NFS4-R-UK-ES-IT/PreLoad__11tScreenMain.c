/* NFS4-R-UK-ES-IT CHANGED @80038940 | base 800386C8 PreLoad__11tScreenMain */
? func_80026844(void *);                            /* extern */
? func_800E5094(?, ?, u8, s32);                     /* extern */
s32 func_800EB41C();                                /* extern */

void func_80038940(void *arg0) {
    s16 temp_v0;
    s32 temp_ret;

    func_800E5094(0x80053468, 0x80011858, *(u8 *)0x80115C24);
    temp_ret = func_800EB41C();
    temp_v0 = temp_ret % 25;
    arg0->unk548 = temp_v0;
    func_800E5094(0x80053448, 0x8001184C, (u8) temp_v0, MULT_HI(temp_ret, 0x51EB851F));
    func_80026844(arg0);
}

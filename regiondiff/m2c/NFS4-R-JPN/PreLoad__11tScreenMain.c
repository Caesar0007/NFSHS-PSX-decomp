/* NFS4-R-JPN CHANGED @80038470 | base 800386C8 PreLoad__11tScreenMain */
? func_80026468(void *);                            /* extern */
? func_800E4E94(?, ?, u8, s32);                     /* extern */
s32 func_800EB21C();                                /* extern */

void func_80038470(void *arg0) {
    s16 temp_v0;
    s32 temp_ret;

    func_800E4E94(0x80052B28, 0x80011858, *(u8 *)0x801159E4);
    temp_ret = func_800EB21C();
    temp_v0 = temp_ret % 25;
    arg0->unk548 = temp_v0;
    func_800E4E94(0x80052B08, 0x8001184C, (u8) temp_v0, MULT_HI(temp_ret, 0x51EB851F));
    func_80026468(arg0);
}

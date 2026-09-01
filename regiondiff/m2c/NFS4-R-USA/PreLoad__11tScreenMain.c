/* NFS4-R-USA CHANGED @800388C0 | base 800386C8 PreLoad__11tScreenMain */
? func_800267A0(void *);                            /* extern */
? func_800E50A8(?, ?, u8, s32);                     /* extern */
s32 func_800EB430();                                /* extern */

void func_800388C0(void *arg0) {
    s16 temp_v0;
    s32 temp_ret;

    func_800E50A8(0x80053060, 0x80011850, *(u8 *)0x80115BF8);
    temp_ret = func_800EB430();
    temp_v0 = temp_ret % 25;
    arg0->unk548 = temp_v0;
    func_800E50A8(0x80053040, 0x80011844, (u8) temp_v0, MULT_HI(temp_ret, 0x51EB851F));
    func_800267A0(arg0);
}

/* NFS4-R-USA CHANGED @800341B4 | base 8003407C LoadDescription__15tMissionManagerb */
/* callers: Front_InitMissions__FR9tFEStream */
? func_800E50A8(? *, ?, s32, ?);                    /* extern */
s32 func_800E5F28(?, ?, ?);                         /* extern */
? func_800E612C(void *);                            /* extern */
void *func_800E63D4(? *, ?);                        /* extern */
? func_800E6EC8(void *, s32, s32);                  /* extern */

void func_800341B4(void *arg0, s32 arg1) {
    ? sp10;
    ? var_a3;
    s32 temp_s0;
    s32 temp_s3;
    s32 temp_s5;
    void *temp_s1;
    void *temp_s1_2;
    void *temp_v0;

    if (arg1 != 0) {
        var_a3 = 0x80011650;
    } else {
        var_a3 = 0x8001165C;
    }
    func_800E50A8(&sp10, 0x80011648, (void *)0x80117720->unk94, var_a3);
    temp_v0 = func_800E63D4(&sp10, 0x10);
    arg0->unk0 = (u8) temp_v0->unk0;
    temp_s5 = temp_v0->unk4;
    temp_s3 = temp_v0->unk8;
    temp_s1 = temp_v0 + 0xC;
    if (arg0->unk4 == 0) {
        arg0->unk4 = func_800E5F28(0x80011668, 0x3120, 0);
    }
    func_800E6EC8(temp_s1, arg0->unk4, arg0->unk0 * 4);
    temp_s0 = temp_s5 * 0x14;
    temp_s1_2 = temp_s1 + (arg0->unk0 * 4);
    func_800E6EC8(temp_s1_2, arg0->unk4 + 0x20, temp_s0);
    func_800E6EC8(temp_s1_2 + temp_s0, arg0->unk4 + 0x520, temp_s3 * 0x2C);
    func_800E612C(temp_v0);
}

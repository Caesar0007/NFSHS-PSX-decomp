/* NFS4-R-AU CHANGED @8003422C | base 8003407C LoadDescription__15tMissionManagerb */
/* callers: Front_InitMissions__FR9tFEStream */
? func_800E5094(? *, ?, s32, ?);                    /* extern */
s32 func_800E5F14(?, ?, ?);                         /* extern */
? func_800E6118(void *);                            /* extern */
void *func_800E63C0(? *, ?);                        /* extern */
? func_800E6EB4(void *, s32, s32);                  /* extern */

void func_8003422C(void *arg0, s32 arg1) {
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
    func_800E5094(&sp10, 0x80011648, (void *)0x8011774C->unk94, var_a3);
    temp_v0 = func_800E63C0(&sp10, 0x10);
    arg0->unk0 = (u8) temp_v0->unk0;
    temp_s5 = temp_v0->unk4;
    temp_s3 = temp_v0->unk8;
    temp_s1 = temp_v0 + 0xC;
    if (arg0->unk4 == 0) {
        arg0->unk4 = func_800E5F14(0x80011668, 0x3120, 0);
    }
    func_800E6EB4(temp_s1, arg0->unk4, arg0->unk0 * 4);
    temp_s0 = temp_s5 * 0x14;
    temp_s1_2 = temp_s1 + (arg0->unk0 * 4);
    func_800E6EB4(temp_s1_2, arg0->unk4 + 0x20, temp_s0);
    func_800E6EB4(temp_s1_2 + temp_s0, arg0->unk4 + 0x520, temp_s3 * 0x2C);
    func_800E6118(temp_v0);
}

/* NFS4-R-JPN CHANGED @800A8534 | base 800A79C8 Draw__25tPMenuItemLeftRightSliderb */
/* callers: Draw__32tPMenuItemLeftRightSliderIndexedb */
? func_800A7BA8(s16, s16, s32, s16);                /* extern */
s16 func_800B9D0C(s32);                             /* extern */
? func_800D3344(?, s32, s32, ?, s32, s32, s32, s32); /* extern */

void func_800A8534(void *arg0, s16 arg1) {
    s16 temp_v0;
    s16 temp_v0_2;
    s32 var_s0;
    s32 var_s1;
    s32 var_v1;
    u16 temp_s3;

    var_s0 = 0;
    var_s1 = 0x42;
    temp_v0 = func_800B9D0C(arg0->unk4);
    temp_s3 = saved_reg_gp->unk1890;
    func_800A7BA8((s16) arg0->unk4, arg1, arg0->unk0 & 1, temp_v0);
    temp_v0_2 = temp_s3 + 4;
loop_1:
    if (var_s0 < 0xF) {
        var_v1 = 0x323232;
        if (var_s0 < ((s32) (*arg0->unkC * 0xF) / (s32) arg0->unk10)) {
            var_v1 = 0x808080;
            if (arg1 != 0) {
                var_v1 = 0xBEBE;
            }
        }
        func_800D3344(0, temp_v0 + var_s1, temp_v0_2 + 2, 3, 5, var_v1, 0, 0);
        var_s1 += 5;
        var_s0 += 1;
        goto loop_1;
    }
    func_800D3344(0, temp_v0 + 0x3F, temp_v0_2 + 1, 0x4F, 7, 0, 0, 0);
}

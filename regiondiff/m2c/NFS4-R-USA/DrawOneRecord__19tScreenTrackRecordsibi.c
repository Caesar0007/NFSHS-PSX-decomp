/* NFS4-R-USA CHANGED @80042AE0 | base 80042700 DrawOneRecord__19tScreenTrackRecordsibi */
/* callers: DrawRecords__19tScreenTrackRecordss, DrawRecords__19tScreenTrackRecordss */
? func_80021020(? *, s16, s16, ?, s32, s32);        /* extern */
? func_8004AE74(s32, ? *);                          /* extern */
? func_8004EB60(?, ?, s16, s16, s32, s32, s32);     /* extern */
? *func_800B9F18(s32);                              /* extern */
s16 func_800B9F58(?);                               /* extern */
? func_800CECD0(s32, s32, s32, s32, s32);           /* extern */
? func_800E50A8(? *, ? *);                          /* extern */

void func_80042AE0(void *arg0, s32 arg1, s32 arg2, s16 arg3) {
    ? sp20;
    ? *temp_s1;
    s16 temp_a1;
    s16 temp_a1_2;
    s16 temp_a1_3;
    s32 temp_a0;
    s32 temp_a2;
    s32 temp_s0;
    s32 temp_s0_2;
    s32 temp_s3;
    s32 var_v0;

    temp_s0 = arg1 * 0x14;
    temp_s3 = (arg2 != 0) * 2;
    if ((temp_s0 + arg0->unk64)->unk10 >= 0) {
        if (arg2 != 0) {
            temp_a2 = arg0->unk68;
            func_800CECD0(func_800B9F58(0x248) + 3, arg3 + 4, temp_a2 / 2, (temp_a2 * 2) / 3, 0x17);
            func_8004EB60(0, 0, func_800B9F58(0x248), arg3, 0, 0, 0);
        }
        temp_a1 = func_800B9F58(0x24C);
        if (arg2 != 0) {
            var_v0 = 2;
        } else {
            var_v0 = 1;
        }
        func_80021020(arg0->unk64 + temp_s0, temp_a1, arg3, 0xB, var_v0, 0);
        temp_s0_2 = arg1 * 0x14;
        temp_s1 = func_800B9F18((temp_s0_2 + arg0->unk64)->unk8 + 0x154);
        func_80021020(temp_s1, func_800B9F58(0x24D), arg3, 0xB, temp_s3, 0);
        temp_a0 = (temp_s0_2 + arg0->unk64)->unkC;
        if (temp_a0 != 0) {
            func_8004AE74(temp_a0, &sp20);
        } else {
            func_800E50A8(&sp20, func_800B9F18(0x262));
        }
        temp_a1_2 = func_800B9F58(0x24E);
        if ((arg2 != 0) || (arg1 != 0)) {

        }
        func_80021020(&sp20, temp_a1_2, arg3, 0xB, 0);
        func_8004AE74(((arg1 * 0x14) + arg0->unk64)->unk10, &sp20);
        temp_a1_3 = func_800B9F58(0x24F);
        if ((arg1 != 0) || (temp_s3 != 0)) {

        }
        func_80021020(&sp20, temp_a1_3, arg3, 0xB, 0);
    }
}

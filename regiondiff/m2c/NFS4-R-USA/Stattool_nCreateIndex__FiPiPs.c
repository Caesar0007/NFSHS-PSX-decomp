/* NFS4-R-USA CHANGED @8004AD40 | base 8004A868 Stattool_nCreateIndex__FiPiPs */
/* callers: StatChk_IsRecordLapTime__FP10Car_tStatssPs, StatChk_SaveTopTime__FP10Car_tStatss */
s32 *func_800E5F28(?, s32, ?);                      /* extern */
? func_800E612C(s32 *);                             /* extern */

void func_8004AD40(s32 arg0, s32 *arg1, s16 *arg2) {
    s16 *var_t2;
    s16 *var_v1;
    s16 temp_t3;
    s16 var_s0;
    s32 *temp_a0;
    s32 *var_a1;
    s32 *var_a1_2;
    s32 *var_a2;
    s32 *var_t1;
    s32 temp_t0;
    s32 temp_v0;
    s32 temp_v1;
    s32 var_a2_2;
    s32 var_s0_2;
    void *var_a3;

    var_s0 = 0;
    temp_a0 = func_800E5F28(0x800124C4, (arg0 + 1) * 4, 0x10);
    if (arg0 > 0) {
        var_a2 = temp_a0;
        var_a1 = arg1;
        var_v1 = arg2;
        do {
            *var_v1 = var_s0;
            temp_v0 = *var_a1;
            var_a1 += 4;
            var_v1 += 2;
            var_s0 += 1;
            *var_a2 = temp_v0;
            var_a2 += 4;
        } while (var_s0 < arg0);
    }
    var_s0_2 = 1;
    if (arg0 != 1) {
        var_t2 = arg2 + 2;
        if (arg0 > 1) {
            var_t1 = temp_a0 + 4;
            do {
                var_a2_2 = var_s0_2 - 1;
                temp_t0 = *var_t1;
                temp_t3 = *var_t2;
                if (var_a2_2 >= 0) {
                    var_a3 = (var_a2_2 * 2) + arg2;
                    var_a1_2 = &temp_a0[var_a2_2];
loop_8:
                    temp_v1 = var_a1_2->unk0;
                    if (temp_v1 >= temp_t0) {
                        var_a1_2->unk4 = temp_v1;
                        var_a1_2 -= 4;
                        var_a2_2 -= 1;
                        var_a3->unk2 = (u16) var_a3->unk0;
                        var_a3 -= 2;
                        if (var_a2_2 >= 0) {
                            goto loop_8;
                        }
                    }
                }
                var_t2 += 2;
                var_s0_2 += 1;
                temp_a0[var_a2_2].unk4 = temp_t0;
                ((var_a2_2 * 2) + arg2)->unk2 = temp_t3;
                var_t1 += 4;
            } while (var_s0_2 < arg0);
        }
    }
    func_800E612C(temp_a0);
}

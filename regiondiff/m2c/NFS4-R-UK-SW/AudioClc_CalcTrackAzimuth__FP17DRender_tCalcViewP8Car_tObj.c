/* NFS4-R-UK-SW CHANGED @8007571C | base 80074E24 AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj */
s32 func_800E6710(s32, s32, s32, s32);              /* extern */

s32 func_8007571C(void *arg0, void *arg1) {
    s32 temp_a1;
    s32 temp_a2;
    s32 temp_a3;
    s32 temp_t0;
    s32 temp_t2;
    s32 temp_t3;
    s32 var_a0;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v0_3;
    s32 var_v0_4;
    s32 var_v0_5;
    s32 var_v1;
    s32 var_v1_2;
    s32 var_v1_3;

    if (*(s32 *)0x8013D994 != 0) {
        temp_a3 = arg1->unk15C;
        var_v1 = temp_a3;
        if (temp_a3 < 0) {
            var_v1 = temp_a3 + 0xFF;
        }
        var_v0_3 = arg0->unkC;
        temp_t3 = var_v1 >> 8;
        if (var_v0_3 < 0) {
            var_v0_3 += 0xFF;
        }
        temp_a2 = arg1->unk160;
        var_v1_2 = temp_a2;
        if (temp_a2 < 0) {
            var_v1_2 = temp_a2 + 0xFF;
        }
        var_v0_4 = arg0->unk10;
        temp_t2 = var_v1_2 >> 8;
        if (var_v0_4 < 0) {
            var_v0_4 += 0xFF;
        }
        temp_a1 = arg1->unk164;
        var_v1_3 = temp_a1;
        if (temp_a1 < 0) {
            var_v1_3 = temp_a1 + 0xFF;
        }
        var_v0_5 = arg0->unk14;
        temp_t0 = var_v1_3 >> 8;
        if (var_v0_5 < 0) {
            var_v0_5 += 0xFF;
        }
        var_v0 = arg0->unk24;
        var_a0 = (temp_t3 * (var_v0_3 >> 8)) + (temp_t2 * (var_v0_4 >> 8)) + (temp_t0 * (var_v0_5 >> 8));
        if (var_v0 < 0) {
            var_v0 += 0xFF;
        }
        var_v0_2 = arg0->unk2C;
        if (var_v0_2 < 0) {
            var_v0_2 += 0xFF;
        }
        if (*(s32 *)0x801144FC != 0) {
            var_a0 = -var_a0;
        }
        return (func_800E6710(var_a0 >> 8, (s32) ((temp_t3 * (var_v0 >> 8)) + (temp_t2 * ((s32) arg0->unk28 / 256)) + (temp_t0 * (var_v0_2 >> 8))) >> 8, temp_a2, temp_a3) << 6) & 0xFFC0;
    }
    return 0;
}

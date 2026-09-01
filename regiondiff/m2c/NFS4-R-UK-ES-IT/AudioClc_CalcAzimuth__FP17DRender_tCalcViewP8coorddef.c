/* NFS4-R-UK-ES-IT CHANGED @800754C8 | base 80074BE8 AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef */
/* callers: AudioClc_SoundPlayersCar__Fi, AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji */
s32 func_800E6710(s32, s32, s32, s32);              /* extern */

s32 func_800754C8(void *arg0, void *arg1) {
    s32 sp18;
    s32 temp_a2;
    s32 temp_a2_2;
    s32 temp_a3;
    s32 temp_t1;
    s32 temp_t2;
    s32 var_a1;
    s32 var_a1_2;
    s32 var_a2;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v0_3;
    s32 var_v0_4;
    s32 var_v0_5;
    s32 var_v1;
    s32 var_v1_2;

    if (*(s32 *)0x8013D994 != 0) {
        temp_a2_2 = arg1->unk0 - arg0->unk0;
        temp_a3 = arg1->unk4 - arg0->unk4;
        var_a1 = temp_a2_2;
        var_v1_2 = arg1->unk8 - arg0->unk8;
        sp18 = var_v1_2;
        if (temp_a2_2 < 0) {
            var_a1 = temp_a2_2 + 0xFF;
        }
        var_v0_3 = arg0->unkC;
        temp_t2 = var_a1 >> 8;
        if (var_v0_3 < 0) {
            var_v0_3 += 0xFF;
        }
        var_a1_2 = temp_a3;
        if (temp_a3 < 0) {
            var_a1_2 = temp_a3 + 0xFF;
        }
        var_v0_4 = arg0->unk10;
        temp_t1 = var_a1_2 >> 8;
        if (var_v0_4 < 0) {
            var_v0_4 += 0xFF;
        }
        if (var_v1_2 < 0) {
            var_v1_2 += 0xFF;
        }
        var_v0_5 = arg0->unk14;
        if (var_v0_5 < 0) {
            var_v0_5 += 0xFF;
        }
        var_v0 = arg0->unk24;
        var_v1 = (temp_t2 * (var_v0_3 >> 8)) + (temp_t1 * (var_v0_4 >> 8)) + ((var_v1_2 >> 8) * (var_v0_5 >> 8));
        if (var_v0 < 0) {
            var_v0 += 0xFF;
        }
        var_a2 = sp18;
        if (var_a2 < 0) {
            var_a2 += 0xFF;
        }
        var_v0_2 = arg0->unk2C;
        temp_a2 = var_a2 >> 8;
        if (var_v0_2 < 0) {
            var_v0_2 += 0xFF;
        }
        if (*(s32 *)0x801144FC != 0) {
            var_v1 = -var_v1;
        }
        return (func_800E6710(var_v1 >> 8, (s32) ((temp_t2 * (var_v0 >> 8)) + (temp_t1 * ((s32) arg0->unk28 / 256)) + (temp_a2 * (var_v0_2 >> 8))) >> 8, temp_a2, temp_a3) << 6) & 0xFFC0;
    }
    return 0;
}

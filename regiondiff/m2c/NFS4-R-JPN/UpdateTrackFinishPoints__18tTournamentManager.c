/* NFS4-R-JPN CHANGED @80032BA0 | base 80032E30 UpdateTrackFinishPoints__18tTournamentManager */
/* callers: AdvanceToNextTrack__18tTournamentManager */
s16 func_800332E8();                                /* extern */
? func_800E6764(void *, s16, ?, ?);                 /* extern */

void func_80032BA0(void *arg0) {
    s16 temp_t0;
    s16 var_a3;
    s32 temp_a1;
    s32 temp_a2;
    s32 var_a0;
    s32 var_a0_2;
    s8 var_a0_3;
    s8 var_a0_4;
    u32 temp_v1_2;
    void *temp_v1;
    void *var_a1;
    void *var_a1_2;
    void *var_a2;
    void *var_v0;
    void *var_v0_2;

    var_a3 = 0;
    temp_a1 = arg0->unk18;
    temp_t0 = func_800332E8();
    if (((((temp_a1 + (arg0->unk4 * 0xC))->unk2 + arg0->unk8) * 0x54) + temp_a1)->unk29 != 0) {
        var_a0 = 0;
        if (temp_t0 > 0) {
            var_a1 = arg0;
            do {
                if (var_a1->unk120 == 0) {
                    temp_v1 = (var_a3 * 0xA0) + 0x80110BF4;
                    temp_a2 = temp_v1->unk84;
                    if ((u32) (temp_a2 - 1) < 6U) {
                        if (temp_a2 >= arg0->unk10) {
                            var_a1->unk120 = 1;
                        } else {
                            var_a1->unk124 = (u16) (var_a1->unk124 + 1);
                        }
                        var_a1->unk126 = (u8) temp_v1->unk84;
                    }
                    var_a3 += 1;
                }
                var_a0 += 1;
                var_a1 += 0x10;
            } while (var_a0 < temp_t0);
        }
        arg0->unk10 = (s32) (arg0->unk10 - 1);
        return;
    }
    var_a0_2 = 0;
    if (temp_t0 > 0) {
        var_a2 = arg0;
        var_a1_2 = (void *)0x80110BF4;
        do {
            temp_v1_2 = var_a1_2->unk84 - 1;
            if ((temp_v1_2 < 6U) && (var_a1_2->unk80 == 2)) {
                var_a2->unk124 = (u16) (var_a2->unk124 + (arg0 + temp_v1_2)->unk231);
            }
            var_a2 += 0x10;
            var_a0_2 += 1;
            var_a1_2 += 0xA0;
        } while (var_a0_2 < temp_t0);
    }
    var_a0_3 = 5;
    var_v0 = arg0 + 5;
    do {
        var_v0->unk237 = var_a0_3;
        var_a0_3 -= 1;
        var_v0 -= 1;
    } while (var_a0_3 >= 0);
    func_800E6764(arg0 + 0x237, temp_t0, 1, 0x800327C0);
    var_a0_4 = 0;
    var_v0_2 = arg0;
    do {
        var_a0_4 += 1;
        (arg0 + (var_v0_2->unk237 * 0x10))->unk126 = var_a0_4;
        var_v0_2 = arg0 + var_a0_4;
    } while (var_a0_4 < 6);
}

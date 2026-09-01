/* NFS4-R-UK-SW CHANGED @800E4DF4 | base 800E4210 PAD_update */
/* callers: CalculateDimensions__11tDialogHelp, FEInput_GetNoDebounceKey__Fii, Front_ResetPSXController__Fii, GetPSXPadValue__Fii, Movie_Play__Fc */
? func_800E6EB4(u8 *, s32, ?);                      /* extern */
? func_800F2504(s32, ?, ?);                         /* extern */

void func_800E4DF4(void) {
    ? var_a1;
    s32 var_a0;
    s32 var_s1;
    s32 var_s2;
    s32 var_s2_2;
    s32 var_s3;
    u8 *var_s0;
    u8 temp_a1;
    u8 temp_v0;
    void *var_a0_2;
    void *var_a2;

    var_s2 = 0;
    var_s3 = 0x8013FBDC;
    var_s1 = 0x8013FBD4;
    var_s0 = (u8 *)0x8013FC24;
    do {
        var_a0 = var_s1;
        if (*var_s0 != 0) {
            var_a1 = 0x20;
        } else {
            func_800E6EB4(var_s0, var_s1, 8);
            var_a0 = var_s3;
            var_a1 = 0x18;
        }
        func_800F2504(var_a0, var_a1, 0xFF);
        var_s3 += 0x20;
        var_s1 += 0x20;
        var_s2 += 1;
        var_s0 += 0x22;
    } while (var_s2 < 2);
    var_s2_2 = 0;
    var_a0_2 = (void *)0x8013FBD0;
    var_a2 = (void *)0x8013FBD0;
    do {
        temp_a1 = var_a2->unk4 == 0;
        if (temp_a1 != var_a0_2->unk44) {
            temp_v0 = var_a0_2->unk45;
            var_a0_2->unk45 = (u8) (temp_v0 + 1);
            if ((u32) (temp_v0 & 0xFF) >= 6U) {
                var_a0_2->unk44 = temp_a1;
                var_a0_2->unk45 = 0U;
            }
        }
        var_a0_2 += 2;
        var_s2_2 += 1;
        var_a2 += 8;
    } while (var_s2_2 < 8);
}

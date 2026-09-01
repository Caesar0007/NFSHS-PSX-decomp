/* NFS4-R-JPN CHANGED @8007593C | base 80075028 AudioClc_SoundCloseCar__Fii */
/* callers: AudioClc_SoundCars__Fv */
s32 func_80075440(?, s32);                          /* extern */

s32 func_8007593C(void) {
    s32 *var_s1;
    s32 temp_a1;
    s32 temp_v0;
    s32 temp_v1;
    s32 var_s0;
    s32 var_s2;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v0_3;
    s32 var_v1;

    if (*(s32 *)0x8011429C == 1) {
        goto block_1;
    }
    var_s0 = 0xC00000;
    var_s2 = 0;
    var_s1 = (s32 *)0x8010F3F8;
loop_3:
    if (var_s2 < 4) {
        temp_a1 = *var_s1;
        if (temp_a1 != 0) {
            temp_v0 = func_80075440(0x8010F4D8, temp_a1 + 0xA0);
            if (temp_v0 <= 0x7FFFFF) {
                var_s0 = var_s0 + 0xFF800000 + temp_v0;
            }
        }
        var_s1 += 0x38;
        var_s2 += 1;
        goto loop_3;
    }
    var_v0_2 = var_s0;
    if (var_s0 < 0) {
        var_v0_2 = var_s0 + 0xFFFF;
    }
    var_v1 = var_v0_2 >> 0x10;
    if (var_v1 >= 0x81) {
        var_v1 = 0x80;
    }
    var_v0 = 0;
    if (var_v1 >= 0) {
        var_v0_3 = var_s0;
        if (var_s0 < 0) {
            var_v0_3 = var_s0 + 0xFFFF;
        }
        temp_v1 = var_v0_3 >> 0x10;
        var_v0 = temp_v1;
        if (temp_v1 < 0x81) {
            /* Duplicate return node #16. Try simplifying control flow for better match */
            return var_v0;
        }
block_1:
        return 0x80;
    }
    return var_v0;
}

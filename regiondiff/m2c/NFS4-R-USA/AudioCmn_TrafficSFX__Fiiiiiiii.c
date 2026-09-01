/* NFS4-R-USA CHANGED @80079B54 | base 80079104 AudioCmn_TrafficSFX__Fiiiiiiii */
/* callers: AudioClc_SoundPlayersCar__Fi */
? func_80078A88(s32);                               /* extern */
? func_80078D88(s32, s32, s32, s32, s32, s32);      /* extern */
s32 func_8009AEA0(?, ?);                            /* extern */
s32 func_800E4F14(s32, s32);                        /* extern */
s32 func_800E4FF0(?, s32, s32);                     /* extern */

void func_80079B54(s32 arg0, ? arg1, s32 arg2, s32 arg3, s32 arg4, s32 arg5, s32 arg6, s32 arg7) {
    ? var_a0_2;
    s32 temp_a0;
    s32 temp_a1;
    s32 temp_s1;
    s32 temp_s1_2;
    s32 temp_v0;
    s32 temp_v1;
    s32 var_a0;
    s32 var_a0_3;
    s32 var_a0_4;
    s32 var_a1;
    s32 var_lo;
    s32 var_s2;
    s32 var_s3;

    var_a0 = 0;
    if (*(s32 *)0x801144B0 == 1) {
        var_a0 = (arg0 < 8) ^ 1;
    }
    var_a0_2 = 0x08000000;
    if (((var_a0 * 0x110) + 0x80110570)->unk70 == 0xC) {
        var_a0_2 = 0x10000000;
        var_a1 = 0x10000;
    } else {
        var_a1 = 0x20000;
    }
    temp_v0 = func_800E4FF0(var_a0_2, arg4 + var_a1, arg4);
    var_s2 = temp_v0 >> 0x10;
    if (temp_v0 < 0) {
        var_s2 = (s32) (temp_v0 + 0xFFFF) >> 0x10;
    }
    if ((var_s2 == 0) && (arg0 != -1)) {
        var_a0_3 = arg0 + 4;
        if (*(0x8010FBC0 + (arg0 * 8)) != -1) {
            func_80078A88(arg0);
            var_a0_3 = arg0 + 4;
        }
        if (*(0x8010FBC0 + (var_a0_3 * 8)) != -1) {
            func_80078A88(var_a0_3);
        }
        temp_a0 = arg0 + 8;
        if (*(0x8010FBC0 + (temp_a0 * 8)) != -1) {
            func_80078A88(temp_a0);
        }
    } else {
        temp_a1 = arg7 + (arg7 >> 1);
        var_a0_4 = temp_a1 >> 0xA;
        temp_s1 = (s32) (func_800E4F14(arg2 + 0x3333, arg3) * 0x50) >> 0xA;
        if (var_a0_4 >= 0x41) {
            var_a0_4 = 0x40;
        }
        var_s3 = -0x40;
        if (var_a0_4 >= -0x40) {
            temp_v1 = temp_a1 >> 0xA;
            var_s3 = 0x40;
            if (temp_v1 < 0x41) {
                var_s3 = temp_v1;
            }
        }
        temp_s1_2 = temp_s1 * 0x10;
        func_80078D88(arg0 + 4, func_8009AEA0(arg1, 0), 0x40, temp_s1_2, (s32) (var_s2 * *(0x8010F950 + (s32) (0x40 - var_s3))) >> 7, arg5);
        func_80078D88(arg0 + 8, func_8009AEA0(arg1, 1), 0x40, temp_s1_2, (s32) (var_s2 * (var_s3 + 0x8010F950)->unk40) >> 7, arg5);
        var_lo = var_s2 * arg6;
        if (arg6 > 0x280000) {
            var_lo = var_s2 * 0x280000;
        }
        func_80078D88(arg0, 0x63, arg2, arg3, (s32) ((var_lo / 2621440) * *(s32 *)0x8013D8F8) >> 7, arg5);
    }
}

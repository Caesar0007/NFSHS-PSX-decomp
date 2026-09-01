/* NFS4-R-UK-SW CHANGED @8008A304 | base 800898DC Car_DoPostCollisionStuff__FP8Car_tObj */
? func_8006D174(void *);                            /* extern */
? func_80087560(void *);                            /* extern */
? func_8008A1F4(void *);                            /* extern */
s32 func_800E4F00(s32, s32);                        /* extern */

void func_8008A304(void *arg0) {
    s32 temp_a0;
    s32 temp_a0_3;
    s32 temp_a0_4;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 temp_v1;
    s32 temp_v1_2;
    s32 temp_v1_3;
    s32 temp_v1_4;
    s32 temp_v1_5;
    s32 var_a0;
    s32 var_a0_2;
    s32 var_s1;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v0_3;
    s32 var_v0_4;
    s32 var_v0_5;
    u32 temp_a0_2;
    u32 var_v0_6;

    temp_v0 = arg0->unk190;
    arg0->unk794 = 0;
    if (temp_v0 != 0) {
        arg0->unk1B4 = temp_v0;
        temp_v1 = arg0->unk194;
        arg0->unk1B8 = (s32) *(s32 *)0x8011F394;
        if (temp_v1 != 0) {
            arg0->unk1B0 = temp_v1;
        } else {
            arg0->unk1B0 = 0;
        }
    }
    if ((arg0->unk90 != 0) || (arg0->unk91 == 0)) {
        arg0->unk848 = 0;
        arg0->unk84C = 0;
        arg0->unk858 = (s32) -arg0->unk464->unk154;
        func_80087560(arg0);
        return;
    }
    func_8006D174(arg0);
    func_80087560(arg0);
    func_8008A1F4(arg0);
    if (!(arg0->unk260 & 4) || (arg0->unk17C != 0)) {
        arg0->unk850 = (s32) ((s32) ((arg0->unk850 * 0xF) + arg0->unk414) >> 4);
        var_v0 = (s32) ((arg0->unk854 * 0xF) + arg0->unk40C) >> 4;
    } else {
        arg0->unk850 = (s32) ((s32) ((arg0->unk850 * 7) + arg0->unk414) >> 3);
        var_v0 = (s32) ((arg0->unk854 * 7) + arg0->unk40C) >> 3;
    }
    arg0->unk854 = var_v0;
    var_a0 = 0x140000;
    if (arg0->unk288->unk0 != 0x1C) {
        temp_v1_2 = arg0->unk854;
        if ((temp_v1_2 > 0x140000) || (var_a0 = -0x140000, ((temp_v1_2 < 0xFFEC0000) != 0))) {
            arg0->unk854 = var_a0;
        }
        temp_v1_3 = arg0->unk850;
        var_a0_2 = 0xA0000;
        if ((temp_v1_3 > 0xA0000) || (var_a0_2 = -0xA0000, ((temp_v1_3 < 0xFFF60000) != 0))) {
            arg0->unk850 = var_a0_2;
        }
    }
    temp_a0 = -arg0->unk184;
    var_v0_2 = temp_a0;
    if (temp_a0 < 0) {
        var_v0_2 = temp_a0 + 0x1F;
    }
    temp_v1_4 = var_v0_2 >> 5;
    var_v0_3 = temp_v1_4 < -0xA3C;
    if (temp_v1_4 >= 0x51F) {
        var_v0_3 = 0x51E < -0xA3C;
    }
    var_s1 = -0xA3D;
    if (var_v0_3 == 0) {
        var_v0_4 = temp_a0;
        if (temp_a0 < 0) {
            var_v0_4 = temp_a0 + 0x1F;
        }
        temp_v1_5 = var_v0_4 >> 5;
        var_s1 = 0x51E;
        if (temp_v1_5 < 0x51F) {
            var_s1 = temp_v1_5;
        }
    }
    temp_a0_2 = arg0->unk854 * 3;
    var_v0_5 = func_800E4F00((s32) (temp_a0_2 + (temp_a0_2 >> 0x1F)) >> 1, arg0->unk464->unk14C);
    if (var_v0_5 < 0) {
        var_v0_5 = -var_v0_5;
    }
    temp_a0_3 = arg0->unk854;
    arg0->unk84C = temp_a0_3;
    arg0->unk858 = (s32) ((var_s1 - var_v0_5) - arg0->unk464->unk154);
    arg0->unk84C = func_800E4F00(temp_a0_3, arg0->unk860);
    temp_a0_4 = -arg0->unk850;
    arg0->unk848 = temp_a0_4;
    temp_v0_2 = func_800E4F00(temp_a0_4, arg0->unk85C);
    arg0->unk848 = temp_v0_2;
    var_v0_6 = (u32) temp_v0_2 >> 0x1F;
    if ((arg0->unk288->unk40 == 1) || (var_v0_6 = (u32) temp_v0_2 >> 0x1F, ((arg0->unk260 & 4) == 0))) {
        arg0->unk848 = (s32) ((s32) (temp_v0_2 + var_v0_6) >> 1);
        arg0->unk84C = (s32) ((s32) arg0->unk84C / 2);
    }
}

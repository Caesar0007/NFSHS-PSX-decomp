/* NFS4-R-AU CHANGED @80085A2C | base 80085008 Camera_GetViewInfo__FiP17DRender_tCalcViewi */
/* callers: Camera_SetCamera__FP13DRender_tView */
? func_800804E8(void *, s32, ?);                    /* extern */
? func_80084698();                                  /* extern */
? func_800848BC(s32, void *);                       /* extern */
? func_80085230(s32, void *);                       /* extern */
? func_800852BC(s32, s32, void *, s32, s32);        /* extern */
? func_80085658(s32, void *, ?);                    /* extern */
s32 func_800E4F00(s32, ?);                          /* extern */
? func_800E4F30(void *, s32 *);                     /* extern */
? func_800EB820(s32 *, s32 *, void *);              /* extern */

void func_80085A2C(s32 arg0, void *arg1) {
    s32 sp18;
    s32 sp1C;
    s32 sp20;
    ? var_a2;
    s32 *temp_s1;
    s32 *var_a0;
    s32 *var_s0;
    s32 *var_v0;
    s32 *var_v1;
    s32 temp_s0_2;
    s32 temp_s0_3;
    s32 temp_s2;
    s32 temp_s2_3;
    s32 temp_v0;
    s32 temp_v0_2;
    void *temp_s0;
    void *temp_s2_2;

    temp_s2 = arg0 * 0x110;
    temp_s0 = temp_s2 + 0x8011059C;
    if (((u32) temp_s0->unk74 >> 2) & 1) {
        func_80084698();
    }
    arg1->unk0 = (s32) temp_s0->unk8;
    arg1->unk4 = (s32) temp_s0->unkC;
    arg1->unk8 = (s32) temp_s0->unk10;
    if (((u32) temp_s0->unk74 >> 4) & 1) {
        func_800848BC(arg0, arg1);
    }
    func_800804E8(arg1, temp_s2 + 0x80110628, 1);
    if ((temp_s0->unkE6 == 0) && (temp_s0->unk70 >= 2)) {
        func_80085230(arg0, arg1);
    }
    temp_s0_2 = arg0 * 0x110;
    temp_s2_2 = temp_s0_2 + 0x8011059C;
    if (((u32) temp_s2_2->unk74 >> 3) & 1) {
        func_800852BC(arg0, 0, arg1, temp_s0_2 + 0x801105CC, 1);
    }
    if (temp_s2_2->unk70 == 0x10) {
        func_800852BC(arg0, (arg0 * 0xC) + 0x8013F324, arg1, temp_s0_2 + 0x801105CC, 1);
    }
    var_a0 = arg1 + 0xC;
    if (!(((u32) temp_s2_2->unk74 >> 5) & 1)) {
        if (*(0x8013E534 + (arg0 * 4)) != 0) {
            var_a2 = 0;
        } else {
            var_a2 = 1;
        }
        func_80085658(arg0, arg1, var_a2);
        var_a0 = arg1 + 0xC;
    }
    temp_v0 = (arg0 * 0x110) + 0x8011059C;
    var_v1 = temp_v0 + 0x30;
    do {
        var_a0->unk0 = var_v1->unk0;
        var_a0->unk4 = (s32) var_v1->unk4;
        var_a0->unk8 = (s32) var_v1->unk8;
        var_a0->unkC = (s32) var_v1->unkC;
        var_v1 += 0x10;
        var_a0 += 0x10;
    } while (var_v1 != (temp_v0 + 0x50));
    *var_a0 = *var_v1;
    if (*(s32 *)0x801144FC != 0) {
        arg1->unkC = (s32) -arg1->unkC;
        arg1->unk14 = (s32) -arg1->unk14;
        arg1->unk10 = (s32) -arg1->unk10;
    }
    var_s0 = arg1 + 0x3C;
    func_800E4F30(arg1 + 0xC, var_s0);
    var_v0 = arg1 + 0x60;
    do {
        var_v0->unk0 = var_s0->unk0;
        var_v0->unk4 = (s32) var_s0->unk4;
        var_v0->unk8 = (s32) var_s0->unk8;
        var_v0->unkC = (s32) var_s0->unkC;
        var_s0 += 0x10;
        var_v0 += 0x10;
    } while (var_s0 != (arg1 + 0x5C));
    *var_v0 = *var_s0;
    temp_s2_3 = func_800E4F00(arg1->unk18, 0x11599);
    temp_s0_3 = func_800E4F00(arg1->unk1C, 0x11599);
    temp_v0_2 = func_800E4F00(arg1->unk20, 0x11599);
    temp_s1 = arg1 + 0x3C;
    arg1->unk18 = temp_s2_3;
    arg1->unk1C = temp_s0_3;
    arg1->unk20 = temp_v0_2;
    func_800E4F30(arg1 + 0xC, temp_s1);
    sp18 = -arg1->unk0;
    sp1C = -arg1->unk4;
    sp20 = -arg1->unk8;
    func_800EB820(&sp18, temp_s1, arg1 + 0x30);
}

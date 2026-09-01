/* NFS4-R-AU CHANGED @800D280C | base 800D1A80 Hud_CreateHudViews__Fv */
/* callers: Render_CreateViews__Fv */
s32 func_800BE8AC(?, s32, ?, s32, s32, s32, s32, s32, s32); /* extern */
? func_800D45EC();                                  /* extern */

void func_800D280C(void) {
    s32 temp_a0;
    s32 temp_a1;
    s32 temp_a1_2;
    s32 temp_a1_3;
    s32 temp_v1;
    s32 var_v1;
    void *var_a0;

    func_800D45EC();
    temp_a0 = (void *)0x801144D0->unk3C4;
    saved_reg_gp->unk13E0 = 0;
    var_v1 = 0;
    if (temp_a0 > 0) {
        var_a0 = (void *)0x801144D0;
        do {
            if (var_a0->unk3D8 & 0x40) {
                saved_reg_gp->unk13E0 = 1;
            }
            var_v1 += 1;
            var_a0 += 0xB4;
        } while (var_v1 < temp_a0);
    }
    temp_v1 = (void *)0x801144D0->unk3C8;
    if (temp_v1 >= 2) {
        saved_reg_gp->unk1410 = -6;
    } else if (((temp_v1 + (void *)0x801144D0->unk3CC) == 1) || (saved_reg_gp->unk13E0 != 0)) {
        saved_reg_gp->unk1410 = 8;
    } else {
        saved_reg_gp->unk1410 = 0;
    }
    if (*(s32 *)0x801144DC == 1) {
        temp_a1 = saved_reg_gp->unk1410 + 0x146;
        saved_reg_gp->unk13FC = func_800BE8AC(0x105, temp_a1, 0x245, temp_a1, 0x2D, 0x30, 0, 0, 1);
        temp_a1_2 = saved_reg_gp->unk1410 + 0x1B9;
        saved_reg_gp->unk1400 = func_800BE8AC(0x105, temp_a1_2, 0x245, temp_a1_2, 0x2D, 0x30, 0, 0, 1);
        saved_reg_gp->unk13F4 = func_800BE8AC(0, 0x100, 0x140, 0x100, 0x140, 0x80, 0, 0, 1);
        saved_reg_gp->unk13F8 = func_800BE8AC(0, 0x180, 0x140, 0x180, 0x140, 0x80, 0, 0, 1);
        saved_reg_gp->unk1404 = func_800BE8AC(0x115, 0x113, 0x255, 0x113, 0x1C, 0x1C, 0, 0, 1);
        saved_reg_gp->unk1408 = func_800BE8AC(0x115, 0x184, 0x255, 0x184, 0x1C, 0x1C, 0, 0, 1);
    } else {
        temp_a1_3 = saved_reg_gp->unk1410 + 0x1B4;
        saved_reg_gp->unk13FC = func_800BE8AC(0xFF, temp_a1_3, 0x23F, temp_a1_3, 0x2D, 0x30, 0, 0, 1);
        saved_reg_gp->unk13F4 = func_800BE8AC(0, 0x100, 0x140, 0x100, 0x140, 0x100, 0, 0, 1);
        saved_reg_gp->unk1404 = func_800BE8AC(0xB8, 0x115, 0x1F8, 0x115, 0x1C, 0x1C, 0, 0, 1);
    }
    saved_reg_gp->unk140C = func_800BE8AC(0, 0x100, 0x140, 0x100, 0x140, 0x100, 0, 0, 1);
}

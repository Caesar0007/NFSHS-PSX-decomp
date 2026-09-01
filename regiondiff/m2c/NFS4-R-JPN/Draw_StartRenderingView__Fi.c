/* NFS4-R-JPN CHANGED @800BEB98 | base 800BE060 Draw_StartRenderingView__Fi */
/* callers: Redraw__14tFEApplication, DisplayLoadingText__7tScreen, Render_StartRenderingWorldView__Fi, Render_RenderPauseMenuView__Fv, Hud_RenderMapView__Fv */
void func_800BEB98(s32 arg0) {
    s32 temp_a0;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 temp_v1;
    s32 var_a1;
    void *temp_a2;

    temp_v0 = arg0 * 0xC8;
    temp_a2 = temp_v0 + 0x8011FD30;
    temp_v0_2 = *(0x8011FD30 + temp_v0);
    var_a1 = temp_v0_2 * 7;
    saved_reg_gp->unk125C = temp_v0_2;
    if (var_a1 < 0) {
        var_a1 += 7;
    }
    *(u16 *)0x1F800010 = temp_a2->unkC;
    *(u16 *)0x1F800012 = temp_a2->unkE;
    saved_reg_gp->unk1268 = (s32) (var_a1 >> 3);
    *(u16 *)0x1F800000 = (s32) (temp_a2 + (saved_reg_gp->unk1260 * 4))->unkC0;
    if (*(s32 *)0x8013E3F4 != 0) {
        *(u16 *)0x1F800008 = (s32) (*(u16 *)0x1F800004 + temp_a2->unk4);
    } else {
        temp_a0 = saved_reg_gp->unk126C - 0x1A0;
        if ((*(s32 *)0x8011429C == 1) && (arg0 == *(s32 *)0x8013E49C)) {
            temp_v1 = *(u16 *)0x1F800004;
            *(u16 *)0x1F800008 = (s32) (temp_v1 + ((s32) (temp_a0 - temp_v1) >> 1));
        } else {
            *(u16 *)0x1F800008 = temp_a0;
        }
    }
    *(u16 *)0x1F80000C = 0;
}

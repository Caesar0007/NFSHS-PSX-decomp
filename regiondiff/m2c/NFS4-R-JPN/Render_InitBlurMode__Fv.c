/* NFS4-R-JPN CHANGED @800B4488 | base 800B3A04 Render_InitBlurMode__Fv */
/* callers: Render_InitTrackRender__Fv */
void func_800B4488(void) {
    s32 temp_v1;

    temp_v1 = *(s32 *)0x801142C8;
    saved_reg_gp->unkE70 = 0;
    switch (temp_v1) {                              /* irregular */
    case 0x10:
        saved_reg_gp->unkE70 = 0xB;
        return;
    case 0x20:
        saved_reg_gp->unkE70 = 0x1B;
        return;
    case 0x40:
        saved_reg_gp->unkE70 = 0x1F;
        return;
    }
}

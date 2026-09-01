/* NFS4-R-UK-ES-IT CHANGED @800B3D78 | base 800B30AC Render_CreatePlayerViews__Fv */
/* callers: Render_CreateViews__Fv */
s32 func_800BE8AC(?, ?, ?, ?, s32, s32, s32, s32, s32); /* extern */

void func_800B3D78(void) {
    s32 var_v0;

    if (*(s32 *)0x801144DC == 1) {
        saved_reg_gp->unkE74 = func_800BE8AC(0, 0x100, 0x140, 0x100, 0x140, 0x80, 0, 1, 0x7D0);
        var_v0 = func_800BE8AC(0, 0x180, 0x140, 0x180, 0x140, 0x80, 0, 1, 0x7D0);
    } else {
        saved_reg_gp->unkE74 = func_800BE8AC(0, 0x100, 0x140, 0x100, 0x140, 0x100, 0, 1, 0xBB8);
        var_v0 = -1;
    }
    saved_reg_gp->unkE78 = var_v0;
}

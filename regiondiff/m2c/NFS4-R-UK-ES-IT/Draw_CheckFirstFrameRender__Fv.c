/* NFS4-R-UK-ES-IT CHANGED @800BEFB8 | base 800BE230 Draw_CheckFirstFrameRender__Fv */
/* callers: Render_StartFrameRender__Fv */
? func_800BEC50();                                  /* extern */
? func_800BF200(?, ?, ?, ?, s32, s32, s32, s32, s32, s32); /* extern */

void func_800BEFB8(void) {
    if (saved_reg_gp->unk1260 == -1) {
        func_800BF200(0x140, 0x100, 0x140, 0x100, 1, 0, 1, 0, 0, 0);
        func_800BF200(0, 0x100, 0x140, 0x100, 1, 1, 1, 0, 0, 0);
        saved_reg_gp->unk1260 = 1;
        func_800BEC50();
    }
}

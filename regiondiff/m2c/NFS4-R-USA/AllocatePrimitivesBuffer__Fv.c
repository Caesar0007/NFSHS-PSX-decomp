/* NFS4-R-USA CHANGED @800BEC4C | base 800BDE60 AllocatePrimitivesBuffer__Fv */
/* callers: Draw_CheckFirstFrameRender__Fv */
? func_800BE9C8();                                  /* extern */
? func_800BEA4C();                                  /* extern */
s32 func_800DCEE4(s32, ?);                          /* extern */

void func_800BEC4C(void) {
    s32 var_v0;

    if (*(s32 *)0x801144B0 == 1) {
        func_800BE9C8();
    } else {
        func_800BEA4C();
    }
    if (*(void *)0x801144B0 == 1) {
        var_v0 = 0x228E8;
    } else {
        var_v0 = 0x1F9E8;
    }
    saved_reg_gp->unk1270 = var_v0;
    (void *)0x80120714->unk14 = func_800DCEE4(saved_reg_gp->unk1270, 0x8013EA88);
    (void *)0x80120714->unk2C = func_800DCEE4(saved_reg_gp->unk1270, 0x8013EA8C);
}

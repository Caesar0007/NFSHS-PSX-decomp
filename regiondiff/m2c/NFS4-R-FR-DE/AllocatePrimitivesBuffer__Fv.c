/* NFS4-R-FR-DE CHANGED @800BEC50 | base 800BDE60 AllocatePrimitivesBuffer__Fv */
/* callers: Draw_CheckFirstFrameRender__Fv */
? func_800BE9CC();                                  /* extern */
? func_800BEA50();                                  /* extern */
s32 func_800DCF10(s32, ?);                          /* extern */

void func_800BEC50(void) {
    s32 var_v0;

    if (*(s32 *)0x801144DC == 1) {
        func_800BE9CC();
    } else {
        func_800BEA50();
    }
    if (*(void *)0x801144DC == 1) {
        var_v0 = 0x228E8;
    } else {
        var_v0 = 0x1F9E8;
    }
    saved_reg_gp->unk1270 = var_v0;
    (void *)0x80120740->unk14 = func_800DCF10(saved_reg_gp->unk1270, 0x8013EAB4);
    (void *)0x80120740->unk2C = func_800DCF10(saved_reg_gp->unk1270, 0x8013EAB8);
}

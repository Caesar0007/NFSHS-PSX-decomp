/* NFS4-R-JPN CHANGED @800BEA38 | base 800BDE60 AllocatePrimitivesBuffer__Fv */
/* callers: Draw_CheckFirstFrameRender__Fv */
? func_800BE7B4();                                  /* extern */
? func_800BE838();                                  /* extern */
s32 func_800DCCD0(s32, ?);                          /* extern */

void func_800BEA38(void) {
    s32 var_v0;

    if (*(s32 *)0x8011429C == 1) {
        func_800BE7B4();
    } else {
        func_800BE838();
    }
    if (*(void *)0x8011429C == 1) {
        var_v0 = 0x228E8;
    } else {
        var_v0 = 0x1F9E8;
    }
    saved_reg_gp->unk1270 = var_v0;
    (void *)0x80120500->unk14 = func_800DCCD0(saved_reg_gp->unk1270, 0x8013E874);
    (void *)0x80120500->unk2C = func_800DCCD0(saved_reg_gp->unk1270, 0x8013E878);
}

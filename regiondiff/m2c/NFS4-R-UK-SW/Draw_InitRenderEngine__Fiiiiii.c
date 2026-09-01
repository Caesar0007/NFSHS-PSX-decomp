/* NFS4-R-UK-SW CHANGED @800BF370 | base 800BE5D8 Draw_InitRenderEngine__Fiiiiii */
/* callers: Render_InitTrackRender__Fv */
? func_800BF0E8(?);                                 /* extern */
? func_800F2C68(void *, s32, ?, s32, s32);          /* extern */

void func_800BF370(s32 arg0, ? arg1, s32 arg2, ? arg3, s32 arg4, s32 arg5) {
    saved_reg_gp->unk1260 = -1;
    (void *)0x80120740->unk14 = 0;
    (void *)0x80120740->unk2C = 0;
    func_800F2C68((void *)0x80120740, arg0, arg1, arg4, arg5);
    func_800F2C68((void *)0x80120740 + 0x18, arg2, arg3, arg4, arg5);
    (void *)0x80120740->unk22 = 0x15;
    (void *)0x80120740->unkA = 0x15;
    (void *)0x80120740->unk26 = 0x100;
    (void *)0x80120740->unkE = 0x100;
    func_800BF0E8(0);
}

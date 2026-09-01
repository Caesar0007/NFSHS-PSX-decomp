/* NFS4-R-USA CHANGED @800B3F80 | base 800B32B8 Render_RenderWorld__FP13DRender_tView */
/* callers: Render_RenderPlayerView__Fii */
? func_8007EAF0();                                  /* extern */
? func_800B38C0(s32);                               /* extern */
? func_800B4740();                                  /* extern */
? func_800B8ABC(s32);                               /* extern */
? func_800D207C(s32);                               /* extern */
? func_800E0070(s32);                               /* extern */
? func_800E493C(s32);                               /* extern */
s32 func_800E5098(s32);                             /* extern */

void func_800B3F80(s32 arg0) {
    s32 temp_s1;
    s32 temp_s1_2;
    s32 temp_s1_3;

    func_8007EAF0();
    func_800D207C(arg0);
    temp_s1 = func_800E5098(0x1F8003FC);
    func_800E493C(arg0);
    func_800E5098(temp_s1);
    func_800B4740();
    temp_s1_2 = func_800E5098(0x1F8003FC);
    func_800E0070(arg0);
    func_800E5098(temp_s1_2);
    temp_s1_3 = func_800E5098(0x1F8003FC);
    func_800B8ABC(arg0);
    func_800E5098(temp_s1_3);
    func_800B38C0(arg0);
}

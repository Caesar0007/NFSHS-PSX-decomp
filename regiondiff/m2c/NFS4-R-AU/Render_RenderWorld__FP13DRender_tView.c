/* NFS4-R-AU CHANGED @800B3F84 | base 800B32B8 Render_RenderWorld__FP13DRender_tView */
/* callers: Render_RenderPlayerView__Fii */
? func_8007EAF0();                                  /* extern */
? func_800B38C4(s32);                               /* extern */
? func_800B4744();                                  /* extern */
? func_800B8AC0(s32);                               /* extern */
? func_800D20A8(s32);                               /* extern */
? func_800E009C(s32);                               /* extern */
? func_800E4928(s32);                               /* extern */
s32 func_800E5084(s32);                             /* extern */

void func_800B3F84(s32 arg0) {
    s32 temp_s1;
    s32 temp_s1_2;
    s32 temp_s1_3;

    func_8007EAF0();
    func_800D20A8(arg0);
    temp_s1 = func_800E5084(0x1F8003FC);
    func_800E4928(arg0);
    func_800E5084(temp_s1);
    func_800B4744();
    temp_s1_2 = func_800E5084(0x1F8003FC);
    func_800E009C(arg0);
    func_800E5084(temp_s1_2);
    temp_s1_3 = func_800E5084(0x1F8003FC);
    func_800B8AC0(arg0);
    func_800E5084(temp_s1_3);
    func_800B38C4(arg0);
}

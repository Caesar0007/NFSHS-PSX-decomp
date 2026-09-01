/* NFS4-R-JPN CHANGED @800B3D34 | base 800B32B8 Render_RenderWorld__FP13DRender_tView */
/* callers: Render_RenderPlayerView__Fii */
? func_8007EAF0();                                  /* extern */
? func_800B3674(s32);                               /* extern */
? func_800B44F4();                                  /* extern */
? func_800B8870(s32);                               /* extern */
? func_800D1E68(s32);                               /* extern */
? func_800DFE5C(s32);                               /* extern */
? func_800E4728(s32);                               /* extern */
s32 func_800E4E84(s32);                             /* extern */

void func_800B3D34(s32 arg0) {
    s32 temp_s1;
    s32 temp_s1_2;
    s32 temp_s1_3;

    func_8007EAF0();
    func_800D1E68(arg0);
    temp_s1 = func_800E4E84(0x1F8003FC);
    func_800E4728(arg0);
    func_800E4E84(temp_s1);
    func_800B44F4();
    temp_s1_2 = func_800E4E84(0x1F8003FC);
    func_800DFE5C(arg0);
    func_800E4E84(temp_s1_2);
    temp_s1_3 = func_800E4E84(0x1F8003FC);
    func_800B8870(arg0);
    func_800E4E84(temp_s1_3);
    func_800B3674(arg0);
}

/* NFS4-R-USA CHANGED @800C7BC8 | base 800C6E38 DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache */
/* callers: DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry, DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry, DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry, DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry, DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis */
? func_800C7288(void *, s32);                       /* extern */

void func_800C7BC8(void *arg0) {
    s32 var_s0;
    s32 var_s1;

    var_s1 = arg0->unkE8;
    var_s0 = arg0->unkE7 - 1;
    if (var_s0 != -1) {
        do {
            func_800C7288(arg0, var_s1);
            var_s0 -= 1;
            var_s1 += 6;
        } while (var_s0 != -1);
    }
}

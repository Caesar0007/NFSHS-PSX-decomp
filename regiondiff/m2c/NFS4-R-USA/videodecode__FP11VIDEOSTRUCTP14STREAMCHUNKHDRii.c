/* NFS4-R-USA CHANGED @80051698 | base 800511B0 videodecode__FP11VIDEOSTRUCTP14STREAMCHUNKHDRii */
/* callers: VIDEO_updateframexy__Fiii */
? func_80050F90();                                  /* extern */
? func_80050FD4(s32, void *);                       /* extern */
s32 func_800510EC(s32);                             /* extern */
? func_800E77F0(?);                                 /* extern */

s32 func_80051698(void *arg0, void *arg1) {
    s32 temp_s1;
    s32 var_v0;

    if (arg1->unk0 == 0x4443546D) {
        arg0->unk34 = (s32) arg1->unkC;
        arg0->unk38 = (s32) arg1->unkE;
        func_80050FD4(arg0->unk10, arg1 + 8);
        temp_s1 = *(s32 *)0x8013EF8C + (*(s32 *)0x8013EFA4 * 4);
loop_2:
        var_v0 = 1;
        if (func_800510EC(arg0->unk10) == 0) {
            func_800E77F0(0);
            if (temp_s1 < *(void *)0x8013EF8C) {
                func_80050F90();
                goto block_5;
            }
            goto loop_2;
        }
    } else {
block_5:
        var_v0 = 0;
    }
    return var_v0;
}

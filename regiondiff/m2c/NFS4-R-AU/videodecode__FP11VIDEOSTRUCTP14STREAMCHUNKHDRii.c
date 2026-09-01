/* NFS4-R-AU CHANGED @80051750 | base 800511B0 videodecode__FP11VIDEOSTRUCTP14STREAMCHUNKHDRii */
/* callers: VIDEO_updateframexy__Fiii */
? func_80051048();                                  /* extern */
? func_8005108C(s32, void *);                       /* extern */
s32 func_800511A4(s32);                             /* extern */
? func_800E77DC(?);                                 /* extern */

s32 func_80051750(void *arg0, void *arg1) {
    s32 temp_s1;
    s32 var_v0;

    if (arg1->unk0 == 0x4443546D) {
        arg0->unk34 = (s32) arg1->unkC;
        arg0->unk38 = (s32) arg1->unkE;
        func_8005108C(arg0->unk10, arg1 + 8);
        temp_s1 = *(s32 *)0x8013EFB8 + (*(s32 *)0x8013EFD0 * 4);
loop_2:
        var_v0 = 1;
        if (func_800511A4(arg0->unk10) == 0) {
            func_800E77DC(0);
            if (temp_s1 < *(void *)0x8013EFB8) {
                func_80051048();
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

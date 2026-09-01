/* NFS4-R-AU CHANGED @80077174 | base 8007675C AudioCmn_LoadAsyncSfx__FiiPvi */
/* callers: CopSpeak_ReadyNextRequest__Fv, CopSpeak_ReadyNextRequest__Fv, CopSpeak_ReadyNextRequest__Fv, CopSpeak_ReadyNextRequest__Fv, CopSpeak_Skip__Fv */
s32 func_8007708C(s32);                             /* extern */
s32 func_800E5F14(?, s32, ?);                       /* extern */
? func_800E724C(s32);                               /* extern */
s32 func_800E873C(s32);                             /* extern */
? func_800E8780(s32, s32);                          /* extern */
s32 func_800E88C4(s32 *);                           /* extern */
s32 func_800E89C4(void *, ?);                       /* extern */
? func_800E8CA4(?);                                 /* extern */

void func_80077174(s32 arg0, s32 arg1, ? arg2, s32 arg3) {
    s32 sp10;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 var_v1;
    void *var_s0;

    var_v1 = 0;
    var_s0 = (void *)0x8010FE24;
loop_1:
    if ((arg1 == var_s0->unk4) && (arg0 == var_s0->unk0) && (var_s0->unk8 == -1)) {
        if (arg3 != 0) {
loop_5:
            if ((func_800E88C4(&sp10) - 0x1000) < arg3) {
                if (func_8007708C(arg0) == -1) {
                    var_s0->unk8 = -1;
                    goto block_16;
                }
                goto loop_5;
            }
            temp_v0 = func_800E89C4(var_s0 + 8, arg2);
            sp10 = temp_v0;
            if (temp_v0 == 7) {
                temp_v0_2 = func_800E5F14(0x8013D99C, func_800E873C(var_s0->unk8), 0x10);
                var_s0->unk14 = temp_v0_2;
                if (temp_v0_2 != 0) {
                    func_800E8780(temp_v0_2, var_s0->unk8);
                    var_s0->unk4 = arg1;
                    var_s0->unkC = (s32) (void *)0x8011F390->unk4;
                    return;
                }
            }
            if (arg0 == 2) {
                func_800E8CA4(0x80055EA0);
            }
            func_800E873C(var_s0->unk8);
            if (sp10 >= 0) {
                func_800E724C(var_s0->unk8);
            }
            goto block_15;
        }
block_15:
        var_s0->unk8 = -1;
block_16:
        var_s0->unk4 = -1;
        return;
    }
    var_v1 += 1;
    var_s0 += 0x18;
    if (var_v1 >= 0x20) {
        return;
    }
    goto loop_1;
}

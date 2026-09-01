/* NFS4-R-JPN CHANGED @8009A790 | base 80099BEC CopSpeak_DirectRequest__FillP8Car_tObjPc */
/* callers: SubmitRequest__6Speechlll */
? func_8009A0D0(void *);                            /* extern */

void func_8009A790(s32 arg0, s32 arg1, s32 arg2, s32 arg3) {
    s32 temp_a0;
    s32 temp_v0;
    s32 var_s1;
    void *temp_s0;

    temp_a0 = saved_reg_gp->unkB60;
    if (((temp_a0 - (saved_reg_gp->unkB70 - 0x40)) & 0x3F) < 0x21) {
        temp_v0 = temp_a0 << 5;
        temp_s0 = temp_v0 + 0x80112FD4;
        var_s1 = 0;
        if (temp_a0 < 0x3F) {
            var_s1 = temp_a0 + 1;
        }
        if (var_s1 != saved_reg_gp->unkB64) {
            func_8009A0D0(temp_s0);
            temp_s0->unk10 = arg0;
            temp_s0->unk8 = arg1;
            temp_s0->unkC = arg2;
            temp_s0->unk1F = 0x7F;
            *(0x80112FD4 + temp_v0) = arg3;
            saved_reg_gp->unkB60 = var_s1;
        }
    }
}

/* NFS4-R-AU CHANGED @8009A858 | base 80099C98 CopSpeak_GenericBankRequest__FiP8Car_tObj */
/* callers: SubmitRequest__6Speechlll */
? func_8009A0D4(void *);                            /* extern */

void func_8009A858(s32 arg0, s32 arg1) {
    s32 temp_a0;
    s32 temp_v0;
    s32 var_s1;
    void *temp_s0;

    temp_a0 = saved_reg_gp->unkB60;
    if (((temp_a0 - (saved_reg_gp->unkB70 - 0x40)) & 0x3F) < 0x21) {
        temp_v0 = temp_a0 << 5;
        temp_s0 = temp_v0 + 0x80113214;
        var_s1 = 0;
        if (temp_a0 < 0x3F) {
            var_s1 = temp_a0 + 1;
        }
        if ((var_s1 != saved_reg_gp->unkB64) && (var_s1 != saved_reg_gp->unkB74)) {
            func_8009A0D4(temp_s0);
            temp_s0->unk1E = 3;
            temp_s0->unk18 = arg0;
            temp_s0->unk1F = 0x7F;
            *(0x80113214 + temp_v0) = arg1;
            saved_reg_gp->unkB60 = var_s1;
        }
    }
}

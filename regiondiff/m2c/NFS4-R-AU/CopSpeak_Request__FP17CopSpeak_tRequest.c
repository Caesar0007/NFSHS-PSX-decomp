/* NFS4-R-AU CHANGED @8009B0A0 | base 8009A4C8 CopSpeak_Request__FP17CopSpeak_tRequest */
/* callers: AudioCmn_GetAsyncSfx__Fiib, AudioCmn_CheckState__FP8Car_tObj, AudioCmn_CheckState__FP8Car_tObj, AudioCmn_CheckState__FP8Car_tObj, AudioCmn_CheckState__FP8Car_tObj */
s32 func_8009B0A0(void *arg0) {
    s32 temp_a1_2;
    s32 temp_a3;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 temp_v0_3;
    s32 temp_v1;
    s32 var_a2;
    s32 var_v1;
    void *temp_a1;
    void *temp_v0_4;

    temp_a3 = saved_reg_gp->unkB60;
    if (((temp_a3 - (saved_reg_gp->unkB70 - 0x40)) & 0x3F) < 0x21) {
        var_v1 = 0;
        if (temp_a3 < 0x3F) {
            var_v1 = temp_a3 + 1;
        }
        if ((var_v1 == saved_reg_gp->unkB64) || (temp_v0 = arg0->unk1E * 0x10, temp_a1 = temp_v0 + 0x80113194, (temp_a1->unk4 == 0)) || (temp_a1->unk8 == 0) || (temp_v1 = arg0->unk18, (temp_v1 < 0)) || (temp_a1->unkC < temp_v1)) {
            /* Duplicate return node #8. Try simplifying control flow for better match */
            return -1;
        }
        arg0->unk10 = (s32) *(0x80113194 + temp_v0);
        arg0->unk8 = (s32) *((arg0->unk18 * 8) + temp_a1->unk8);
        temp_v0_2 = ((arg0->unk18 * 8) + temp_a1->unk8)->unk4;
        arg0->unkC = temp_v0_2;
        if (temp_v0_2 != 0) {
            temp_v0_3 = temp_a3 << 5;
            temp_a1_2 = saved_reg_gp->unkB60;
            temp_v0_4 = temp_v0_3 + 0x80113214;
            *(0x80113214 + temp_v0_3) = (s32) arg0->unk0;
            temp_v0_4->unk4 = (s32) arg0->unk4;
            temp_v0_4->unk8 = (s32) arg0->unk8;
            temp_v0_4->unkC = (s32) arg0->unkC;
            temp_v0_4->unk10 = (s32) arg0->unk10;
            temp_v0_4->unk14 = (s32) arg0->unk14;
            temp_v0_4->unk18 = (s32) arg0->unk18;
            temp_v0_4->unk1C = (s32) arg0->unk1C;
            var_a2 = 0;
            if (temp_a1_2 < 0x3F) {
                var_a2 = temp_a1_2 + 1;
            }
            saved_reg_gp->unkB60 = var_a2;
            return temp_a3;
        }
        /* Duplicate return node #8. Try simplifying control flow for better match */
        return -1;
    }
    return -1;
}

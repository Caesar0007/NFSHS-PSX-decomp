/* NFS4-R-FR-DE CHANGED @8009B43C | base 8009A828 CopSpeak_PlayNextRequest__Fv */
s32 func_80077300(s8, s32, ?, s32);                 /* extern */
? func_8009A0D4(void *);                            /* extern */
s32 func_8009AEDC(void *, s32);                     /* extern */

void func_8009B43C(void) {
    s32 temp_a0;
    s32 temp_a3;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 temp_v1;
    s32 var_a1;
    s32 var_v1;
    void *temp_s0;

    temp_v0 = saved_reg_gp->unkB64 << 5;
    temp_s0 = temp_v0 + 0x80113214;
    if ((temp_s0->unk1E >= 0) && (temp_s0->unk1D == 0) && ((*(s32 *)0x8013E704 < 2) || (*(s32 *)0x80118314 != 3))) {
        temp_v1 = saved_reg_gp->unkB68;
        if (temp_v1 == -1) {
            (void *)0x801131F4->unk0 = (s32) *(0x80113214 + temp_v0);
            (void *)0x801131F4->unk4 = (s32) temp_s0->unk4;
            (void *)0x801131F4->unk8 = (s32) temp_s0->unk8;
            (void *)0x801131F4->unkC = (s32) temp_s0->unkC;
            (void *)0x801131F4->unk10 = (s32) temp_s0->unk10;
            (void *)0x801131F4->unk14 = (s32) temp_s0->unk14;
            temp_a3 = temp_s0->unk18;
            (void *)0x801131F4->unk18 = temp_a3;
            (void *)0x801131F4->unk1C = (s32) temp_s0->unk1C;
            var_a1 = temp_s0->unk18;
            if (var_a1 == temp_v1) {
                var_a1 = temp_s0->unk8 + 0x4000;
            }
            temp_v0_2 = func_80077300(temp_s0->unk1E, var_a1, 1, temp_a3);
            if ((temp_v0_2 >= 0) || (temp_s0->unk1E == 3)) {
                saved_reg_gp->unkB68 = func_8009AEDC(temp_s0, temp_v0_2);
            }
            goto block_11;
        }
    } else {
block_11:
        func_8009A0D4(temp_s0);
        temp_a0 = saved_reg_gp->unkB64;
        var_v1 = 0;
        if (temp_a0 < 0x3F) {
            var_v1 = temp_a0 + 1;
        }
        saved_reg_gp->unkB64 = var_v1;
    }
}

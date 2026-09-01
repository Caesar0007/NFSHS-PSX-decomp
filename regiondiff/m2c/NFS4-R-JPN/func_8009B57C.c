/* NFS4-R-JPN REGION-ONLY @8009B57C */
/* callers: AudioClc_SoundSpeech__Fv, AudioCmn_Reset__Fv, AudioTrk_PreLoad__Fv */
? func_80077300(s8, s32, ?);                        /* extern */
? func_80099EF8(s32);                               /* extern */
? func_8009A068(void *);                            /* extern */
? func_8009A0D0(?);                                 /* extern */
? func_8009A29C();                                  /* extern */
? func_8009B21C();                                  /* extern */
? func_8009B438();                                  /* extern */
s32 func_800EDA80(s32);                             /* extern */

void func_8009B57C(void) {
    s32 temp_a1;
    s32 temp_a2;
    s32 temp_v0_2;
    s32 temp_v0_3;
    s32 temp_v1;
    s32 temp_v1_3;
    s32 temp_v1_4;
    s32 temp_v1_5;
    s32 var_a0_2;
    s32 var_a1;
    s32 var_a1_2;
    s32 var_s0;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v1;
    s8 temp_a0_2;
    void *temp_a0;
    void *temp_a0_3;
    void *temp_v0;
    void *temp_v1_2;
    void *var_a0;

    if (saved_reg_gp->unkB68 != -1) {
        var_a1 = (void *)0x80112FB4->unk18;
        if (var_a1 == -1) {
            var_a1 = (void *)0x80112FB4->unk8 + 0x4000;
        }
        func_80077300((void *)0x80112FB4->unk1E, var_a1, 1);
        if (func_800EDA80(saved_reg_gp->unkB68) < 5) {
            temp_v1 = saved_reg_gp->unkB64;
            if (temp_v1 != saved_reg_gp->unkB60) {
                temp_a0 = (temp_v1 << 5) + 0x80112FD4;
                if ((temp_a0->unk1E == 3) && (temp_a0->unk18 == 0x13) && ((void *)0x80112FB4->unk0 == 0)) {
                    temp_a0->unk18 = 0x14;
                }
            }
            saved_reg_gp->unkB68 = -1;
            func_8009A0D0(0x80112FB4);
        }
    }
    var_s0 = saved_reg_gp->unkB64;
    if (var_s0 != saved_reg_gp->unkB60) {
        var_v0 = var_s0 << 5;
        do {
            temp_v1_2 = var_v0 + 0x80112FD4;
            var_v0_2 = var_s0 < 0x3F;
            if (temp_v1_2->unk1D == 0) {
                temp_a0_2 = temp_v1_2->unk1E;
                var_v0_2 = var_s0 < 0x3F;
                if (temp_a0_2 != 3) {
                    if (temp_a0_2 >= 0) {
                        var_a1_2 = temp_v1_2->unk18;
                        if (var_a1_2 == -1) {
                            var_a1_2 = temp_v1_2->unk8 + 0x4000;
                        }
                        func_80077300(temp_a0_2, var_a1_2, 1);
                    }
                    var_v0_2 = var_s0 < 0x3F;
                }
            }
            var_v1 = 0;
            if (var_v0_2 != 0) {
                var_v1 = var_s0 + 1;
            }
            var_s0 = var_v1;
            var_v0 = var_s0 << 5;
        } while (var_s0 != saved_reg_gp->unkB60);
    }
    if (saved_reg_gp->unkB74 != saved_reg_gp->unkB70) {
        func_8009A29C();
    }
    var_a0 = NULL;
    if (saved_reg_gp->unkB68 != -1) {
        var_a0 = (void *)0x80112FB4;
    } else {
        temp_v1_3 = saved_reg_gp->unkB64;
        if ((temp_v1_3 != saved_reg_gp->unkB74) && (temp_v1_3 != saved_reg_gp->unkB60)) {
            var_a0 = (void *)0x80112FD4;
            if (temp_v1_3 < 0x3F) {
                var_a0 = ((temp_v1_3 + 1) << 5) + 0x80112FD4;
            }
        }
    }
    if ((var_a0 != NULL) && (var_a0->unk1F != 0)) {
        temp_v0 = var_a0->unk0;
        var_a0_2 = 0x30;
        if (temp_v0 != NULL) {
            temp_v1_4 = temp_v0->unk8E + 0x20;
            var_a0_2 = 0x7F;
            if (temp_v1_4 < 0x80) {
                var_a0_2 = temp_v1_4;
            }
        }
        func_80099EF8(var_a0_2);
    } else {
        func_8009A068(var_a0);
    }
    temp_a1 = saved_reg_gp->unkB74;
    if ((temp_a1 == saved_reg_gp->unkB60) || (temp_v0_2 = temp_a1 << 5, ((temp_v0_2 + 0x80112FD4)->unk1D != 0)) || (temp_a2 = saved_reg_gp->unkB64, temp_v0_3 = temp_a2 << 5, temp_a0_3 = temp_v0_3 + 0x80112FD4, (*(0x80112FD4 + temp_v0_2) != *(0x80112FD4 + temp_v0_3))) || (temp_a0_3->unk1E < 0) || (temp_a0_3->unk1D != 0) || (((temp_a1 - (temp_a2 - 0x40)) & 0x3F) >= 0x11)) {
        temp_v1_5 = saved_reg_gp->unkB64;
        if ((temp_v1_5 != saved_reg_gp->unkB74) && (temp_v1_5 != saved_reg_gp->unkB60)) {
            func_8009B438();
        }
    }
    func_8009B21C();
}

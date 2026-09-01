/* NFS4-R-FR-DE CHANGED @800E4490 | base 800E3858 Weather_DoSplats__FiP18Weather_tSplatInfo */
/* callers: Weather_DoWeather__FP13DRender_tView */
? func_800E4368(void *);                            /* extern */
s32 func_800E8380(s32);                             /* extern */

void func_800E4490(s32 arg0, void *arg1) {
    s32 temp_a0;
    s32 temp_a0_2;
    s32 temp_ret;
    s32 temp_v1;
    s32 var_s2;
    u32 var_v0;
    void *var_s0;

    if (saved_reg_gp->unk1644 < arg0) {
        saved_reg_gp->unk1644 = arg0;
    }
    var_s2 = 0;
    if (saved_reg_gp->unk1644 > 0) {
        var_s0 = arg1;
        do {
            temp_a0 = (void *)0x8011F390->unk4;
            temp_v1 = var_s0->unk4;
            if (temp_a0 >= temp_v1) {
                if ((temp_v1 + 0x20) < temp_a0) {
                    if ((arg0 < saved_reg_gp->unk1644) && (var_s2 == (saved_reg_gp->unk1644 - 1))) {
                        saved_reg_gp->unk1644 = var_s2;
                        var_s0 += 8;
                    } else {
                        temp_ret = func_800E8380(temp_a0);
                        temp_a0_2 = temp_ret / 320;
                        var_s0->unk0 = (s16) (temp_ret % 320);
                        if ((void *)0x801144D0->unkC == 1) {
                            var_v0 = (u32) (func_800E8380(temp_a0_2) & 0xFF) >> 1;
                        } else {
                            var_v0 = func_800E8380(temp_a0_2) & 0xFF;
                        }
                        var_s0->unk2 = (s16) var_v0;
                        var_s0->unk4 = (s32) ((void *)0x8011F390->unk4 + (func_800E8380() % 100));
                        goto block_14;
                    }
                } else {
                    func_800E4368(var_s0);
                    goto block_14;
                }
            } else {
block_14:
                var_s0 += 8;
            }
            var_s2 += 1;
        } while (var_s2 < saved_reg_gp->unk1644);
    }
}

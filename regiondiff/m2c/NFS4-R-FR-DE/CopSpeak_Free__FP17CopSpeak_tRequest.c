/* NFS4-R-FR-DE CHANGED @8009A1EC | base 8009971C CopSpeak_Free__FP17CopSpeak_tRequest */
/* callers: CopSpeak_ReadyNextRequest__Fv */
void func_8009A1EC(void *arg0) {
    s16 temp_v1;
    s32 temp_a1;
    s32 temp_v0;
    u16 temp_v0_2;

    temp_v0 = arg0->unk4;
    if ((temp_v0 >= 0) && (temp_a1 = arg0->unkC, (temp_a1 > 0))) {
        temp_v1 = saved_reg_gp->unkB8A;
        if (temp_v1 != 0) {
            if ((temp_v0 + temp_a1) != temp_v1) {
                temp_v0_2 = saved_reg_gp->unkB84 + (u16) arg0->unkC;
                saved_reg_gp->unkB84 = temp_v0_2;
                saved_reg_gp->unkB88 = temp_v0_2;
            } else {
                saved_reg_gp->unkB88 = 0x7FFCU;
                saved_reg_gp->unkB8A = 0;
                saved_reg_gp->unkB84 = 0U;
            }
            goto block_9;
        }
        if ((temp_v0 + temp_a1) == saved_reg_gp->unkB86) {
            saved_reg_gp->unkB86 = 0;
            saved_reg_gp->unkB84 = 0U;
            arg0->unk4 = -1;
            return;
        }
        saved_reg_gp->unkB84 = (u16) (saved_reg_gp->unkB84 + (u16) arg0->unkC);
block_9:
        arg0->unk4 = -1;
    }
}

/* NFS4-R-FR-DE CHANGED @8009A16C | base 80099684 CopSpeak_Alloc__FP17CopSpeak_tRequest */
/* callers: CopSpeak_LoadNextRequest__Fv */
void func_8009A16C(void *arg0) {
    s16 temp_a2;
    s16 temp_v1;
    s32 temp_a3;
    u16 temp_a1;

    temp_v1 = saved_reg_gp->unkB86;
    temp_a3 = arg0->unkC;
    temp_a1 = (u16) saved_reg_gp->unkB86;
    if ((saved_reg_gp->unkB88 - temp_v1) >= temp_a3) {
        arg0->unk4 = (s32) temp_v1;
        saved_reg_gp->unkB86 = (s16) (temp_a1 + (u16) arg0->unkC);
        return;
    }
    temp_a2 = saved_reg_gp->unkB84;
    if (temp_a2 < temp_v1) {
        if (temp_a2 >= temp_a3) {
            saved_reg_gp->unkB8A = temp_a1;
            saved_reg_gp->unkB88 = (s16) (u16) saved_reg_gp->unkB84;
            arg0->unk4 = 0;
            saved_reg_gp->unkB86 = (s16) (u16) arg0->unkC;
            return;
        }
        /* Duplicate return node #6. Try simplifying control flow for better match */
        arg0->unk4 = -1;
        return;
    }
    arg0->unk4 = -1;
}

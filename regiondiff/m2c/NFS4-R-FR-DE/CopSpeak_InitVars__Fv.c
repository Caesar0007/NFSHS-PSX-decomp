/* NFS4-R-FR-DE CHANGED @8009A714 | base 80099B70 CopSpeak_InitVars__Fv */
/* callers: CopSpeak_StartUp__Fv */
? func_8009A0D4(?);                                 /* extern */

void func_8009A714(void) {
    s32 var_a0;
    void *var_v1;

    var_a0 = 0;
    var_v1 = (void *)0x80113194;
    do {
        var_v1->unk4 = 0;
        var_v1->unk8 = 0;
        var_a0 += 1;
        var_v1 += 0x10;
    } while (var_a0 < 4);
    saved_reg_gp->unkB68 = -1;
    saved_reg_gp->unkB80 = 0;
    saved_reg_gp->unkB60 = 0;
    saved_reg_gp->unkB70 = 0;
    saved_reg_gp->unkB74 = 0;
    saved_reg_gp->unkB64 = 0;
    saved_reg_gp->unkB78 = 0;
    saved_reg_gp->unkB84 = 0;
    saved_reg_gp->unkB8A = 0;
    saved_reg_gp->unkB86 = 0;
    saved_reg_gp->unkB7C = 0;
    saved_reg_gp->unkB88 = 0x7FFC;
    func_8009A0D4(0x801131F4);
}

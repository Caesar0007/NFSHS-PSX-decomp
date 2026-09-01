/* NFS4-R-FR-DE REGION-ONLY @8009A5B0 */
/* callers: AudioCmn_Reset__Fv, AudioCmn_UnPauseAndRestart__Fv, CopSpeak_Stop__Fv */
? func_8009A06C();                                  /* extern */
? func_8009A0D4(?);                                 /* extern */
? func_8009A2A0();                                  /* extern */
? func_8009A560();                                  /* extern */
? func_800E77DC(?);                                 /* extern */
? func_800E8A58(s32);                               /* extern */

void func_8009A5B0(void) {
    s32 temp_a0;

    if (saved_reg_gp->unkB74 != saved_reg_gp->unkB70) {
        func_8009A560();
loop_3:
        if (saved_reg_gp->unkB74 != saved_reg_gp->unkB70) {
            func_8009A2A0();
            func_800E77DC(0);
            goto loop_3;
        }
    }
    temp_a0 = saved_reg_gp->unkB68;
    if (temp_a0 != -1) {
        func_800E8A58(temp_a0);
    }
    func_8009A06C();
    saved_reg_gp->unkB68 = -1;
    func_8009A0D4(0x801131F4);
    saved_reg_gp->unkB60 = 0;
    saved_reg_gp->unkB70 = 0;
    saved_reg_gp->unkB74 = 0;
    saved_reg_gp->unkB64 = 0;
    saved_reg_gp->unkB84 = 0;
    saved_reg_gp->unkB8A = 0;
    saved_reg_gp->unkB86 = 0;
    saved_reg_gp->unkB88 = 0x7FFC;
}

/* NFS4-R-USA REGION-ONLY @8009A5AC */
/* callers: AudioCmn_Reset__Fv, AudioCmn_UnPauseAndRestart__Fv, CopSpeak_Stop__Fv */
? func_8009A068();                                  /* extern */
? func_8009A0D0(?);                                 /* extern */
? func_8009A29C();                                  /* extern */
? func_8009A55C();                                  /* extern */
? func_800E77F0(?);                                 /* extern */
? func_800E8A6C(s32);                               /* extern */

void func_8009A5AC(void) {
    s32 temp_a0;

    if (saved_reg_gp->unkB74 != saved_reg_gp->unkB70) {
        func_8009A55C();
loop_3:
        if (saved_reg_gp->unkB74 != saved_reg_gp->unkB70) {
            func_8009A29C();
            func_800E77F0(0);
            goto loop_3;
        }
    }
    temp_a0 = saved_reg_gp->unkB68;
    if (temp_a0 != -1) {
        func_800E8A6C(temp_a0);
    }
    func_8009A068();
    saved_reg_gp->unkB68 = -1;
    func_8009A0D0(0x801131C8);
    saved_reg_gp->unkB60 = 0;
    saved_reg_gp->unkB70 = 0;
    saved_reg_gp->unkB74 = 0;
    saved_reg_gp->unkB64 = 0;
    saved_reg_gp->unkB84 = 0;
    saved_reg_gp->unkB8A = 0;
    saved_reg_gp->unkB86 = 0;
    saved_reg_gp->unkB88 = 0x7FFC;
}

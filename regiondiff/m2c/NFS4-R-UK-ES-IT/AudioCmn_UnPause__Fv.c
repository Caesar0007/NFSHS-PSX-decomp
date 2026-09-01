/* NFS4-R-UK-ES-IT CHANGED @8007A6A0 | base 80079C18 AudioCmn_UnPause__Fv */
/* callers: Sim_ProcessPause__Fv, Sim_MainGameLoop__Fv */
? func_8007BC44(s32);                               /* extern */
? func_8007CED4();                                  /* extern */
? func_800E8BC8(?);                                 /* extern */

void func_8007A6A0(void) {
    s32 var_v0;
    s32 var_v1;

    func_800E8BC8(0x7F);
    var_v1 = saved_reg_gp->unk108;
    var_v0 = var_v1 * 2;
    if (var_v1 >= 0x55) {
        var_v1 = (var_v1 * 2) - 0x54;
        var_v0 = var_v1 * 2;
    }
    func_8007BC44((s32) ((var_v0 + var_v1) << 5) >> 7);
    func_8007CED4();
    (void *)0x801144D0->unkF4 = (s32) saved_reg_gp->unk10C;
    (void *)0x801144D0->unkF0 = (s32) saved_reg_gp->unk108;
}

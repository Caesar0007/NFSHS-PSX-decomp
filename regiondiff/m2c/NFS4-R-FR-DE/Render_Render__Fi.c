/* NFS4-R-FR-DE CHANGED @800B4174 | base 800B34A8 Render_Render__Fi */
/* callers: Sim_MainGameLoop__Fv */
? func_8009F790();                                  /* extern */
? func_800B4028(s32, ?);                            /* extern */
? func_800B4074();                                  /* extern */
? func_800B407C();                                  /* extern */
? func_800B40BC();                                  /* extern */
? func_800B40FC();                                  /* extern */
? func_800D9C70();                                  /* extern */
? func_800DDAFC();                                  /* extern */
? func_800DDBBC();                                  /* extern */
? func_800DDBDC();                                  /* extern */
? func_800EE1C4(?);                                 /* extern */

void func_800B4174(s32 arg0) {
    ? var_a1;
    s32 var_a0;

    if (arg0 != 0) {
        if (saved_reg_gp->unkE84 == 0) {
            saved_reg_gp->unkE80 = 0x140;
            saved_reg_gp->unkE84 = 1;
            saved_reg_gp->unkE7C = 0;
            saved_reg_gp->unkE7E = 0;
            saved_reg_gp->unkE82 = 0x100;
            func_800EE1C4(0);
            func_800DDAFC();
            func_8009F790();
            *(s32 *)0x8013E568 = 1;
            *(s32 *)0x8013E544 = 0;
        }
        saved_reg_gp->unkE7C = 0x4E;
        saved_reg_gp->unkE7E = 0x62;
        saved_reg_gp->unkE80 = 0xA4;
        saved_reg_gp->unkE82 = 0x8B;
        if (*(void *)0x8013E568 != 0) {
            func_800DDBBC();
            func_800B40FC();
            func_800DDBDC();
        }
    } else {
        if (saved_reg_gp->unkE84 != 0) {
            saved_reg_gp->unkE84 = 0;
            return;
        }
        if (*(s32 *)0x801144DC == 1) {
            func_800B407C();
            func_800D9C70();
            func_800B4028(saved_reg_gp->unkE74, 0);
            var_a0 = saved_reg_gp->unkE78;
            var_a1 = 1;
        } else {
            func_800B407C();
            func_800D9C70();
            var_a0 = saved_reg_gp->unkE74;
            var_a1 = 0;
        }
        func_800B4028(var_a0, var_a1);
        func_800B4074();
        func_800B40BC();
    }
}

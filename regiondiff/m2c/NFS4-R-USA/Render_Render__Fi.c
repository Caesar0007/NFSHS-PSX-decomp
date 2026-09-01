/* NFS4-R-USA CHANGED @800B4170 | base 800B34A8 Render_Render__Fi */
/* callers: Sim_MainGameLoop__Fv */
? func_8009F78C();                                  /* extern */
? func_800B4024(s32, ?);                            /* extern */
? func_800B4070();                                  /* extern */
? func_800B4078();                                  /* extern */
? func_800B40B8();                                  /* extern */
? func_800B40F8();                                  /* extern */
? func_800D9C44();                                  /* extern */
? func_800DDAD0();                                  /* extern */
? func_800DDB90();                                  /* extern */
? func_800DDBB0();                                  /* extern */
? func_800EE1D8(?);                                 /* extern */

void func_800B4170(s32 arg0) {
    ? var_a1;
    s32 var_a0;

    if (arg0 != 0) {
        if (saved_reg_gp->unkE84 == 0) {
            saved_reg_gp->unkE80 = 0x140;
            saved_reg_gp->unkE84 = 1;
            saved_reg_gp->unkE7C = 0;
            saved_reg_gp->unkE7E = 0;
            saved_reg_gp->unkE82 = 0xF0;
            func_800EE1D8(0);
            func_800DDAD0();
            func_8009F78C();
            *(s32 *)0x8013E53C = 1;
            *(s32 *)0x8013E518 = 0;
        }
        saved_reg_gp->unkE7C = 0x4E;
        saved_reg_gp->unkE7E = 0x62;
        saved_reg_gp->unkE80 = 0xA4;
        saved_reg_gp->unkE82 = 0x8B;
        if (*(void *)0x8013E53C != 0) {
            func_800DDB90();
            func_800B40F8();
            func_800DDBB0();
        }
    } else {
        if (saved_reg_gp->unkE84 != 0) {
            saved_reg_gp->unkE84 = 0;
            return;
        }
        if (*(s32 *)0x801144B0 == 1) {
            func_800B4078();
            func_800D9C44();
            func_800B4024(saved_reg_gp->unkE74, 0);
            var_a0 = saved_reg_gp->unkE78;
            var_a1 = 1;
        } else {
            func_800B4078();
            func_800D9C44();
            var_a0 = saved_reg_gp->unkE74;
            var_a1 = 0;
        }
        func_800B4024(var_a0, var_a1);
        func_800B4070();
        func_800B40B8();
    }
}

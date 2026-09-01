/* NFS4-R-JPN CHANGED @800B3F24 | base 800B34A8 Render_Render__Fi */
/* callers: Sim_MainGameLoop__Fv */
? func_8009F78C();                                  /* extern */
? func_800B3DD8(s32, ?);                            /* extern */
? func_800B3E24();                                  /* extern */
? func_800B3E2C();                                  /* extern */
? func_800B3E6C();                                  /* extern */
? func_800B3EAC();                                  /* extern */
? func_800D9A30();                                  /* extern */
? func_800DD8BC();                                  /* extern */
? func_800DD97C();                                  /* extern */
? func_800DD99C();                                  /* extern */
? func_800EDFC4(?);                                 /* extern */

void func_800B3F24(s32 arg0) {
    ? var_a1;
    s32 var_a0;

    if (arg0 != 0) {
        if (saved_reg_gp->unkE84 == 0) {
            saved_reg_gp->unkE80 = 0x140;
            saved_reg_gp->unkE84 = 1;
            saved_reg_gp->unkE7C = 0;
            saved_reg_gp->unkE7E = 0;
            saved_reg_gp->unkE82 = 0xF0;
            func_800EDFC4(0);
            func_800DD8BC();
            func_8009F78C();
            *(s32 *)0x8013E328 = 1;
            *(s32 *)0x8013E304 = 0;
        }
        saved_reg_gp->unkE7C = 0x4E;
        saved_reg_gp->unkE7E = 0x62;
        saved_reg_gp->unkE80 = 0xA4;
        saved_reg_gp->unkE82 = 0x8B;
        if (*(void *)0x8013E328 != 0) {
            func_800DD97C();
            func_800B3EAC();
            func_800DD99C();
        }
    } else {
        if (saved_reg_gp->unkE84 != 0) {
            saved_reg_gp->unkE84 = 0;
            return;
        }
        if (*(s32 *)0x8011429C == 1) {
            func_800B3E2C();
            func_800D9A30();
            func_800B3DD8(saved_reg_gp->unkE74, 0);
            var_a0 = saved_reg_gp->unkE78;
            var_a1 = 1;
        } else {
            func_800B3E2C();
            func_800D9A30();
            var_a0 = saved_reg_gp->unkE74;
            var_a1 = 0;
        }
        func_800B3DD8(var_a0, var_a1);
        func_800B3E24();
        func_800B3E6C();
    }
}

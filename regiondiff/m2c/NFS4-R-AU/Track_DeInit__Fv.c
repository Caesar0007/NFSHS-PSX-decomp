/* NFS4-R-AU CHANGED @800BBA44 | base 800BAC74 Track_DeInit__Fv */
/* callers: BWorld_DeInit__Fv */
? func_8007F38C();                                  /* extern */
? func_800A4914(void *);                            /* extern */
? func_800A77C4();                                  /* extern */
? func_800BA0D4();                                  /* extern */
? func_800BBD8C(s32, ?);                            /* extern */
? func_800E6118(s32);                               /* extern */

void func_800BBA44(void) {
    s32 temp_a0;
    s32 temp_a0_2;
    s32 temp_a0_3;
    void *temp_s0;

    temp_s0 = saved_reg_gp->unkF84;
    if (temp_s0 != NULL) {
        func_800E6118(temp_s0->unk0);
        temp_s0->unk4 = 0;
        func_800A4914(temp_s0);
    }
    temp_a0 = saved_reg_gp->unkF74;
    if (temp_a0 != 0) {
        func_800BBD8C(temp_a0, 3);
        saved_reg_gp->unkF74 = 0;
    }
    if ((void *)0x8011F474->unk4 != 0) {
        (void *)0x8011F474->unk4 = 0;
    }
    func_8007F38C();
    func_800A77C4();
    func_800BA0D4();
    temp_a0_2 = *(s32 *)0x8013DB38;
    if (temp_a0_2 != 0) {
        func_800E6118(temp_a0_2);
        *(void *)0x8013DB38 = 0;
    }
    temp_a0_3 = saved_reg_gp->unkF70;
    if (temp_a0_3 != 0) {
        func_800E6118(temp_a0_3);
    }
    saved_reg_gp->unkF70 = 0;
    saved_reg_gp->unkF6C = 0;
    saved_reg_gp->unkF68 = 0;
    saved_reg_gp->unkF64 = 0;
}

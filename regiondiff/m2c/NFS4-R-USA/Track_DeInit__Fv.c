/* NFS4-R-USA CHANGED @800BBA40 | base 800BAC74 Track_DeInit__Fv */
/* callers: BWorld_DeInit__Fv */
? func_8007F38C();                                  /* extern */
? func_800A4910(void *);                            /* extern */
? func_800A77C0();                                  /* extern */
? func_800BA0D0();                                  /* extern */
? func_800BBD88(s32, ?);                            /* extern */
? func_800E612C(s32);                               /* extern */

void func_800BBA40(void) {
    s32 temp_a0;
    s32 temp_a0_2;
    s32 temp_a0_3;
    void *temp_s0;

    temp_s0 = saved_reg_gp->unkF84;
    if (temp_s0 != NULL) {
        func_800E612C(temp_s0->unk0);
        temp_s0->unk4 = 0;
        func_800A4910(temp_s0);
    }
    temp_a0 = saved_reg_gp->unkF74;
    if (temp_a0 != 0) {
        func_800BBD88(temp_a0, 3);
        saved_reg_gp->unkF74 = 0;
    }
    if ((void *)0x8011F448->unk4 != 0) {
        (void *)0x8011F448->unk4 = 0;
    }
    func_8007F38C();
    func_800A77C0();
    func_800BA0D0();
    temp_a0_2 = *(s32 *)0x8013DB0C;
    if (temp_a0_2 != 0) {
        func_800E612C(temp_a0_2);
        *(void *)0x8013DB0C = 0;
    }
    temp_a0_3 = saved_reg_gp->unkF70;
    if (temp_a0_3 != 0) {
        func_800E612C(temp_a0_3);
    }
    saved_reg_gp->unkF70 = 0;
    saved_reg_gp->unkF6C = 0;
    saved_reg_gp->unkF68 = 0;
    saved_reg_gp->unkF64 = 0;
}

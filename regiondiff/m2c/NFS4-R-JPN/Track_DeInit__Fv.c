/* NFS4-R-JPN CHANGED @800BB7F4 | base 800BAC74 Track_DeInit__Fv */
/* callers: BWorld_DeInit__Fv */
? func_8007F38C();                                  /* extern */
? func_800A4910(void *);                            /* extern */
? func_800A77C0();                                  /* extern */
? func_800B9E84();                                  /* extern */
? func_800BBB3C(s32, ?);                            /* extern */
? func_800E5F18(s32);                               /* extern */

void func_800BB7F4(void) {
    s32 temp_a0;
    s32 temp_a0_2;
    s32 temp_a0_3;
    void *temp_s0;

    temp_s0 = saved_reg_gp->unkF84;
    if (temp_s0 != NULL) {
        func_800E5F18(temp_s0->unk0);
        temp_s0->unk4 = 0;
        func_800A4910(temp_s0);
    }
    temp_a0 = saved_reg_gp->unkF74;
    if (temp_a0 != 0) {
        func_800BBB3C(temp_a0, 3);
        saved_reg_gp->unkF74 = 0;
    }
    if ((void *)0x8011F234->unk4 != 0) {
        (void *)0x8011F234->unk4 = 0;
    }
    func_8007F38C();
    func_800A77C0();
    func_800B9E84();
    temp_a0_2 = *(s32 *)0x8013D8F8;
    if (temp_a0_2 != 0) {
        func_800E5F18(temp_a0_2);
        *(void *)0x8013D8F8 = 0;
    }
    temp_a0_3 = saved_reg_gp->unkF70;
    if (temp_a0_3 != 0) {
        func_800E5F18(temp_a0_3);
    }
    saved_reg_gp->unkF70 = 0;
    saved_reg_gp->unkF6C = 0;
    saved_reg_gp->unkF68 = 0;
    saved_reg_gp->unkF64 = 0;
}

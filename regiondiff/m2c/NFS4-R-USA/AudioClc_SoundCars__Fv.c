/* NFS4-R-USA CHANGED @80076B90 | base 80076160 AudioClc_SoundCars__Fv */
/* callers: Sim_ProcessSimSchedules__Fv */
s32 func_8007593C();                                /* extern */
? func_80075A30(?, ?);                              /* extern */
? func_80075F28(?);                                 /* extern */
? func_80076734(?, ?, ?);                           /* extern */
? func_80076B60();                                  /* extern */
? func_80076EE8();                                  /* extern */
? func_80077300(?, s32, ?);                         /* extern */
? func_80085D60(?, ?, ?, s32);                      /* extern */
s32 func_8009AEA0(s32, ?);                          /* extern */

void func_80076B90(void) {
    s32 temp_a3;
    s32 temp_v1;
    s32 var_s1;
    void *var_s0;

    func_80076B60();
    func_80076EE8();
    temp_v1 = (void *)0x801144A4->unk0;
    if (((temp_v1 == 1) || (temp_v1 == 5)) && (((*(void **)0x80110D0C)->unk260 & 0x200) || ((*(s32 *)0x8013DAF4 == 2) && (((void **)0x80110000 + 0xD0C)->unk4->unk260 & 0x200))) && (*(s32 *)0x8013EC08 != 0)) {
        var_s1 = 0;
        if ((void *)0x801144A4->unk1AC > 0) {
            var_s0 = (void *)0x801144A4;
            do {
                var_s1 += 1;
                func_80077300(1, func_8009AEA0(var_s0->unk1BC, 0), 0);
                func_80077300(1, func_8009AEA0(var_s0->unk1BC, 1), 0);
                var_s0 += 0x34;
            } while (var_s1 < (void *)0x801144A4->unk1AC);
        }
    }
    if (*(s32 *)0x801144B0 == 1) {
        func_80085D60(0, 0x8010F6EC, 0x8013D8FC);
        func_80076734(0, 0, 2);
        saved_reg_gp->unkBC = 0;
        func_80075F28(0);
        if (*(s32 *)0x8013D954 > 0) {
            func_80075A30(0, 0);
            func_80075A30(0, 1);
        }
        temp_a3 = (void *)0x8010F6EC->unk0;
        (void *)0x8010F56C->unkC = temp_a3;
        (void *)0x8010F56C->unk10 = (s32) (void *)0x8010F6EC->unk4;
        (void *)0x8010F56C->unk14 = (s32) (void *)0x8010F6EC->unk8;
        func_80085D60(1, 0x8010F6EC, 0x8013D8FC, temp_a3);
        func_80076734(1, 2, 2);
        func_80075F28(1);
        if (*(void *)0x8013D954 > 0) {
            func_80075A30(1, 2);
            func_80075A30(1, 3);
        }
        (void *)0x8010F56C->unk5C = (s32) (void *)0x8010F6EC->unk0;
        (void *)0x8010F56C->unk60 = (s32) (void *)0x8010F6EC->unk4;
        (void *)0x8010F56C->unk64 = (s32) (void *)0x8010F6EC->unk8;
        return;
    }
    func_80085D60(0, 0x8010F6EC, 0x8013D8FC);
    func_80076734(0, 0, 4);
    saved_reg_gp->unkBC = func_8007593C();
    func_80075F28(0);
    if (*(void *)0x8013D954 > 0) {
        func_80075A30(0, 0);
        func_80075A30(0, 1);
        func_80075A30(0, 2);
        func_80075A30(0, 3);
    }
    (void *)0x8010F56C->unkC = (s32) (void *)0x8010F6EC->unk0;
    (void *)0x8010F56C->unk10 = (s32) (void *)0x8010F6EC->unk4;
    (void *)0x8010F56C->unk14 = (s32) (void *)0x8010F6EC->unk8;
}

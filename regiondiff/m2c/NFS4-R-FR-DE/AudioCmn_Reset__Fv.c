/* NFS4-R-FR-DE CHANGED @800775EC | base 80076BEC AudioCmn_Reset__Fv */
/* callers: Nfs2_ResetGame__Fv */
s32 func_80076E60(s32);                             /* extern */
? func_80077054();                                  /* extern */
s32 func_80077300(?, s32, ?);                       /* extern */
? func_80077474();                                  /* extern */
? func_8007A938();                                  /* extern */
s32 func_8007A9C4();                                /* extern */
s32 func_8007AA48();                                /* extern */
? func_8007BC44(s32);                               /* extern */
? func_8007DD04();                                  /* extern */
? func_8009A108(?, ?);                              /* extern */
? func_8009A5B0();                                  /* extern */
s32 func_8009AEA4(s32, ?);                          /* extern */
? func_8009B580();                                  /* extern */
? func_800E77DC(?);                                 /* extern */
? func_800E78C8(s32, ?, ?);                         /* extern */
? func_800E80B8();                                  /* extern */
s32 func_800E88C4(? *);                             /* extern */
? func_800E8A58(s32);                               /* extern */
s32 func_800E8DF8();                                /* extern */

void func_800775EC(void) {
    ? sp10;
    s32 temp_a0;
    s32 temp_a0_2;
    s32 temp_s0;
    s32 temp_s0_2;
    s32 temp_s3;
    s32 temp_s6;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 var_s0_2;
    s32 var_s1;
    s32 var_s1_2;
    s32 var_s1_3;
    s32 var_s2;
    void *var_s0;
    void *var_s0_3;

    func_8009A108(0, 0);
    var_s1 = 0;
    func_8009A5B0();
    func_800E80B8();
    func_80077054();
    var_s0 = (void *)0x8010FBEC;
    do {
        temp_a0 = var_s0->unk0;
        if (temp_a0 != -1) {
            func_800E8A58(temp_a0);
            var_s0->unk0 = -1;
            var_s0->unk4 = -1;
        }
        var_s1 += 1;
        var_s0 += 8;
    } while (var_s1 < 0x47);
    if (saved_reg_gp->unk130 != 0) {
        func_8007A938();
    }
    func_80077474();
    if (saved_reg_gp->unk118 > 0) {
        var_s1_2 = 0;
        temp_s6 = func_800E8DF8() + 0x280;
loop_8:
        if ((var_s1_2 == 0) && (func_800E8DF8() < temp_s6)) {
            var_s1_2 = 1;
            func_8009B580();
            func_800E77DC(0);
            if (func_800E88C4(&sp10) > 0x8000) {
                if ((void *)0x801144D0->unk0 == 1) {
                    var_s0_2 = 0;
                    do {
                        if (func_80077300(2, var_s0_2 + 0x2F, 0) == -1) {
                            var_s1_2 = 0;
                        }
                        var_s0_2 += 1;
                    } while (var_s0_2 < 4);
                }
                var_s2 = 0;
                if ((void *)0x801144D0->unk48 == 1) {
                    var_s2 = 0;
                    if (func_80077300(1, 0, 0) == -1) {
                        var_s1_2 = 0;
                    }
                }
                var_s0_3 = (void *)0x801144D0;
loop_20:
                if (var_s2 < (void *)0x801144D0->unk3C4) {
                    if (var_s0_3->unk3D8 == 2) {
                        temp_v0 = func_8009AEA4(var_s0_3->unk3D4, 0);
                        if ((temp_v0 >= 0) && (func_80077300(1, temp_v0, 0) == -1)) {
                            var_s1_2 = 0;
                        }
                        temp_v0_2 = func_8009AEA4(var_s0_3->unk3D4, 1);
                        if ((temp_v0_2 >= 0) && (func_80077300(1, temp_v0_2, 0) == -1)) {
                            var_s1_2 = 0;
                        }
                    }
                    var_s0_3 += 0xB4;
                    var_s2 += 1;
                    goto loop_20;
                }
            }
            goto loop_8;
        }
    }
    func_8007DD04();
    func_800E78C8(*(s32 *)0x8013E830, 0xFF, 0xFF);
    temp_a0_2 = saved_reg_gp->unk108;
    if (temp_a0_2 != 0) {
        func_8007BC44(func_80076E60(temp_a0_2));
        temp_s0 = func_800E8DF8();
        temp_s3 = temp_s0 + 0x100;
        func_800E8DF8();
        func_8007AA48();
        func_8007A9C4();
loop_31:
        var_s1_3 = 0;
        if (((func_800E8DF8() < (temp_s0 + 0x40)) || (func_8007A9C4() <= 0) || (temp_s0_2 = func_8007AA48(), ((temp_s0_2 < func_8007A9C4()) != 0))) && (func_800E8DF8() < temp_s3)) {
            var_s1_3 = 1;
        }
        if (var_s1_3 != 0) {
            func_800E77DC(0);
            goto loop_31;
        }
        func_800E8DF8();
        func_8007AA48();
        func_8007A9C4();
    }
}

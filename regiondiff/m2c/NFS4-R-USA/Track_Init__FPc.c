/* NFS4-R-USA CHANGED @800BB5B4 | base 800BA808 Track_Init__FPc */
/* callers: BWorld_Init__Fv */
? func_8008BE88(s32, void *, void *);               /* extern */
? func_8008C418();                                  /* extern */
void *func_8009CBEC(void *, ?);                     /* extern */
void *func_8009CC14(void *, ?, ?);                  /* extern */
s32 func_8009CCC8(void *, ?, void *, ?);            /* extern */
void *func_800A48C0(?);                             /* extern */
? func_800A7788(s32);                               /* extern */
s32 func_800B7F24(void *, s32, ?);                  /* extern */
s32 func_800B7F70(void *, s32);                     /* extern */
? func_800B7F90(void *);                            /* extern */
? func_800B9FD0(?);                                 /* extern */
? func_800BA0A0();                                  /* extern */
? func_800BA4F8();                                  /* extern */
? func_800BAF24(s32, s32 *, ?);                     /* extern */
? func_800BAFC4(s32, s32 *);                        /* extern */
? func_800BB030(s32 *, s32);                        /* extern */
? func_800BB2F4(s32);                               /* extern */
? func_800BB3D8(void *);                            /* extern */
? func_800BBB88();                                  /* extern */
s32 func_800BBD44(void *, ?);                       /* extern */
? func_800E1D40();                                  /* extern */
? func_800E50A8(? *, ?, s32);                       /* extern */
s32 func_800E5F28(?, s32, ?);                       /* extern */
s32 func_800E6258(s32);                             /* extern */
void *func_800E64DC(? *, s32);                      /* extern */

void func_800BB5B4(s32 arg0) {
    ? sp10;
    s16 *var_v1_2;
    s32 temp_s1;
    s32 temp_s2;
    s32 temp_v0;
    s32 temp_v0_6;
    s32 temp_v1;
    s32 var_a0;
    s32 var_s1;
    s32 var_s2;
    s32 var_s3;
    s32 var_s5;
    s32 var_t0;
    s32 var_t1;
    s32 var_v1;
    s8 var_a1;
    u16 *var_a2;
    u16 *var_a3;
    u16 temp_a0;
    void *temp_s0;
    void *temp_s7;
    void *temp_v0_2;
    void *temp_v0_3;
    void *temp_v0_4;
    void *temp_v0_5;
    void *var_s0;
    void *var_s4;

    saved_reg_gp->unkF74 = 0;
    saved_reg_gp->unkF80 = 0;
    saved_reg_gp->unkF7C = 0;
    func_800E50A8(&sp10, 0x8013E774, arg0);
    temp_s2 = func_800E6258(arg0);
    *(s32 *)0x8013DB0C = func_800E5F28(0x80056E1C, 0x404, 0);
    func_800E1D40();
    var_s1 = temp_s2 + 0x9080;
    func_800BA0A0();
    func_800BA4F8();
    temp_s0 = func_800A48C0(0xC);
    temp_v0 = func_800E5F28(0x80056E28, var_s1, 0);
    temp_s0->unk0 = temp_v0;
    temp_s0->unk4 = temp_v0;
    if (temp_v0 == 0) {
        var_s1 = 0;
    }
    temp_s0->unk8 = var_s1;
    saved_reg_gp->unkF84 = temp_s0;
    temp_v0_2 = func_800E64DC(&sp10, func_800B7F70(temp_s0, temp_s2) + 0x9080);
    saved_reg_gp->unkF5C = (void *) (func_8009CCC8(temp_v0_2, 0x1F, saved_reg_gp->unkF84, 0) + 4);
    *(s32 *)0x8013DB10 = func_8009CCC8(temp_v0_2, 0x20, saved_reg_gp->unkF84, 0) + 4;
    temp_v0_3 = func_8009CC14(temp_v0_2, 0x23, 0);
    var_a0 = *(void *)0x8013DB0C;
    var_v1 = temp_v0_3 + 0x10;
    temp_v0_4 = temp_v0_3 + 0x410;
    if ((var_v1 | var_a0) & 3) {
        do {
            var_a0->unk0 = (unaligned s32) var_v1->unk0;
            var_a0->unk4 = (unaligned s32) var_v1->unk4;
            var_a0->unk8 = (unaligned s32) var_v1->unk8;
            var_a0->unkC = (unaligned s32) var_v1->unkC;
            var_v1 += 0x10;
            var_a0 += 0x10;
        } while (var_v1 != temp_v0_4);
    } else {
        do {
            var_a0->unk0 = (s32) var_v1->unk0;
            var_a0->unk4 = (s32) var_v1->unk4;
            var_a0->unk8 = (s32) var_v1->unk8;
            var_a0->unkC = (s32) var_v1->unkC;
            var_v1 += 0x10;
            var_a0 += 0x10;
        } while (var_v1 != temp_v0_4);
    }
    var_s2 = 0;
    var_s3 = 0;
    var_s5 = 0;
    saved_reg_gp->unkF98 = (u32) ((u32) (func_8009CC14(temp_v0_2, 0x23, 0)->unk4 - 0x10) >> 2);
    saved_reg_gp->unkF54 = func_800B7F24(saved_reg_gp->unkF84, saved_reg_gp->unkF5C->unk1C * 0x48, 0);
    saved_reg_gp->unkF58 = func_800B7F24(saved_reg_gp->unkF84, saved_reg_gp->unkF5C->unk1C, 0);
    saved_reg_gp->unkF60 = func_800B7F24(saved_reg_gp->unkF84, saved_reg_gp->unkF5C->unk1C * 0x70, 0);
    func_8008C418();
    temp_s7 = func_8009CC14(temp_v0_2, 0x21, 0);
    var_s0 = func_8009CC14(temp_v0_2, 0x1D, 0);
loop_8:
    temp_v1 = saved_reg_gp->unkF5C->unk1C;
    if (var_s2 < temp_v1) {
        temp_s1 = saved_reg_gp->unkF60 + var_s5;
        var_s4 = NULL;
        if (var_s2 < (temp_v1 - 1)) {
            var_s4 = func_8009CBEC(var_s0, 0x1D);
        }
        func_8008BE88(temp_s1, var_s0, saved_reg_gp->unkF84);
        temp_v0_5 = func_8009CC14(var_s0, 4, 0);
        var_t1 = temp_v0_5->unkC;
        var_t0 = 0;
        if (var_t1 >= 0x25) {
            var_t1 = 0x24;
        }
        var_a1 = 0;
        if (var_t1 > 0) {
            var_a3 = temp_v0_5 + 0x10;
            var_a2 = var_s3 + saved_reg_gp->unkF54;
            do {
                temp_a0 = *var_a3;
                if ((temp_a0 & 0x3FF) < saved_reg_gp->unkF5C->unk1C) {
                    *var_a2 = temp_a0;
                    var_a2 += 2;
                    var_a1 += 1;
                }
                var_t0 += 1;
                var_a3 += 2;
            } while (var_t0 < var_t1);
        }
        *(saved_reg_gp->unkF58 + var_s2) = var_a1;
        if (var_a1 < 0x24) {
            var_v1_2 = (var_a1 * 2) + (var_s3 + saved_reg_gp->unkF54);
            do {
                *var_v1_2 = 0x3FF;
                var_a1 += 1;
                var_v1_2 += 2;
            } while (var_a1 < 0x24);
        }
        var_s0 = var_s4;
        var_s3 += 0x40;
        var_s5 += 0x70;
        var_s2 += 1;
        goto loop_8;
    }
    func_800BB3D8(temp_s7);
    func_800B7F90(saved_reg_gp->unkF84);
    func_800B9FD0(0x8013E778);
    temp_v0_6 = func_800E5F28(0x8013E780, (*saved_reg_gp->unkF64 * 8) | 4, 0);
    saved_reg_gp->unkF70 = temp_v0_6;
    func_800BB030(saved_reg_gp->unkF64, temp_v0_6);
    func_800BAF24(saved_reg_gp->unkF6C, saved_reg_gp->unkF64, 2);
    func_800BAFC4(saved_reg_gp->unkF68, saved_reg_gp->unkF64);
    saved_reg_gp->unkF74 = func_800BBD44(func_800A48C0(8), 0x30);
    func_800BBB88();
    func_800A7788(saved_reg_gp->unkF7C + 0x2A);
    func_800BB2F4(*(s32 *)0x801144E0);
}

/* NFS4-R-FR-DE CHANGED @800BB5B8 | base 800BA808 Track_Init__FPc */
/* callers: BWorld_Init__Fv */
? func_8008BE8C(s32, void *, void *);               /* extern */
? func_8008C41C();                                  /* extern */
void *func_8009CBF0(void *, ?);                     /* extern */
void *func_8009CC18(void *, ?, ?);                  /* extern */
s32 func_8009CCCC(void *, ?, void *, ?);            /* extern */
void *func_800A48C4(?);                             /* extern */
? func_800A778C(s32);                               /* extern */
s32 func_800B7F28(void *, s32, ?);                  /* extern */
s32 func_800B7F74(void *, s32);                     /* extern */
? func_800B7F94(void *);                            /* extern */
? func_800B9FD4(?);                                 /* extern */
? func_800BA0A4();                                  /* extern */
? func_800BA4FC();                                  /* extern */
? func_800BAF28(s32, s32 *, ?);                     /* extern */
? func_800BAFC8(s32, s32 *);                        /* extern */
? func_800BB034(s32 *, s32);                        /* extern */
? func_800BB2F8(s32);                               /* extern */
? func_800BB3DC(void *);                            /* extern */
? func_800BBB8C();                                  /* extern */
s32 func_800BBD48(void *, ?);                       /* extern */
? func_800E1D6C();                                  /* extern */
? func_800E5094(? *, ?, s32);                       /* extern */
s32 func_800E5F14(?, s32, ?);                       /* extern */
s32 func_800E6244(s32);                             /* extern */
void *func_800E64C8(? *, s32);                      /* extern */

void func_800BB5B8(s32 arg0) {
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
    func_800E5094(&sp10, 0x8013E7A0, arg0);
    temp_s2 = func_800E6244(arg0);
    *(s32 *)0x8013DB38 = func_800E5F14(0x80056E1C, 0x404, 0);
    func_800E1D6C();
    var_s1 = temp_s2 + 0x9080;
    func_800BA0A4();
    func_800BA4FC();
    temp_s0 = func_800A48C4(0xC);
    temp_v0 = func_800E5F14(0x80056E28, var_s1, 0);
    temp_s0->unk0 = temp_v0;
    temp_s0->unk4 = temp_v0;
    if (temp_v0 == 0) {
        var_s1 = 0;
    }
    temp_s0->unk8 = var_s1;
    saved_reg_gp->unkF84 = temp_s0;
    temp_v0_2 = func_800E64C8(&sp10, func_800B7F74(temp_s0, temp_s2) + 0x9080);
    saved_reg_gp->unkF5C = (void *) (func_8009CCCC(temp_v0_2, 0x1F, saved_reg_gp->unkF84, 0) + 4);
    *(s32 *)0x8013DB3C = func_8009CCCC(temp_v0_2, 0x20, saved_reg_gp->unkF84, 0) + 4;
    temp_v0_3 = func_8009CC18(temp_v0_2, 0x23, 0);
    var_a0 = *(void *)0x8013DB38;
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
    saved_reg_gp->unkF98 = (u32) ((u32) (func_8009CC18(temp_v0_2, 0x23, 0)->unk4 - 0x10) >> 2);
    saved_reg_gp->unkF54 = func_800B7F28(saved_reg_gp->unkF84, saved_reg_gp->unkF5C->unk1C * 0x48, 0);
    saved_reg_gp->unkF58 = func_800B7F28(saved_reg_gp->unkF84, saved_reg_gp->unkF5C->unk1C, 0);
    saved_reg_gp->unkF60 = func_800B7F28(saved_reg_gp->unkF84, saved_reg_gp->unkF5C->unk1C * 0x70, 0);
    func_8008C41C();
    temp_s7 = func_8009CC18(temp_v0_2, 0x21, 0);
    var_s0 = func_8009CC18(temp_v0_2, 0x1D, 0);
loop_8:
    temp_v1 = saved_reg_gp->unkF5C->unk1C;
    if (var_s2 < temp_v1) {
        temp_s1 = saved_reg_gp->unkF60 + var_s5;
        var_s4 = NULL;
        if (var_s2 < (temp_v1 - 1)) {
            var_s4 = func_8009CBF0(var_s0, 0x1D);
        }
        func_8008BE8C(temp_s1, var_s0, saved_reg_gp->unkF84);
        temp_v0_5 = func_8009CC18(var_s0, 4, 0);
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
    func_800BB3DC(temp_s7);
    func_800B7F94(saved_reg_gp->unkF84);
    func_800B9FD4(0x8013E7A4);
    temp_v0_6 = func_800E5F14(0x8013E7AC, (*saved_reg_gp->unkF64 * 8) | 4, 0);
    saved_reg_gp->unkF70 = temp_v0_6;
    func_800BB034(saved_reg_gp->unkF64, temp_v0_6);
    func_800BAF28(saved_reg_gp->unkF6C, saved_reg_gp->unkF64, 2);
    func_800BAFC8(saved_reg_gp->unkF68, saved_reg_gp->unkF64);
    saved_reg_gp->unkF74 = func_800BBD48(func_800A48C4(8), 0x30);
    func_800BBB8C();
    func_800A778C(saved_reg_gp->unkF7C + 0x2A);
    func_800BB2F8(*(s32 *)0x8011450C);
}

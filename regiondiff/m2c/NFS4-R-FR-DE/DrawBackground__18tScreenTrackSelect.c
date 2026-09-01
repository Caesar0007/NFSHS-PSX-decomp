/* NFS4-R-FR-DE CHANGED @80041A48 | base 80041600 DrawBackground__18tScreenTrackSelect */
? func_80021C94(?, u8, ? *);                        /* extern */
s16 func_80021FC4(s32, ?);                          /* extern */
? func_80025EB8(void *, void *);                    /* extern */
? func_8002607C(void *, ?);                         /* extern */
? func_80037158(void *);                            /* extern */
? func_800421B8(void *, ?);                         /* extern */
? func_800421E8(void *, ? *);                       /* extern */
? func_800422D8(void *, ? *);                       /* extern */
? func_8004234C(void *);                            /* extern */
? func_8004C508(s16, s16 *, ?);                     /* extern */
? func_80051748(s32, ? *);                          /* extern */
? func_800517A4(s32);                               /* extern */
s32 func_80051848(s32);                             /* extern */
s32 func_800518F0(s32, ?, u32);                     /* extern */
? func_800E5094(? *, ?, s32, s16);                  /* extern */
? func_800EE1C4(?);                                 /* extern */
? func_800EE348(s16 *, ?, ?, ?);                    /* extern */
s16 func_800F295C(?, ?, s16, ?);                    /* extern */

void func_80041A48(void *arg0) {
    s16 sp10;
    s16 sp12;
    s16 sp14;
    s16 sp16;
    ? sp18;
    s16 sp48;
    s16 sp4A;
    s16 sp4C;
    s16 sp4E;
    ? sp50;
    void *spA0;
    ? var_a1;
    s16 temp_t0_2;
    s16 temp_t0_4;
    s32 *temp_t0;
    s32 *temp_t0_3;
    s32 temp_v0;
    s32 temp_v1;
    s8 temp_s0_2;
    s8 temp_s2;
    s8 temp_t1;
    s8 temp_v0_2;
    s8 temp_v0_3;
    s8 temp_v1_2;
    s8 var_s6;
    void *temp_s0;
    void *temp_s8;
    void *temp_s8_2;

    sp10 = 0x140;
    sp12 = 0xC8;
    sp14 = 0xAA;
    sp16 = 0xC;
    sp12 = 0xD0;
    func_8004C508(func_80021FC4(*(s32 *)0x800522A8 + 0xC88, -1), &sp10, 0);
    func_80021C94(0x80115D34, *(u8 *)0x80115907, &sp18);
    func_800421E8(arg0, &sp18);
    func_800422D8(arg0, &sp18);
    func_80025EB8(arg0, arg0 + 0x28);
    temp_s0 = arg0 + 0x260;
    if ((arg0->unk2C != 0) && (temp_s0->unk14 != -1) && (arg0->unk70 == 0)) {
        func_8002607C(arg0, 0xA);
        func_80037158(temp_s0);
    }
    temp_s0_2 = ((arg0->unk68 & 1) == 0) << 7;
    var_s6 = temp_s0_2;
    temp_v0 = func_80051848(arg0->unk64);
    if (temp_v0 == 1) {
        sp4C = 0xAA;
        sp48 = 0x200;
        sp4A = 0;
        sp4E = 0x100;
        func_800EE348(&sp48, 0, 0, 0);
        func_800EE1C4(0);
        arg0->unk70 = 0;
        arg0->unk78 = (s32) (*(s32 *)0x8013EFB8 - 0x14);
    } else if (temp_v0 == 3) {
        if (func_800518F0(arg0->unk64, 0x200, (u32) (temp_s0_2 << 0x10) >> 0x10) != 0) {
            temp_v1 = arg0->unk68 + 1;
            var_s6 = ((temp_v1 & 1) == 0) << 7;
            arg0->unk68 = temp_v1;
        }
    } else if (((arg0->unk7C != 0) || (arg0->unk72 < arg0->unk70)) && ((u32) (*(void *)0x8013EFB8 - arg0->unk29C) >= 0x101U)) {
        if (arg0->unk72 >= arg0->unk70) {
            var_a1 = 0x20;
            if (sp1B != 0) {
                var_a1 = 0x80;
            }
            func_800421B8(arg0, var_a1);
        }
        func_800E5094(&sp50, 0x80011EA4, *(s32 *)0x801177F0, arg0->unk6E);
        func_80051748(arg0->unk64, &sp50);
        func_800517A4(arg0->unk64);
    }
    if (arg0->unk70 > 0) {
        spA0 = (void *)0x1F800004;
        temp_s8 = *(void **)0x1F800004;
        temp_s2 = var_s6 | 0x7F;
        temp_t0 = *(s32 **)0x1F800000;
        temp_s8->unk0 = (s32) ((temp_s8->unk0 & 0xFF000000) | (*temp_t0 & 0xFFFFFF));
        *(void *)0x1F800004 = (void *) (temp_s8 + 0x28);
        *temp_t0 = (*temp_t0 & 0xFF000000) | ((s32) temp_s8 & 0xFFFFFF);
        temp_t0_2 = arg0->unk70;
        temp_s8->unk3 = 9;
        temp_s8->unkA = 0x69;
        temp_s8->unk12 = 0x69;
        temp_s8->unk8 = 0x99;
        temp_s8->unk18 = 0x99;
        temp_v0_2 = 0x200 & 0x3F;
        temp_v1_2 = temp_v0_2 + 0x50;
        temp_s8->unk10 = 0x139;
        temp_s8->unk1A = 0xE8;
        temp_s8->unk20 = 0x139;
        temp_s8->unk22 = 0xE8;
        temp_s8->unkC = temp_v0_2;
        temp_s8->unkD = var_s6;
        temp_s8->unk14 = temp_v1_2;
        temp_s8->unk15 = var_s6;
        temp_s8->unk1C = temp_v0_2;
        temp_s8->unk1D = temp_s2;
        temp_s8->unk24 = temp_v1_2;
        temp_s8->unk25 = temp_s2;
        temp_s8->unk4 = (s32) ((temp_t0_2 << 0x10) | (temp_t0_2 << 8) | temp_t0_2);
        temp_s8->unk7 = 0x2E;
        temp_t1 = 0x250 & 0x3F;
        temp_s8->unk16 = func_800F295C(2, 1, (s16) (-0x40 & 0x200), 0);
        temp_s8->unkE = 0;
        temp_t0_3 = *(void *)0x1F800000;
        temp_s8_2 = *(void *)0x1F800004;
        temp_s8_2->unk0 = (s32) ((temp_s8_2->unk0 & 0xFF000000) | (*temp_t0_3 & 0xFFFFFF));
        *temp_t0_3 = (*temp_t0_3 & 0xFF000000) | ((s32) temp_s8_2 & 0xFFFFFF);
        temp_t0_4 = arg0->unk70;
        *(void *)0x1F800004 = (void *) (temp_s8_2 + 0x28);
        temp_s8_2->unk3 = 9;
        temp_s8_2->unk10 = 0x1D9;
        temp_s8_2->unk20 = 0x1D9;
        temp_v0_3 = temp_t1 + 0x50;
        temp_s8_2->unk14 = temp_v0_3;
        temp_s8_2->unk24 = temp_v0_3;
        temp_s8_2->unkA = 0x69;
        temp_s8_2->unk12 = 0x69;
        temp_s8_2->unk4 = (s32) ((temp_t0_4 << 0x10) | (temp_t0_4 << 8) | temp_t0_4);
        temp_s8_2->unk8 = 0x139;
        temp_s8_2->unk18 = 0x139;
        temp_s8_2->unk1A = 0xE8;
        temp_s8_2->unk22 = 0xE8;
        temp_s8_2->unkC = temp_t1;
        temp_s8_2->unkD = var_s6;
        temp_s8_2->unk15 = var_s6;
        temp_s8_2->unk1C = temp_t1;
        temp_s8_2->unk1D = temp_s2;
        temp_s8_2->unk25 = temp_s2;
        temp_s8_2->unk7 = 0x2E;
        temp_s8_2->unk16 = func_800F295C(2, 1, (s16) (0x250 & ~0x3F), 0);
        temp_s8_2->unkE = 0;
    }
    func_8004234C(arg0);
}

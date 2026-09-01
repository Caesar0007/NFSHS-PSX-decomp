/* NFS4-R-UK-SW CHANGED @8001D824 | base 8001D63C Draw__20tMenuItemSlidingMenuiib */
? func_8001C188(s32, s16, s16, ?);                  /* extern */
? func_8001C2E4(s16, s16, s16, s32, s32, s32, s32, s32); /* extern */
? func_80020F3C(s32, s16, s16, s32, s32, s32);      /* extern */
s32 func_8004BE04(?, ?, s16, s16);                  /* extern */
s32 func_8004BEA8(?, s16, s16);                     /* extern */
? func_8004EF24(?, ?, s16, s16, s32, s32, s16 *);   /* extern */
? func_8004F4F0(?, s16, s16, s16, s32);             /* extern */
s32 func_800B9F1C(s32);                             /* extern */
s16 func_800B9F5C(s32);                             /* extern */
s16 func_800B9F7C(s32);                             /* extern */
void *func_800BEB88(s32, s32);                      /* extern */
? func_800EEC5C(s32 *, s16 *, s32 *, ?);            /* extern */

void func_8001D824(void *arg0, s32 arg1, s32 arg2, ? arg3) {
    s16 sp20;
    u16 sp22;
    s32 sp24;                                       /* compiler-managed */
    s16 sp28;
    s16 sp2A;
    s16 sp2C;
    s16 sp2E;
    s32 sp38;
    s32 sp3C;
    s32 sp40;
    void *sp44;
    s32 sp48;
    void *sp4C;
    s16 temp_a0_2;
    s16 temp_a2;
    s16 temp_a3;
    s16 temp_s0_3;
    s16 temp_s0_4;
    s16 temp_s4;
    s16 temp_s5;
    s16 temp_s8;
    s16 temp_v0_2;
    s16 temp_v1_3;
    s16 var_a3;
    s16 var_a3_2;
    s16 var_s0;
    s32 *temp_a0;
    s32 *temp_a0_3;
    s32 *temp_a2_2;
    s32 *temp_a2_3;
    s32 temp_a0_4;
    s32 temp_a0_5;
    s32 temp_s0;
    s32 temp_s0_2;
    s32 temp_s1;
    s32 temp_s1_2;
    s32 temp_s1_3;
    s32 temp_s2;
    s32 temp_s2_2;
    s32 temp_t0;
    s32 temp_v1;
    s32 temp_v1_2;
    void *temp_s3;
    void *temp_s7;
    void *temp_t1;
    void *temp_v0;
    void *temp_v0_3;

    temp_v0 = arg0->unk18;
    temp_v0->unk5C(arg0 + temp_v0->unk58, arg3);
    sp38 = func_8004BEA8(6, arg0->unk8, arg0->unk2C);
    sp3C = func_800B9F5C(arg0->unk4) + arg1;
    temp_v0_2 = func_800B9F7C(arg0->unk4);
    *(s32 *)0x80051E58 = -1;
    sp40 = temp_v0_2 + arg2;
    sp44 = *(s32 *)0x800532B4 + 0x3C0;
    temp_v1 = arg0->unk1C == (*(s32 *)0x800522A0 + 0x2758);
    sp48 = temp_v1;
    temp_a2 = arg0->unk2C;
    if ((temp_a2 != 0x80) && (temp_v1 != 0)) {
        func_8001C188(sp40, arg0->unk8, temp_a2, 0x80051E50);
    }
    if ((arg0->unk1C != 0) || (sp48 != 0)) {
        var_s0 = 0xDC;
        if (sp48 == 0) {
            var_s0 = arg0->unk24;
        }
        var_a3 = sp40 - 2;
        sp24 = func_8004BE04(0, 0xBEBE, arg0->unk8, arg0->unk2C);
        temp_s1 = sp3C + var_s0;
        if (sp48 != 0) {
            var_a3 = sp40 - 3;
        }
        func_8004EF24(0x39, 0x18, (temp_s1 - sp44->unk10) - 0xA, var_a3, 0, 1, &sp20);
        var_a3_2 = sp40 + 4;
        if (sp48 != 0) {
            var_a3_2 = sp40 + 3;
        }
        func_8004EF24(0x3A, 0x18, (temp_s1 - sp44->unk10) - 0xA, var_a3_2, 0, 1, &sp20);
    }
    if (arg0->unk1C != 0) {
        temp_s8 = arg0->unk24;
        temp_s4 = sp3C + arg0->unk3C;
        temp_s2 = arg0->unk28 << 0x10;
        temp_s5 = sp40 + arg0->unk3E;
        temp_v0_3 = func_800BEB88(*(s32 *)0x8013E6DC, *(s32 *)0x8013EAC8);
        temp_a0 = *(s32 **)0x1F800004;
        sp20 = 0;
        sp4C = temp_v0_3;
        sp24 = 0x200;
        temp_a2_2 = *(s32 **)0x1F800000;
        sp22 = temp_v0_3->unk2;
        unksp26 = *(u16 *)0x8013EF98;
        *temp_a0 = (*temp_a0 & 0xFF000000) | (*temp_a2_2 & 0xFFFFFF);
        *(s32 **)0x1F800004 = temp_a0 + 0xC;
        *temp_a2_2 = (*temp_a2_2 & 0xFF000000) | ((s32) temp_a0 & 0xFFFFFF);
        func_800EEC5C(temp_a0, &sp20, temp_a2_2, 0xFFFFFF);
        temp_s0 = temp_s2 >> 0x11;
        func_8001C2E4(temp_s4, temp_s5, temp_s8, temp_s0, 0x505050, 0x505050, 0, 0);
        func_8001C2E4(temp_s4, temp_s5 + temp_s0, temp_s8, temp_s0, 0, 0, 0x505050, 0x505050);
        temp_t0 = arg0->unk1C;
        temp_t1 = temp_t0->unk68;
        temp_v1_2 = *(void *)0x800532B4;
        temp_s7 = temp_v1_2 + 0x3E0;
        temp_s3 = temp_v1_2 + 0x400;
        temp_t1->unk5C(temp_t0 + temp_t1->unk58, temp_s4, temp_s5, temp_s8, (s32) (s16) (arg0->unk2A * 2), (s32) arg0->unk26);
        temp_s2_2 = temp_s2 >> 0x10;
        if ((arg0->unk40 != 0) && (temp_s7->unk12 < temp_s2_2)) {
            func_8004EF24(0x1F, 0xC, temp_s4, temp_s5, 0, 0, NULL);
            temp_s1_2 = temp_s4 + temp_s8;
            func_8004EF24(0x1F, 8, temp_s1_2 - temp_s7->unk10, temp_s5, 0, 0, NULL);
            temp_s0_2 = temp_s5 + temp_s2_2;
            func_8004EF24(0x20, 0xC, temp_s4, temp_s0_2 - temp_s3->unk12, 0, 0, NULL);
            func_8004EF24(0x20, 8, temp_s1_2 - temp_s3->unk10, temp_s0_2 - temp_s3->unk12, 0, 0, NULL);
        }
        temp_a3 = temp_s7->unk10;
        func_8004F4F0(0, temp_s4 + temp_a3 + 5, temp_s5, ((temp_s8 - temp_a3) - temp_s3->unk10) - 0xA, temp_s2_2);
        temp_v1_3 = temp_s7->unk12;
        temp_a0_2 = temp_s3->unk12;
        if ((temp_v1_3 + temp_a0_2) < temp_s2_2) {
            func_8004F4F0(0, temp_s4, temp_s5 + temp_v1_3, temp_s8, (temp_s2_2 - temp_v1_3) - temp_a0_2);
        }
        temp_a0_3 = *(void *)0x1F800004;
        temp_a2_3 = *(void *)0x1F800000;
        sp28 = temp_s4;
        sp2C = temp_s8;
        sp2E = (s16) temp_s2_2;
        sp2A = sp4C->unk2 + temp_s5 + 8;
        *temp_a0_3 = (*temp_a0_3 & 0xFF000000) | (*temp_a2_3 & 0xFFFFFF);
        *(void *)0x1F800004 = (s32 *) (temp_a0_3 + 0xC);
        *temp_a2_3 = (*temp_a2_3 & 0xFF000000) | ((s32) temp_a0_3 & 0xFFFFFF);
        func_800EEC5C(temp_a0_3, &sp28, temp_a2_3, 0xFFFFFF);
        temp_a0_4 = *(void *)0x80051E58;
        if (temp_a0_4 != -1) {
            temp_s1_3 = func_800B9F1C(temp_a0_4);
            temp_s0_3 = func_800B9F5C(*(void *)0x80051E58);
            func_80020F3C(temp_s1_3, temp_s0_3, func_800B9F7C(*(void *)0x80051E58), *(s32 *)0x80051E54, 0, 2);
        }
        temp_a0_5 = func_800B9F1C(arg0->unk4);
        if (sp48 != 0) {

        }
        func_80020F3C(temp_a0_5, (s16) sp3C, (s16) sp40, sp38);
        temp_s0_4 = sp40 - 2;
        func_8004EF24(0x1E, 8, (sp3C + arg0->unk24) - sp44->unk10, temp_s0_4, (s32) arg0->unk2C, 0, NULL);
        if (arg0->unk40 != 0) {
            func_8004F4F0(0, (s16) sp3C, temp_s0_4, arg0->unk24 - sp44->unk10, (s32) sp44->unk12);
        }
    }
}

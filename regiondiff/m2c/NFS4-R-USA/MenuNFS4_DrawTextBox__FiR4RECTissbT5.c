/* NFS4-R-USA CHANGED @8001A158 | base 8001A018 MenuNFS4_DrawTextBox__FiR4RECTissbT5 */
/* callers: Draw__27tMenuItemGoToMenuNFS4Buttoniib, Draw__27tMenuItemGoToMenuNFS4Buttoniib, Draw__28tMenuItemNFS4LeftRightChoiceiib, Draw__28tMenuItemNFS4LeftRightChoiceiib */
? func_80020E38(?);                                 /* extern */
? func_80020EAC(s32, s16, s16, s32, s32, s32);      /* extern */
? func_80026910(? *);                               /* extern */
s32 func_8004BCD8(?, s32, s16);                     /* extern */
s32 func_8004BE30(?, s16, ?);                       /* extern */
? func_8004C2E0(void *);                            /* extern */
? func_8004EB60(?, ?, s32, s16, s32, s32, ? *);     /* extern */
? func_8004F12C(?, s16, s16, s16, s32);             /* extern */
s32 func_800B9F18(s32);                             /* extern */
void *func_800BEB84(s32, s32);                      /* extern */
s32 func_800E4A2C(? *);                             /* extern */
? func_800E50A8(? *, ?, s32);                       /* extern */
s32 func_800EA8D0(? *);                             /* extern */
? func_800EEC70(s32 *, u16 *, s32 *, ?);            /* extern */

void func_8001A158(s32 arg0, void *arg1, s32 arg2, s16 arg3, s32 arg4, s32 arg5, s32 arg6) {
    u16 sp20;
    u16 sp22;                                       /* compiler-managed */
    u16 sp24;                                       /* compiler-managed */
    u16 sp26;
    ? sp28;
    s32 sp2C;
    ? sp40;
    s16 temp_v0;
    s16 temp_v1;
    s16 var_a2;
    s16 var_s2;
    s32 *temp_a0;
    s32 *temp_a0_2;
    s32 *temp_a2;
    s32 *temp_a2_2;
    s32 temp_s0;
    s32 temp_s4;
    s32 temp_s5;
    s32 var_s0;
    s32 var_v1;
    void *temp_s0_2;
    void *temp_s8;

    temp_s8 = func_800BEB84(*(s32 *)0x8013E6B0, *(s32 *)0x8013EA9C);
    sp2C = func_8004BCD8(0xB54200, 0xBEBE, (s16) arg4);
    if (arg6 != 0) {
        var_a2 = 0xE0 - arg1->unk2;
        if (var_a2 < 0) {
            var_a2 = 0;
        } else if (var_a2 >= 0x81) {
            var_a2 = 0x80;
        }
        sp2C = func_8004BCD8(0, sp2C, var_a2);
    }
    func_8004C2E0(arg1);
    if (arg0 >= 0) {
        temp_a0 = *(s32 **)0x1F800004;
        sp20 = 0;
        sp24 = 0x200;
        temp_a2 = *(s32 **)0x1F800000;
        sp26 = 0xF0;
        sp22 = temp_s8->unk2;
        *temp_a0 = (*temp_a0 & 0xFF000000) | (*temp_a2 & 0xFFFFFF);
        *(s32 **)0x1F800004 = temp_a0 + 0xC;
        *temp_a2 = (*temp_a2 & 0xFF000000) | ((s32) temp_a0 & 0xFFFFFF);
        func_800EEC70(temp_a0, &sp20, temp_a2, 0xFFFFFF);
        func_80020E38(0);
        func_800E50A8(&sp40, 0x80010614, func_800B9F18(arg0));
        func_80026910(&sp40);
        temp_s0 = func_800E4A2C(&sp40);
        temp_s4 = temp_s0 - func_800EA8D0(&sp40);
        var_v1 = temp_s4;
        if (temp_s4 < arg2) {
            var_v1 = arg2;
        }
        temp_s5 = var_v1 + 0x19;
        var_s0 = func_8004BE30(1, (s16) arg4, 0);
        if (arg6 != 0) {
            var_s0 = func_8004BCD8(0, var_s0, 0xF0 - arg1->unk2);
        }
        func_80020EAC(func_800B9F18(arg0), (s16) (arg1->unk0 + arg3), (s16) ((u16) arg1->unk2 + 4), var_s0, 0, 0);
        func_80020EAC(func_800B9F18(arg0), (s16) ((arg1->unk0 + arg3) - temp_s5), (s16) ((u16) arg1->unk2 + 4), var_s0, 0, 0);
        if (arg5 != 0) {
            var_s2 = arg1->unk2 + ((s32) (arg1->unk6 << 0x10) >> 0x11);
            if (arg6 == 0) {
                var_s2 += 2;
            }
            func_8004EB60(0xA, 0x118, ((s16) arg1->unk0 + arg3) - 0xA, var_s2, 0, 0, &sp28);
            func_8004EB60(0xB, 0x118, (s16) arg1->unk0 + arg3 + temp_s4 + 8, var_s2, 0, 0, &sp28);
            func_8004EB60(0xA, 0x118, (((s16) arg1->unk0 + arg3) - temp_s5) - 0xA, var_s2, 0, 0, &sp28);
            func_8004EB60(0xB, 0x118, (((s16) arg1->unk0 + arg3) - temp_s5) + temp_s4 + 8, var_s2, 0, 0, &sp28);
        }
        temp_a0_2 = *(void *)0x1F800004;
        sp20 = (unaligned s32) arg1->unk0;
        sp24 = (unaligned s32) arg1->unk4;
        temp_a2_2 = *(void *)0x1F800000;
        sp22 += temp_s8->unk2;
        sp20 += 2;
        sp24 -= 4;
        *temp_a0_2 = (*temp_a0_2 & 0xFF000000) | (*temp_a2_2 & 0xFFFFFF);
        *(void *)0x1F800004 = (s32 *) (temp_a0_2 + 0xC);
        *temp_a2_2 = (*temp_a2_2 & 0xFF000000) | ((s32) temp_a0_2 & 0xFFFFFF);
        func_800EEC70(temp_a0_2, &sp20, temp_a2_2, 0xFFFFFF);
    }
    sp20 = (unaligned s32) arg1->unk0;
    sp24 = (unaligned s32) arg1->unk4;
    temp_v0 = sp22 + 1;
    sp22 = temp_v0;
    temp_s0_2 = *(s32 *)0x80052EF4 + 0x3C0;
    sp26 -= 2;
    temp_v1 = (sp24 - 1) - ((s32) (temp_s0_2->unk10 << 0x10) >> 0x11);
    sp24 = temp_v1;
    func_8004EB60(0x1E, 8, (s16) sp20 + temp_v1, temp_v0, 0, 0, NULL);
    func_8004F12C(0, (s16) sp20, sp22, sp24, (s32) temp_s0_2->unk12);
}

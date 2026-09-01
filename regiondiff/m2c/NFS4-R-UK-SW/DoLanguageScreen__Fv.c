/* NFS4-R-UK-SW CHANGED @8004E238 | base 8004DC34 DoLanguageScreen__Fv */
/* callers: Init_PSX_FrontEnd__Fv */
s32 func_80023D38(?, ?);                            /* extern */
? func_800279F8();                                  /* extern */
? func_8004DCE0(?, ?, ?);                           /* extern */
? func_800A5130();                                  /* extern */
? func_800E5094(? *, s32, s32, ?);                  /* extern */
? func_800E6118(s32);                               /* extern */
? func_800E77DC(?);                                 /* extern */
s32 func_800EBAB8(s32, s32);                        /* extern */
? func_800F146C(?);                                 /* extern */
? func_800F1498(s32, s32, ?);                       /* extern */
s32 func_800F299C(? *, ?);                          /* extern */
? func_800F2CA4(?);                                 /* extern */

void func_8004E238(void) {
    s32 sp10;
    s32 sp14;
    s32 sp18;
    s32 sp1C;
    s32 sp20;
    s32 sp24;
    s32 sp28;
    s32 sp30;
    s8 sp50;
    s8 sp51;
    ? sp58;
    ? var_a2;
    s32 *var_s2;
    s32 *var_s4;
    s32 temp_a1;
    s32 temp_a1_2;
    s32 temp_s6;
    s32 var_s0;
    s32 var_s1;
    s32 var_s1_2;
    s32 var_s2_2;
    s32 var_s3;
    s32 var_s5;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v0_3;
    s32 var_v1;

    func_800279F8();
    if (*(u8 *)0x80115C24 == 0xFF) {
        sp10 = (void *)0x80012818->unk0;
        sp14 = (void *)0x80012818->unk4;
        sp18 = (void *)0x80012818->unk8;
        sp1C = (void *)0x80012818->unkC;
        sp20 = (void *)0x80012818->unk10;
        sp24 = (void *)0x80012818->unk14;
        sp28 = (void *)0x80012818->unk18;
        var_s3 = 0;
        var_s1 = 0;
        var_s4 = &sp30;
        var_s2 = &sp10;
        sp50 = 0;
        sp51 = 5;
        func_800E5094(&sp58, *(s32 *)0x800532A4, *(s32 *)0x801177CC, 0x80012834);
        temp_s6 = func_800F299C(&sp58, 0);
        func_800E77DC(0);
        do {
            temp_a1 = *var_s2;
            var_s2 += 4;
            var_s1 += 1;
            *var_s4 = func_800EBAB8(temp_s6, temp_a1);
            var_s4 += 4;
        } while (var_s1 < 7);
        var_s5 = 0;
        func_8004DCE0(1, 1, 1);
        func_800F146C(0);
        func_800F1498(sp30, 0, 0);
        var_v1 = 0;
loop_4:
        if (var_v1 != 2) {
            var_s5 += 1;
            if (var_v1 != 0x2000) {
                if (var_s5 >= 2) {
                    var_s5 = 0;
                }
                func_800F146C(1);
                var_s1_2 = 0;
                var_s2_2 = 4;
                var_s0 = 0xE2 - sp44->unk4;
                func_800F2CA4(0);
loop_9:
                if (var_s1_2 < 2) {
                    var_v0 = 0x18;
                    if (var_s3 == var_s1_2) {
                        var_v0 = 0x14;
                    }
                    func_800F1498(*(&sp30 + var_v0), var_s0, 0xB4);
                    var_v0_2 = var_s2_2;
                    if (var_s3 != var_s1_2) {
                        var_v0_2 = (var_s1_2 + 3) * 4;
                    }
                    temp_a1_2 = var_s0 + (((s32) ((u16) sp44->unk4 << 0x10) >> 0x11) - ((s32) ((*(&sp30 + var_s2_2))->unk4 << 0x10) >> 0x11));
                    var_a2 = 0xB9;
                    if ((sp + var_s1_2)->unk50 == 3) {
                        var_a2 = 0xB8;
                    }
                    var_s2_2 += 4;
                    func_800F1498(*(&sp30 + var_v0_2), temp_a1_2, var_a2);
                    var_s1_2 += 1;
                    var_s0 = var_s0 + 0x3C + sp44->unk4;
                    goto loop_9;
                }
                var_v1 = func_80023D38(0, -1);
                if (var_v1 == 0) {
                    var_v1 = func_80023D38(1, -1);
                }
                if (var_v1 == 0x800) {
                    var_s3 -= 1;
                }
                var_v0_3 = var_s3 < 2;
                if (var_v1 == 0x1000) {
                    var_s3 += 1;
                    var_v0_3 = var_s3 < 2;
                }
                if (var_v0_3 == 0) {
                    var_s3 = 1;
                }
                if (var_s3 < 0) {
                    var_s3 = 0;
                }
                goto loop_4;
            }
        }
        *(void *)0x80115C24 = (u8) (sp + var_s3)->unk50;
        func_800E6118(temp_s6);
        func_8004DCE0(1, 1, 1);
        func_800A5130();
    }
}

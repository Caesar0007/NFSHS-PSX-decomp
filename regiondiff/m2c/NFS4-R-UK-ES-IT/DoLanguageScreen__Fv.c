/* NFS4-R-UK-ES-IT CHANGED @8004E250 | base 8004DC34 DoLanguageScreen__Fv */
/* callers: Init_PSX_FrontEnd__Fv */
s32 func_80023D50(?, ?);                            /* extern */
? func_80027A10();                                  /* extern */
? func_8004DCF8(?, ?, ?);                           /* extern */
? func_800A5130();                                  /* extern */
? func_800E5094(? *, s32, s32, ?);                  /* extern */
? func_800E6118(s32);                               /* extern */
? func_800E77DC(?);                                 /* extern */
s32 func_800EBAB8(s32, s32);                        /* extern */
? func_800F146C(?);                                 /* extern */
? func_800F1498(s32, s32, ?);                       /* extern */
s32 func_800F299C(? *, ?);                          /* extern */
? func_800F2CA4(?, s16);                            /* extern */

void func_8004E250(void) {
    s32 sp10;
    s32 sp38;
    s8 sp60;
    s8 sp61;
    s8 sp62;
    ? sp68;
    ? var_a2_2;
    s16 temp_a1_2;
    s32 *var_a2;
    s32 *var_s2;
    s32 *var_s4;
    s32 *var_v1;
    s32 temp_a1;
    s32 temp_a1_3;
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
    s32 var_v1_2;

    func_80027A10();
    var_a2 = &sp10;
    if (*(u8 *)0x80115C24 == 0xFF) {
        var_v1 = (s32 *)0x80012828;
        do {
            var_a2->unk0 = var_v1->unk0;
            var_a2->unk4 = (s32) var_v1->unk4;
            var_a2->unk8 = (s32) var_v1->unk8;
            var_a2->unkC = (s32) var_v1->unkC;
            var_v1 += 0x10;
            var_a2 += 0x10;
        } while (var_v1 != (s32 *)0x80012848);
        var_s3 = 0;
        var_s1 = 0;
        var_s4 = &sp38;
        var_s2 = &sp10;
        *var_a2 = *var_v1;
        sp60 = (void *)0x8001284C->unk0;
        sp61 = (void *)0x8001284C->unk1;
        sp62 = (void *)0x8001284C->unk2;
        func_800E5094(&sp68, *(s32 *)0x800532EC, *(s32 *)0x801177CC, 0x80012850);
        temp_s6 = func_800F299C(&sp68, 0);
        func_800E77DC(0);
        do {
            temp_a1 = *var_s2;
            var_s2 += 4;
            var_s1 += 1;
            *var_s4 = func_800EBAB8(temp_s6, temp_a1);
            var_s4 += 4;
        } while (var_s1 < 9);
        var_s5 = 0;
        func_8004DCF8(1, 1, 1);
        func_800F146C(0);
        func_800F1498(sp38, 0, 0);
        var_v1_2 = 0;
loop_6:
        if (var_v1_2 != 2) {
            var_s5 += 1;
            if (var_v1_2 != 0x2000) {
                if (var_s5 >= 2) {
                    var_s5 = 0;
                }
                func_800F146C(1);
                var_s1_2 = 0;
                var_s2_2 = 4;
                temp_a1_2 = sp54->unk4;
                var_s0 = (0xF6 - ((s32) (sp58->unk4 << 0x10) >> 0x11)) - temp_a1_2;
                func_800F2CA4(0, temp_a1_2);
loop_11:
                if (var_s1_2 < 3) {
                    var_v0 = 0x20;
                    if (var_s3 == var_s1_2) {
                        var_v0 = 0x1C;
                    }
                    func_800F1498(*(&sp38 + var_v0), var_s0, 0xB4);
                    var_v0_2 = var_s2_2;
                    if (var_s3 != var_s1_2) {
                        var_v0_2 = (var_s1_2 + 4) * 4;
                    }
                    temp_a1_3 = var_s0 + (((s32) ((u16) sp54->unk4 << 0x10) >> 0x11) - ((s32) ((*(&sp38 + var_s2_2))->unk4 << 0x10) >> 0x11));
                    var_a2_2 = 0xB9;
                    if ((sp + var_s1_2)->unk60 == 3) {
                        var_a2_2 = 0xB8;
                    }
                    var_s2_2 += 4;
                    func_800F1498(*(&sp38 + var_v0_2), temp_a1_3, var_a2_2);
                    var_s1_2 += 1;
                    var_s0 = var_s0 + 0xA + sp54->unk4;
                    goto loop_11;
                }
                var_v1_2 = func_80023D50(0, -1);
                if (var_v1_2 == 0) {
                    var_v1_2 = func_80023D50(1, -1);
                }
                if (var_v1_2 == 0x800) {
                    var_s3 -= 1;
                }
                var_v0_3 = var_s3 < 3;
                if (var_v1_2 == 0x1000) {
                    var_s3 += 1;
                    var_v0_3 = var_s3 < 3;
                }
                if (var_v0_3 == 0) {
                    var_s3 = 2;
                }
                if (var_s3 < 0) {
                    var_s3 = 0;
                }
                goto loop_6;
            }
        }
        *(void *)0x80115C24 = (u8) (sp + var_s3)->unk60;
        func_800E6118(temp_s6);
        func_8004DCF8(1, 1, 1);
        func_800A5130();
    }
}

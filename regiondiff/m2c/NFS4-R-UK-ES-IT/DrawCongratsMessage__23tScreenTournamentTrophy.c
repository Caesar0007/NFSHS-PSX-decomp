/* NFS4-R-UK-ES-IT CHANGED @8004946C | base 80048F64 DrawCongratsMessage__23tScreenTournamentTrophy */
? func_80020F54(? *, ?, s16, ?, s32, s32);          /* extern */
? func_80021948(s16, ? *, s16 *, ?, s32);           /* extern */
s32 func_80021AD0(s16, ? *);                        /* extern */
? func_80026DA8(? *, s32);                          /* extern */
? func_80033AF8(?, ? *);                            /* extern */
? *func_800B9F1C(s32, s32);                         /* extern */
s32 func_800B9F7C(?);                               /* extern */
? func_800E5094(? *, ? *, ? *);                     /* extern */

void func_8004946C(void *arg0) {
    s16 sp18;
    u16 sp1A;
    s16 sp1C;
    s16 sp1E;
    ? sp20;
    ? sp68;
    ? sp260;
    ? sp458;
    ? sp558;
    ? *temp_s0;
    ? *var_a0;
    ? *var_v0;
    s16 temp_s0_2;
    s32 temp_a0;
    s32 temp_a1;
    s32 temp_v1;
    s32 var_s0;
    s32 var_s2;
    s32 var_s3;
    s8 *temp_s1;

    sp18 = 0x29;
    sp1A = 0x35;
    sp1C = 0x1A4;
    sp1E = 0x190;
    if (arg0->unk64 == 0) {
        var_s2 = 0;
        temp_a1 = (void *)0x80115DBC->unk18;
        var_s3 = 0;
        temp_s1 = temp_a1 + ((((temp_a1 + ((void *)0x80115DBC->unk4 * 0xC))->unk2 + (void *)0x80115DBC->unk8) * 0x54) + 0x24);
        if ((void *)0x80115DBC->unk230 >= 4) {
            temp_v1 = arg0->unk68;
            var_s2 = *temp_s1 + 0x3B4;
            if (temp_v1 != 1) {
                if (temp_v1 < 2) {
                    if (temp_v1 != 0) {
                        var_s0 = 2;
                    } else {
                        goto block_7;
                    }
                } else if (temp_v1 == 3) {
block_7:
                    var_s0 = 0;
                } else {
                    var_s0 = 2;
                }
            } else {
                var_s0 = 1;
            }
            temp_s0 = func_800B9F1C(*temp_s1 + 0x3B4, temp_a1);
            func_800E5094(&sp68, temp_s0, func_800B9F1C(var_s0 + 0x3E2));
        }
        temp_a0 = arg0->unk68;
        if (((temp_a0 == 0) && (*(s8 *)0x80115FEC != 1)) || (temp_a0 == 3)) {
            if (var_s2 == 0) {
                var_s2 = *temp_s1 + 0x3C7;
                var_v0 = func_800B9F1C(var_s2);
                var_a0 = &sp68;
            } else {
                var_s3 = *temp_s1 + 0x3C7;
                var_v0 = func_800B9F1C(var_s3);
                var_a0 = &sp260;
            }
            func_800E5094(var_a0, var_v0);
        }
        if (var_s2 != 0) {
            func_80021948(arg0->unk5C, &sp68, &sp18, 2, 0xA);
            sp1A = sp1A - 0xE + func_80021AD0(sp1C, &sp68);
        }
        if (var_s3 != 0) {
            sp1C = 0xC8;
            func_80021948(arg0->unk5C, &sp260, &sp18, 2, 0xA);
        }
        func_80033AF8(0x80115DBC, &sp20);
        if (sp40 != 0) {
            sp18 = 0x104;
            sp1A = 0xC8;
            sp1C = 0xF0;
            func_80026DA8(&sp558, sp44);
            func_800E5094(&sp458, func_800B9F1C(0x40), &sp558);
            func_80021948(arg0->unk5C, func_800B9F1C(0x40), &sp18, 1, 0xA);
        }
    } else {
        temp_s0_2 = func_800B9F7C(0x321) + 6;
        func_80020F54(func_800B9F1C(0x321), 0x120, temp_s0_2, 0x414141, 3, 2);
    }
}

/* NFS4-R-JPN CHANGED @8003C69C | base 8003C7D8 DrawForeground__16tScreenCarSelect */
? func_80015C28(?, s8);                             /* extern */
? func_80020C0C(s32, s16, s16, s32, s32, s32);      /* extern */
s32 func_8002349C(?, void *);                       /* extern */
? func_80036C08(void *);                            /* extern */
? func_80036CA8(void *);                            /* extern */
? func_8003A81C(s8 *, s16, s16, s32, s32, s32, s32, s32, s32); /* extern */
? func_8003AB90(void *, s32);                       /* extern */
? func_8003B6B0(void *, s16, s16, s16, s32, s32, s32 *, s32 *, s32 *, s32 *, s32 *); /* extern */
? func_8003C368(void *, ?, ?);                      /* extern */
? func_8003C37C(void *, ?);                         /* extern */
s32 func_8004B830(s32, s32);                        /* extern */
? func_8004E628(?, ?, ?, ?, s32, s32, ? *);         /* extern */
s32 func_800B9CCC(s16);                             /* extern */
s32 func_800B9CEC(s16, s32);                        /* extern */
s16 func_800B9D0C(s16);                             /* extern */
s16 func_800B9D2C(s16);                             /* extern */
s32 func_800E8BF8();                                /* extern */
s32 func_800F3BF8(s32, ?);                          /* extern */
s32 func_800F696C(s32);                             /* extern */

void func_8003C69C(void *arg0) {
    s8 sp30;
    ? sp100;
    s32 sp104;
    s32 sp114;
    s32 sp118;
    s32 sp11C;
    s32 sp120;
    s32 sp124;
    s32 sp128;
    ? var_a1_3;
    s16 temp_s1_2;
    s16 temp_s4;
    s16 temp_v0_3;
    s16 temp_v0_7;
    s16 temp_v0_8;
    s16 temp_v0_9;
    s16 temp_v1_10;
    s16 temp_v1_2;
    s16 var_a2;
    s16 var_a3;
    s16 var_s0;
    s16 var_s0_2;
    s16 var_t1_2;
    s16 var_v0_2;
    s16 var_v0_4;
    s32 temp_a1_3;
    s32 temp_a1_4;
    s32 temp_a2_2;
    s32 temp_s0;
    s32 temp_s0_2;
    s32 temp_s1_3;
    s32 temp_t0;
    s32 temp_t0_2;
    s32 temp_v0;
    s32 temp_v0_5;
    s32 temp_v0_6;
    s32 temp_v1_6;
    s32 temp_v1_7;
    s32 temp_v1_8;
    s32 temp_v1_9;
    s32 var_a1;
    s32 var_s1;
    s32 var_s2;
    s32 var_t0;
    s32 var_t1;
    s32 var_v0;
    s32 var_v0_3;
    s32 var_v0_5;
    s8 temp_v1_5;
    u16 var_a1_2;
    u32 temp_s1;
    void *temp_a0;
    void *temp_a1;
    void *temp_a1_2;
    void *temp_a2;
    void *temp_v0_2;
    void *temp_v0_4;
    void *temp_v1;
    void *temp_v1_3;
    void *temp_v1_4;

    temp_a2 = arg0->unk60;
    temp_v1 = (*(void **)0x80051470)->unk4;
    temp_s0 = (temp_v1 + (temp_v1->unk8 * 4))->unk10;
    temp_v0 = temp_a2->unk6C(arg0 + temp_a2->unk68, &sp30, temp_a2);
    var_s1 = 0;
    temp_a1 = *(void **)0x800519A8;
    temp_a1->unk20B8 = (s32) (temp_a1->unk20B8 | 1);
    temp_v1_2 = arg0->unk11C;
    switch (temp_v1_2) {                            /* irregular */
    case 1:
        var_s1 = (u32) (temp_s0 ^ (s32) (temp_a1 + 0x12E8)) < 1U;
        temp_a1->unk133C = (s32) (temp_a1->unk133C & ~1);
        if (((void *)0x801156A4->unk4 == 2) && ((void *)0x801156A4->unk122 == 0) && (func_8002349C(0xD, temp_a1) != 0)) {
            temp_v1_3 = *(void **)0x800519A8;
            temp_v1_3->unk20B8 = (s32) (temp_v1_3->unk20B8 & ~1);
        }
        if (temp_v0 != 0) {
            if (sp32 < 5U) {
                arg0->unkD8 = 1;
            } else {
                goto block_9;
            }
        } else {
block_9:
            temp_v1_4 = *(void *)0x800519A8;
            temp_v1_4->unk133C = (s32) (temp_v1_4->unk133C | 1);
            arg0->unkD8 = -1;
        }
        break;
    case 0:
        if (temp_s0 == (temp_a1 + 0x11D4)) {
            var_s1 = 1;
        }
        temp_a1->unk11FC = (s32) (temp_a1->unk11FC & ~1);
        temp_a1->unk1224 = (s32) (temp_a1->unk1224 & ~1);
        if (sp32 == 7) {
            temp_a1->unk11FC = (s32) (temp_a1->unk11FC | 1);
            temp_a1->unk1224 = (s32) (temp_a1->unk1224 | 1);
        }
        break;
    case 2:
        if (temp_s0 == (temp_a1 + 0x1CA0)) {
            var_s1 = 1;
        }
        break;
    case 3:
        if (temp_s0 == (temp_a1 + 0x1DE0)) {
            var_s1 = 1;
        }
        temp_a1->unk1E08 = (s32) (temp_a1->unk1E08 & ~1);
        if (temp_v0 != 0) {
            arg0->unkD8 = 1;
        } else {
            arg0->unkD8 = -1;
            temp_a1->unk1E08 = (s32) (temp_a1->unk1E08 | 1);
        }
        break;
    case 4:
        var_s1 = 1;
        arg0->unkF0 = 1;
        arg0->unkC0 = 1;
        break;
    }
    var_v0 = var_s1;
    if (temp_v0 == 0) {
        var_v0 = 0;
    }
    var_v0_2 = 1;
    if (var_v0 == 0) {
        var_v0_2 = -1;
    }
    arg0->unk108 = var_v0_2;
    var_s0 = 0;
    var_v0_3 = 0 << 0x10;
    do {
        temp_a2_2 = var_v0_3 >> 0x10;
        temp_a1_2 = arg0 + (temp_a2_2 * 4);
        temp_a0 = temp_a1_2->unk10C;
        if (temp_a0 != NULL) {
            if (temp_a0->unk16 != *(0x80051EFC + (s32) (temp_a2_2 + (arg0->unk11C * 4)))) {
                temp_a0->unk14 = -1;
                var_v0_4 = var_s0 + 1;
                if (temp_a1_2->unk10C->unk10 <= 0) {
                    temp_a1_2->unk10C = NULL;
                    goto block_35;
                }
            } else {
                goto block_37;
            }
        } else {
block_35:
            temp_v1_5 = *(0x80051EFC + (s32) (temp_a2_2 + (arg0->unk11C * 4)));
            if (temp_v1_5 >= 0) {
                temp_v0_2 = arg0 + ((temp_v1_5 * 0x18) + 0x64);
                temp_a1_2->unk10C = temp_v0_2;
                temp_v0_2->unk10 = 0;
                temp_a1_2->unk10C->unk14 = 1;
            }
block_37:
            var_v0_4 = var_s0 + 1;
        }
        var_s0 = var_v0_4;
        var_v0_3 = var_s0 << 0x10;
    } while (var_v0_4 < 4);
    var_s0_2 = 1;
    var_v0_5 = 1 << 0x10;
    do {
        func_8003AB90(arg0, (arg0 + (var_v0_5 >> 0xE))->unk10C);
        temp_v0_3 = var_s0_2 + 1;
        var_s0_2 = temp_v0_3;
        var_v0_5 = var_s0_2 << 0x10;
    } while (temp_v0_3 < 4);
    if (temp_v0 == 0) {
        sp30 = -1;
    }
    temp_v0_4 = arg0->unk60;
    temp_v0_4->unk64(arg0 + temp_v0_4->unk60, &sp30);
    if ((*(0x800529C0 + ((*(void *)0x80051470)->unk22C * 4)))->unk8D8 != 0) {
        func_8003C368(arg0, 0, 0);
        func_80036C08(arg0 + 0x304);
        arg0->unk37C = (s32) *(s32 *)0x8013ED78;
    }
    func_8003C37C(arg0, 0);
    if ((u32) ((u16) arg0->unk11C - 5) >= 2U) {
        *(s32 *)0x80051210 = 0;
        arg0->unk39C = (s32) (arg0->unk39C + 3);
        func_8003A81C(&sp30, 0x13A, 0x54, 0x40800000, 0xC0F00000, (s32) arg0->unk374, 1, arg0->unk39C, 0);
    } else {
        sp120 = 0;
        sp124 = 0;
        sp128 = 0;
        sp118 = 0;
        temp_v0_5 = *(void *)0x8013ED78 - arg0->unk390;
        temp_t0 = temp_v0_5 - 0x100;
        sp11C = 0;
        if ((temp_t0 >= 0) && (spF1 >= 0)) {
            temp_a1_3 = temp_t0 >> 9;
            temp_s4 = (temp_a1_3 - (((temp_v0_5 - 0x100) / 9728) * 0x13)) + 0x3E5 + (spF1 * 0x13);
            temp_a1_4 = temp_a1_3 << 9;
            temp_s1 = temp_t0 - temp_a1_4;
            var_s2 = *(0x80051618 + (((func_800B9CEC(temp_s4, temp_a1_4) * 6) + 0x80051568)->unk4 * 4));
            if (temp_s1 < 0x80U) {
                var_a1 = 0x80 - temp_s1;
                goto block_52;
            }
            var_a1 = temp_s1 - 0x180;
            if ((u32) (0x200 - temp_s1) < 0x80U) {
block_52:
                var_s2 = func_8004B830(var_s2, var_a1);
            }
            temp_s0_2 = func_800B9CCC(temp_s4);
            temp_s1_2 = func_800B9D0C(temp_s4);
            func_80020C0C(temp_s0_2, temp_s1_2, func_800B9D2C(temp_s4), var_s2, 0, 0);
        }
        sp104 = 0x551E00;
        sp114 = arg0->unk28;
        temp_t0_2 = (*(void *)0x8013ED78 - arg0->unk390) - 0x80;
        var_t1 = 0x80;
        if (temp_t0_2 > 0) {
            var_t1 = 0x80 - temp_t0_2;
            if (temp_t0_2 >= 0x80) {
                var_t1 = 0;
            }
        }
        if ((arg0->unk3A & 1) && (var_t1 < 0x80)) {
            func_8004E628(0xA, 0x200, 0, 0, var_t1, 0, &sp100);
        }
        var_t0 = *(void *)0x8013ED78 - arg0->unk38C;
loop_61:
        if (var_t0 >= 0x259) {
            temp_v1_6 = arg0->unk398;
            arg0->unk38C = (s32) (arg0->unk38C + 0x258);
            temp_v0_6 = temp_v1_6 + 1;
            arg0->unk398 = temp_v0_6;
            var_t0 -= 0x258;
            if (temp_v0_6 >= 7) {
                arg0->unk398 = (s32) (temp_v1_6 - 4);
            }
            goto loop_61;
        }
        var_a1_2 = (u16) arg0->unk398;
        (void *)0x80052B70->unk0 = 0;
        if ((s16) var_a1_2 >= 7) {
            var_a1_2 -= 5;
            (void *)0x80052B70->unk0 = 0x04000000;
        }
        temp_v0_7 = var_a1_2 + 1;
        var_a2 = temp_v0_7;
        temp_v1_7 = (void *)0x80052B70->unk0;
        (void *)0x80052B70->unk4 = temp_v1_7;
        if (temp_v0_7 >= 7) {
            var_a2 = var_a1_2 - 4;
            (void *)0x80052B70->unk4 = (s32) (temp_v1_7 + 0x04000000);
        }
        temp_v0_8 = var_a2 + 1;
        var_a3 = temp_v0_8;
        temp_v1_8 = (void *)0x80052B70->unk4;
        (void *)0x80052B70->unk8 = temp_v1_8;
        if (temp_v0_8 >= 7) {
            var_a3 = var_a2 - 4;
            (void *)0x80052B70->unk8 = (s32) (temp_v1_8 + 0x04000000);
        }
        temp_v0_9 = var_a3 + 1;
        var_t1_2 = temp_v0_9;
        temp_v1_9 = (void *)0x80052B70->unk8;
        (void *)0x80052B70->unkC = temp_v1_9;
        if (temp_v0_9 >= 7) {
            var_t1_2 = var_a3 - 4;
            (void *)0x80052B70->unkC = (s32) (temp_v1_9 + 0x04000000);
        }
        func_8003B6B0(arg0, (s16) var_a1_2, var_a2, var_a3, (s32) var_t1_2, var_t0, &sp118, &sp11C, &sp120, &sp124, &sp128);
        *(void *)0x80051210 = 1;
        temp_s1_3 = func_800F3BF8(func_800F696C(sp118), 0x37800000);
        func_8003A81C(&sp30, (s16) sp120, (s16) sp124, temp_s1_3, func_800F3BF8(func_800F696C(sp11C), 0x37800000), (s32) arg0->unk374, 1, sp128, 0);
        if ((temp_v0 != 0) && ((u32) (func_800E8BF8() - arg0->unk390) >= 0x281U) && (arg0->unk394 == 0) && (spF1 >= 0)) {
            arg0->unk394 = 1;
            func_80015C28(0, spF1);
        }
    }
    if ((*(void **)0x800529C0)->unk8D8 == 0) {
        temp_v1_10 = (s16) arg0->unk374;
        if ((temp_v1_10 == arg0->unk378) && (temp_v1_10 == 0) && ((*(void *)0x8013ED78 - arg0->unk37C) >= 0x81)) {
            var_a1_3 = 0x20;
            if (sp37 != 0) {
                var_a1_3 = 0x80;
            }
            func_8003C368(arg0, var_a1_3, 0);
            func_80036CA8(arg0 + 0x304);
        }
    }
}

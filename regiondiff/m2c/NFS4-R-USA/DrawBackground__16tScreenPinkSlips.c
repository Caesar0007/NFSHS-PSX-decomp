/* NFS4-R-USA CHANGED @80038D60 | base 80038B68 DrawBackground__16tScreenPinkSlips */
? func_800212E0(s16, s16, s16, ?, s32, s32);        /* extern */
? func_80021C04(s32, u8, s8 *);                     /* extern */
s16 func_80021F34(s32, ?);                          /* extern */
? func_800224AC(void *);                            /* extern */
? func_80025E2C(void *, void *);                    /* extern */
? func_80025FF0(void *, ?);                         /* extern */
? func_800395FC(void *, s8 *);                      /* extern */
? func_800396A8(void *);                            /* extern */
? func_8004C490(?, s16 *, ?);                       /* extern */
? func_8004DBC0(?);                                 /* extern */
? func_8004EB60(?, ?, s32, s16, s32, s32, s32);     /* extern */
? func_8004F12C(?, ?, ?, s32, s32);                 /* extern */
? func_8004F3B8(s32, s16, s16, ?, s32, s32);        /* extern */
? func_80051380(s32, ? *);                          /* extern */
? func_800513DC(s32);                               /* extern */
s32 func_80051480(s32);                             /* extern */
s32 func_80051528(s32, ?, u32);                     /* extern */
s32 func_800B9F18(?);                               /* extern */
? func_800CECD0(s32, s32, s32, s32, s32);           /* extern */
s32 func_800E4A2C(s32);                             /* extern */
? func_800E50A8(? *, ?, s32, s8);                   /* extern */
s16 func_800F2930(?, ?, s32, s16);                  /* extern */

void func_80038D60(void *arg0) {
    s16 sp20;
    s16 sp22;
    s16 sp24;
    s16 sp26;
    s8 sp28;
    ? sp58;
    u16 spA8;
    u8 spB0;
    s32 spB8;
    s32 spBC;
    s16 temp_a0;
    s16 temp_v0_3;
    s16 temp_v0_4;
    s16 temp_v0_5;
    s16 temp_v0_6;
    s16 temp_v1_2;
    s16 var_s1;
    s16 var_s2;
    s16 var_s2_2;
    s16 var_s2_3;
    s16 var_s2_4;
    s16 var_s2_5;
    s16 var_s3;
    s16 var_t1;
    s32 temp_lo;
    s32 temp_s4;
    s32 temp_v0;
    s32 temp_v1;
    s32 var_a1;
    s32 var_s0;
    s32 var_t0;
    s32 var_v1;
    u16 temp_s0;
    u16 temp_v0_2;
    u32 var_v0;
    void *temp_s0_2;

    var_s2 = 0;
    if (arg0->unk5C >= 0x64) {
        func_800212E0(0x27E, 0x1E0, 0xDC, 1, 1, 4);
        func_8004F12C(0, 0x1E0, 0xDC, -func_800E4A2C(func_800B9F18(0x27E)) - 5, 7);
        var_s2 = 0;
    }
    sp20 = 0x15B;
    sp22 = 0x8F;
    sp24 = 0x90;
    sp26 = 0xE;
loop_3:
    var_s0 = 1;
    if (var_s2 < (s32) (void *)0x801158B8->unk47) {
        temp_a0 = arg0->unk64->unk8;
        var_a1 = 0;
        if ((var_s2 == (temp_a0 - 1)) || ((var_s2 == 0) && (temp_a0 == 0))) {
            var_a1 = 1;
        }
        if (var_a1 != 0) {
            temp_v0 = *(s32 *)0x80053080 + 1;
            *(s32 *)0x80053080 = temp_v0;
            if (temp_v0 >= 0x3D) {
                *(s32 *)0x80053080 = 0;
            }
            var_v1 = *(s32 *)0x80053080;
            var_v0 = (u32) var_v1 >> 0x1F;
            if (var_v1 >= 0x1F) {
                var_v0 = 0x3C - var_v1;
                var_v1 = (s32) (var_v0 >> 0x1F);
            }
            temp_lo = (((s32) (var_v1 + var_v0) >> 1) + 0x14) * (0x80 - arg0->unk5C);
            if (temp_lo > 0) {
                func_800CECD0(sp20 - 0xF, sp22 + 6, temp_lo / 2, (temp_lo * 2) / 3, 0x17);
                func_8004EB60(0x38, 0, sp20 - 0x12, sp22, (s32) arg0->unk5C, 1, 0);
            }
            var_s0 = 2;
        }
        func_80021C04(0x80115D08, (var_s2 + 0x801158B8)->unk23, &sp28);
        (void *)0x801158B8->unk46 = (u8) var_s2;
        func_800212E0(func_80021F34(*(s32 *)0x80051EE0 + 0xC88, -1), (s16) ((u16) sp20 + 0xA), (s16) ((u16) sp22 + 3), 0, var_s0, 1);
        func_8004C490(-1, &sp20, 1);
        var_s2 += 1;
        sp22 = (u16) sp22 + 0xE;
        goto loop_3;
    }
    temp_v0_2 = (u16) arg0->unk64->unk8;
    (void *)0x801158B8->unk46 = (u8) temp_v0_2;
    if (temp_v0_2 & 0xFF) {
        (void *)0x801158B8->unk46 = (u8) (temp_v0_2 - 1);
    }
    func_80021C04(0x80115D08, ((void *)0x801158B8->unk46 + 0x801158B8)->unk23, &sp28);
    func_800395FC(arg0, &sp28);
    func_80025E2C(arg0, arg0 + 0x28);
    if ((arg0->unk2C != 0) && (arg0->unk80 >= 0)) {
        func_80025FF0(arg0, 4);
        arg0->unk80 = 1;
        arg0->unk7C = (s32) *(s32 *)0x8013EF8C;
    }
    func_800396A8(arg0);
    temp_s0 = ((arg0->unk6C & 1) == 0) << 7;
    spA8 = temp_s0;
    if (func_80051480(arg0->unk68) != 0) {
        var_s3 = 0;
        if (func_80051528(arg0->unk68, 0x200, (u32) (temp_s0 << 0x10) >> 0x10) != 0) {
            temp_v1 = arg0->unk6C + 1;
            spA8 = ((temp_v1 & 1) == 0) << 7;
            arg0->unk6C = temp_v1;
        }
        var_s2_2 = 0;
        var_t1 = 0x40;
        var_t0 = 1;
        spB0 = (u8) spA8;
        var_s1 = 0;
        do {
            temp_s4 = var_s2_2 << 6;
loop_27:
            temp_s0_2 = arg0 + (var_s3 * 0x30);
            temp_s0_2->unk98 = (s16) ((var_s1 * 0x50) + 0xA0);
            temp_s0_2->unk9A = (s16) (temp_s4 + 0x19);
            temp_s0_2->unk9C = 0x50;
            temp_s0_2->unk9E = var_t1;
            temp_s0_2->unkA0 = (s8) (var_s1 * 0x28);
            temp_s0_2->unkA1 = (s8) (temp_s4 + spB0);
            temp_s0_2->unkA2 = 0x28;
            temp_s0_2->unkA3 = (s8) var_t1;
            if (var_s2_2 == var_t0) {
                temp_s0_2->unkA3 = 0x3F;
            }
            spB8 = var_t0;
            spBC = (s32) var_t1;
            temp_v1_2 = var_s1 + 1;
            var_s1 = temp_v1_2;
            temp_s0_2->unkA8 = func_800F2930(2, 0, 0x200, (s16) spA8);
            temp_s0_2->unkA6 = 0;
            temp_s0_2->unk8C = 0x20;
            temp_s0_2->unk94 = 0x808080;
            temp_s0_2->unk84 = var_t0;
            var_s3 += 1;
            if (temp_v1_2 < 4) {
                goto loop_27;
            }
            temp_v0_3 = var_s2_2 + 1;
            var_s2_2 = temp_v0_3;
            var_s1 = 0;
        } while (temp_v0_3 < 2);
        var_s2_3 = 0xF0;
    } else {
        var_s2_3 = 0xF0;
        if ((u32) (*(void *)0x8013EF8C - arg0->unk7C) >= 0x101U) {
            func_800E50A8(&sp58, 0x800118B4, *(s32 *)0x801177C4, sp28);
            func_80051380(arg0->unk68, &sp58);
            var_s2_3 = 0xF0;
            func_800513DC(arg0->unk68);
        }
    }
    do {
        func_8004F3B8(0x303030, var_s2_3, 0xF, 2, 0x81, 1);
        temp_v0_4 = var_s2_3 + 0x50;
        var_s2_3 = temp_v0_4;
    } while (temp_v0_4 < 0x1E0);
    var_s2_4 = 0x4F;
    do {
        func_8004F3B8(0x202020, 0xA0, var_s2_4, 0x141, 1, 1);
        temp_v0_5 = var_s2_4 + 0x40;
        var_s2_4 = temp_v0_5;
    } while (temp_v0_5 < 0x8F);
    func_8004DBC0(2);
    var_s2_5 = 0;
    do {
        func_800224AC(arg0 + ((var_s2_5 * 0x30) + 0x84));
        temp_v0_6 = var_s2_5 + 1;
        var_s2_5 = temp_v0_6;
    } while (temp_v0_6 < 8);
}

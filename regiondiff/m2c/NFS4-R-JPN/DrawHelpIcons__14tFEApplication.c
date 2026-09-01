/* NFS4-R-JPN CHANGED @8001348C | base 80013344 DrawHelpIcons__14tFEApplication */
/* callers: Redraw__14tFEApplication */
? func_80020C0C(u8 *, s32, s16, ?, s32, s32);       /* extern */
? func_8004E628(?, ?, s16, s16, s32, s32, ? *);     /* extern */
u8 *func_800B9CCC(?);                               /* extern */
s32 func_800E4818(u8 *);                            /* extern */
? func_800E4E94(u8 *, u8 *);                        /* extern */
s32 func_800EA6BC(u8 *);                            /* extern */

void func_8001348C(void *arg0) {
    ? sp20;
    s32 sp24;
    u8 sp38;
    u8 sp48;
    s8 sp49;
    s16 temp_a2;
    s16 var_s1;
    s16 var_s2;
    s32 temp_s0;
    s32 var_s0;
    s32 var_v1;
    u8 temp_v0;
    void *temp_a0;
    void *temp_v1;

    sp24 = 0x786E14;
    temp_v1 = arg0->unk4;
    var_s2 = *(s32 *)0x8013ED58 - 0x19;
    if ((temp_v1 != NULL) && (temp_v1->unk64 != 0)) {
        sp49 = 0;
        func_800E4E94(&sp38, func_800B9CCC(0xFD));
        var_s0 = func_800EA6BC(&sp38) - 1;
        if (var_s0 >= 0) {
            do {
                temp_a2 = var_s2;
                var_s2 -= 8;
                temp_v0 = (&sp38)[var_s0];
                var_s0 -= 1;
                sp48 = temp_v0;
                func_80020C0C(&sp48, 0xE0000 >> 0x10, temp_a2, 0x786E14, 0, 0);
            } while (var_s0 >= 0);
        }
    } else {
        func_80020C0C(func_800B9CCC(0xFD), 0xE, var_s2, 0x786E14, 0, 0);
        temp_s0 = func_800E4818(func_800B9CCC(0xFD));
        var_s1 = (temp_s0 - func_800EA6BC(func_800B9CCC(0xFD))) + 0x13;
        var_v1 = 0;
        if ((arg0->unk4->unk5C != 0) || ((temp_a0 = arg0->unk8, (temp_a0 != NULL)) && (temp_a0->unk5C != 0))) {
            var_v1 = 1;
        }
        if (var_v1 != 0) {
            if ((((void *)0x8013F990->unk4 == 0) && ((void *)0x8013F990->unk5 != 0x23)) || (((void *)0x8013F990->unk24 == 0) && ((void *)0x8013F990->unk25 != 0x23))) {
                func_8004E628(0x37, 0x18, var_s1, var_s2, 0, 0, &sp20);
                var_s1 += 0xE;
            }
            func_80020C0C(func_800B9CCC(0xFE), (s32) var_s1, var_s2, 0x786E14, 0, 0);
        }
    }
}

/* NFS4-R-AU CHANGED @800138B4 | base 8001373C Redraw__14tFEApplication */
/* callers: RunDemoVideo__14tFEApplication, MainLoop__14tFEApplicationP5tMenu, MainLoop__14tFEApplicationP5tMenu, Run__18tDialogInteractive, Run__18tDialogInteractive */
? func_800134BC(void *);                            /* extern */
? func_80015A98(?);                                 /* extern */
? func_80018888();                                  /* extern */
? func_8001B3BC(void *, ?, s32 *, ? *);             /* extern */
? func_80026240(s32, ?);                            /* extern */
? func_8002689C(s32);                               /* extern */
? func_8004DCB4(?, ?);                              /* extern */
void *func_800BEB88(s32, s32);                      /* extern */
? func_800BEDB0(s32);                               /* extern */
? func_800BEEA0(s32);                               /* extern */
? func_800BF048();                                  /* extern */
? func_800BF0F4();                                  /* extern */
? func_800EEC5C(s32 *, s16 *, s32 *, ?);            /* extern */

void func_800138B4(void *arg0) {
    s16 sp10;
    u16 sp12;
    s16 sp14;
    u16 sp16;
    ? sp18;
    s32 sp20;
    s32 sp24;
    s32 *temp_a0_5;
    s32 *temp_a0_9;
    s32 *temp_a2;
    s32 *temp_a2_2;
    s32 temp_a0_6;
    s32 temp_a0_7;
    s32 temp_a0_8;
    s32 temp_v1_2;
    s32 var_s0;
    s32 var_v0;
    u32 temp_v0;
    u32 var_s4;
    u8 temp_s6;
    u8 temp_v0_2;
    u8 var_s3;
    void *temp_a0;
    void *temp_a0_2;
    void *temp_a0_3;
    void *temp_a0_4;
    void *temp_a1;
    void *temp_s5;
    void *temp_v0_10;
    void *temp_v0_11;
    void *temp_v0_3;
    void *temp_v0_4;
    void *temp_v0_5;
    void *temp_v0_6;
    void *temp_v0_7;
    void *temp_v0_8;
    void *temp_v0_9;
    void *temp_v1;
    void *temp_v1_10;
    void *temp_v1_3;
    void *temp_v1_4;
    void *temp_v1_5;
    void *temp_v1_6;
    void *temp_v1_7;
    void *temp_v1_8;
    void *temp_v1_9;

    temp_s6 = arg0->unk22C;
    func_80015A98(0);
    func_800BF048();
    func_800BEDB0(*(s32 *)0x8013E6DC);
    temp_s5 = func_800BEB88(*(s32 *)0x8013E6DC, *(s32 *)0x8013EAC8);
    if (arg0->unk8 != 0) {
        temp_v0 = *(u32 *)0x8013EF98;
        var_s4 = (u32) (temp_v0 + (temp_v0 >> 0x1F)) >> 1;
    } else {
        var_s4 = (u32) (u16) *(void *)0x8013EF98;
    }
    func_80018888();
    func_800134BC(arg0);
    if (((void *)0x8013FBD0->unk4 != 0) || ((void *)0x8013FBD0->unk24 != 0)) {
        temp_a1 = *(void *)0x80051F98;
        temp_a1->unk2C = (s32) (temp_a1->unk2C | 1);
        temp_a0 = arg0->unk4;
        sp20 = 0x200;
        if ((temp_a0 + (temp_a0->unk8 * 4))->unk10 == (temp_a1 + 0x2C)) {
            func_8001B3BC(temp_a1 + 0xB0, 0, &sp20, &sp18);
        }
    } else {
        temp_a0_2 = *(void **)0x80051F98;
        temp_a0_2->unk2C = (s32) (temp_a0_2->unk2C & ~1);
    }
    if (*(u8 *)0x8013FBD4 != 0) {
        temp_a0_3 = *(void *)0x80051F98;
        temp_a0_3->unk0 = (s32) (temp_a0_3->unk0 | 1);
        temp_v1 = arg0->unk4;
        temp_v1_2 = (temp_v1 + (temp_v1->unk8 * 4))->unk10;
        sp24 = 0x400;
        if (temp_v1_2 == temp_a0_3) {
            func_8001B3BC(temp_v1_2 + 0xB0, 0, &sp24, &sp18);
        }
    } else {
        temp_a0_4 = *(void *)0x80051F98;
        temp_a0_4->unk0 = (s32) (temp_a0_4->unk0 & ~1);
    }
    var_s3 = 1;
    temp_a0_5 = *(s32 **)0x1F800004;
    sp10 = 0;
    sp14 = 0x200;
    temp_a2 = *(s32 **)0x1F800000;
    sp12 = temp_s5->unk2;
    sp16 = (u16) *(void *)0x8013EF98;
    *temp_a0_5 = (*temp_a0_5 & 0xFF000000) | (*temp_a2 & 0xFFFFFF);
    *(s32 **)0x1F800004 = temp_a0_5 + 0xC;
    *temp_a2 = (*temp_a2 & 0xFF000000) | ((s32) temp_a0_5 & 0xFFFFFF);
    func_800EEC5C(temp_a0_5, &sp10, temp_a2, 0xFFFFFF);
    var_v0 = var_s4 << 0x10;
    do {
        arg0->unk22C = var_s3;
        arg0->unk154 = (u16) ((var_s3 & 0xFF) * (var_v0 >> 0x10));
        temp_v1_3 = (arg0 + ((var_s3 & 0xFF) * 4))->unk4;
        if (temp_v1_3 != NULL) {
            temp_v0_3 = temp_v1_3->unk68;
            temp_v0_3->unk54(temp_v1_3 + temp_v0_3->unk50);
        }
        temp_v1_4 = (arg0 + (arg0->unk22C * 4))->unk24;
        if (temp_v1_4 != NULL) {
            temp_v0_4 = temp_v1_4->unk68;
            temp_v0_4->unk54(temp_v1_4 + temp_v0_4->unk50);
        }
        temp_a0_6 = (arg0 + (arg0->unk22C * 4))->unkC;
        if (temp_a0_6 != 0) {
            func_8002689C(temp_a0_6);
        }
        temp_v1_5 = (arg0 + (arg0->unk22C * 4))->unk4;
        if (temp_v1_5 != NULL) {
            temp_v0_5 = temp_v1_5->unk68;
            if (temp_v0_5->unk44(temp_v1_5 + temp_v0_5->unk40) != 0) {
                temp_v1_6 = (arg0 + (arg0->unk22C * 4))->unk4;
                temp_v0_6 = temp_v1_6->unk68;
                temp_v0_6->unk4C(temp_v1_6 + temp_v0_6->unk48);
            }
        }
        temp_a0_7 = (arg0 + (arg0->unk22C * 4))->unkC;
        if (temp_a0_7 != 0) {
            func_80026240(temp_a0_7, 0);
        }
        temp_v0_7 = arg0 + (arg0->unk22C * 4);
        temp_v1_7 = temp_v0_7->unk4;
        if (temp_v1_7 != NULL) {
            var_s0 = 0;
            if (temp_v0_7->unk230 != 0) {
                temp_v0_8 = temp_v1_7->unk68;
                if (temp_v0_8->unk3C(temp_v1_7 + temp_v0_8->unk38) == 0) {
                    temp_v1_8 = (arg0 + (arg0->unk22C * 4))->unk4;
                    temp_v0_9 = temp_v1_8->unk68;
                    var_s0 = temp_v0_9->unk44(temp_v1_8 + temp_v0_9->unk40) == 0;
                }
                if (var_s0 != 0) {
                    goto block_30;
                }
            } else {
block_30:
                temp_v1_9 = (arg0 + (arg0->unk22C * 4))->unk4;
                temp_v0_10 = temp_v1_9->unk68;
                temp_v0_10->unk4C(temp_v1_9 + temp_v0_10->unk48);
            }
            temp_v1_10 = (arg0 + (arg0->unk22C * 4))->unk24;
            if (temp_v1_10 != NULL) {
                temp_v0_11 = temp_v1_10->unk68;
                temp_v0_11->unk4C(temp_v1_10 + temp_v0_11->unk48);
            }
        }
        temp_a0_8 = (arg0 + (arg0->unk22C * 4))->unkC;
        if (temp_a0_8 != 0) {
            func_80026240(temp_a0_8, 1);
        }
        temp_a0_9 = *(void *)0x1F800004;
        sp10 = 0;
        temp_a2_2 = *(void *)0x1F800000;
        sp14 = 0x200;
        sp16 = (u16) var_s4;
        sp12 = temp_s5->unk2 + arg0->unk154;
        *temp_a0_9 = (*temp_a0_9 & 0xFF000000) | (*temp_a2_2 & 0xFFFFFF);
        *(void *)0x1F800004 = (s32 *) (temp_a0_9 + 0xC);
        *temp_a2_2 = (*temp_a2_2 & 0xFF000000) | ((s32) temp_a0_9 & 0xFFFFFF);
        func_800EEC5C(temp_a0_9, &sp10, temp_a2_2, 0xFF000000);
        temp_v0_2 = var_s3 - 1;
        var_s3 = temp_v0_2;
        var_v0 = var_s4 << 0x10;
    } while (!(temp_v0_2 & 0x8000));
    func_8004DCB4(0, 8);
    arg0->unk22C = temp_s6;
    func_800BEEA0(*(void *)0x8013E6DC);
    func_800BF0F4();
}

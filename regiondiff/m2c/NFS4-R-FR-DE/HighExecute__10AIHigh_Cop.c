/* NFS4-R-FR-DE CHANGED @800644B4 | base 80063CC4 HighExecute__10AIHigh_Cop */
? func_8005C9DC();                                  /* extern */
s32 func_8005CAA4(void *, ?, void *);               /* extern */
? func_8005CF80(void *, void *);                    /* extern */
? func_8005D218(void *);                            /* extern */
? func_8006443C(void *);                            /* extern */
s32 func_80065B94(void *);                          /* extern */
? func_80065C30(void *);                            /* extern */
s32 func_80065DA8(void *, ?, ?);                    /* extern */
? func_80066008(void *, s32, void *, u8);           /* extern */
s32 func_80066094(void *, s32 *);                   /* extern */
void *func_80066144(void *);                        /* extern */
s32 func_80067E50(void *);                          /* extern */
? func_800689A0(void *, s32, ?, ?, s32);            /* extern */
? func_80068B24(void *, s32, ?, s32 *, ? *);        /* extern */
? func_80068CD4(void *, s32, s32, s32, s32);        /* extern */
? func_8006D1F0(void *, ?);                         /* extern */
? func_80070244(void *);                            /* extern */
? func_800702CC(void *, void *);                    /* extern */
void *func_800702E4(?);                             /* extern */
void *func_800703BC(void *, void *);                /* extern */
void *func_800704DC(void *, void *, void *, s32 *, s32, s32, s32, s32, s32); /* extern */
? func_8007066C(void *, void *, s32 *);             /* extern */
? func_8007074C(void *, ?, s32);                    /* extern */
s32 func_800715F4(void *);                          /* extern */
void *func_80071A00(void *, void *, s32, s32 *, ? *, s32, s32, s32); /* extern */
? func_80071B48(void *, void *);                    /* extern */
void *func_80071D6C(void *, void *);                /* extern */
void *func_80072C4C(void *, void *, s32, ?);        /* extern */
s32 func_80072DB8(void *, ?);                       /* extern */
? func_800736F0(s32, s32 *);                        /* extern */
s32 func_80073998(void *, void *);                  /* extern */
s32 func_80073A08(void *, s32);                     /* extern */
? func_8007E26C(s32, s32, s32, ?);                  /* extern */
? func_8008708C(void *, ?, ?);                      /* extern */
void *func_80098350(void *);                        /* extern */
? func_800E4EF0(s32 *, ?, ?);                       /* extern */
s32 func_800E4F00(s32, ?, ?);                       /* extern */
s32 func_800E4FDC(s32, s32);                        /* extern */
s32 func_800E5084(s32);                             /* extern */

void func_800644B4(void *arg0) {
    s32 sp28;
    s32 sp30;
    s32 sp34;
    s32 sp38;
    ? sp40;
    ? var_a1_3;
    ? var_s0_7;
    ? var_s3;
    s32 *var_v1;
    s32 temp_a1;
    s32 temp_a1_4;
    s32 temp_lo;
    s32 temp_lo_2;
    s32 temp_s0_3;
    s32 temp_s0_8;
    s32 temp_v0_17;
    s32 temp_v0_29;
    s32 temp_v0_30;
    s32 temp_v0_31;
    s32 temp_v0_8;
    s32 temp_v1_16;
    s32 temp_v1_22;
    s32 temp_v1_27;
    s32 temp_v1_29;
    s32 temp_v1_30;
    s32 temp_v1_32;
    s32 temp_v1_4;
    s32 temp_v1_9;
    s32 var_a0;
    s32 var_a0_3;
    s32 var_a1;
    s32 var_a1_4;
    s32 var_s0_2;
    s32 var_s0_5;
    s32 var_s0_6;
    s32 var_s2;
    s32 var_s2_2;
    s32 var_v0_3;
    s32 var_v0_4;
    s32 var_v0_7;
    s32 var_v0_8;
    s32 var_v1_2;
    s32 var_v1_3;
    u32 temp_v1;
    u32 var_v0;
    u32 var_v0_5;
    u32 var_v0_6;
    u8 temp_a3;
    void **var_s0_8;
    void *temp_a0;
    void *temp_a0_2;
    void *temp_a0_3;
    void *temp_a0_4;
    void *temp_a0_5;
    void *temp_a1_2;
    void *temp_a1_3;
    void *temp_a2;
    void *temp_a2_2;
    void *temp_a2_3;
    void *temp_s0;
    void *temp_s0_10;
    void *temp_s0_11;
    void *temp_s0_12;
    void *temp_s0_13;
    void *temp_s0_2;
    void *temp_s0_4;
    void *temp_s0_5;
    void *temp_s0_6;
    void *temp_s0_7;
    void *temp_s0_9;
    void *temp_s2;
    void *temp_v0;
    void *temp_v0_10;
    void *temp_v0_11;
    void *temp_v0_12;
    void *temp_v0_13;
    void *temp_v0_14;
    void *temp_v0_15;
    void *temp_v0_16;
    void *temp_v0_18;
    void *temp_v0_19;
    void *temp_v0_20;
    void *temp_v0_21;
    void *temp_v0_22;
    void *temp_v0_23;
    void *temp_v0_24;
    void *temp_v0_25;
    void *temp_v0_26;
    void *temp_v0_27;
    void *temp_v0_28;
    void *temp_v0_2;
    void *temp_v0_32;
    void *temp_v0_33;
    void *temp_v0_34;
    void *temp_v0_35;
    void *temp_v0_36;
    void *temp_v0_37;
    void *temp_v0_38;
    void *temp_v0_39;
    void *temp_v0_3;
    void *temp_v0_4;
    void *temp_v0_5;
    void *temp_v0_6;
    void *temp_v0_7;
    void *temp_v0_9;
    void *temp_v1_10;
    void *temp_v1_11;
    void *temp_v1_12;
    void *temp_v1_13;
    void *temp_v1_14;
    void *temp_v1_15;
    void *temp_v1_17;
    void *temp_v1_18;
    void *temp_v1_19;
    void *temp_v1_20;
    void *temp_v1_21;
    void *temp_v1_23;
    void *temp_v1_24;
    void *temp_v1_25;
    void *temp_v1_26;
    void *temp_v1_28;
    void *temp_v1_2;
    void *temp_v1_31;
    void *temp_v1_33;
    void *temp_v1_34;
    void *temp_v1_35;
    void *temp_v1_36;
    void *temp_v1_37;
    void *temp_v1_38;
    void *temp_v1_3;
    void *temp_v1_5;
    void *temp_v1_6;
    void *temp_v1_7;
    void *temp_v1_8;
    void *var_a0_2;
    void *var_a1_2;
    void *var_a2;
    void *var_s0;
    void *var_s0_3;
    void *var_s0_4;
    void *var_v0_2;

    arg0->unk0->unk268 = 0;
    arg0->unk0->unk264 = 0;
    func_8005C9DC();
    func_80065C30(arg0);
    func_8006443C(arg0);
    temp_v1 = arg0->unk8;
    switch (temp_v1) {                              /* switch 1 */
    case 0:                                         /* switch 1 */
        func_80066008(arg0, 0);
        temp_a0 = arg0->unk0;
        temp_a0->unk570 = (s32) (temp_a0->unk570 & ~2);
        if (arg0->unk0->unk260 & 0x400) {
            var_s0 = func_800702E4(0x10);
            func_800702CC(var_s0, arg0->unk0);
            var_s0->unk4 = 0x80055DD0;
            var_s0->unkC = 1;
            temp_v1_2 = arg0->unk4;
            if (temp_v1_2 != NULL) {
                temp_v0 = temp_v1_2->unk4;
                temp_v0->unk14(temp_v1_2 + temp_v0->unk10, 3);
            }
            var_v0 = 3;
        } else {
            temp_v1_3 = arg0->unk4;
            var_s0 = func_80071D6C(func_800702E4(8), arg0->unk0);
            if (temp_v1_3 != NULL) {
                temp_v0_2 = temp_v1_3->unk4;
                temp_v0_2->unk14(temp_v1_3 + temp_v0_2->unk10, 3);
            }
            var_v0 = 1;
        }
        arg0->unk4 = var_s0;
        arg0->unk8 = var_v0;
        return;
    case 1:                                         /* switch 1 */
        temp_a0_2 = arg0->unk0;
        temp_a0_2->unk570 = (s32) (temp_a0_2->unk570 & ~2);
        arg0->unk64 = -1;
        arg0->unk54 = 0;
        if (arg0->unk20 == 4) {
            arg0->unk20 = 0;
        }
        temp_v1_4 = arg0->unk20;
        if (temp_v1_4 == 2) {
            func_80066008(arg0, arg0->unk24);
            temp_v0_3 = func_800702E4(0x10);
            func_800702CC(temp_v0_3, arg0->unk0);
            temp_v0_3->unk4 = 0x80055DD0;
            temp_v0_3->unkC = 1;
            temp_v1_5 = arg0->unk4;
            if (temp_v1_5 != NULL) {
                temp_v0_4 = temp_v1_5->unk4;
                temp_v0_4->unk14(temp_v1_5 + temp_v0_4->unk10, 3);
            }
            arg0->unk4 = temp_v0_3;
            arg0->unk8 = 3U;
            func_80068CD4(arg0->unk0, arg0->unk34, arg0->unk38, arg0->unk3C, arg0->unk40);
            arg0->unk64 = (s32) arg0->unk30;
        } else if ((arg0->unk0->unk570 & 8) && (temp_v1_4 != 1)) {
            var_v0_2 = func_80066144(arg0);
            var_s0_2 = 0;
            if (var_v0_2 != NULL) {
                var_v1 = &sp28;
                temp_a0_3 = var_v0_2 + 0x40;
                do {
                    var_v1->unk0 = var_v0_2->unk0;
                    var_v1->unk4 = (s32) var_v0_2->unk4;
                    var_v1->unk8 = (s32) var_v0_2->unk8;
                    var_v1->unkC = (s32) var_v0_2->unkC;
                    var_v0_2 += 0x10;
                    var_v1 += 0x10;
                } while (var_v0_2 != temp_a0_3);
                var_v1->unk0 = var_v0_2->unk0;
                var_v1->unk4 = (s32) var_v0_2->unk4;
                if (*(s32 *)0x8013DB20 == 2) {
                    var_v0_3 = func_80073998(*(void **)0x80110D38, ((void **)0x80110000 + 0xD38)->unk4);
                    if (var_v0_3 < 0) {
                        var_v0_3 = -var_v0_3;
                    }
                    if (var_v0_3 <= 0x012BFFFF) {
                        var_s0_2 = 1;
                    }
                }
                if (var_s0_2 != 0) {
                    sp28 = 1;
                    sp38 = 1;
                    sp30 = 1;
                    sp34 = 1;
                }
                func_800736F0(*(s32 *)0x8013D904, &sp28);
                switch (sp28) {                     /* switch 2; irregular */
                case 2:                             /* switch 2 */
                    break;
                case 3:                             /* switch 2 */
                    var_v0_4 = ~sp30;
                    if (*(s32 *)0x80114500 == 0) {
                        var_v0_4 = sp30 ^ 1;
                    }
                    if ((var_v0_4 == 0) || (sp30 == 0)) {
                        func_80066008(arg0, 0);
                        temp_v1_6 = arg0->unk4;
                        temp_s0 = func_80071A00(func_800702E4(0x68), arg0->unk0, sp2C, &sp34, &sp40, sp64, sp68, sp6C);
                        if (temp_v1_6 != NULL) {
                            temp_v0_5 = temp_v1_6->unk4;
                            temp_v0_5->unk14(temp_v1_6 + temp_v0_5->unk10, 3);
                        }
                        arg0->unk4 = temp_s0;
                        arg0->unk8 = 5U;
                        func_80068B24(arg0->unk0, sp2C, 1, &sp34, &sp40);
                    }
                    break;
                case 1:                             /* switch 2 */
                    temp_lo = *(s32 *)0x8013E400 * *(s32 *)0x8013E408;
                    *(s32 *)0x8013E404 = temp_lo;
                    *(void *)0x8013E400 = (s32) (temp_lo & 0xFFFF);
                    var_s3 = -1;
                    if (*(void *)0x80114500 == 0) {
                        var_s3 = 1;
                    }
                    if (sp38 != 0) {
                        func_80066008(arg0, 0);
                        temp_v1_7 = arg0->unk4;
                        var_s0_3 = func_800703BC(func_800702E4(8), arg0->unk0);
                        if (temp_v1_7 != NULL) {
                            temp_v0_6 = temp_v1_7->unk4;
                            temp_v0_6->unk14(temp_v1_7 + temp_v0_6->unk10, 3);
                        }
                        var_v0_5 = 2;
                    } else {
                        func_80066008(arg0, 0);
                        var_s0_3 = func_800702E4(0x10);
                        func_800702CC(var_s0_3, arg0->unk0);
                        var_s0_3->unk4 = 0x80055DD0;
                        var_s0_3->unkC = sp28;
                        temp_v1_8 = arg0->unk4;
                        if (temp_v1_8 != NULL) {
                            temp_v0_7 = temp_v1_8->unk4;
                            temp_v0_7->unk14(temp_v1_8 + temp_v0_7->unk10, 3);
                        }
                        var_v0_5 = 3;
                    }
                    arg0->unk4 = var_s0_3;
                    arg0->unk8 = var_v0_5;
                    func_800689A0(arg0->unk0, sp2C, var_s3, var_s3, sp38);
                    break;
                }
            }
        }
    default:                                        /* switch 1 */
block_212:
        func_80070244(arg0->unk4);
        return;
    case 2:                                         /* switch 1 */
        arg0->unk64 = -1;
        temp_v0_8 = arg0->unk20;
        if (temp_v0_8 != 1) {
            if (temp_v0_8 != 4) {
                temp_v0_9 = arg0->unk0;
                temp_v0_9->unk570 = (s32) (temp_v0_9->unk570 & ~2);
            }
            temp_v1_9 = arg0->unk20;
            if ((temp_v1_9 != 1) && (temp_v1_9 != 4) && (func_80065DA8(arg0, 1) != 0)) {
                func_80066094(arg0, &sp28);
                temp_v1_10 = arg0->unk4;
                temp_s0_2 = func_800704DC(func_800702E4(0x94), arg0->unk0, arg0->unk58->unk0, &sp28, ((arg0->unk68 * 0x14) + 0x8010DB2C)->unk10, *(0x8010DC4C + (arg0->unk18 * 8)), ((arg0->unk18 * 8) + 0x8010DC4C)->unk4, arg0->unk68, *(0x8010DB68 + (*(s32 *)0x801144D8 * 4)));
                if (temp_v1_10 != NULL) {
                    temp_v0_10 = temp_v1_10->unk4;
                    temp_v0_10->unk14(temp_v1_10 + temp_v0_10->unk10, 3);
                }
                arg0->unk4 = temp_s0_2;
                arg0->unk8 = 4U;
                temp_v0_11 = func_80098350(arg0->unk0);
                temp_a2 = temp_v0_11->unk4C;
                temp_a2->unk34(temp_v0_11 + temp_a2->unk30, arg0->unk58->unk0, temp_a2);
            }
        }
        if ((arg0->unk5C != 0) || (func_80067E50(arg0->unk0) != 0)) {
            arg0->unk5C = 0;
            temp_v0_12 = func_80098350(arg0->unk0);
            temp_v1_11 = temp_v0_12->unk4C;
            temp_v1_11->unk84(temp_v0_12 + temp_v1_11->unk80);
            func_80066008(arg0, 0);
            temp_v1_12 = arg0->unk4;
            var_s0_4 = func_80071D6C(func_800702E4(8), arg0->unk0);
            if (temp_v1_12 != NULL) {
                temp_v0_13 = temp_v1_12->unk4;
                temp_v0_13->unk14(temp_v1_12 + temp_v0_13->unk10, 3);
            }
            var_v0_6 = 1;
block_211:
            arg0->unk4 = var_s0_4;
            arg0->unk8 = var_v0_6;
        }
        goto block_212;
    case 4:                                         /* switch 1 */
        temp_v0_14 = arg0->unk0;
        temp_s2 = arg0->unk4;
        temp_v0_14->unk570 = (s32) (temp_v0_14->unk570 | 2);
        var_a2 = (void *)1;
        if (arg0->unk58 != NULL) {
            if (temp_s2->unk90 >= 0xA1) {
                temp_s0_3 = func_800715F4(temp_s2);
                temp_v1_13 = arg0->unk4;
                temp_s0_4 = func_80072C4C(func_800702E4(0x10), arg0->unk0, temp_s0_3, 0);
                if (temp_v1_13 != NULL) {
                    temp_v0_15 = temp_v1_13->unk4;
                    temp_v0_15->unk14(temp_v1_13 + temp_v0_15->unk10, 3);
                }
                arg0->unk4 = temp_s0_4;
                arg0->unk8 = 9U;
                temp_v0_16 = func_80098350(arg0->unk0);
                temp_v1_14 = temp_v0_16->unk4C;
                temp_v1_14->unk3C(temp_v0_16 + temp_v1_14->unk38);
            }
            temp_v1_15 = arg0->unk58->unk9C + (arg0->unk18 * 4);
            if ((temp_v1_15->unk0 == 0) && (temp_v1_15->unkC == 0)) {
                temp_s2->unk7C = 0;
            }
            arg0->unk64 = -1;
            var_a0 = 0;
            if ((void *)0x8011F390->unk4 >= temp_s2->unk8C) {
                var_a0 = ~func_80065B94(arg0) != 0;
            }
            if (var_a0 != 0) {
                temp_s2->unk8C = (s32) ((void *)0x8011F390->unk4 + 0x3C0);
            }
            func_8005D218(arg0);
            var_s0_5 = 0;
            if (func_80066094(arg0, &sp28) != 0) {
                var_s0_5 = temp_s2->unk70 == 0;
            }
            if (var_s0_5 != 0) {
                func_8007066C(temp_s2, arg0->unk58->unk0, &sp28);
            }
            temp_v0_17 = arg0->unk68 * 0x14;
            temp_v0_18 = temp_v0_17 + 0x8010DB2C;
            var_a1 = 0;
            if (*(0x8010DB2C + temp_v0_17) < temp_s2->unk78) {
                var_v0_7 = temp_s2->unk6C;
                if (var_v0_7 < 0) {
                    var_v0_7 = -var_v0_7;
                }
                if (var_v0_7 < temp_v0_18->unk4) {
                    var_v0_8 = temp_s2->unk68;
                    if (var_v0_8 < 0) {
                        var_v0_8 = -var_v0_8;
                    }
                    var_a1 = var_v0_8 < temp_v0_18->unk8;
                }
            }
            if (var_a1 != 0) {
                func_8007074C(temp_s2, 1, ((arg0->unk68 * 0x14) + 0x8010DB2C)->unkC);
            }
            var_s0_6 = 0;
            if (func_8005CAA4(arg0, 0x4000, arg0->unk58->unk0) != 0) {
                var_s0_6 = temp_s2->unk70 == 0;
            }
            if (var_s0_6 != 0) {
                func_800E4EF0(&sp38, 0, 0xC);
                func_8007066C(temp_s2, arg0->unk58->unk0, &sp38);
                func_8007074C(temp_s2, 1, 0x20);
            }
            if (func_80065DA8(arg0) != 0) {
                func_80066094(arg0, &sp38);
                func_8007066C(temp_s2, arg0->unk58->unk0, &sp38);
            }
            temp_v1_16 = arg0->unk20;
            if (temp_v1_16 != 1) {
                if (temp_v1_16 != 4) {
                    temp_v0_19 = arg0->unk58;
                    if ((temp_v0_19 == NULL) || (temp_v0_19->unk0->unk390 >= 2)) {
                        goto block_99;
                    }
                } else {
block_99:
                    if ((temp_v1_16 == 1) || (temp_v1_16 == 4)) {
                        goto block_101;
                    }
                    goto block_104;
                }
            } else {
block_101:
                var_a0_2 = (void *)1;
                if (*(void *)0x80114500 == 0) {
                    var_a0_2 = (void *)-1;
                }
                arg0->unk0->unk550 = var_a0_2;
                arg0->unk0->unk6F0 = 1;
block_104:
                func_80066008(arg0, 0);
                temp_v1_17 = arg0->unk4;
                temp_s0_5 = func_800703BC(func_800702E4(8), arg0->unk0);
                if (temp_v1_17 != NULL) {
                    temp_v0_20 = temp_v1_17->unk4;
                    temp_v0_20->unk14(temp_v1_17 + temp_v0_20->unk10, 3);
                }
                arg0->unk4 = temp_s0_5;
                arg0->unk8 = 2U;
            }
            if ((arg0->unk5C != 0) || (func_80067E50(arg0->unk0) != 0)) {
                if ((func_80067E50(arg0->unk0) != 0) && (arg0->unk54 == 0)) {
                    temp_v0_21 = func_80098350(arg0->unk0);
                    temp_v1_18 = temp_v0_21->unk4C;
                    temp_v1_18->unk3C(temp_v0_21 + temp_v1_18->unk38);
                }
                temp_v0_22 = func_80098350(arg0->unk0);
                temp_v1_19 = temp_v0_22->unk4C;
                temp_v1_19->unk84(temp_v0_22 + temp_v1_19->unk80);
                arg0->unk5C = 0;
                func_80066008(arg0, 0);
                temp_v1_20 = arg0->unk4;
                var_s0_4 = func_80071D6C(func_800702E4(8), arg0->unk0);
                if (temp_v1_20 != NULL) {
                    temp_v0_23 = temp_v1_20->unk4;
                    temp_v0_23->unk14(temp_v1_20 + temp_v0_23->unk10, 3);
                }
                var_v0_6 = 1;
                goto block_211;
            }
            var_a2 = (void *)1;
            if (arg0->unk54 != 0) {
                goto block_130;
            }
        } else {
block_129:
block_130:
            if (*(void *)0x80114500 == 0) {
                var_a2 = (void *)-1;
            }
            arg0->unk0->unk550 = var_a2;
            arg0->unk0->unk6F0 = 1;
            func_80066008(arg0, 0, var_a2);
            temp_v1_21 = arg0->unk4;
            temp_s0_6 = func_800703BC(func_800702E4(8), arg0->unk0);
            if (temp_v1_21 != NULL) {
                temp_v0_24 = temp_v1_21->unk4;
                temp_v0_24->unk14(temp_v1_21 + temp_v0_24->unk10, 3);
            }
            arg0->unk4 = temp_s0_6;
            arg0->unk8 = 2U;
            if (arg0->unk54 == 1) {
                func_8008708C(arg0->unk0, 1, 1);
            }
            arg0->unk54 = 0;
        }
        goto block_212;
    case 3:                                         /* switch 1 */
        temp_v1_22 = arg0->unk20;
        if ((temp_v1_22 == 1) || (temp_v1_22 == 4)) {
            var_a1_2 = (void *)1;
            if (*(void *)0x80114500 == 0) {
                var_a1_2 = (void *)-1;
            }
            arg0->unk0->unk550 = var_a1_2;
            arg0->unk0->unk6F0 = 1;
            func_80066008(arg0, 0, (void *)1);
            temp_v1_23 = arg0->unk4;
            temp_s0_7 = func_800703BC(func_800702E4(8), arg0->unk0);
            if (temp_v1_23 != NULL) {
                temp_v0_25 = temp_v1_23->unk4;
                temp_v0_25->unk14(temp_v1_23 + temp_v0_25->unk10, 3);
            }
            arg0->unk4 = temp_s0_7;
            arg0->unk8 = 2U;
        }
        if (arg0->unk5C != 0) {
            arg0->unk5C = 0;
            temp_v0_26 = func_80098350(arg0->unk0);
            temp_v1_24 = temp_v0_26->unk4C;
            temp_v1_24->unk84(temp_v0_26 + temp_v1_24->unk80);
            func_80066008(arg0, 0);
            temp_v1_25 = arg0->unk4;
            var_s0_4 = func_80071D6C(func_800702E4(8), arg0->unk0);
            if (temp_v1_25 != NULL) {
                temp_v0_27 = temp_v1_25->unk4;
                temp_v0_27->unk14(temp_v1_25 + temp_v0_27->unk10, 3);
            }
            var_v0_6 = 1;
            goto block_211;
        }
        var_a2 = (void *)1;
        if (arg0->unk54 != 0) {
            goto block_129;
        }
        if (arg0->unk20 == 2) {
            temp_v1_26 = arg0->unk0;
            temp_v1_26->unk570 = (s32) (temp_v1_26->unk570 | 2);
            var_s2 = 0;
            if (arg0->unk64 != -1) {
                if ((void *)0x8010E1D4->unk0 == 0) {
                    temp_v1_27 = *(void *)0x801144D8;
                    if (temp_v1_27 != 0) {
                        var_s0_7 = 0xE666;
                        if (temp_v1_27 == 1) {
                            var_s0_7 = 0xCCCC;
                        }
                    } else {
                        var_s0_7 = 0xB333;
                    }
                    temp_v0_28 = (arg0->unk64 << 5) + *(s32 *)0x8013DAE0;
                    temp_v1_28 = (arg0->unk64 << 5) + *(void *)0x8013DAE0;
                    temp_s0_8 = func_800E4F00((temp_v0_28->unk1E << 0xF) * ((u8) temp_v0_28->unk1D >> 4), var_s0_7, 1);
                    temp_v0_29 = func_800E4F00((temp_v1_28->unk1F << 0xF) * (temp_v1_28->unk1D & 0xF), var_s0_7);
                    temp_a1 = -temp_s0_8;
                    (void *)0x8010E1D4->unk8 = temp_a1;
                    (void *)0x8010E1D4->unkC = temp_v0_29;
                    (void *)0x8010E1D4->unk0 = 1;
                    (void *)0x8010E1D4->unk4 = (s32) arg0->unk64;
                    (void *)0x8010E1D4->unk10 = (s32) *(s32 *)0x8011F394;
                    func_8007E26C(arg0->unk64, temp_a1, temp_s0_8 + temp_v0_29, 0x80110000);
                }
            }
            *(s32 *)0x8013D890 = 1;
            if ((arg0->unk64 != -1) && ((void *)0x8010E1D4->unk4 == arg0->unk64)) {
                (void *)0x8010E1D4->unk10 = (s32) *(void *)0x8011F394;
            }
            if (arg0->unk28 != 0) {
                if (*(s32 *)0x8013EB30 != 0) {
                    *(void *)0x8013EB44 = func_800E5084(*(s32 *)0x8013EB44);
                    *(void *)0x8013EB30 = 0;
                    func_8005CF80(arg0, arg0 + 0x20);
                    *(void *)0x8013EB44 = func_800E5084(*(void *)0x8013EB44);
                    *(void *)0x8013EB30 = 1;
                } else {
                    func_8005CF80(arg0, arg0 + 0x20);
                }
            }
            temp_a1_2 = arg0->unk58;
            temp_s0_9 = temp_a1_2 + 0x8C;
            var_v1_2 = temp_s0_9->unk10->unk24 * *(s32 *)0x8013D914;
            if (var_v1_2 < 0) {
                var_v1_2 += 0xFFFF;
            }
            temp_v1_29 = var_v1_2 >> 0x10;
            temp_lo_2 = 0x10000 / (s32) (temp_v1_29 << 5);
            temp_a1_2->unk8C = (s32) (temp_v1_29 << 0x15);
            temp_s0_9->unk1C = temp_lo_2;
            temp_v1_30 = *(s32 *)0x801144D4;
            if (temp_v1_30 == 2) {
                var_a1_3 = 0x13333;
                goto block_158;
            }
            var_a1_3 = 0xA8F5;
            if (temp_v1_30 == 4) {
block_158:
                temp_s0_9->unk1C = func_800E4F00(temp_lo_2, var_a1_3);
            }
            func_80066094(arg0, &sp28);
            temp_v0_30 = func_80073998(arg0->unk0, arg0->unk58->unk0);
            var_a1_4 = temp_v0_30;
            if (temp_v0_30 < 0) {
                var_a1_4 = -var_a1_4;
            }
            if (var_a1_4 > 0x31FFFF) {
                if (var_a1_4 <= 0x012BFFFF) {
                    var_v1_3 = arg0->unk58->unk0->unk564;
                    if (var_v1_3 <= 0) {
                        var_v1_3 = -var_v1_3;
                    }
                    if (var_v1_3 > 0x471C7) {
                        temp_v0_31 = func_800E4FDC(temp_v0_30, arg0->unk58->unk0->unk564);
                        if ((temp_v0_31 > 0) && (temp_v0_31 < arg0->unk48)) {
                            goto block_168;
                        }
                    }
                }
            } else {
block_168:
                var_s2 = 1;
            }
            if (var_s2 == 0) {
                var_a0_3 = func_80073A08(arg0->unk58->unk0, arg0->unk34);
                if (var_a0_3 < 0) {
                    var_a0_3 += 0xFFFF;
                }
                if ((arg0->unk4C * (var_a0_3 >> 0x10)) > 0) {
                    goto block_173;
                }
            } else {
block_173:
                temp_a0_4 = arg0->unk58;
                arg0->unk64 = -1;
                if (arg0->unk2C == temp_a0_4->unk94) {
                    temp_a0_4->unk8C = 0;
                }
                arg0->unk20 = 0;
                temp_v1_31 = arg0->unk4;
                temp_s0_10 = func_800704DC(func_800702E4(0x94), arg0->unk0, arg0->unk58->unk0, &sp28, ((arg0->unk68 * 0x14) + 0x8010DB2C)->unk10, *(0x8010DC4C + (arg0->unk18 * 8)), ((arg0->unk18 * 8) + 0x8010DC4C)->unk4, arg0->unk68, *(0x8010DB68 + (*(void *)0x801144D8 * 4)));
                if (temp_v1_31 != NULL) {
                    temp_v0_32 = temp_v1_31->unk4;
                    temp_v0_32->unk14(temp_v1_31 + temp_v0_32->unk10, 3);
                }
                arg0->unk4 = temp_s0_10;
                arg0->unk8 = 4U;
                if (arg0->unk44 != 0) {
                    func_8006D1F0(arg0->unk0, 0x40);
                }
            }
        } else {
            temp_v0_33 = arg0->unk0;
            temp_v0_33->unk570 = (s32) (temp_v0_33->unk570 & ~2);
            if ((func_80065DA8(arg0, -3, 1) != 0) && (temp_v1_32 = arg0->unk20, (temp_v1_32 != 1)) && (temp_v1_32 != 4)) {
                func_80066094(arg0, &sp28);
                temp_v1_33 = arg0->unk4;
                temp_s0_11 = func_800704DC(func_800702E4(0x94), arg0->unk0, arg0->unk58->unk0, &sp28, ((arg0->unk68 * 0x14) + 0x8010DB2C)->unk10, *(0x8010DC4C + (arg0->unk18 * 8)), ((arg0->unk18 * 8) + 0x8010DC4C)->unk4, arg0->unk68, *(0x8010DB68 + (*(void *)0x801144D8 * 4)));
                if (temp_v1_33 != NULL) {
                    temp_v0_34 = temp_v1_33->unk4;
                    temp_v0_34->unk14(temp_v1_33 + temp_v0_34->unk10, 3);
                }
                arg0->unk4 = temp_s0_11;
                arg0->unk8 = 4U;
                temp_v0_35 = func_80098350(arg0->unk0);
                temp_a2_2 = temp_v0_35->unk4C;
                temp_a2_2->unk34(temp_v0_35 + temp_a2_2->unk30, arg0->unk58->unk0, temp_a2_2);
            } else if (func_80067E50(arg0->unk0) != 0) {
                func_80066008(arg0, 0);
                temp_v1_34 = arg0->unk4;
                var_s0_4 = func_80071D6C(func_800702E4(8), arg0->unk0);
                if (temp_v1_34 != NULL) {
                    temp_v0_36 = temp_v1_34->unk4;
                    temp_v0_36->unk14(temp_v1_34 + temp_v0_36->unk10, 3);
                }
                var_v0_6 = 1;
                goto block_211;
            }
        }
        goto block_212;
    case 5:                                         /* switch 1 */
        temp_v1_35 = arg0->unk0;
        if (temp_v1_35->unk90 == 0) {
            temp_v1_35->unk784 = 0;
        } else {
            temp_v1_35->unk784 = 0x18000;
        }
        arg0->unk64 = -1;
        var_s2_2 = 0;
        var_s0_8 = (void **)0x80110CF0;
loop_193:
        if (var_s2_2 < *(s32 *)0x8013DB18) {
            temp_a1_3 = *var_s0_8;
            if ((*(0x8010D9C0 + (temp_a1_3->unk254 * 4)))->unk78 != 0) {
                func_80071B48(arg0->unk4, temp_a1_3);
            }
            var_s0_8 += 4;
            var_s2_2 += 1;
            goto loop_193;
        }
        temp_a2_3 = arg0->unk0;
        temp_a0_5 = (temp_a2_3->unk8 << 5) + *(void *)0x8013DAE0;
        temp_a3 = temp_a0_5->unk1D;
        temp_a1_4 = temp_a2_3->unk574;
        if ((temp_a1_4 >= -((temp_a0_5->unk1E << 0xF) * (temp_a3 >> 4))) && (((temp_a0_5->unk1F << 0xF) * (temp_a3 & 0xF)) >= temp_a1_4)) {
            temp_a2_3->unk784 = 0;
            func_80066008(arg0, 0, temp_a2_3, temp_a3);
            temp_v1_36 = arg0->unk4;
            temp_s0_12 = func_800703BC(func_800702E4(8), arg0->unk0);
            if (temp_v1_36 != NULL) {
                temp_v0_37 = temp_v1_36->unk4;
                temp_v0_37->unk14(temp_v1_36 + temp_v0_37->unk10, 3);
            }
            arg0->unk4 = temp_s0_12;
            arg0->unk8 = 2U;
        }
        if ((arg0->unk5C != 0) || (func_80067E50(arg0->unk0) != 0)) {
            arg0->unk0->unk784 = 0;
            arg0->unk5C = 0;
            func_80066008(arg0, 0);
            temp_v1_37 = arg0->unk4;
            var_s0_4 = func_80071D6C(func_800702E4(8), arg0->unk0);
            if (temp_v1_37 != NULL) {
                temp_v0_38 = temp_v1_37->unk4;
                temp_v0_38->unk14(temp_v1_37 + temp_v0_38->unk10, 3);
            }
            var_v0_6 = 1;
            goto block_211;
        }
        goto block_212;
    case 9:                                         /* switch 1 */
        temp_s0_13 = arg0->unk4;
        func_80066008(arg0, 0);
        if (func_80072DB8(temp_s0_13, 0xA0000) != 0) {
            temp_v1_38 = arg0->unk4;
            var_s0_4 = func_800703BC(func_800702E4(8), arg0->unk0);
            if (temp_v1_38 != NULL) {
                temp_v0_39 = temp_v1_38->unk4;
                temp_v0_39->unk14(temp_v1_38 + temp_v0_39->unk10, 3);
            }
            var_v0_6 = 2;
            goto block_211;
        }
        goto block_212;
    }
}

/* NFS4-R-AU CHANGED @800C47E0 | base 800C3A30 DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache */
/* callers: R3DCar_InsertCarFacetII__FP8Car_tObj, R3DCar_InsertCarFacetMenuII__FP8Car_tObji */
? func_800CD8E4(s32, void *, void *, void *, s32, s32, void *); /* extern */
? func_800E2564(?);                                 /* extern */
? func_800E2570(s32, s32);                          /* extern */

void func_800C47E0(void *arg0, void *arg1, void *arg2, s32 arg3, s32 arg4, s32 arg5, void *arg6) {
    s32 temp_a0;
    s32 temp_a1;
    s32 temp_s4;
    s32 temp_s8;
    s32 temp_v0;
    s32 temp_v1;
    s32 temp_v1_2;
    s32 var_a0;
    s32 var_a0_2;
    s32 var_s0;
    s32 var_s1;
    s32 var_s5_2;
    s32 var_s7;
    s32 var_v0;
    s32 var_v1;
    s32 var_v1_2;
    u16 temp_v0_5;
    u16 temp_v0_6;
    u16 var_s5;
    void *temp_s3;
    void *temp_s6;
    void *temp_v0_2;
    void *temp_v0_3;
    void *temp_v0_4;

    temp_s8 = arg2->unk10;
    func_800E2564(8);
    arg6->unk14 = (s16) ((s32) arg0->unk0 >> 4);
    arg6->unk16 = (s16) ((s32) arg0->unkC >> 4);
    arg6->unk18 = (s16) ((s32) arg0->unk18 >> 4);
    temp_v0 = (s32) arg0->unk4 >> 4;
    arg6->unk1A = (s16) temp_v0;
    arg6->unk1C = (u16) ((s32) arg0->unk10 >> 4);
    arg6->unk1E = (u16) ((s32) arg0->unk1C >> 4);
    arg6->unk1A = (s16) -temp_v0;
    temp_a0 = (s32) arg0->unk14 >> 4;
    temp_a1 = (s32) arg0->unk20 >> 4;
    arg6->unk20 = (s16) ((s32) arg0->unk8 >> 4);
    arg6->unk22 = (s16) temp_a0;
    arg6->unk24 = (s16) temp_a1;
    arg6->unk1C = (u16) -(s32) arg6->unk1C;
    arg6->unk1E = (u16) -(s32) arg6->unk1E;
    temp_v1 = *(s32 *)0x8013EEA8;
    arg6->unk28 = (s32) ((s32) arg1->unk0 >> temp_v1);
    arg6->unk2C = (s32) -((s32) arg1->unk4 >> temp_v1);
    arg6->unk30 = (s32) ((s32) arg1->unk8 >> temp_v1);
    func_800E2570(temp_a0, temp_a1);
    var_s5 = arg2->unk2;
    temp_s6 = arg6 + 0x14;
    var_s7 = var_s5 * 0xC;
loop_1:
    var_s5_2 = var_s5 - 1;
loop_2:
    var_s7 -= 0xC;
    if (var_s5_2 != -1) {
        temp_s3 = arg2->unk18 + var_s7;
        CTC2_R11R12((s32) arg6->unk14);
        CTC2_R13R21(temp_s6->unk4);
        CTC2_R22R23(temp_s6->unk8);
        CTC2_R31R32(temp_s6->unkC);
        CTC2_R33(temp_s6->unk10);
        CTC2_TRX(temp_s6->unk14);
        CTC2_TRY(temp_s6->unk18);
        CTC2_TRZ(temp_s6->unk1C);
        temp_v0_2 = temp_s8 + (temp_s3->unk3 * 6);
        arg6->unkB0 = (u16) temp_v0_2->unk4;
        temp_v0_3 = temp_s8 + (temp_s3->unk4 * 6);
        arg6->unkAC = (u16) temp_v0_2->unk0;
        arg6->unkAE = (u16) temp_v0_2->unk2;
        arg6->unkB8 = (u16) temp_v0_3->unk4;
        temp_v0_4 = temp_s8 + (temp_s3->unk5 * 6);
        arg6->unkB4 = (u16) temp_v0_3->unk0;
        arg6->unkB6 = (u16) temp_v0_3->unk2;
        arg6->unkBE = (u16) temp_v0_4->unk2;
        arg6->unkBC = (u16) temp_v0_4->unk0;
        arg6->unkC0 = (u16) temp_v0_4->unk4;
        LWC2_VXY0(arg6->unkAC);
        LWC2_VZ0((arg6 + 0xAC)->unk4);
        LWC2_VXY1(arg6->unkB4);
        LWC2_VZ1((arg6 + 0xB4)->unk4);
        LWC2_VXY2(arg6->unkBC);
        LWC2_VZ2((arg6 + 0xBC)->unk4);
        GTE_RTPT(0x280030);
        GTE_NCLIP(0x01400006);
        arg6->unk44 = MFC2_MAC0();
        var_v1 = arg6->unk44;
        if (arg6->unkC != 0) {
            var_v1 = -var_v1;
        }
        var_s5_2 -= 1;
        if (var_v1 > 0) {
            var_s5 = var_s5_2 + 1;
            GTE_AVSZ3(0x0158002D);
            arg6->unk3C = MFC2_OTZ();
            temp_v1_2 = arg6->unk3C + arg6->unk40;
            arg6->unk3C = temp_v1_2;
            if (temp_v1_2 >= 0) {
                var_s5_2 = var_s5 - 1;
                if (arg6->unk88 >= temp_v1_2) {
                    var_s5 = var_s5_2 + 1;
                    var_s1 = arg3 & 0xFFBF;
                    if (arg4 >= 0) {
                        temp_v0_5 = *(0x80120824 + (arg4 * 2));
                        if (temp_s3->unk0 < 0) {
                            var_v1_2 = (s32) (temp_v0_5 << 0x10) >> 0x18;
                        } else {
                            var_v1_2 = (s16) temp_v0_5 & 0xFF;
                        }
                        if (arg3 & 0x40) {
                            var_v0 = var_v1_2 & 0x81;
                            if (!(var_v1_2 & 0x40)) {
                                temp_v0_6 = (void *)0x80120824->unk30;
                                if (temp_s3->unk0 < 0) {
                                    var_v1_2 = (s32) (temp_v0_6 << 0x10) >> 0x18;
                                } else {
                                    var_v1_2 = (s16) temp_v0_6 & 0xFF;
                                }
                                goto block_17;
                            }
                        } else {
block_17:
                            var_v0 = var_v1_2 & 0x81;
                        }
                        var_s5_2 = var_s5 - 1;
                        if (var_v0 != 0) {
                            var_s5 = var_s5_2 + 1;
                            var_s0 = var_s1 & 0xFF;
                            if ((var_v1_2 & 3) != 1) {
                                var_a0 = var_s0;
                                if (arg3 & 0x7F00) {
                                    var_s1 = var_s1 >> 8;
                                    goto block_22;
                                }
                            } else {
                                goto block_23;
                            }
                            goto block_24;
                        }
                    } else {
block_22:
                        var_s0 = var_s1 & 0xFF;
block_23:
                        var_a0 = var_s0;
block_24:
                        temp_s4 = arg6->unk0;
                        arg6->unk0 = (s32) arg6->unk38;
                        func_800CD8E4(var_a0, arg6 + 0xAC, arg6 + 0xB4, arg6 + 0xBC, (s32) temp_s3->unk0, arg6->unk3C, arg6);
                        var_a0_2 = var_s1 & 0xFF;
                        switch (arg5) {             /* irregular */
                        case -1:
                            if (var_s0 != 5) {
                                if (arg5 == -2) {
                                    var_a0_2 = var_s1 & 0xFF;
                                    if (var_s0 != 5) {
                                        goto block_29;
                                    }
                                }
                            } else {
                            default:
block_29:
                                if (var_a0_2 < 7) {
                                    CTC2_R11R12((s32) arg6->unk14);
                                    CTC2_R13R21(temp_s6->unk4);
                                    CTC2_R22R23(temp_s6->unk8);
                                    CTC2_R31R32(temp_s6->unkC);
                                    CTC2_R33(temp_s6->unk10);
                                    CTC2_TRX(temp_s6->unk14);
                                    CTC2_TRY(temp_s6->unk18);
                                    CTC2_TRZ(temp_s6->unk1C);
                                    func_800CD8E4(var_a0_2 | 0x100, arg6 + 0xAC, arg6 + 0xB4, arg6 + 0xBC, (s32) temp_s3->unk0, arg6->unk3C, arg6);
                                }
                            }
                            break;
                        }
                        arg6->unk0 = temp_s4;
                        goto loop_1;
                    }
                }
            } else {
                goto loop_1;
            }
        }
        goto loop_2;
    }
}

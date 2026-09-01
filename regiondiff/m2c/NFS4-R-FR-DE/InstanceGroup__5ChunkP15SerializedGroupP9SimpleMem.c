/* NFS4-R-FR-DE CHANGED @8008BE8C | base 8008B3FC InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem */
/* callers: Track_Init__FPc */
void *func_8009CC18(void *, ?, ?);                  /* extern */
s32 *func_8009CCCC(void *, ?, ?, ?);                /* extern */
s32 *func_8009CDAC(void *, void *, ?, s32);         /* extern */

void func_8008BE8C(void *arg0, void *arg1, ? arg2) {
    s16 *var_a0;
    s16 temp_v0_4;
    s32 *temp_v0_2;
    s32 *temp_v0_5;
    s32 *temp_v0_6;
    s32 *temp_v1_2;
    s32 *var_a0_3;
    s32 temp_a1;
    s32 temp_v0_10;
    s32 temp_v0_8;
    s32 temp_v0_9;
    s32 var_a1_2;
    s32 var_a1_3;
    s32 var_a2;
    s32 var_a3;
    s32 var_s0;
    s32 var_v1;
    s32 var_v1_3;
    u8 temp_v0_3;
    u8 temp_v1;
    void *temp_a0;
    void *temp_s0;
    void *temp_s1;
    void *temp_s3;
    void *temp_v0;
    void *temp_v0_7;
    void *var_a0_2;
    void *var_a1;
    void *var_v1_2;

    temp_v0 = func_8009CC18(arg1, 0x1C, 0);
    temp_a0 = temp_v0 + 0x10;
    arg0->unk68 = (u16) temp_a0->unkA;
    arg0->unk0 = (unaligned s32) temp_v0->unk20;
    arg0->unk4 = (unaligned s32) temp_v0->unk24;
    arg0->unk8 = (unaligned s32) temp_v0->unk28;
    arg0->unkC = (unaligned s32) temp_v0->unk2C;
    arg0->unk10 = (unaligned s32) temp_v0->unk30;
    arg0->unk14 = (unaligned s32) temp_v0->unk34;
    arg0->unk18 = (unaligned s32) temp_v0->unk38;
    arg0->unk1C = (unaligned s32) temp_v0->unk3C;
    arg0->unk6A = (u16) temp_a0->unkC;
    if (*(s32 *)0x801144DC != 1) {
        arg0->unk40 = func_8009CCCC(arg1, 3, arg2, 0);
        arg0->unk50 = func_8009CCCC(arg1, 0xB, arg2, 0);
        goto block_34;
    }
    temp_s3 = func_8009CC18(arg1, 0xB, 0);
    temp_s1 = func_8009CC18(arg1, 3, 0);
    if (temp_s3 != NULL) {
        var_a2 = 0;
        var_a1 = temp_s3 + 0x10;
loop_4:
        if (var_a2 < temp_s3->unkC) {
            if (var_a1->unk12 != 0x7F) {
                temp_v1 = var_a1->unk12;
                var_a0 = temp_s1 + 0x10;
                if ((s32) temp_v1 < temp_s1->unkC) {
                    var_v1 = temp_v1 - 1;
                    if (var_v1 != -1) {
                        do {
                            var_v1 -= 1;
                            var_a0 += *var_a0;
                        } while (var_v1 != -1);
                    }
                    if ((var_a0 != NULL) && (var_a0->unk2 == 5) && (var_a0->unk23 == 0)) {
                        goto block_13;
                    }
                }
            } else {
block_13:
                var_a1 += 0x14;
                var_a2 += 1;
                goto loop_4;
            }
        }
        if (var_a2 != 0) {
            temp_v0_2 = func_8009CDAC(arg1, temp_s3, arg2, var_a2 * 0x14);
            arg0->unk50 = temp_v0_2;
            *temp_v0_2 = var_a2;
        } else {
            goto block_16;
        }
    } else {
block_16:
        arg0->unk50 = NULL;
    }
    var_s0 = 0;
    if (temp_s1 != NULL) {
        var_a3 = 0;
        var_v1_2 = temp_s1 + 0x10;
loop_19:
        if (var_s0 < temp_s1->unkC) {
            temp_v0_3 = var_v1_2->unk2;
            if (temp_v0_3 == 5) {
                if (var_v1_2->unk23 == 0) {
                    goto block_24;
                }
            } else if (temp_v0_3 == 1) {
block_24:
                temp_v0_4 = var_v1_2->unk0;
                var_s0 += 1;
                var_a3 += temp_v0_4;
                var_v1_2 += temp_v0_4;
                goto loop_19;
            }
        }
        temp_v0_5 = func_8009CDAC(arg1, temp_s1, arg2, var_a3);
        arg0->unk40 = temp_v0_5;
        *temp_v0_5 = var_s0;
    } else {
        arg0->unk40 = NULL;
    }
    temp_v1_2 = arg0->unk50;
    if (temp_v1_2 != NULL) {
        if (arg0->unk40 != NULL) {
            var_a1_2 = *temp_v1_2;
            var_a0_2 = (var_a1_2 * 0x14) + (temp_s3 + 0x10);
loop_30:
            var_a1_3 = var_a1_2 - 1;
loop_31:
            var_a0_2 -= 0x14;
            if (var_a1_3 != -1) {
                var_a1_3 -= 1;
                if ((s32) var_a0_2->unk12 >= *arg0->unk40) {
                    var_a1_2 = var_a1_3 + 1;
                    var_a0_2->unk12 = 0x7FU;
                    goto loop_30;
                }
                goto loop_31;
            }
            goto block_34;
        }
    } else {
block_34:
        temp_v0_6 = arg0->unk40;
        var_a0_3 = temp_v0_6 + 4;
        if (temp_v0_6 != NULL) {
            temp_a1 = *temp_v0_6;
            var_v1_3 = 0;
            if (temp_a1 > 0) {
                do {
                    if (var_a0_3->unk2 == 5) {
                        *(void *)0x8013E7E4 = (s32) (*(s32 *)0x8013E7E4 + 1);
                    }
                    var_v1_3 += 1;
                    var_a0_3 += var_a0_3->unk0;
                } while (var_v1_3 < temp_a1);
            }
        }
    }
    arg0->unk44 = func_8009CCCC(arg1, 0x15, arg2, 0);
    arg0->unk54 = func_8009CCCC(arg1, 0xA, arg2, 0);
    arg0->unk4C = func_8009CCCC(arg1, 5, arg2, 0);
    arg0->unk48 = func_8009CCCC(arg1, 6, arg2, 0);
    arg0->unk58 = func_8009CCCC(arg1, 9, arg2, 0);
    temp_v0_7 = func_8009CC18(arg1, 0x17, 0);
    temp_s0 = func_8009CC18(temp_v0_7, 0x1B, 0) + 0x10;
    arg0->unk20 = (u8) temp_s0->unkC;
    arg0->unk21 = (u8) temp_s0->unkE;
    arg0->unk22 = (u8) temp_s0->unk10;
    arg0->unk23 = (u8) temp_s0->unk12;
    arg0->unk24 = (u8) temp_s0->unk14;
    arg0->unk25 = (u8) temp_s0->unk16;
    temp_v0_8 = func_8009CCCC(temp_v0_7, 0x19, arg2, 0) + 4;
    arg0->unk28 = temp_v0_8;
    temp_v0_9 = temp_v0_8 + ((s16) temp_s0->unkC * 6);
    arg0->unk2C = temp_v0_9;
    temp_v0_10 = temp_v0_9 + ((s16) temp_s0->unkE * 6);
    arg0->unk30 = temp_v0_10;
    arg0->unk34 = (s32) (temp_v0_10 + ((s16) temp_s0->unk14 * 6));
    arg0->unk38 = func_8009CCCC(temp_v0_7, 0x1A, arg2, 0);
    arg0->unk3C = func_8009CCCC(temp_v0_7, 0x25, arg2, 0);
    arg0->unk6C = func_8009CCCC(temp_v0_7, 0x18, arg2, 0);
    arg0->unk5C = func_8009CCCC(temp_v0_7, 0x27, arg2, 0);
    arg0->unk60 = func_8009CCCC(temp_v0_7, 0x28, arg2, 0);
    arg0->unk64 = func_8009CCCC(temp_v0_7, 0x29, arg2, 0);
}

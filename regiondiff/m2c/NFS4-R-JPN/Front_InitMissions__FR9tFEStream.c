/* NFS4-R-JPN CHANGED @800287F0 | base 80028B64 Front_InitMissions__FR9tFEStream */
/* callers: Front_BuildStream__FPi */
? func_80033DD4(?, ?, ?, s8);                       /* extern */
? func_80033F44(?, u8, u8, void *);                 /* extern */
? func_80033FAC(?, void *);                         /* extern */

void func_800287F0(void *arg0) {
    ? var_a1;
    s16 temp_v0;
    s16 temp_v1;
    s16 var_a0;
    s32 var_v1;
    s8 temp_v1_3;
    s8 var_a3;
    u8 temp_s2;
    u8 temp_s3;
    void *temp_v1_2;

    arg0->unk258 = 0;
    arg0->unk25C = 0;
    var_a3 = 0;
    if (*(u8 *)0x801156A8 == 1) {
        temp_v1 = arg0->unk6;
        var_a0 = 0;
        if (temp_v1 > 0) {
            var_v1 = 0 << 0x10;
loop_3:
            temp_v1_2 = arg0 + ((var_v1 >> 0x10) * 0xCC);
            if (temp_v1_2->unkA == 7) {
                temp_v1_3 = temp_v1_2->unk8;
                temp_v0 = var_a0 + 1;
                if (var_a3 < temp_v1_3) {
                    var_a3 = temp_v1_3;
                }
                var_a0 = temp_v0;
                var_v1 = var_a0 << 0x10;
                if (temp_v0 >= temp_v1) {
                    goto block_7;
                }
                goto loop_3;
            }
        } else {
block_7:
            var_a1 = 0;
            temp_s2 = (void *)0x801156A4->unk12B;
            temp_s3 = (void *)0x801156A4->unk12C;
            (void *)0x801156A4->unk12B = (u8) (var_a3 - 0x16);
            (void *)0x801156A4->unk12C = 0U;
            if ((arg0->unk244 > 0) || ((void *)0x801156A4->unk3 == 1)) {
                var_a1 = 1;
            }
            func_80033DD4(0x8013E380, var_a1, 0x801156A4, var_a3);
            func_80033FAC(0x8013E380, arg0 + 0x258);
            func_80033F44(0x8013E380, (void *)0x801156A4->unk12B, (void *)0x801156A4->unk12C, arg0 + 0x25C);
            (void *)0x801156A4->unk12B = temp_s2;
            (void *)0x801156A4->unk12C = temp_s3;
        }
    }
}

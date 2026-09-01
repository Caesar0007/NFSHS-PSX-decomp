/* NFS4-R-JPN CHANGED @80019090 | base 8001912C Draw__11tDialogHelp */
? func_80018940(void *);                            /* extern */
? func_80020D80(? *, s16, s16, ?);                  /* extern */
? func_80026618(?, u16, s32, s32);                  /* extern */
s32 func_800EA6BC(? *);                             /* extern */

void func_80019090(void *arg0) {
    ? sp18;
    ? *var_a0;
    ? var_a3;
    s16 temp_a0;
    s16 var_a1;
    s16 var_a1_2;
    s16 var_s3;
    s16 var_s4;
    s32 temp_a1;
    s32 temp_s5;
    s32 temp_v0_2;
    s32 temp_v1;
    s32 temp_v1_2;
    s32 temp_v1_3;
    s32 var_v1;
    void *temp_s1;
    void *temp_v0;

    temp_v0 = arg0->unk60;
    temp_v0->unk54(arg0 + temp_v0->unk50);
    temp_v0_2 = *(s32 *)0x8013ED78;
    temp_a1 = arg0->unk74;
    if (temp_v0_2 >= (temp_a1 + 0x32)) {
        var_s4 = 0;
        temp_s5 = ((temp_v0_2 - temp_a1) - 0x32) / 3;
        var_v1 = 0 << 0x10;
loop_2:
        temp_v1 = var_v1 >> 0x10;
        if (temp_v1 < arg0->unkCC) {
            if (temp_v1 == 0) {
                var_s3 = arg0->unk68 + 4;
            } else {
                var_s3 = arg0->unk68 + ((temp_v1 - 1) * 0xF) + 0x13;
            }
            if (var_s4 > 0) {
                func_80026618(0x41, (arg0 + (var_s4 * 4))->unkB0, arg0->unk66 + 0x14, ((var_s4 - 1) * 0xF) + (s16) arg0->unk68 + 0x13);
            }
            temp_s1 = arg0 + (var_s4 * 4);
            var_a3 = 8;
            if (temp_s5 < func_800EA6BC(temp_s1->unk94)) {
                var_a1 = 0;
                if (temp_s5 > 0) {
                    do {
                        temp_v1_2 = var_a1 << 0x10;
                        temp_a0 = var_a1 + 1;
                        var_a1 = temp_a0;
                        temp_v1_3 = temp_v1_2 >> 0x10;
                        *(&sp18 + temp_v1_3) = *(temp_s1->unk94 + temp_v1_3);
                    } while (temp_a0 < temp_s5);
                }
                *(&sp18 + temp_s5) = 0;
                var_a1_2 = (u16) arg0->unk66 + arg0->unkD0;
                var_a3 = 8;
                if ((var_s4 << 0x10) == 0) {
                    var_a3 = 9;
                }
                var_a0 = &sp18;
            } else {
                var_a1_2 = (u16) arg0->unk66 + arg0->unkD0;
                if (var_s4 == 0) {
                    var_a3 = 9;
                }
                var_a0 = temp_s1->unk94;
            }
            var_s4 += 1;
            func_80020D80(var_a0, var_a1_2, var_s3, var_a3);
            var_v1 = var_s4 << 0x10;
            goto loop_2;
        }
    }
    func_80018940(arg0);
}

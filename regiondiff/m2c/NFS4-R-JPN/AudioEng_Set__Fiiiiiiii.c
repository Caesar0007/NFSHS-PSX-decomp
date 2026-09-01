/* NFS4-R-JPN CHANGED @8007BF3C | base 8007B5A8 AudioEng_Set__Fiiiiiiii */
/* callers: AudioCmn_SoundCar__FP8Car_tObjiiiiiii */
s32 func_800E4D00(s32, s32, s16);                   /* extern */

void func_8007BF3C(u32 arg0, s32 arg1, s32 arg2, s32 arg3, s32 arg4, s32 arg5, s32 arg6, s32 arg7) {
    s32 temp_a0;
    s32 temp_a1;
    s32 temp_v1;
    s32 temp_v1_3;
    s32 var_a0;
    s32 var_a3;
    s32 var_lo;
    s32 var_lo_2;
    s32 var_v0;
    s32 var_v1;
    s8 temp_v1_2;
    void *temp_s0;
    void *temp_s1;

    if (arg0 < 2U) {
        temp_a0 = arg0 * 4;
        temp_s1 = *(0x8013D814 + temp_a0);
        if ((temp_s1 != NULL) && ((temp_s1->unk11B != 0xF) || !((temp_s1->unk11A + 1) & 1))) {
            temp_s0 = temp_s1 + ((temp_s1->unk11A * 0xC) + 0x5A);
            temp_v1 = (s32) (temp_s1->unk7 * arg2) >> 0xE;
            var_a3 = 0x1FF;
            if (temp_v1 < 0x200) {
                var_a3 = temp_v1;
            }
            temp_s0->unk8 = (s16) var_a3;
            if (*(*(0x80110A8C + temp_a0))->unk288 == 0x1C) {
                var_a0 = (arg2 >> 2) + 0xC000;
            } else {
                var_a0 = arg2 + 0x3333;
            }
            temp_s0->unk2 = (s16) ((s32) (temp_s1->unk6 * func_800E4D00(var_a0, arg5, (s16) var_a3)) >> 0xA);
            temp_v1_2 = arg3 + (arg3 >> 5) + (arg3 >> 6);
            if (temp_v1_2 < 0x81) {
                temp_s0->unkB = temp_v1_2;
            } else {
                temp_s0->unkB = 0x80;
            }
            if (arg4 == 0) {
                temp_s0->unkA = (u8) temp_s1->unk1;
                if (*(s32 *)0x8011429C == 1) {
                    temp_s0->unk6 = 0;
                    temp_s0->unk4 = (s16) arg6;
                } else {
                    temp_s0->unk4 = 0;
                    temp_s0->unk6 = (s16) ((s32) (*(s32 *)0x8013D6E4 * 0x3FFF) >> 7);
                }
                var_lo = arg1 * temp_s1->unk0;
            } else {
                temp_s0->unkA = (u8) temp_s1->unk2;
                if (arg7 < 0) {
                    var_lo_2 = arg7 * temp_s1->unk3 * temp_s0->unkA;
                } else {
                    var_lo_2 = arg7 * temp_s1->unk4 * (0x80 - temp_s0->unkA);
                }
                temp_v1_3 = var_lo_2 >> 7;
                var_v0 = temp_v1_3 >> 0x10;
                if (temp_v1_3 < 0) {
                    var_v0 = (s32) (temp_v1_3 + 0xFFFF) >> 0x10;
                }
                temp_s0->unkA = (u8) (temp_s0->unkA + var_v0);
                temp_s0->unk4 = (s16) arg6;
                temp_s0->unk6 = 0;
                var_lo = arg1 * temp_s1->unk5;
            }
            temp_a1 = var_lo >> 6;
            var_v1 = 0x7FF;
            if (temp_a1 < 0x800) {
                var_v1 = temp_a1;
            }
            temp_s0->unk0 = (s16) var_v1;
            temp_s1->unk11A = (u8) ((temp_s1->unk11A + 1) & 0xF);
        }
    }
}

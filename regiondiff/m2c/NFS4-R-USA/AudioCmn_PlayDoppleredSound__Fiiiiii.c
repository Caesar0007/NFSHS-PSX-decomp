/* NFS4-R-USA CHANGED @80078AF8 | base 80078140 AudioCmn_PlayDoppleredSound__Fiiiiii */
/* callers: AudioCmn_PlaySound__Fiiiii, AudioCmn_PlaySFX__Fiiiiii, AudioCmn_PlaySFX__Fiiiiii */
s8 func_80077300(s32, s32, ?);                      /* extern */
? func_800E7420(s32 *);                             /* extern */
s32 func_800E861C(s32 *);                           /* extern */

s32 func_80078AF8(s8 arg0, s32 arg1, s16 arg2, s32 arg3, s32 arg4, s32 arg5) {
    s32 sp10;
    s8 sp14;
    s8 sp17;
    s8 sp18;
    s8 sp19;
    s8 sp1B;
    s16 sp1C;
    s16 sp20;
    s32 temp_v1;
    s32 temp_v1_2;
    s32 var_a0;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v0_3;
    s32 var_v0_4;
    s32 var_v0_5;
    s32 var_v1;

    func_800E7420(&sp10);
    sp14 = arg0;
    if (arg1 == 0x7D) {
        var_v0_2 = (s32) (saved_reg_gp->unk10C * arg3) >> 7;
    } else if (arg0 == -4) {
        var_v0_2 = (s32) (saved_reg_gp->unk114 * 0x81) >> 7;
    } else {
        temp_v1 = (void *)0x8010FB6C->unk18;
        if (arg0 == temp_v1) {
            var_v1 = saved_reg_gp->unk118;
            var_v0_3 = arg3 * 0x28;
            goto block_18;
        }
        if (arg0 == (void *)0x8010FB6C->unk3C) {
            var_v1 = saved_reg_gp->unk118;
            var_v0_4 = arg3 * 0x82;
            goto block_19;
        }
        switch (arg1) {                             /* irregular */
        case 22:
        case 18:
            var_v0_2 = (s32) (saved_reg_gp->unk10C * arg3) >> 7;
            break;
        case 3:
            var_v0_3 = arg3 << 7;
            if ((arg0 != (void *)0x8010FB6C->unk0) && (arg0 != temp_v1)) {
                if (arg1 == 0) {
                case 0:
                    var_v1 = saved_reg_gp->unk110;
                    var_v0_4 = arg3 * 0x19;
                } else {
                default:
                    var_v0_3 = arg3 * 0x28;
                    goto block_17;
                }
            } else {
block_17:
                var_v1 = saved_reg_gp->unk10C;
block_18:
                var_v0_4 = var_v0_3 - arg3;
            }
block_19:
            var_v0_2 = (s32) (var_v1 * var_v0_4) >> 0xE;
            break;
        }
    }
    sp18 = (s8) var_v0_2;
    if (arg1 == 0x63) {
        sp10 = 1;
    } else {
        sp10 = arg1;
    }
    sp19 = (s8) arg4;
    temp_v1_2 = *(s32 *)0x8013E7E4;
    sp1C = (s16) (arg5 >> 4);
    sp1B = temp_v1_2 != 0;
    if (temp_v1_2 != 0) {
        sp20 = arg2;
    } else {
        if (saved_reg_gp->unk12C != 0) {
            if ((u32) (arg2 - 0x4000) <= 0x7FFFU) {
                var_v0_5 = (s32) (0xBFFF - arg2) >> 8;
            } else {
                var_v0_5 = (s32) ((u32) (arg2 + 0x4000) >> 8);
            }
        } else {
            var_v0_5 = 0x40;
        }
        sp17 = (s8) var_v0_5;
    }
    if (sp14 < -1) {
        if (sp14 == -4) {
            var_a0 = 2;
        } else {
            var_a0 = sp14 == -3;
        }
        sp14 = func_80077300(var_a0, arg1, 0);
        sp10 = 0;
    }
    var_v0 = -1;
    if (sp14 >= 0) {
        var_v0 = func_800E861C(&sp10);
    }
    saved_reg_gp->unk128 = (s32) (saved_reg_gp->unk128 + 1);
    return var_v0;
}

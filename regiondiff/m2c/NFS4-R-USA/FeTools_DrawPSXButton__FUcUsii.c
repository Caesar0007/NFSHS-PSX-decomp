/* NFS4-R-USA CHANGED @800269D0 | base 800269B0 FeTools_DrawPSXButton__FUcUsii */
/* callers: Draw__11tDialogHelp, Draw__11tDialogHelp */
? func_8004EB60(?, ?, s32, s32, s32, s32, ? *);     /* extern */

void func_800269D0(s32 arg0, s32 arg1, s32 arg2, s32 arg3) {
    ? sp20;
    s32 sp24;
    ? var_a0;
    ? var_t0;
    s32 temp_a1;
    s32 temp_a1_2;
    s32 temp_a2;
    s32 temp_s1;
    s32 var_a2;
    s32 var_a3;
    s32 var_s1;
    s32 var_s2;

    var_s2 = arg2;
    var_s1 = arg3 + 1;
    temp_a2 = arg1 & 0xFFFF;
    sp24 = 0xBEBE;
    switch (temp_a2) {                              /* irregular */
    case 0x50:
        func_8004EB60(0x1A, 0x18, var_s2 + 3, var_s1 - 2, 0, 0, &sp20);
        var_a0 = 0x1B;
        var_a2 = var_s2 + 4;
        var_a3 = var_s1 + 4;
        break;
    case 0xA0:
        temp_s1 = var_s1 - 1;
        func_8004EB60(0x1C, 0x18, var_s2, temp_s1, 0, 0, &sp20);
        var_a0 = 0x1D;
        var_a2 = var_s2 + 0xA;
        var_a3 = temp_s1;
        break;
    default:
        if ((arg0 & 0xFF) == 0x23) {
            temp_a1 = arg1 & 0xFFFF;
            if (temp_a1 != 0x1000) {
                if (temp_a1 < 0x1001) {
                    var_a0 = 0;
                    if (temp_a1 != 8) {

                    } else {
                        var_t0 = 0x15;
                        goto block_28;
                    }
                } else if (temp_a1 != 0x4000) {
                    var_a0 = 0;
                    if (temp_a1 != 0x8000) {

                    } else {
                        var_t0 = 0x14;
                        var_s1 -= 2;
                        goto block_29;
                    }
                } else {
                    var_t0 = 0x13;
                    var_s1 -= 4;
                    goto block_29;
                }
            } else {
                var_t0 = 0x12;
                var_s1 -= 3;
                goto block_29;
            }
        } else {
            temp_a1_2 = arg1 & 0xFFFF;
            if (temp_a1_2 != 0x1000) {
                if (temp_a1_2 < 0x1001) {
                    var_a0 = 0;
                    if (temp_a1_2 != 8) {

                    } else {
                        var_t0 = 0x10;
                        var_s2 += 2;
block_28:
                        var_s1 -= 1;
                        goto block_29;
                    }
                } else if (temp_a1_2 != 0x4000) {
                    var_a0 = 0;
                    if (temp_a1_2 != 0x8000) {

                    } else {
                        var_t0 = 0xE;
                        var_s1 -= 3;
                        goto block_29;
                    }
                } else {
                    var_t0 = 0xC;
                    var_s1 -= 3;
                    goto block_29;
                }
            } else {
                var_t0 = 0xF;
                var_s1 -= 3;
block_29:
                var_a0 = var_t0;
            }
        }
        var_a2 = var_s2;
        var_a3 = var_s1;
        break;
    }
    func_8004EB60(var_a0, 0x18, var_a2, var_a3);
}

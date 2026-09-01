/* NFS4-R-JPN CHANGED @80023100 | base 80023240 FECheat_HandleActivation__F10tCheatCode */
/* callers: FECheat_ActivateBonus__F10tCheatCode, FECheat_ActivateCheat__FPc, FECheat_LoadBonus__FRUl */
? func_80016CF8(?, u32, ?);                         /* extern */
? func_80016D7C(?, ?, ?);                           /* extern */

void func_80023100(u32 arg0) {
    ? var_a1;

    switch (arg0) {
    case 0:
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
        func_80016CF8(0x80115318, arg0, 1);
        return;
    case 8:
        var_a1 = 0x13;
block_6:
        func_80016D7C(0x80115318, var_a1, 1);
    default:
        return;
    case 9:
        var_a1 = 0x14;
        goto block_6;
    case 10:
        var_a1 = 0x1C;
        goto block_6;
    }
}

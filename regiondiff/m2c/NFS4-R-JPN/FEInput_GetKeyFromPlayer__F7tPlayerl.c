/* NFS4-R-JPN CHANGED @80023984 | base 80023C88 FEInput_GetKeyFromPlayer__F7tPlayerl */
/* callers: MainLoop__14tFEApplicationP5tMenu, Run__18tDialogInteractive */
s32 func_80023688(s32, s32);                        /* extern */
s32 func_80023870(s32, s32);                        /* extern */

s32 func_80023984(s32 arg0, s32 arg1) {
    s32 temp_v0;
    s32 var_s1;
    s32 var_s2;
    s32 var_v0;

    var_s1 = 0;
    var_s2 = 0;
loop_1:
    temp_v0 = (var_s1 & 0xFFFF) * 8;
    if ((func_80023870(*(0x8005168C + temp_v0), arg0) != 0) || (!(arg1 & (temp_v0 + 0x8005168C)->unk4) && (func_80023688(*(0x8005168C + temp_v0), arg0) != 0))) {
        var_s2 = 1;
    }
    if (var_s2 == 0) {
        var_s1 += 1;
        var_s2 = 0;
        if ((u32) (var_s1 & 0xFFFF) >= 0x10U) {
            var_v0 = 0x10;
            if (func_80023870(0x4000, arg0) == 0) {
                var_v0 = 2;
                if (func_80023870(0x2000, arg0) == 0) {
                    if (func_80023870(0x8000, arg0) == 0) {
                        return (func_80023870(8, arg0) != 0) << 0xD;
                    }
                    var_v0 = 8;
                    /* Duplicate return node #13. Try simplifying control flow for better match */
                    return var_v0;
                }
            }
            return var_v0;
        }
        goto loop_1;
    }
    return (((var_s1 & 0xFFFF) * 8) + 0x8005168C)->unk4;
}

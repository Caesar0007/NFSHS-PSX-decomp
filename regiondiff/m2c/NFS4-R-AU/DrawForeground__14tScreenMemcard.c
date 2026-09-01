/* NFS4-R-AU CHANGED @80047EC0 | base 80047AD8 DrawForeground__14tScreenMemcard */
? func_80021318(?, ?, ?, ?, s32, s32);              /* extern */
? func_8004EC18(s32, ?, ?, ?, s32, s32, s32);       /* extern */
? func_8004F1E4(?, ?, ?, s32, s32);                 /* extern */
s32 func_800B9F1C(?);                               /* extern */
s32 func_800E4A18(s32);                             /* extern */

void func_80047EC0(void *arg0) {
    s16 var_a0;
    s32 temp_v0;
    s32 var_a0_2;
    s32 var_s0;
    s32 var_v0;

    temp_v0 = arg0->unk5C * 2;
    var_a0 = temp_v0 - 0x80;
    if ((var_a0 >= 0x80) || (var_a0 > 0)) {
        var_v0 = temp_v0 << 0x10;
        if (var_a0 >= 0x81) {
            var_a0 = 0x80;
        }
    } else {
        var_a0 = 0;
        var_v0 = temp_v0 << 0x10;
    }
    if ((var_v0 >> 0x10) >= 0x64) {
        func_80021318(0x27E, 0x1E0, 0xDC, 1, 1, 4);
        func_8004F1E4(0, 0x1E0, 0xDC, -func_800E4A18(func_800B9F1C(0x27E)) - 5, 7);
    }
    var_s0 = 0;
    var_a0_2 = 0x38;
    do {
        func_8004EC18(var_a0_2, 0, 0, 0, (s32) var_a0, 0, 0);
        var_s0 += 1;
        var_a0_2 = var_s0 + 0x38;
    } while (var_s0 < 4);
}

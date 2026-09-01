/* NFS4-R-AU CHANGED @80048314 | base 80047E8C GetShapeInfo__15tScreenCongratsRsT1PPcT3 */
s32 func_80033C5C(?, s16);                          /* extern */
? func_80033D18(s32, void *, ?, ?, s32);            /* extern */
? func_800E5094(?, ?, ?, u8);                       /* extern */

void func_80048314(void *arg0, s16 *arg1, s16 *arg2, s32 *arg3, s32 *arg4) {
    ? var_a2;
    s16 temp_v0;
    s16 var_a0;
    s16 var_s0;
    s16 var_s2;
    s32 temp_a1;
    s32 temp_v1;
    void *temp_s4;

    temp_a1 = (void *)0x80115DBC->unk18;
    arg0->unk74 = 0;
    arg0->unk70 = 0;
    temp_s4 = temp_a1 + ((((temp_a1 + ((void *)0x80115DBC->unk4 * 0xC))->unk2 + (void *)0x80115DBC->unk8) * 0x54) + 0x24);
    var_a0 = 0x16;
    if (arg0->unk64 == 0) {
        var_a0 = 0x2B;
    }
    *arg1 = var_a0;
    if (arg0->unk64 == 0) {
        var_a2 = 0x80012244;
    } else {
        var_a2 = 0x8001224C;
    }
    func_800E5094(0x80052EB4, 0x8001223C, var_a2, *(u8 *)0x80115C24);
    *arg3 = 0x80052EB4;
    if ((u32) (arg0->unk68 - 3) >= 2U) {
        var_s2 = 0x384;
        temp_v0 = (void *)0x80115DBC->unk10 + (temp_s4->unk5 != 0);
        var_s0 = 1;
        if (temp_v0 > 0) {
            do {
                if ((func_80033C5C(0x80115DBC, var_s0) << 0x10) == 0) {
                    var_s2 = var_s0;
                }
                var_s0 += 1;
            } while (temp_v0 >= var_s0);
        }
        func_80033D18(0x80115DBC, temp_s4, 2, 0x80052EA4, (s32) var_s2);
        *arg4 = 0x80052EA4;
        *arg2 = 0x20;
        arg0->unk70 = 0x20;
        return;
    }
    temp_v1 = arg0->unk6C;
    if (temp_v1 != 1) {
        if (temp_v1 != 2) {
            *arg4 = 0;
            *arg2 = 0;
            return;
        }
        *arg2 = 0xA;
        arg0->unk74 = 0xA;
        *arg4 = 0x80012254;
        return;
    }
    *arg2 = 0x20;
    arg0->unk74 = 0x20;
    func_80033D18(0x80115DBC, temp_s4, 0, 0x80052EA4, -1);
    *arg4 = 0x80052EA4;
}

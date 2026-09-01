/* NFS4-R-FR-DE CHANGED @8003E6C8 | base 8003E330 GetShapeInfo__25tScreenCarSelectTwoPlayerRsT1PPcT3 */
? func_800E5094(?, ?, ? *);                         /* extern */

void func_8003E6C8(void *arg0, s16 *arg1, s16 *arg2, s32 *arg3, s32 *arg4) {
    u8 sp10;
    ? sp20;
    s32 var_s0;
    void *temp_v0;

    var_s0 = 0;
    *arg1 = 0x34;
    *arg2 = 5;
    arg0->unk11E = -1;
    arg0->unk120 = -1;
    arg0->unk122 = -1;
    *arg3 = 0x80011AE0;
    temp_v0 = arg0->unk60;
    if (temp_v0->unk6C(arg0 + temp_v0->unk68, &sp10) != 0) {
        var_s0 = (*(void **)0x80051D70)->unk22C == 0;
    }
    if (var_s0 != 0) {
        arg0->unk11E = (s16) spD8;
        arg0->unk122 = (s16) spD7;
        arg0->unk120 = (s16) (s8) sp10;
        func_800E5094(0x80053480, 0x80011A8C, &sp20);
        *arg4 = 0x80053480;
        return;
    }
    *arg4 = 0;
}

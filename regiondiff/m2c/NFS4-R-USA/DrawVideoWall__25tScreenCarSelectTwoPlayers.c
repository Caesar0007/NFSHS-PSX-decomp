/* NFS4-R-USA CHANGED @8003E4C0 | base 8003E190 DrawVideoWall__25tScreenCarSelectTwoPlayers */
? func_80036A38(void *);                            /* extern */
? func_80036B84(void *, ?, ?, ?);                   /* extern */
? func_80036BC0(void *, ?, ?);                      /* extern */
? func_80036BCC(void *, u8);                        /* extern */
? func_80036BD4(void *, s16);                       /* extern */
? func_80036BDC(void *);                            /* extern */
? func_80036DAC(void *);                            /* extern */
? func_80037074(void *);                            /* extern */
? func_8003C7B0(void *, ?, ?);                      /* extern */
? func_8004EB60(s32, ?, ?, s16, s32, s32, s32);     /* extern */

void func_8003E4C0(void *arg0, s16 arg1) {
    ? sp20;
    ? var_a2;
    ? var_a3;
    s16 temp_s3;
    s16 temp_v0_2;
    s16 var_s1;
    s32 var_a0;
    void *temp_s0;
    void *temp_v0;
    void *var_s0;

    temp_v0 = arg0->unk60;
    var_s1 = 0;
    temp_s3 = temp_v0->unk6C(arg0 + temp_v0->unk68, &sp20);
    var_a0 = 0 << 0x10;
    do {
        func_8004EB60(var_a0 >> 0x10, 0, 0, -arg1, (s32) arg0->unk5C, 0, 0);
        temp_v0_2 = var_s1 + 1;
        var_s1 = temp_v0_2;
        var_a0 = var_s1 << 0x10;
    } while (temp_v0_2 < 0xC);
    if ((arg0->unk3A & 1) && (arg0->unk384 == 0)) {
        var_a2 = 0;
        if ((*(void **)0x800519A8)->unk22C != 0) {
            var_a2 = 0x69;
        }
        temp_s0 = arg0 + 0x304;
        func_80036BC0(temp_s0, 6, var_a2);
        var_a3 = 0x2D;
        if ((*(void **)0x800519A8)->unk22C != 0) {
            var_a3 = 0x96;
        }
        func_80036B84(temp_s0, 0xF9, 0x10E, var_a3);
        func_80036A38(temp_s0);
        arg0->unk384 = 1;
    }
    var_s0 = arg0 + 0x304;
    if ((arg0->unk5C > 0) && (arg0->unk54 != 0)) {
        func_80037074(arg0 + 0x304);
        func_8003C7B0(arg0, 0, 0);
        var_s0 = arg0 + 0x304;
    }
    func_80036BD4(var_s0, temp_s3);
    func_80036BCC(var_s0, sp27);
    func_80036BDC(var_s0);
    func_80036DAC(var_s0);
}

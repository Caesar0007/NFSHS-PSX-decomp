/* NFS4-R-UK-ES-IT CHANGED @80014184 | base 80014014 RunDemoVideo__14tFEApplication */
/* callers: MainLoop__14tFEApplicationP5tMenu */
? func_80013924(void *);                            /* extern */
? func_80013ED0(void *);                            /* extern */
? func_80014108();                                  /* extern */
? func_80015B08(?);                                 /* extern */
? func_80025B80();                                  /* extern */
? func_800268C8(void *, ?, ?);                      /* extern */
? func_800268E8(void *, ?, ?);                      /* extern */
? func_80026C70();                                  /* extern */
? func_80026D58();                                  /* extern */
? func_8004D474(u8);                                /* extern */
? func_8004DDD0();                                  /* extern */
? func_8004DE44();                                  /* extern */
? func_8004F4A4();                                  /* extern */
? func_800780F0();                                  /* extern */
? func_8007B798(?);                                 /* extern */
? func_8007BC44(s32);                               /* extern */
? func_800BC95C(?, ?);                              /* extern */
? func_800BCA50();                                  /* extern */
? func_800BCB08();                                  /* extern */
s32 func_800E5E5C();                                /* extern */
? func_800EE1C4(?);                                 /* extern */
? func_800EE348(s16 *, ?, ?, ?);                    /* extern */

void func_80014184(void *arg0) {
    s16 sp38;
    s16 sp3A;
    s16 sp3C;
    s16 sp3E;
    s32 var_s0;
    void *temp_a1;
    void *temp_v0;
    void *temp_v0_2;
    void *temp_v0_3;
    void *temp_v0_4;
    void *temp_v0_5;
    void *temp_v0_6;
    void *temp_v1;
    void *temp_v1_2;
    void *temp_v1_3;
    void *temp_v1_4;
    void *temp_v1_5;
    void *temp_v1_6;
    void *temp_v1_7;

    if (arg0->unk4 == (*(s32 *)0x800522E8 + 0xB0)) {
        func_8007B798(0x78);
        func_80015B08(0);
        temp_v1 = arg0->unk4;
        temp_v0 = temp_v1->unk68;
        temp_v0->unk2C(temp_v1 + temp_v0->unk28);
        func_800268C8(arg0->unkC, 2, 0);
loop_2:
        temp_v1_2 = arg0->unk4;
        temp_v0_2 = temp_v1_2->unk68;
        var_s0 = 0;
        if ((temp_v0_2->unk3C(temp_v1_2 + temp_v0_2->unk38) == 0) || (temp_v1_3 = arg0->unkC, temp_v0_3 = temp_v1_3->unk60, (temp_v0_3->unk44(temp_v1_3 + temp_v0_3->unk40) == 0))) {
            var_s0 = 1;
        }
        if (var_s0 != 0) {
            func_80013924(arg0);
            func_80015B08(0);
            goto loop_2;
        }
        temp_v1_4 = arg0->unkC;
        temp_v0_4 = temp_v1_4->unk60;
        temp_v0_4->unk3C(temp_v1_4 + temp_v0_4->unk38);
        func_800BCB08();
        func_800BCA50();
        func_8004DE44();
        func_80026D58();
        func_80014108();
        *(s32 *)0x80051DA8 = func_800E5E5C();
        sp38 = 0;
        sp3A = 0;
        sp3C = 0x400;
        sp3E = 0x200;
        func_800EE348(&sp38, 0, 0, 0);
        func_800EE1C4(0);
        func_8004D474(*(u8 *)0x80051DAC);
        sp38 = 0;
        sp3A = 0;
        sp3C = 0x400;
        sp3E = 0x200;
        func_800EE348(&sp38, 0, 0, 0);
        func_800EE1C4(0);
        *(s32 *)0x80051DA8 = func_800E5E5C();
        func_8004DDD0();
        func_80026C70();
        func_80025B80();
        func_800BC95C(0xD800, 0x18000);
        func_800780F0();
        func_8004F4A4();
        temp_a1 = arg0->unk4;
        temp_v1_5 = temp_a1->unk68;
        *(s32 *)0x80051DA8 = func_800E5E5C();
        temp_v1_5->unk14(temp_a1 + temp_v1_5->unk10, temp_a1);
        temp_v1_6 = arg0->unkC;
        temp_v0_5 = temp_v1_6->unk60;
        temp_v0_5->unk34(temp_v1_6 + temp_v0_5->unk30);
        temp_v1_7 = arg0->unk4;
        temp_v0_6 = temp_v1_7->unk68;
        temp_v0_6->unk34(temp_v1_7 + temp_v0_6->unk30);
        func_800268E8(arg0->unkC, 2, 0);
        *(u8 *)0x80051DAC = (s32) (5 - (s32) *(u8 *)0x80051DAC);
        func_80013ED0(arg0);
        func_8007BC44((s32) (*(u8 *)0x80115C25 * 0x23) >> 6);
    }
}

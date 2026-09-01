/* NFS4-R-USA CHANGED @800FA444 | base 800F9AE8 CD_systaskfunc */
? func_800E7794(?);                                 /* extern */
? func_800EB944(?);                                 /* extern */
? func_800F2C78(?);                                 /* extern */
? func_800F8108(?);                                 /* extern */
? func_800F8174();                                  /* extern */
? func_800F81A8(?, ?);                              /* extern */
? func_800F81FC(?);                                 /* extern */
? func_800F8210(?, ? *, ? *);                       /* extern */
? func_800F8480(?, s8 *, ? *);                      /* extern */
? func_800F8650(s32, ? *);                          /* extern */
s32 func_80109A38(?);                               /* extern */
s32 func_80109B74();                                /* extern */

s32 func_800FA444(void) {
    ? sp10;
    ? sp18;
    s8 sp20;
    s32 temp_v0;
    s32 temp_v1;
    s32 var_s0;

    var_s0 = 0;
    temp_v0 = func_80109A38(1);
    switch (temp_v0) {                              /* irregular */
    case 2:
        if ((u32) (func_80109B74() - 1) < 2U) {
            *(s32 *)0x80148018 = 0;
            var_s0 = 1;
        }
        break;
    case 5:
        temp_v1 = (void *)0x80148000->unk18;
        if (temp_v1 == 0) {
            (void *)0x80148000->unk18 = (s32) (*(s32 *)0x8013EF90 + (*(s32 *)0x8013EFA4 * 5));
        } else if (*(void *)0x8013EF90 >= temp_v1) {
            (void *)0x80148000->unk18 = 0;
            var_s0 = 1;
        }
        break;
    case 16:
        *(void *)0x80148018 = 0;
        break;
    }
    if (var_s0 != 0) {
        func_800E7794(0x800FA444);
        func_800F8108(0);
        sp20 = 0xA0;
        func_800F8480(0xE, &sp20, &sp10);
        func_800F2C78(3);
        func_800F8174();
        func_800F81A8(0, 0);
        func_800F8650((void *)0x80148000->unkC, &sp18);
        func_800F8210(0x1B, &sp18, &sp10);
        func_800F81FC(0x800FA654);
        if ((void *)0x80148000->unk0 & 1) {
            (void *)0x80148000->unk1C = 0;
            (void *)0x80148000->unk18 = (s32) (*(void *)0x8013EFA4 * 0xC);
            func_800EB944(0x800FA5F4);
        }
    }
    return 0;
}

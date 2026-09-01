/* NFS4-R-UK-ES-IT CHANGED @800FA470 | base 800F9AE8 CD_systaskfunc */
? func_800E7780(?);                                 /* extern */
? func_800EB930(?);                                 /* extern */
? func_800F2CA4(?);                                 /* extern */
? func_800F8134(?);                                 /* extern */
? func_800F81A0();                                  /* extern */
? func_800F81D4(?, ?);                              /* extern */
? func_800F8228(?);                                 /* extern */
? func_800F823C(?, ? *, ? *);                       /* extern */
? func_800F84AC(?, s8 *, ? *);                      /* extern */
? func_800F867C(s32, ? *);                          /* extern */
s32 func_80109A64(?);                               /* extern */
s32 func_80109BA0();                                /* extern */

s32 func_800FA470(void) {
    ? sp10;
    ? sp18;
    s8 sp20;
    s32 temp_v0;
    s32 temp_v1;
    s32 var_s0;

    var_s0 = 0;
    temp_v0 = func_80109A64(1);
    switch (temp_v0) {                              /* irregular */
    case 2:
        if ((u32) (func_80109BA0() - 1) < 2U) {
            *(s32 *)0x80148044 = 0;
            var_s0 = 1;
        }
        break;
    case 5:
        temp_v1 = (void *)0x8014802C->unk18;
        if (temp_v1 == 0) {
            (void *)0x8014802C->unk18 = (s32) (*(s32 *)0x8013EFBC + (*(s32 *)0x8013EFD0 * 5));
        } else if (*(void *)0x8013EFBC >= temp_v1) {
            (void *)0x8014802C->unk18 = 0;
            var_s0 = 1;
        }
        break;
    case 16:
        *(void *)0x80148044 = 0;
        break;
    }
    if (var_s0 != 0) {
        func_800E7780(0x800FA470);
        func_800F8134(0);
        sp20 = 0xA0;
        func_800F84AC(0xE, &sp20, &sp10);
        func_800F2CA4(3);
        func_800F81A0();
        func_800F81D4(0, 0);
        func_800F867C((void *)0x8014802C->unkC, &sp18);
        func_800F823C(0x1B, &sp18, &sp10);
        func_800F8228(0x800FA680);
        if ((void *)0x8014802C->unk0 & 1) {
            (void *)0x8014802C->unk1C = 0;
            (void *)0x8014802C->unk18 = (s32) (*(void *)0x8013EFD0 * 0xC);
            func_800EB930(0x800FA620);
        }
    }
    return 0;
}

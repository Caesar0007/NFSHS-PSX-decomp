/* NFS4-R-JPN CHANGED @800FA230 | base 800F9AE8 CD_systaskfunc */
? func_800E7580(?);                                 /* extern */
? func_800EB730(?);                                 /* extern */
? func_800F2A64(?);                                 /* extern */
? func_800F7EF4(?);                                 /* extern */
? func_800F7F60();                                  /* extern */
? func_800F7F94(?, ?);                              /* extern */
? func_800F7FE8(?);                                 /* extern */
? func_800F7FFC(?, ? *, ? *);                       /* extern */
? func_800F826C(?, s8 *, ? *);                      /* extern */
? func_800F843C(s32, ? *);                          /* extern */
s32 func_80109824(?);                               /* extern */
s32 func_80109960();                                /* extern */

s32 func_800FA230(void) {
    ? sp10;
    ? sp18;
    s8 sp20;
    s32 temp_v0;
    s32 temp_v1;
    s32 var_s0;

    var_s0 = 0;
    temp_v0 = func_80109824(1);
    switch (temp_v0) {                              /* irregular */
    case 2:
        if ((u32) (func_80109960() - 1) < 2U) {
            *(s32 *)0x80147E04 = 0;
            var_s0 = 1;
        }
        break;
    case 5:
        temp_v1 = (void *)0x80147DEC->unk18;
        if (temp_v1 == 0) {
            (void *)0x80147DEC->unk18 = (s32) (*(s32 *)0x8013ED7C + (*(s32 *)0x8013ED90 * 5));
        } else if (*(void *)0x8013ED7C >= temp_v1) {
            (void *)0x80147DEC->unk18 = 0;
            var_s0 = 1;
        }
        break;
    case 16:
        *(void *)0x80147E04 = 0;
        break;
    }
    if (var_s0 != 0) {
        func_800E7580(0x800FA230);
        func_800F7EF4(0);
        sp20 = 0xA0;
        func_800F826C(0xE, &sp20, &sp10);
        func_800F2A64(3);
        func_800F7F60();
        func_800F7F94(0, 0);
        func_800F843C((void *)0x80147DEC->unkC, &sp18);
        func_800F7FFC(0x1B, &sp18, &sp10);
        func_800F7FE8(0x800FA440);
        if ((void *)0x80147DEC->unk0 & 1) {
            (void *)0x80147DEC->unk1C = 0;
            (void *)0x80147DEC->unk18 = (s32) (*(void *)0x8013ED90 * 0xC);
            func_800EB730(0x800FA3E0);
        }
    }
    return 0;
}

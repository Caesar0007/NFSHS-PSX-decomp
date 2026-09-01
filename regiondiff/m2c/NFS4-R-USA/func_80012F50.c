/* NFS4-R-USA REGION-ONLY @80012F50 */
/* callers: DrawCar__FR8tCarInfossffcbUl7tPlayer */
? func_8009E850(s32 *, ? *, s32);                   /* extern */
? func_800B3850(void *);                            /* extern */
? func_800E12A4();                                  /* extern */
? func_800E2544();                                  /* extern */
? func_800E25D4(s32, s32, ?, ?);                    /* extern */
? func_800E4F44(s32, s32);                          /* extern */
? func_800E66B0(? *, s32);                          /* extern */
? func_800EB834(s32 *, s32, void *);                /* extern */
s32 func_800F3E0C(s32, ?);                          /* extern */
s32 func_800F4294(s32);                             /* extern */

void func_80012F50(void *arg0, s32 arg1, s32 arg2, s32 arg3, s32 arg4, s32 arg5, s32 arg6, s32 arg7) {
    ? sp10;
    s32 sp38;
    s32 sp3C;
    s32 sp40;
    s32 sp48;
    s32 sp4C;
    s32 sp50;
    s32 sp54;
    s32 sp58;
    s32 sp5C;
    s32 sp60;
    s32 sp64;
    s32 sp68;
    s32 temp_s0;
    s32 temp_s2;
    s32 temp_s3;

    func_800E2544();
    func_800E25D4(arg1 - 0x100, arg2 - 0x80, 0x200, 0x100);
    temp_s0 = arg3 * 4;
    *(0x8005174C + temp_s0) = (s32) (*(0x8005174C + temp_s0) + arg4);
    func_800E66B0(&sp10, arg5);
    temp_s2 = arg0 + 0x14;
    sp48 = 0x10000;
    sp58 = 0x10000;
    sp68 = 0x10000;
    sp4C = 0;
    sp50 = 0;
    sp54 = 0;
    sp5C = 0;
    sp60 = 0;
    sp64 = 0;
    sp58 = 0x8980;
    func_8009E850(&sp48, &sp10, temp_s2);
    temp_s3 = arg0 + 0x44;
    func_800E4F44(temp_s2, temp_s3);
    sp38 = 0;
    sp3C = func_800F4294(func_800F3E0C(arg6, 0x47800000));
    sp40 = func_800F4294(func_800F3E0C(arg7, 0x47800000));
    func_800EB834(&sp38, temp_s2, arg0 + 8);
    sp38 = -arg0->unk8;
    sp3C = -arg0->unkC;
    sp40 = -arg0->unk10;
    func_800EB834(&sp38, temp_s3, arg0 + 0x38);
    func_800E12A4();
    *(s32 *)0x1F80008C = 0x404040;
    func_800B3850(arg0);
}

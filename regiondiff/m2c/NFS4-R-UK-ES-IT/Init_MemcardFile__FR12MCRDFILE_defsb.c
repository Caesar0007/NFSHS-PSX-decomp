/* NFS4-R-UK-ES-IT CHANGED @80034ACC | base 800348A0 Init_MemcardFile__FR12MCRDFILE_defsb */
/* callers: SaveGame__Fs, LoadGame__FsbT1, SavePinkSlipsCars__Fss */
? func_800E5094(?, ?);                              /* extern */
? func_800F2500(?);                                 /* extern */

void func_80034ACC(void *arg0, s32 arg2) {
    func_800F2500(0x2C);
    arg0->unk0 = 0x80011684;
    if (arg2 != 0) {
        *(s8 *)0x80053400 = 0;
    } else {
        func_800E5094(0x80053400, 0x8001168C);
    }
    arg0->unk4 = (void *) ((s8 *)0x80050000 + 0x3400);
    arg0->unk8 = 0x1500;
    arg0->unkC = 0;
    arg0->unk10 = 0;
}

/* NFS4-R-JPN CHANGED @80034604 | base 800348A0 Init_MemcardFile__FR12MCRDFILE_defsb */
/* callers: SaveGame__Fs, LoadGame__FsbT1, SavePinkSlipsCars__Fss */
? func_800E4E94(?, ?);                              /* extern */
? func_800F22C0(?);                                 /* extern */

void func_80034604(void *arg0, s32 arg2) {
    func_800F22C0(0x2C);
    arg0->unk0 = 0x80011684;
    if (arg2 != 0) {
        *(s8 *)0x80052AC0 = 0;
    } else {
        func_800E4E94(0x80052AC0, 0x8001168C);
    }
    arg0->unk4 = (void *) ((s8 *)0x80050000 + 0x2AC0);
    arg0->unk8 = 0x1500;
    arg0->unkC = 0;
    arg0->unk10 = 0;
}

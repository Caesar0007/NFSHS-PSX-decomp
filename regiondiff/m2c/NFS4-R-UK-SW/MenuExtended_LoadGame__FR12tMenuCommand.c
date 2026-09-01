/* NFS4-R-UK-SW CHANGED @8002DA20 | base 8002D8D0 MenuExtended_LoadGame__FR12tMenuCommand */
? func_80018AC4(s32);                               /* extern */
s16 func_800199A8(? *);                             /* extern */
? func_80019C4C(? *);                               /* extern */
? func_80026124(? *, ?);                            /* extern */
? func_8002D98C(s16);                               /* extern */
s32 func_800B9F1C(?);                               /* extern */

void func_8002DA20(void) {
    ? sp10;

    if (!((*(void **)0x800522A0)->unk3080 & 1)) {
        func_80019C4C(&sp10);
        sp10.unk60 = 0x80010308;
        sp10.unkA0 = 0x322;
        sp10.unkA4 = 0x323;
        sp10.unk88 = 0;
        *(s32 *)0x800522B0 = (s32) (*(void **)0x80053140)->unk59C;
        sp10.unk90 = func_800B9F1C(0x2C1);
        if (func_800199A8(&sp10) == 1) {
            func_8002D98C((*(void **)0x80053140)->unk59C);
        } else {
            func_80018AC4(*(s32 *)0x80051D68 + 0x238);
        }
        func_80026124(&sp10, 2);
    }
}

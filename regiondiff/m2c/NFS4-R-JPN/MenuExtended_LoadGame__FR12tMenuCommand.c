/* NFS4-R-JPN CHANGED @8002D598 | base 8002D8D0 MenuExtended_LoadGame__FR12tMenuCommand */
? func_8001888C(s32);                               /* extern */
s16 func_8001968C(? *);                             /* extern */
? func_80019930(? *);                               /* extern */
? func_80025D60(? *, ?);                            /* extern */
? func_8002D504(s16);                               /* extern */
s32 func_800B9CCC(?);                               /* extern */

void func_8002D598(void) {
    ? sp10;

    if (!((*(void **)0x800519A8)->unk3080 & 1)) {
        func_80019930(&sp10);
        sp10.unk60 = 0x80010308;
        sp10.unkA0 = 0x322;
        sp10.unkA4 = 0x323;
        sp10.unk88 = 0;
        *(s32 *)0x800519B8 = (s32) (*(void **)0x80052848)->unk59C;
        sp10.unk90 = func_800B9CCC(0x2C1);
        if (func_8001968C(&sp10) == 1) {
            func_8002D504((*(void **)0x80052848)->unk59C);
        } else {
            func_8001888C(*(s32 *)0x80051470 + 0x238);
        }
        func_80025D60(&sp10, 2);
    }
}

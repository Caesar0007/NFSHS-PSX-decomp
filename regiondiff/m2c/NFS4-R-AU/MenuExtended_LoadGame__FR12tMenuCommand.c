/* NFS4-R-AU CHANGED @8002D9C8 | base 8002D8D0 MenuExtended_LoadGame__FR12tMenuCommand */
? func_80018A6C(s32);                               /* extern */
s16 func_80019950(? *);                             /* extern */
? func_80019BF4(? *);                               /* extern */
? func_800260CC(? *, ?);                            /* extern */
? func_8002D934(s16);                               /* extern */
s32 func_800B9F1C(?);                               /* extern */

void func_8002D9C8(void) {
    ? sp10;

    if (!((*(void **)0x80051F98)->unk3080 & 1)) {
        func_80019BF4(&sp10);
        sp10.unk60 = 0x80010308;
        sp10.unkA0 = 0x322;
        sp10.unkA4 = 0x323;
        sp10.unk88 = 0;
        *(s32 *)0x80051FA8 = (s32) (*(void **)0x80052E40)->unk59C;
        sp10.unk90 = func_800B9F1C(0x2C1);
        if (func_80019950(&sp10) == 1) {
            func_8002D934((*(void **)0x80052E40)->unk59C);
        } else {
            func_80018A6C(*(s32 *)0x80051A60 + 0x238);
        }
        func_800260CC(&sp10, 2);
    }
}

/* NFS4-R-USA CHANGED @8002D950 | base 8002D8D0 MenuExtended_LoadGame__FR12tMenuCommand */
? func_80018A44(s32);                               /* extern */
s16 func_80019928(? *);                             /* extern */
? func_80019BCC(? *);                               /* extern */
? func_80026098(? *, ?);                            /* extern */
? func_8002D8BC(s16);                               /* extern */
s32 func_800B9F18(?);                               /* extern */

void func_8002D950(void) {
    ? sp10;

    if (!((*(void **)0x80051EE0)->unk3080 & 1)) {
        func_80019BCC(&sp10);
        sp10.unk60 = 0x80010308;
        sp10.unkA0 = 0x322;
        sp10.unkA4 = 0x323;
        sp10.unk88 = 0;
        *(s32 *)0x80051EF0 = (s32) (*(void **)0x80052D80)->unk59C;
        sp10.unk90 = func_800B9F18(0x2C1);
        if (func_80019928(&sp10) == 1) {
            func_8002D8BC((*(void **)0x80052D80)->unk59C);
        } else {
            func_80018A44(*(s32 *)0x800519A8 + 0x238);
        }
        func_80026098(&sp10, 2);
    }
}

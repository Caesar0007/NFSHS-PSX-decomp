/* NFS4-R-UK-ES-IT CHANGED @8002DA38 | base 8002D8D0 MenuExtended_LoadGame__FR12tMenuCommand */
? func_80018ADC(s32);                               /* extern */
s16 func_800199C0(? *);                             /* extern */
? func_80019C64(? *);                               /* extern */
? func_8002613C(? *, ?);                            /* extern */
? func_8002D9A4(s16);                               /* extern */
s32 func_800B9F1C(?);                               /* extern */

void func_8002DA38(void) {
    ? sp10;

    if (!((*(void **)0x800522E8)->unk3080 & 1)) {
        func_80019C64(&sp10);
        sp10.unk60 = 0x80010308;
        sp10.unkA0 = 0x322;
        sp10.unkA4 = 0x323;
        sp10.unk88 = 0;
        *(s32 *)0x800522F8 = (s32) (*(void **)0x80053188)->unk59C;
        sp10.unk90 = func_800B9F1C(0x2C1);
        if (func_800199C0(&sp10) == 1) {
            func_8002D9A4((*(void **)0x80053188)->unk59C);
        } else {
            func_80018ADC(*(s32 *)0x80051DB0 + 0x238);
        }
        func_8002613C(&sp10, 2);
    }
}

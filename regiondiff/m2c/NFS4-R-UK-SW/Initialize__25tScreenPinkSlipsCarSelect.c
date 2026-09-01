/* NFS4-R-UK-SW CHANGED @8003F650 | base 8003F24C Initialize__25tScreenPinkSlipsCarSelect */
? func_800348A4(?, ?);                              /* extern */
? func_8003F1A8(void *);                            /* extern */
s32 func_80050AEC(?);                               /* extern */

void func_8003F650(void *arg0) {
    arg0->unk438 = 0;
    arg0->unk440 = 0;
    arg0->unk444 = 0;
    *(s32 *)0x80052884 = 0;
    ((s32 *)0x80050000 + 0x2884)->unk4 = 0;
    arg0->unk43C = func_80050AEC(1);
    func_800348A4(1, 1);
    arg0->unk448 = 0;
    func_8003F1A8(arg0);
    arg0->unk3A = (u16) (arg0->unk3A & 0xFFFE);
}

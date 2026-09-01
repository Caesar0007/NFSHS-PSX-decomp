/* NFS4-R-JPN CHANGED @8003F1A0 | base 8003F24C Initialize__25tScreenPinkSlipsCarSelect */
? func_800343F4(?, ?);                              /* extern */
? func_8003ECF8(void *);                            /* extern */
s32 func_800501F4(?);                               /* extern */

void func_8003F1A0(void *arg0) {
    arg0->unk438 = 0;
    arg0->unk440 = 0;
    arg0->unk444 = 0;
    *(s32 *)0x80051F8C = 0;
    ((s32 *)0x80050000 + 0x1F8C)->unk4 = 0;
    arg0->unk43C = func_800501F4(1);
    func_800343F4(1, 1);
    arg0->unk448 = 0;
    func_8003ECF8(arg0);
    arg0->unk3A = (u16) (arg0->unk3A & 0xFFFE);
}

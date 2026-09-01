/* NFS4-R-USA CHANGED @8003F5E8 | base 8003F24C Initialize__25tScreenPinkSlipsCarSelect */
? func_800347D4(?, ?);                              /* extern */
? func_8003F140(void *);                            /* extern */
s32 func_8005072C(?);                               /* extern */

void func_8003F5E8(void *arg0) {
    arg0->unk438 = 0;
    arg0->unk440 = 0;
    arg0->unk444 = 0;
    *(s32 *)0x800524C4 = 0;
    ((s32 *)0x80050000 + 0x24C4)->unk4 = 0;
    arg0->unk43C = func_8005072C(1);
    func_800347D4(1, 1);
    arg0->unk448 = 0;
    func_8003F140(arg0);
    arg0->unk3A = (u16) (arg0->unk3A & 0xFFFE);
}

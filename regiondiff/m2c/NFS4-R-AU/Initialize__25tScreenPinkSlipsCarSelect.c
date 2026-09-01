/* NFS4-R-AU CHANGED @8003F5E0 | base 8003F24C Initialize__25tScreenPinkSlipsCarSelect */
? func_8003484C(?, ?);                              /* extern */
? func_8003F138(void *);                            /* extern */
s32 func_800507E4(?);                               /* extern */

void func_8003F5E0(void *arg0) {
    arg0->unk438 = 0;
    arg0->unk440 = 0;
    arg0->unk444 = 0;
    *(s32 *)0x80052584 = 0;
    ((s32 *)0x80050000 + 0x2584)->unk4 = 0;
    arg0->unk43C = func_800507E4(1);
    func_8003484C(1, 1);
    arg0->unk448 = 0;
    func_8003F138(arg0);
    arg0->unk3A = (u16) (arg0->unk3A & 0xFFFE);
}

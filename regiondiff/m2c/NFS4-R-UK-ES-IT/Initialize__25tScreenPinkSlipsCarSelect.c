/* NFS4-R-UK-ES-IT CHANGED @8003F668 | base 8003F24C Initialize__25tScreenPinkSlipsCarSelect */
? func_800348BC(?, ?);                              /* extern */
? func_8003F1C0(void *);                            /* extern */
s32 func_80050B34(?);                               /* extern */

void func_8003F668(void *arg0) {
    arg0->unk438 = 0;
    arg0->unk440 = 0;
    arg0->unk444 = 0;
    *(s32 *)0x800528CC = 0;
    ((s32 *)0x80050000 + 0x28CC)->unk4 = 0;
    arg0->unk43C = func_80050B34(1);
    func_800348BC(1, 1);
    arg0->unk448 = 0;
    func_8003F1C0(arg0);
    arg0->unk3A = (u16) (arg0->unk3A & 0xFFFE);
}

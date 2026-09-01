/* NFS4-R-USA CHANGED @8003F140 | base 8003EDC0 Initialize__25tScreenCarSelectTwoPlayer */
/* callers: Initialize__25tScreenPinkSlipsCarSelect */
? func_80036B84(s32, ?, ?, ?);                      /* extern */
? func_8003C060();                                  /* extern */

void func_8003F140(void *arg0) {
    func_8003C060();
    if ((*(void **)0x800519A8)->unk22C == 1) {
        arg0->unk11E = -1;
        arg0->unk120 = -1;
        arg0->unk122 = -1;
    } else {
        func_80036B84(arg0 + 0x304, 0xF9, 0x10E, 0x2D);
    }
    arg0->unk11C = 0;
    arg0->unk37A = 0;
    arg0->unk378 = 0;
    arg0->unk376 = 0;
    arg0->unk374 = 0;
    *(s32 *)0x8005199C = 0;
}

/* NFS4-R-USA CHANGED @800FA5F4 | base 800F9C44 CD_timerfunc */
? func_800E76E0(?, ?, ?);                           /* extern */
? func_800EB9A4(?);                                 /* extern */
? func_800F81FC(?);                                 /* extern */

void func_800FA5F4(void) {
    s32 temp_v0;
    s32 temp_v0_2;

    temp_v0 = (void *)0x80148000->unk18;
    temp_v0_2 = temp_v0 - 1;
    if (temp_v0 != 0) {
        (void *)0x80148000->unk18 = temp_v0_2;
        if (temp_v0_2 == 0) {
            func_800F81FC(0);
            func_800E76E0(0x800FA444, 0, 0);
            func_800EB9A4(0x800FA5F4);
        }
    }
}

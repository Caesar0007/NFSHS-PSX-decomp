/* NFS4-R-JPN CHANGED @800FA3E0 | base 800F9C44 CD_timerfunc */
? func_800E74CC(?, ?, ?);                           /* extern */
? func_800EB790(?);                                 /* extern */
? func_800F7FE8(?);                                 /* extern */

void func_800FA3E0(void) {
    s32 temp_v0;
    s32 temp_v0_2;

    temp_v0 = (void *)0x80147DEC->unk18;
    temp_v0_2 = temp_v0 - 1;
    if (temp_v0 != 0) {
        (void *)0x80147DEC->unk18 = temp_v0_2;
        if (temp_v0_2 == 0) {
            func_800F7FE8(0);
            func_800E74CC(0x800FA230, 0, 0);
            func_800EB790(0x800FA3E0);
        }
    }
}

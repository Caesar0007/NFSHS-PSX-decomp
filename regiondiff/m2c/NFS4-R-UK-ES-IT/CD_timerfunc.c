/* NFS4-R-UK-ES-IT CHANGED @800FA620 | base 800F9C44 CD_timerfunc */
? func_800E76CC(?, ?, ?);                           /* extern */
? func_800EB990(?);                                 /* extern */
? func_800F8228(?);                                 /* extern */

void func_800FA620(void) {
    s32 temp_v0;
    s32 temp_v0_2;

    temp_v0 = (void *)0x8014802C->unk18;
    temp_v0_2 = temp_v0 - 1;
    if (temp_v0 != 0) {
        (void *)0x8014802C->unk18 = temp_v0_2;
        if (temp_v0_2 == 0) {
            func_800F8228(0);
            func_800E76CC(0x800FA470, 0, 0);
            func_800EB990(0x800FA620);
        }
    }
}

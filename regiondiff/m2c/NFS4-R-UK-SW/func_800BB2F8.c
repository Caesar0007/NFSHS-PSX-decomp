/* NFS4-R-UK-SW REGION-ONLY @800BB2F8 */
/* callers: Track_Init__FPc */
? func_8007F788(?, ? *);                            /* extern */
? func_800804E8(s32 *, ? *, ?);                     /* extern */

void func_800BB2F8(s32 arg0) {
    ? sp10;
    s32 sp98;
    s32 sp9C;
    s32 spA0;
    s16 temp_a0;
    s16 temp_v1;
    s32 temp_v0;
    s32 temp_v1_2;
    s32 var_s0;

    if ((arg0 == 0) && ((func_8007F788(0, &sp10), temp_v1 = (void *)0x8011F43C->unk0, var_s0 = 0, (temp_v1 != -1)) || ((void *)0x8011F43C->unk2 != temp_v1))) {
        do {
loop_4:
            temp_v1_2 = var_s0 * 4;
            sp9C = 0;
            sp98 = *(0x8011F43C + temp_v1_2) << 0x10;
            spA0 = (temp_v1_2 + 0x8011F43C)->unk2 << 0x10;
            func_800804E8(&sp98, &sp10, 1);
            if (sp88 != NULL) {
                *sp88 |= 0x80;
            }
            var_s0 += 1;
            temp_v0 = var_s0 * 4;
            temp_a0 = *(0x8011F43C + temp_v0);
            if (temp_a0 != -1) {
                goto loop_4;
            }
        } while ((temp_v0 + 0x8011F43C)->unk2 != temp_a0);
    }
}

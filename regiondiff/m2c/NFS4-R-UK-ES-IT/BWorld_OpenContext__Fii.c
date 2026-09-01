/* NFS4-R-UK-ES-IT CHANGED @8007EEA8 | base 8007E4AC BWorld_OpenContext__Fii */
/* callers: BWorld_Init__Fv, BWorld_Init__Fv */
s32 func_8007EEA8(s32 arg0, s32 arg1) {
    s32 temp_a0;
    s32 var_v0;
    s32 var_v0_2;
    void *temp_a0_2;

    temp_a0_2 = ((void *)0x8011019C->unk4 * 0x9C) + ((void *)0x8011019C + 8);
    temp_a0_2->unk4 = 0;
    temp_a0_2->unk0 = arg1;
    switch (arg0) {                                 /* irregular */
    case 0:
        temp_a0_2->unk90 = 0x9C400;
        temp_a0_2->unk98 = 0x4C90;
        var_v0 = 0xE100;
        temp_a0_2->unk8C = 0xCEA40;
block_8:
        temp_a0_2->unk94 = var_v0;
        break;
    case 1:
        if ((u32) (*(s32 *)0x8011450C - 8) < 3U) {
            var_v0_2 = 0x33A90;
        } else {
            var_v0_2 = 0x42040;
        }
        temp_a0_2->unk8C = var_v0_2;
        temp_a0_2->unk90 = 0x3D090;
        temp_a0_2->unk98 = 0x2710;
        var_v0 = 0x8D04;
        goto block_8;
    }
    temp_a0 = (void *)0x8011019C->unk4;
    (void *)0x8011019C->unk4 = (s32) (temp_a0 + 1);
    return temp_a0;
}

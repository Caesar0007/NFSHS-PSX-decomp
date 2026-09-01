/* NFS4-R-JPN CHANGED @8010B2A8 | base 8010A880 iSNDdmtransfer */
/* callers: iSNDdmcallback, iSNDdmservice */
s32 func_800E8BF8();                                /* extern */

void func_8010B2A8(void) {
    ? (*temp_v1)(?, u32, u32, ?);
    s32 *temp_a1;
    s32 temp_s1;
    s8 var_a0;
    u32 var_a1;
    u32 var_a2;
    void *temp_s0;
    void *temp_v1_2;
    void *var_v1;

    temp_s1 = MFC0_SR();
    MTC0_SR(temp_s1 & ~0x401);
    var_a2 = -1U;
    if (((void *)0x80148A40->unkC << 0x18) <= 0) {
        MTC0_SR(temp_s1);
        return;
    }
    var_a1 = 0;
    (void *)0x80148A40->unkE = 1;
    var_a0 = 0;
    var_v1 = (void *)0x80148A40 + 0x10;
    do {
        if (var_v1->unk0 != 0) {
            if (var_a1 < (u8) var_v1->unkB) {
                (void *)0x80148A40->unkD = var_a0;
                var_a2 = var_v1->unk0;
                var_a1 = var_v1->unkB & 0xFF;
            } else if ((var_v1->unkB == var_a1) && ((u32) var_v1->unk0 < var_a2)) {
                (void *)0x80148A40->unkD = var_a0;
                var_a2 = var_v1->unk0;
            }
        }
        var_a0 += 1;
        var_v1 += 0x14;
    } while (var_a0 < 0xA);
    temp_s0 = ((s8) (u8) (void *)0x80148A40->unkD * 0x14) + ((void *)0x80148A40 + 0x10);
    if (temp_s0->unkC != 0) {
        temp_v1 = (void *)0x80148A40->unk728;
        (void *)0x80148A40->unk1 = 1;
        if (temp_v1 != NULL) {
            temp_v1(0x80148A40, var_a1, var_a2, 0x80148A40);
        }
    }
    temp_s0->unk10 = (s32) (func_800E8BF8() + (*(s32 *)0x8013ED90 / 10));
    (void *)0x80148A40->unk514->unk1A6 = (u16) temp_s0->unk8;
    temp_v1_2 = (void *)0x80148A40->unk514;
    temp_v1_2->unk1AA = (u16) ((temp_v1_2->unk1AA & 0xFFCF) | 0x20);
    temp_a1 = (void *)0x80148A40->unk4FC;
    *temp_a1 = (*temp_a1 & 0xF0FFFFFF) | 0x20000000;
    *(void *)0x80148A40->unk500 = temp_s0->unk4;
    *(void *)0x80148A40->unk504 = (temp_s0->unkA << 0x10) | 0x10;
    *(void *)0x80148A40->unk508 = 0x01000201;
    MTC0_SR(temp_s1);
}

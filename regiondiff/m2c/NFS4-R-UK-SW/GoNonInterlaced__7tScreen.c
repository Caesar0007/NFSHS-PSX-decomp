/* NFS4-R-UK-SW CHANGED @80025CA8 | base 80025BF8 GoNonInterlaced__7tScreen */
/* callers: Initialize__7tScreen */
? func_800EE1C4(?, u16, ?, ?);                      /* extern */
? func_800F2CA4(?);                                 /* extern */

void func_80025CA8(void) {
    u16 temp_a1;
    void *temp_v0;
    void *temp_v0_2;

    *(s32 *)0x8013EF98 = 0x100;
    temp_a1 = (u16) *(s32 *)0x8013EF98;
    (void *)0x80120740->unk10 = 0;
    (void *)0x80120740->unk28 = 0;
    (void *)0x80120740->unk2 = 0x100;
    (void *)0x80120740->unk1A = 0;
    (void *)0x80120740->unk6 = temp_a1;
    (void *)0x80120740->unkE = temp_a1;
    (void *)0x80120740->unk26 = temp_a1;
    temp_v0 = (*(s32 *)0x8013E6DC * 0xC8) + 0x8011FF70;
    temp_v0->unk1F = 0;
    temp_v0->unkA = 0;
    temp_v0->unkE = temp_a1;
    temp_v0->unk10 = 0;
    temp_v0->unk12 = 0;
    temp_v0_2 = (*(s32 *)0x8013E6DC * 0xC8) + 0x8011FF70;
    temp_v0_2->unk66 = 0x100;
    temp_v0_2->unk6C = 0;
    temp_v0_2->unk6E = 0x100;
    temp_v0_2->unk7B = 0;
    temp_v0_2->unk6A = (u16) *(s32 *)0x8013EF98;
    func_800EE1C4(0, temp_a1, 0x8011FF70, 0x100);
    func_800F2CA4(0);
}

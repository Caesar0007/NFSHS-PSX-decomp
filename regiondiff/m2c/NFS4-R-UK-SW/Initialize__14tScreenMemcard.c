/* NFS4-R-UK-SW CHANGED @800480F8 | base 80047C30 Initialize__14tScreenMemcard */
? func_80026158(void *, void *, s32, s32);          /* extern */
s32 func_800E5F14(?, ?, ?);                         /* extern */

void func_800480F8(void *arg0) {
    s32 var_a2;
    s32 var_a3;
    u8 temp_v0;
    void *temp_a0;
    void *temp_v0_2;
    void *var_a1;

    *(s32 *)0x80053144 = 0xEE;
    *(s32 *)0x80053148 = 0x32;
    *(s32 *)0x8005314C = 0x40;
    *(s32 *)0x80053150 = 0x1B;
    *(s32 *)0x80053158 = 0;
    *(s32 *)0x80053154 = 0x14;
    *(s32 *)0x8005315C = 0;
    *(s32 *)0x80053160 = 0xC0;
    *(s32 *)0x80053164 = 0x9B;
    *(s32 *)0x80053168 = 4;
    *(s32 *)0x8005316C = 4;
    *(s32 *)0x80053170 = 0x12;
    *(s32 *)0x80053174 = 6;
    *(s32 *)0x8005317C = 0x18;
    *(s32 *)0x80053180 = 0x150;
    *(s32 *)0x80053178 = 0x150;
    arg0->unk598 = 0;
    *(s32 *)0x80053184 = 0xBC;
    *(s32 *)0x80053188 = func_800E5F14(0x800121D8, 0x21C0, 0);
    arg0->unk590 = 0;
    arg0->unk588 = 0;
    arg0->unk58A = 0;
    temp_v0 = (*(void **)0x80051D68)->unk22D;
    var_a3 = 0x288;
    arg0->unk59C = (s16) temp_v0;
    arg0->unk68 = (s32) ((temp_v0 * 4) + 1);
    if (arg0->unk59C != 0) {
        var_a3 = 0x28A;
    }
    var_a2 = 0;
    temp_a0 = *(void **)0x800522A0;
    var_a1 = arg0;
    temp_a0->unk3084 = var_a3;
    temp_a0->unk3054 = (s32) (temp_a0->unk3054 | 1);
    temp_a0->unk3080 = (s32) (temp_a0->unk3080 | 1);
    do {
        temp_v0_2 = arg0 + var_a2;
        temp_v0_2->unk250 = 0;
        temp_v0_2->unk25F = 0;
        temp_v0_2->unk26E = 0;
        var_a1->unk532 = 0x80;
        var_a1->unk514 = 0;
        var_a2 += 1;
        var_a1 += 2;
    } while (var_a2 < 0xF);
    arg0->unk554 = 0;
    arg0->unk5A0 = 0;
    arg0->unk550 = 0;
    arg0->unk64 = -1;
    arg0->unk594 = 0;
    func_80026158(arg0, var_a1, var_a2, var_a3);
}

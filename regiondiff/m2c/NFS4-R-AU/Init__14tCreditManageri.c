/* NFS4-R-AU CHANGED @80035CC0 | base 80035AF8 Init__14tCreditManageri */
/* callers: SetState__11tScreenMain16tScreenMainState */
? func_800E5094(? *, ?, s32);                       /* extern */
s32 func_800E5F14(?, s32, ?);                       /* extern */
s32 func_800E6244(? *);                             /* extern */
? func_800E6488(? *, s32);                          /* extern */

void func_80035CC0(void *arg0) {
    ? sp10;
    s32 temp_v0;
    u32 temp_hi;

    if (arg0->unk10 == 0) {
        if (arg0->unk14 != 0) {
            arg0->unk14 = 0;
        }
        arg0->unk1C = -1;
        arg0->unk8 = 0x80;
        arg0->unk34 = 0;
        arg0->unk24 = 0;
        arg0->unk28 = 0;
        arg0->unk2C = 0;
        arg0->unk14 = 0;
        arg0->unk20 = 0;
        func_800E5094(&sp10, 0x80011814, *(s32 *)0x801177E0);
        temp_v0 = func_800E5F14(0x80011824, func_800E6244(&sp10), 0);
        arg0->unk0 = temp_v0;
        func_800E6488(&sp10, temp_v0);
        temp_hi = MULTU_HI(func_800E6244(&sp10), 0xCA4587E7);
        arg0->unk10 = 1;
        arg0->unk18 = (u32) (temp_hi >> 8);
    }
}
